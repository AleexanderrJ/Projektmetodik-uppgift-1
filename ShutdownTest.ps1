# Green IT Script
# Script för att stänga av eller försätta datorn i viloläge

# Frågar användaren vilket alternativ som ska användas
$Choice = Read-Host "Välj: 1 = Viloläge | 2 = Avstängning"

try {

    if ($Choice -eq "1") {

        Write-Host "Datorn går till viloläge..."

        shutdown /h

    }

    elseif ($Choice -eq "2") {

        Write-Host "Datorn stängs av om 10 sekunder..."

        shutdown /s /t 10

    }

    else {

        Write-Host "Felaktigt val."

    }

}

catch {

    Write-Host "Ett fel uppstod."

}