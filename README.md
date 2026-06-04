# Grön IT-policyn - Projektöversikt 
(Grupp 3 i YH25) 

## Produktvision
Syftet med detta projekt är att skapa en PowerShell-modul för nätverksinventering (WMI/CIM) som identifierar inaktiva maskiner och därefter schemalägger en avstängning av dessa.

## Product Roadmap

**Sprint 0 (Fredag)** 
* Etablera vår arbetsmiljö och Scrum-struktur (inklusive product vision, product backlog och sprintplanering).
* Skapa ett gemensamt GitHub-repo komplett med en fungerande Project Board. 
Målet är att ha en genomtänkt planering inför sprint 1. Alla i teamet ska känna sig bekväma med uppgiften vi står inför och hur vi påbörjar den.

**Sprint 1 (Måndag)**
  * Skapa ett script som ska kunna skanna av nätverket efter enheter som svarar på ping och exportera en .csv fil med ip.
  * Skapa ett script som ska logga datornamn, användare och tidpunkt när avstängningskommandot skickades.
  * Skapa ett script som kan trigga en avstängning eller sätta en dator i viloläge med kommandot shutdown /h)
  * Se över om vi kan dra nytta av att använda en modulfil som kallar på functions istället för att all kod ligger i samma fil.
 Målet är att testa så att dessa scripts går att exekvera.

**Sprint 2 (Tisdag)**
  * Addera ett skript som avgör om en dator är inaktiv för att sedan baka in det i psm1
  * Fortsatt testning och utveckling av logiken för att säkerställa att PowerShell-modulen fungerar i valfritt nätverk
  * Skapa en VM miljö med en server och en klient
  * Skapa en mapplogik som skapar en loggmapp om den inte redan finns där alla logg-relaterade filer ska hamna
  * Skapa modulskriptet som kallar på functions
  * Pusha alla skripts till main för att sedan prova att köra modulskriptet (psm1)
Målet är att kunna exekvera modulfilen och alla skripts körs korrekt för att kunna stänga av en klient i nätverket som är inaktiv

**Sprint 3 (Onsdag)** 
  * Se över om vi behöver finslipa på något skript och eventuellt addera någonting
  * Testa psm1 filen för att förhoppningsvis kunna få alla skripts att fungera korrekt i följd.
  * Eventuell debugging

**Sprint 4 (Torsdag)**
  * Demonstration av produkten där vi kan visa upp ett körbart exempel som bevisar att koden fungerar.
  * Sammanställning av Scrum-masterns dokumenterade reflektioner från projektets daily stand ups, sprint reviews och retrospectives.


### Regler för GitHub Projects
1.**Ingen jobbar utan ett kort:** Varenda skript/funktion måste ha en tillhörande User Story på vår GitHub-tavla
2.**Assigna direkt:** Så fort någon påbörjar en uppgift ska personens profilbild ligga synlig på det kortet.
3.**Flytta kortet i realtid:** Ett kort får inte ligga kvar i "To Do" om någon kodar på det – det ska flyttas direkt till "In Progress"




# Sprintlogg – Grön IT-policy

Dokumentation av sprintarna i projektet, förd av Scrum Master.

Projektet bygger en PowerShell-modul för nätverksinventering som identifierar inaktiva maskiner och schemalägger avstängning, i syfte att sänka skolans energiförbrukning för IT-hårdvara under icke-arbetstid.

---

## Sprint 0

**Sprintmål:** Etablera arbetsmiljön och Scrum-strukturen, fördela roller och planera inför sprint 1.

### Vad vi gjorde
- **11:00** – Vi delade ut rollerna i gruppen.
- Projektledaren satte upp GitHub: bjöd in alla deltagare som contributors och la upp en branch för varje utvecklare.
- **12:00** – Projektledaren la upp User Stories.
- **12:15** – Vi resonerade tillsammans om vad som passar vem och vad som är rimligt att hinna med.
- **12:30–16:00** – Vi diskuterade designen och hur alla skript kan fungera tillsammans.
- **16:00** – Vi planerade för nästa sprint och vad som behövs, och avslutade sprinten.

### Vad som gick bra
- Tydlig rollfördelning och en fungerande GitHub-struktur med branch per utvecklare på plats direkt.
- Gemensam genomgång av designen, så alla hade samma bild av hur skripten skulle hänga ihop.

### Åtgärder till nästa sprint
- Alla börjar bygga sina skript som funktioner enligt den gemensamma designen.

---

## Sprint 1

**Sprintmål:** Etablera arbetssätt och struktur, alla bygger sina skript med funktioner.

### Vad vi gjorde
- Bestämde att alla skulle bygga sina skript med funktioner, så att de kan anropas senare vid testning.
- Ali och Zahra blev klara med sin del. Eftersom Gabbi redan hade loggning i sin del av skriptet tog Ali och Zahra bort den delen hos sig.
- Bestämde att använda samma filsökväg för logg och CSV för att göra det smidigare.
- ps1/psm1 sköts upp till mergingen i slutet.

### Vad som gick bra
- Projektboarden (GitHub) fungerade bra – alla hade jobbat med sin del.
- Bra kommunikation och bra ton i gruppen.
- Tydliga och fasta mål.

### Problem
- Kodkonflikt mellan Ali, Zahra och Gabbi.
- Hann inte pusha till Alex testmapp.

### Åtgärder till nästa sprint
- Inför en fast rutin för att snabbt pusha skript till Alex för test (kort tutorial gjord).
- Topprioritet: skicka alla funktioner till Alex så tidigt som möjligt så det finns tid att debugga.
- Skriva User Stories korrekt enligt Scrum.

---

## Sprint 2

**Sprintmål:** Fungerande skript och fungerande miljö.

### Vad vi gjorde
- Ali och Zahra blev färdiga, behövde bara pusha till main.
- Richard pushade till sin branch men hade inte lagt till filsökvägen för loggningen. Alex assignade Gabriella att åtgärda det i Richards skript.
- Alex funderade på om hibernate behövs.
- Diskuterade förslag om att scanna aktiva datorer direkt från terminalen istället för att läsa CSV-filen, eftersom den kan innehålla gammal data. Gabriella påpekade att vi först borde verifiera att all nuvarande kod fungerar innan vi lägger till mer.
- Alex testade projektet via skärmdelning på Discord och körde psm1-modulen i CMD:
  - Skriptet loggade shutdown i CSV utan att datorn faktiskt stängdes av.
  - Loggade systeminformation till CSV: datornamn, logon-namn och tidszon.
  - Frågade om datorn ska gå i viloläge eller stängas av (1 eller 2). Vid annat värde hände ingenting (testade med 3).
  - Listade alla lokala IP-adresser i nätet, inklusive Ubuntu-servrar (t.ex. Pi-hole).
- Alex satte upp 2 Windows-VM:ar och dubbelkollade IP-scanningen.
- Diskuterade redovisningsupplägg: köra via en main-server eller ha skriptet i Task Scheduler på varje dator. Beslut: vid redovisning används endast 2 datorer (VM) för test.

### Vad som gick bra
- Ali och Zahra blev klara med sin del.
- Alex fick igång en fungerande demo av modulen som loggade systeminformation och listade IP:n i nätet.

### Problem
- Skriptet loggade shutdown i CSV utan att datorn faktiskt stängdes av.
- Gruppen kände sig stressad – mycket att göra och trötthet efter terminen.
- Richard var inte närvarande på lektionen. Det störde inte arbetet, men gruppen önskade mer delaktighet.

### Åtgärder till nästa sprint
- Testa endast LAN istället för WAN.
- Testköra i simulerad miljö i en Windows-domän – fullt labb för att testa skriptet.

---

## Sprint 3

**Sprintmål:** Alex testar produkten i VM-labbet och felsöker den tills den är redo för redovisning.

### Vad vi gjorde
- Alex skrev nya User Stories: integrera det nya skriptet och "inactive clients"-skriptet in i psm1, i rätt ordning. Ali tog på sig uppgiften.
- Gabbi påpekade att shutdown-skriptet måste anpassas till "inactive clients"-skriptet. Alex la en User Story om detta åt Ali.
- Alex och Richard diskuterade device-loggningen: skriva över gammal loggning eller bara lägga till. Målet är att hitta de inaktiva datorerna.
- Beslut att använda datornamn istället för IP, eftersom datornamn kan pingas och IP tilldelas av DHCP (kan ändras mellan datorer).
- **13:50** – Stämde av med Ali, klar. Alla väntade sedan på att Alex skulle sätta upp VM-labbet och köra produkten.
- **14:00** – Skriptet kördes och hittade inaktiva enheter, men kunde inte stänga av dem.
- Alex testade remote shutdown av klientdator från domännamn via Windows Server (i VM). La en User Story om att alla skulle sätta upp VM-labb.
- **14:27** – Alex la till localpolicy i klienten för att aktivera remote shutdown – fungerade (klienten måste vara inloggad som admin).
- **14:33** – Alex la en User Story om att kontrollera om shutdown-kommandot fungerar från server-admin till blueadmin (klient) även när en vanlig user är inloggad. Löstes av Alex och Gabbi med lokala principer (behörighet kan sättas via GPO eller manuellt).
- **14:40** – Beslut att Alex testar med ny klientdator via GPO istället för manuell konfiguration.
- **14:54** – Med ny kunskap byter vi från IP- till DNS-baserad sökning. Alla ser över sina skript och anpassar till hostname och DNS, eftersom remote shutdown inte fungerade via IP men fungerade via DNS.
- **15:05** – Richard la till hostname i CSV-filen i sitt loggningsskript.

### Vad som gick bra
- Stora framsteg – kunde nu stänga av klientdatorn.
- Löste flera tekniska problem under dagen (remote shutdown via lokala principer och GPO).
- Det fysiska mötet upplevdes bättre än online.

### Problem
- Väntan på labbet gjorde dagen seg.
- Intensiv och rörig dag, trötthet i gruppen.
- Ali tyckte att det blev för många sprintar.
- Richard hade halkat efter från föregående dag och hann inte riktigt ikapp.

### Åtgärder till nästa sprint
- Nätverksscannern måste fungera.
- Felsöka varför DNS-namnen inte fungerar.

---

## Sprint 4

**Sprintmål:** Slutföra felsökningen inför redovisning – se till att en aktiv klient inte stängs av, och verifiera produkten i VM-labbet.

### Vad vi gjorde
- **09:00** – Standup. Sprintmålet sattes: åtgärda den sista buggen där skriptet stängde av en klient även när den var aktiv. Vi satt i grupprummet och Alex kopplade upp sin dator på projektorn så alla såg.
- **09:30** – Alla var delaktiga och kunde följa output och felmeddelanden på projektorn. Vi gav idéer och sökte lösningar tillsammans.
- **11:20** – Felsökningen pågick fortfarande. Vi gick tillbaka till den version som hade fungerat när Alex testade själv hemma. Den hade fungerat hemma men inte vid dagens test, varför vi börjat lägga till mycket extra kod.
- **11:45** – Scrum Master gjorde talkort till alla deltagare inför redovisningen.
- **12:15** – Alex fick en fungerande version genom att gå tillbaka till versionen utan dagens nya kod och bara ändra så att en klient räknas som inaktiv när den är utloggad (vilket sker automatiskt efter en viss tid) i stället för enbart på timern.
- **13:00** – Utvecklarna och projektledaren gick igenom vad som ändrats och fixade kommentarer i koden. Inactiveclients, GreenIT.psm1 och ShutdownTest hade ändrats.
- **13:15** – Deltagarna laddade ner talkorten och kontrollerade att allt stämde, medan Scrum Master skrev på loggen.
- **13:33** – Alla säkerställde att sin kod var färdig och Alex testade produkten ännu en gång. Projektledaren visade på projektorn hur han hämtade den färdiga produkten från GitHub in i VM-labbmiljön och testade att allt fungerade.
- **13:40** – Scrum Master skulle få CMD-kommandot att köras automatiskt via en bat-fil.
- **13:50** – Bat-filen gav många fel. Gabbi föreslog att köra via CMD i stället, vilket fungerade utan fel.
- **14:00** – Alex testade med ytterligare en klient-VM (tidigare testades bara med en server och en klient). Problemet var att den nya inloggade datorn inte kunde hanteras.
- **14:20** – Alex klonade sin andra VM, vilket gjorde att servern blandade ihop klienterna och skriptet inte fungerade som det skulle.
- **14:28** – Nu fungerade inte heller den första VM:en, eftersom den cachade den kopierade versionen / blandade ihop hostnamnen.
- **14:34** – Alex kollade i DNS Manager och såg att en tredje PC fanns. Den gick att pinga och vi kontrollerade om den fungerade med produkten.

### Vad som gick bra
- Vi lyckades lösa den sista buggen och fick en fungerande produkt inför redovisningen.
- Hela gruppen var delaktig i felsökningen tack vare att allt visades på projektorn.

### Problem
- Stressigt och mycket felsökning under dagen.
- Kloning av VM:ar gjorde att servern blandade ihop klienternas hostnamn, vilket tillfälligt bröt produkten.
- Bat-filen för att köra kommandot automatiskt gav fel; vi fick falla tillbaka på att köra via CMD.
