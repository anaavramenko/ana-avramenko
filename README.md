# סקילים לעיצוב ווידאו — ‏Claude Code

חמישה סקילים מקהילת GitHub שנבדקו קובץ־קובץ לפני שנכנסו לכאן.
כולם רצים לגמרי על המחשב המקומי: בלי מפתחות API, בלי חשבון ענן, בלי תוסף דפדפן.

## התקנה

```bash
git clone <כתובת-המאגר-הזה> ana-skills
cd ana-skills
./install-skills.sh --all
```

אחר כך צריך להפעיל מחדש את Claude Code כדי שיזהה את הסקילים החדשים.

פקודות נוספות:

```bash
./install-skills.sh --list           # רשימת הסקילים ומה כל אחד עושה
./install-skills.sh frontend-slides  # התקנת סקיל בודד
./install-skills.sh --dry-run --all  # להראות מה יקרה בלי לשנות כלום
```

ברירת המחדל מתקינה ל-`~/.claude/skills`, כלומר הסקילים זמינים בכל פרויקט.
להתקנה בפרויקט אחד בלבד:

```bash
SKILLS_DIR=./.claude/skills ./install-skills.sh --all
```

## מה יש בפנים

| סקיל | לְמה | מקור |
|---|---|---|
| `frontend-slides` | מצגות — 37 תבניות עיצוב, פלט HTML, ייבוא מ-PPTX | [zarazhangrui](https://github.com/zarazhangrui/frontend-slides) · 26.6K ⭐ |
| `claude-design` | פוסטרים ופריסה — 10 אסכולות עיצוב, ייצוא לדפוס | [jiji262](https://github.com/jiji262/claude-design-skill) · 161 ⭐ |
| `tufte` | אינפוגרפיקה ותרשימים — HTML/SVG עצמאי | [aref-vc](https://github.com/aref-vc/tufte-claude-skill) · 284 ⭐ |
| `ffmpeg-usage` | עריכת וידאו — המרה, חיתוך, איחוד, GIF, כתוביות | [ychoi-kr](https://github.com/ychoi-kr/claude-ffmpeg-skill) · 34 ⭐ |
| `remotion-motion-graphics` | מושן גרפיקס — אנימציה, כתוביות מסונכרנות, color grading | [haidrrrry](https://github.com/haidrrrry/claude-remotion-skill) · 15 ⭐ |

כולם ברישיון MIT.

## מה נבדק

לכל מאגר: מיפוי כל הקבצים, סריקה של כל סקריפט, וחיפוש אחר קריאות רשת,
מפתחות API, גישה לקבצי סביבה ופקודות מחיקה.

- `claude-design`, `tufte`, `remotion-motion-graphics` — **אפס סקריפטים**. מרקדאון ותבניות בלבד.
- `ffmpeg-usage` — סקריפט אחד (`validate.py`) שרק בודק אם ffmpeg מותקן.
- `frontend-slides` — שלושה סקריפטים. `extract-pptx.py` קורא PPTX מקומית,
  `export-pdf.sh` מרים שרת ב-localhost ומייצא PDF דרך Playwright.
  `deck-stage.js` (619 שורות) לא פונה לרשת בכלל.

## מה הוסר בהתקנה

הסקריפט מסיר שני דברים מהמקור:

- **`frontend-slides/scripts/deploy.sh`** — מעלה מצגות לכתובת ציבורית ב-Vercel.
  זה הדבר החיצוני היחיד שנמצא בחמשת המאגרים, והוא לא נחוץ לעבודה מקומית.
- **`ffmpeg-usage/install.sh`** — המתקין של המחבר. הסקריפט כאן מעתיק קבצים
  במקום להריץ מתקין חיצוני.

## למה הגרסאות מקובעות

כל סקיל מקובע ל-commit מסוים, לא ל-branch. מזהה commit הוא בלתי משתנה,
ולכן ההתקנה מביאה בדיוק את הקוד שנבדק ולא גרסה מאוחרת יותר שאיש לא עבר עליה.
הסקריפט מוודא את המזהה אחרי ההורדה ונעצר אם יש אי־התאמה.

לעדכון בעתיד: לבדוק מה השתנה אצל המקור, ורק אז לעדכן את המזהה ב-`install-skills.sh`.

## הערות שכדאי להכיר

- **`claude-design`** — אחד מקבצי הרפרנס (`references/brand-context.md`) מנחה
  להוריד לוגו ודף בית של מותג מהאתר הרשמי שלו. זה קורה רק בבקשת עבודת מיתוג
  ומדובר בנכסים ציבוריים. מצב הפרוטוטייפ ב-React טוען ספריות מ-unpkg —
  עם חתימות `integrity`, שזו הדרך הנכונה. לא רלוונטי לפוסטרים.
- **`frontend-slides`** — המצגות שנוצרות מקשרות לפונטים מ-Google Fonts ו-Fontshare,
  כך שהדפדפן של הצופה פונה לשם. זה נוגע לפונט בלבד, לא לתוכן.
  אפשר להוריד את הפונט ולהטמיע אותו בקובץ אם צריך מצגת שעובדת אופליין לגמרי.

## הסרה

```bash
rm -rf ~/.claude/skills/{frontend-slides,claude-design,tufte,ffmpeg-usage,remotion-motion-graphics}
```
