# בדיקת סקילים — עיצוב גרפי ווידאו

סיכום מלא של בדיקה שנעשתה ביולי 2026 על סקילים לקלוד קוד בתחומי העיצוב הגרפי,
המצגות, האינפוגרפיקה והווידאו.

**דרישות שהוגדרו:** בלי שירותי ענן, בלי מפתחות API, בלי תוספי דפדפן,
בלי העלאת תוכן לשום מקום. הכל מקומי.

**שיטה:** כל מאגר שוכפל ונסרק בפועל — מיפוי כל הקבצים, קריאה של כל סקריפט,
וחיפוש שיטתי אחר קריאות רשת (`curl`, `wget`, `fetch`, `requests`),
מפתחות API, גישה לקבצי סביבה, ופקודות מחיקה. לא הסתמכתי על תיאורים ב-README.

---

## עבר — חמישה סקילים

מותקנים דרך `install-skills.sh` שבמאגר הזה.

### `frontend-slides` — מצגות
[zarazhangrui/frontend-slides](https://github.com/zarazhangrui/frontend-slides) · 26.6K ⭐ · MIT

163 קבצים, מתוכם **רק 4 קבצי קוד**. כל השאר מרקדאון — 37 ערכות עיצוב
(Editorial, Retro-Zine, Sakura, Monochrome ועוד).

| קובץ | מה הוא באמת עושה |
|---|---|
| `extract-pptx.py` | מייבא רק `json`, `os`, `sys`, `pptx`. קורא PPTX וכותב מקומית. אפס רשת |
| `export-pdf.sh` | מרים שרת ב-localhost, Playwright מצלם, מייצא PDF. `mktemp` ומחיקות במרכאות |
| `deck-stage.js` | 619 שורות אנימציה. אפס `fetch`, אפס `http` |
| `deploy.sh` | ⚠️ מעלה מצגת לכתובת ציבורית ב-Vercel — **מוסר בהתקנה** |

### `claude-design` — פוסטרים ופריסה
[jiji262/claude-design-skill](https://github.com/jiji262/claude-design-skill) · 161 ⭐ · MIT

41 קבצים, **אפס סקריפטים**. מבוסס על מערכת העיצוב הפנימית של Claude.ai.

עשר אסכולות עיצוב עם שושלת מוגדרת: Swiss Editorial (Vignelli),
Bauhaus גיאומטרי (Müller-Brockmann), מינימליזם יפני (Kenya Hara),
תעשייתי (Dieter Rams), מגזין עריכתי (Bloomberg Businessweek),
zine/ריזוגרף, Field.io, ברוטליזם, Sagmeister, Y2K.

פלט HTML עם print-to-PDF, כולל רצפות גודל לדפוס (‏≥12pt).

### `tufte` — אינפוגרפיקה ותרשימים
[aref-vc/tufte-claude-skill](https://github.com/aref-vc/tufte-claude-skill) · 284 ⭐ · MIT

25 קבצים. **אפס סקריפטים, אפס תלויות חיצוניות, אפס קריאות רשת.**
הנקי ביותר מכל מה שנבדק.

פלט: קובץ HTML/SVG יחיד ועצמאי — עובד אופליין בכל דפדפן.

מבוסס על שלושת ספריו של אדוארד טאפטי. כולל `principles.md` (10 כללים),
`chart-selection.md` (בחירת סוג תרשים לפי הנתונים), `kill-list.md`,
`checklist.md` (20 בדיקות), `before-after.html` (6 השוואות), ו-`cheatsheet.pdf`.

### `ffmpeg-usage` — עריכת וידאו
[ychoi-kr/claude-ffmpeg-skill](https://github.com/ychoi-kr/claude-ffmpeg-skill) · 34 ⭐ · MIT

7 קבצים. מתכוני ffmpeg: המרות, חיתוך, איחוד, GIF, כתוביות, אופטימיזציה לרשתות.
`validate.py` רק בודק אם ffmpeg מותקן. `install.sh` **מוסר בהתקנה**.

### `remotion-motion-graphics` — מושן גרפיקס
[haidrrrry/claude-remotion-skill](https://github.com/haidrrrry/claude-remotion-skill) · 15 ⭐ · MIT

**אין בו אפילו סקריפט אחד** — SKILL.md ושני קבצי רפרנס בלבד.
סקיל שהוא טקסט בלבד לא יכול לדלוף שום דבר; זה בטוח מבנית.
אנימציות קפיציות, כתוביות מסונכרנות למילים, Ken Burns, גריין.

החיסרון היחיד: פרויקט קטן ולא מוכר.

---

## נפסל

### `wilwaldon/Claude-Code-Video-Toolkit`
שוכפל ונבדק: **קובץ אחד בלבד — README**. אין שם שום סקיל.
זו רשימת קישורים שמוצגת כערכת כלים.

### `digitalsamba/claude-code-video-toolkit` · ~1,900 ⭐
GPU בענן (Modal/RunPod) + ElevenLabs + Ideogram + LTX2.
דורש מפתחות API ושולח קבצים ופרומפטים לשרתים חיצוניים. מנוגד לדרישות.

### `wshuyi/remotion-video-skill`
נמצא בקוד: `MINIMAX_API_KEY` ו-`requests.post` לשרת TTS חיצוני.

### `efaisalzia/posterskill`
פוסטרים אקדמיים לכנסים, לא עיצוב גרפי. בנוסף שולח את כתובת הפרויקט
ל-`api.qrserver.com` (צד שלישי) ומייצר QR שמצביע על המאגר של המחבר עצמו.

### `markdown-viewer/skills` · 3.1K ⭐
**הקוד נקי לגמרי** — 252 קבצים, אפס סקריפטים, ו-70+ תבניות אינפוגרפיקה יפות
(KPI, ציר זמן, SWOT, משפך, פירמידה, עץ ארגוני, מפת דרכים).

אבל הפלט הוא בלוק בפורמט קנייני שנפתח **רק בתוסף הדפדפן שלהם**
(Markdown Viewer מ-docu.md). בלי התוסף מקבלים טקסט.

נפסל בגלל דרישת התוסף בלבד, לא בגלל בעיית אבטחה.
אם אי פעם תהיה נכונות להתקין תוסף כרום — התבניות שם באמת טובות.

### `bluedusk/html-slides` · 70 ⭐
נגזרת של frontend-slides. הפלט מושך Chart.js, Mermaid ו-anime.js מ-CDN חיצוני.
frontend-slides עדיף.

### `inbharatai/claude-skills` · "183 סקילים"
נמצא בתוכו `generate_skills.py` עם נתיב מקודד `C:/Users/reetu/Desktop/`.
כל 183 הסקילים נוצרו אוטומטית מהסקריפט הזה וחולקים את אותו משפט מילוי מדויק:
*"Automate X operations at scale"* — נבדק, 183 מתוך 183.

לא מסוכן, פשוט ריק. **דוגמה טובה לכך שמספר כוכבים ומספר סקילים
לא אומרים כלום עד שפותחים את הקבצים.**

---

## מסקנה על תחום הווידאו

לא קיים כיום סקיל וידאו לקלוד שהוא גם פופולרי וגם מקומי לחלוטין.
כל הפרויקטים עם הרבה כוכבים בתחום מסתמכים על שירותי ענן.
שני הסקילים שנבחרו כאן קטנים ולא מוכרים — אבל נקראו במלואם, וזה מה שקבע.

בעיצוב גרפי המצב הפוך: יש שפע איכותי ומקומי.

---

## איך לבדוק סקיל חדש בעצמך

סקיל הוא בעיקרו קובץ טקסט. הסיכון מגיע משני מקומות בלבד:

1. **תיקיית `scripts/`** — הקוד שירוץ במחשב. נורות אדומות: `curl`/`fetch`/`requests.post`
   לכתובות חיצוניות, קריאה של `~/.ssh` או `.env`, `rm -rf` על נתיב לא קבוע.
2. **דרישת מפתחות API** — כל מפתח כזה אומר שתוכן יוצא לשירות מסחרי.

כללי אצבע:

- להעדיף MIT והיסטוריית קומיטים אמיתית
- להתקין קודם ב-`.claude/skills/` של פרויקט ניסיוני, לא בגלובלי
- **לא** להריץ `curl ... | bash` מה-README. לשכפל עם `git clone` ולהסתכל בקבצים
- אם קלוד מבקש להריץ פקודה מסקיל וזה לא ברור — לענות "לא"

---

## הערות על הסקילים שנבחרו

- **`claude-design`** — `references/brand-context.md` מנחה להוריד לוגו ודף בית של
  מותג מהאתר הרשמי שלו. קורה רק בבקשת עבודת מיתוג, ומדובר בנכסים ציבוריים.
  מצב הפרוטוטייפ ב-React טוען ספריות מ-unpkg **עם חתימות `integrity`** —
  זו הדרך הנכונה. לא רלוונטי לפוסטרים.
- **`frontend-slides`** — המצגות שנוצרות מקשרות לפונטים מ-Google Fonts ו-Fontshare,
  כך שהדפדפן של הצופה פונה לשם. נוגע לפונט בלבד, לא לתוכן.
  להטמיע פונט מקומי אם נדרשת מצגת אופליין מלאה.

## סקילים רשמיים שכבר מותקנים

מ-[anthropics/skills](https://github.com/anthropics/skills), המאגר הרשמי:
`canvas-design` (פוסטרים ל-PNG/PDF), `algorithmic-art`, `brand-guidelines`,
`theme-factory`, `slack-gif-creator`, `web-artifacts-builder`, `pptx`, `dataviz`.

`canvas-design` ו-`claude-design` חופפים חלקית — הראשון מוציא PNG/PDF ישירות,
השני עובד דרך HTML ונותן טיפוגרפיה ושליטת פריסה עשירות יותר. שווה להחזיק את שניהם.
