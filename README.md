# Grön IT-policyn - Projektöversikt 
(Grupp 3 i YH25) 

## Produktvision
Syftet med detta projekt är att skapa en PowerShell-modul för nätverksinventering (WMI/CIM) som identifierar inaktiva maskiner och därefter schemalägger en avstängning av dessa.

## Product Roadmap

**Sprint 0 (Fredag)** 
* Etablera vår arbetsmiljö och Scrum-struktur (inklusive product vision, product backlog och sprintplanering).
* Skapa ett gemensamt GitHub-repo komplett med en fungerande Project Board.
***Mål (Inkrement 1):** Målet är att ha en genomtänkt planering inför sprint 1. Alla i teamet ska känna sig bekväma med uppgiften vi står inför och hur vi påbörjar den.

**Sprint 1 (Måndag)**
  * Skapa ett script som ska kunna skanna av nätverket efter enheter som svarar på ping och exportera en .csv fil med ip.
  * Skapa ett script som ska logga datornamn, användare och tidpunkt när avstängningskommandot skickades.
  * Skapa ett script som kan trigga en avstängning eller sätta en dator i viloläge med kommandot shutdown /h)
  * Se över om vi kan dra nytta av att använda en modulfil som kallar på functions istället för att all kod ligger i samma fil.
  **Mål (Inkrement 2):** Målet är att testa så att dessa scripts går att exekvera.

**Sprint 2 (Tisdag)**
  * Addera ett skript som avgör om en dator är inaktiv för att sedan baka in det i psm1
  * Fortsatt testning och utveckling av logiken för att säkerställa att PowerShell-modulen fungerar i valfritt nätverk
  * Skapa en VM miljö med en server och en klient
  * Skapa en mapplogik som skapar en loggmapp om den inte redan finns där alla logg-relaterade filer ska hamna
  * Skapa modulskriptet som kallar på functions
  * Pusha alla skripts till main för att sedan prova att köra modulskriptet (psm1)

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
