# Green IT Script
# Script för att stänga av eller försätta datorn i viloläge

# Skapar en loggfil
$LogFile = "logg.txt"

# Skriver starttid i loggfilen
Add-Content $LogFile "Script startat: $(Get-Date)"

# Frågar användaren vilket alternativ som ska användas
$Choice = Read-Host "Välj: 1 = Viloläge  |  2 = Avstängning"

# Startar felhantering
try {

    # Om användaren väljer 1
    if ($Choice -eq "1") {

        # Skriver händelsen till loggfilen
        Add-Content $LogFile "Viloläge aktiverat: $(Get-Date)"

        # Försätter datorn i viloläge
        shutdown /h

    }

    # Om användaren väljer 2
    elseif ($Choice -eq "2") {

        # Skriver händelsen till loggfilen
        Add-Content $LogFile "Avstängning aktiverad: $(Get-Date)"

        # Stänger av datorn efter 30 sekunder
        shutdown /s /t 10

    }

    # Om användaren skriver fel val
    else {

        Write-Host "Felaktigt val."

    }

}

# Körs om något fel uppstår
catch {

    # Skriver felet till loggfilen
    Add-Content $LogFile "Fel: $_"

    # Visar felmeddelande på skärmen
    Write-Host "Ett fel uppstod."

}