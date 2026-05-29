Här är ett förslag på hur ni kan lägga upp arbetet och fördela rollerna i er grupp för projektet "Grön IT-policyn", samt en lathund för Git.
1. Rollfördelning i gruppen (5 personer)
Eftersom ni ska arbeta agilt och göra allt på väldigt kort tid ("hyperdrive" med 1-dags-sprintar
), är det viktigt att alla vet vad de ska göra. Här är ett enkelt sätt att dela upp er:
1 Product Owner (Du): Som PO är ditt huvudansvar att skriva en produktvision, skapa en product roadmap och fylla er Product Backlog med uppgifter (User Stories)
. Du bestämmer vad som ska göras och prioriterar listan.
1 Scrum Master: Denna person ser till att "Scrum-hjulet snurrar" och att ni håller era korta tidsramar för dagen
. Scrum Mastern ansvarar specifikt för att dokumentera era reflektioner från de dagliga Sprint Review- och Sprint Retrospective-mötena på eftermiddagarna
.
3 Utvecklare: Dessa tre fokuserar på själva det tekniska genomförandet: att sätta upp utvecklingsmiljön, bygga git-branch-strukturen, samt koda och testa PowerShell-modulen
. De bryter ner dina User Stories till kod.
2. Arbetsgången för dig som Product Owner
För att göra det tydligt för dig som är ny i rollen, här är vad du bör fokusera på under projektets första dag (Sprint 0):
Sätt upp GitHub-tavlan ("Project Board") så ni kan spåra arbetet
.
Skriv ner en tydlig produktvision (målet är en PowerShell-modul för nätverksinventering som hittar inaktiva maskiner och stänger av dem)
.
Skapa User Stories. Ett exempel från källorna som du kan skriva in i er Backlog är: "Som grupp vill jag ha ett gemensamt GitHub-repo med en fungerande Project Board så att vi kan spåra vårt arbete enligt Scrum."
.
3. Regler för GitHub-tavlan i projektet
Innan vi går in på Git-kommandona är det viktigt att ni följer projektets strikta regler för GitHub Projects
:
Inget arbete utan ett kort: Varje script eller funktion måste ha en User Story (eller Issue) på tavlan
.
Assigna direkt: Så fort någon börjar med en uppgift ska deras profilbild ligga på kortet
.
Flytta kort i realtid: När någon kodar ska kortet ligga i "In Progress", inte i "To Do". När koden är klar och körbar (exempelvis vid kl 15:30), flyttas kortet till "Done"
.

--------------------------------------------------------------------------------
Lathund för Git och GitHub
Observera: Källmaterialet beskriver att ni ska ha en git-branch-struktur
, men de exakta terminalkommandona för Git nedan kommer från min generella kunskapsbas för att hjälpa er komma igång, och finns inte i dina dokument.
Steg 1: Skapa ett gemensamt Repo (Bör göras av Scrum Master eller en utvecklare) En person skapar ett tomt repository på GitHub och bjuder in de andra 4 personerna som "Collaborators".
Steg 2: Koppla er lokala mapp till GitHub (Görs av alla individuellt) Öppna din terminal (t.ex. Git Bash eller VS Code terminal) i den mapp på din dator där du vill ha projektet.
Initiera git i mappen: git init
Koppla mappen till ert gemensamma GitHub-repo: git remote add origin <URL-TILL-ERT-GITHUB-REPO>
Hämta ner den senaste versionen (om repot inte är tomt): git pull origin main
Steg 3: Arbeta i en egen Branch (Undvik kodkonflikter) Enligt uppgiften ska ni kunna "koda parallellt utan konflikter"
. Gör aldrig ändringar direkt i main.
Skapa och byt till en ny branch för din specifika uppgift: git checkout -b namn-på-din-branch (t.ex. git checkout -b feature-log-file)
Skapa dina filer och skriv din kod.
Steg 4: Spara och Ladda upp koden (Push) När du har skrivit kod som uppfyller din User Story gör du följande:
Lägg till alla dina ändrade filer: git add .
Spara ändringarna lokalt med ett meddelande: git commit -m "Lade till funktion för att stänga av datorn"
Ladda upp din branch till GitHub: git push -u origin namn-på-din-branch
Efter detta går ni in på GitHub, skapar en "Pull Request" (PR) och slår ihop (mergar) er kod med main-branchen så att koden blir en del av det gemensamma basscriptet
.
