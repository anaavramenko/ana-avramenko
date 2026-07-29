#!/usr/bin/env bash
#
# install-skills.sh — install audited Claude Code design/video skills
#
# Every skill below was reviewed file-by-file before being listed here, and is
# pinned to the exact commit that was reviewed. Pinning matters: a commit SHA is
# immutable, so you install the reviewed bytes rather than whatever upstream
# happens to contain today.
#
# All five skills run entirely on this machine. None of them require an API key,
# a cloud account, or a browser extension.
#
# Usage:
#   ./install-skills.sh --list                 show the catalogue
#   ./install-skills.sh frontend-slides        install one skill
#   ./install-skills.sh --all                  install all five
#   ./install-skills.sh --dry-run --all        show what would happen, change nothing
#
# Install location defaults to ~/.claude/skills (available in every project).
# Override with:  SKILLS_DIR=./.claude/skills ./install-skills.sh --all

set -euo pipefail

SKILLS_DIR="${SKILLS_DIR:-$HOME/.claude/skills}"
DRY_RUN=false

# ── Catalogue ────────────────────────────────────────────────────────────────
# Fields: name | repo | reviewed commit | subdirectory ('.' = repo root) | paths to strip
#
# The strip column removes things that are not part of the skill: upstream
# installer scripts (never run a stranger's installer — this script copies files
# instead) and, for frontend-slides, the Vercel upload script.
CATALOGUE=(
"frontend-slides|https://github.com/zarazhangrui/frontend-slides|9906a34d640d2111f724544cbc50f7f130569ae1|.|scripts/deploy.sh plugins .claude-plugin|Presentations — 37 design templates, HTML output, PPTX import"
"ffmpeg-usage|https://github.com/ychoi-kr/claude-ffmpeg-skill|b88cb5ce08337ab55c66c67674100b8de29cf232|.|install.sh|Video editing — convert, trim, merge, GIF, subtitles, compress"
"remotion-motion-graphics|https://github.com/haidrrrry/claude-remotion-skill|48acfe4a0591fbb5f6f8a8f4d3135e9521736f4f|remotion-motion-graphics||Motion graphics — animation, word-synced captions, colour grading"
"claude-design|https://github.com/jiji262/claude-design-skill|35a20e5ada2c9e768d1bc094ce1ef3218f48684b|.||Posters and layout — 10 named design schools, print-ready PDF"
"tufte|https://github.com/aref-vc/tufte-claude-skill|a145acf0c158f822d70ccdc2590164abb83b39cb|.||Infographics and charts — self-contained HTML/SVG, no dependencies"
)

# ── Output helpers ───────────────────────────────────────────────────────────
if [ -t 1 ]; then
    BOLD=$'\033[1m'; GREEN=$'\033[0;32m'; CYAN=$'\033[0;36m'
    YELLOW=$'\033[1;33m'; RED=$'\033[0;31m'; NC=$'\033[0m'
else
    BOLD=''; GREEN=''; CYAN=''; YELLOW=''; RED=''; NC=''
fi

info() { printf '%s\n' "${CYAN}·${NC} $*"; }
ok()   { printf '%s\n' "${GREEN}✓${NC} $*"; }
warn() { printf '%s\n' "${YELLOW}!${NC} $*"; }
die()  { printf '%s\n' "${RED}✗${NC} $*" >&2; exit 1; }

# Read one catalogue row into the globals R_NAME, R_REPO, R_SHA, R_SUBDIR,
# R_STRIP, R_DESC. Returns 1 if no row matches.
lookup() {
    local want="$1" row
    for row in "${CATALOGUE[@]}"; do
        IFS='|' read -r R_NAME R_REPO R_SHA R_SUBDIR R_STRIP R_DESC <<<"$row"
        [ "$R_NAME" = "$want" ] && return 0
    done
    return 1
}

show_catalogue() {
    printf '\n%s\n\n' "${BOLD}Audited skills${NC}"
    local row
    for row in "${CATALOGUE[@]}"; do
        IFS='|' read -r R_NAME R_REPO R_SHA R_SUBDIR R_STRIP R_DESC <<<"$row"
        printf '  %s%-26s%s %s\n' "$BOLD" "$R_NAME" "$NC" "$R_DESC"
        printf '  %-26s %s @ %s\n\n' '' "$R_REPO" "${R_SHA:0:12}"
    done
    printf 'Install target: %s\n\n' "$SKILLS_DIR"
}

# ── Install ──────────────────────────────────────────────────────────────────
install_skill() {
    local name="$1"
    lookup "$name" || die "Unknown skill: $name  (try --list)"

    local dest="$SKILLS_DIR/$R_NAME"
    printf '\n%s\n' "${BOLD}$R_NAME${NC} — $R_DESC"

    if $DRY_RUN; then
        info "would clone $R_REPO at ${R_SHA:0:12}"
        [ -n "$R_STRIP" ] && info "would strip: $R_STRIP"
        info "would install to $dest"
        return 0
    fi

    if [ -e "$dest" ]; then
        warn "$dest already exists — skipping (delete it first to reinstall)"
        return 0
    fi

    local work
    work="$(mktemp -d)"
    # shellcheck disable=SC2064  # expand $work now, not at trap time
    trap "rm -rf '$work'" RETURN

    info "fetching $R_REPO"
    (
        cd "$work"
        git init -q .
        git remote add origin "$R_REPO"
        # Fetching a bare SHA is the cheapest path and works on GitHub. Some
        # mirrors refuse it, so fall back to a full clone and check the SHA out.
        if ! git fetch -q --depth 1 origin "$R_SHA" 2>/dev/null; then
            git fetch -q origin
        fi
        git checkout -q "$R_SHA"
    ) || die "could not fetch $R_REPO at $R_SHA"

    # The whole point of pinning: refuse anything that is not the reviewed tree.
    local got
    got="$(git -C "$work" rev-parse HEAD)"
    [ "$got" = "$R_SHA" ] || die "commit mismatch — expected $R_SHA, got $got"
    ok "verified commit ${R_SHA:0:12}"

    local src="$work/$R_SUBDIR"
    [ -f "$src/SKILL.md" ] || die "no SKILL.md in $R_REPO/$R_SUBDIR"

    local path
    for path in $R_STRIP; do
        if [ -e "$src/$path" ]; then
            rm -rf "${src:?}/$path"
            ok "removed $path"
        fi
    done

    rm -rf "$src/.git"
    mkdir -p "$SKILLS_DIR"
    cp -R "$src" "$dest"
    ok "installed to $dest"
}

# ── Argument handling ────────────────────────────────────────────────────────
TARGETS=()
for arg in "$@"; do
    case "$arg" in
        --list|-l)    show_catalogue; exit 0 ;;
        --dry-run|-n) DRY_RUN=true ;;
        --all|-a)
            for row in "${CATALOGUE[@]}"; do
                TARGETS+=("${row%%|*}")
            done
            ;;
        -h|--help)
            sed -n '2,20p' "$0" | sed 's/^# \{0,1\}//'
            exit 0
            ;;
        -*) die "Unknown option: $arg" ;;
        *)  TARGETS+=("$arg") ;;
    esac
done

if [ ${#TARGETS[@]} -eq 0 ]; then
    show_catalogue
    printf 'Nothing selected. Pass a skill name, or --all.\n\n'
    exit 0
fi

command -v git >/dev/null || die "git is required but not installed"

$DRY_RUN && warn "dry run — nothing will be written"

for t in "${TARGETS[@]}"; do
    install_skill "$t"
done

printf '\n'
if $DRY_RUN; then
    ok "dry run complete"
else
    ok "done — restart Claude Code to pick up the new skills"
fi
