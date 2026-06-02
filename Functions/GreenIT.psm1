# Importerar funktionerna från de andra scriptfilerna
. $PSScriptRoot\ShutdownLogger.ps1
. $PSScriptRoot\ShutdownTest.ps1
. $PSScriptRoot\aktivaKlienter.ps1

# Huvudfunktion som styr Green IT-flödet
function Start-GreenIT {

    # Söker efter aktiva klienter i nätverket
    Write-Host "1. Söker aktiva klienter..."
    $clients = Get-NetworkClients

    Write-Host ""

    # Loggar datorinformation och tidpunkt
    Write-Host "2. Loggar datorinformation..."

    # Hämtar logginformation för aktuell dator
    $logg = Write-Shutdownlog -ComputerName $env:COMPUTERNAME

    # Skriver ut logginformation till terminalen
    Write-Host "Datornamn: $($logg.ComputerName)"
    Write-Host "Användare: $($logg.UserName)"
    Write-Host "Tidpunkt: $($logg.TimeStamp)"

    Write-Host ""

    # Bestämmer automatiskt åtgärd beroende på aktiva klienter
    if ($clients.Count -gt 0) {

        # Om aktiva klienter finns → sätt datorn i viloläge
        Write-Host "Aktiva klienter hittades. Datorn sätts i viloläge."
        Start-Hibernate
    }
    else {

        # Om inga klienter hittas → stäng av datorn
        Write-Host "Inga aktiva klienter hittades. Datorn stängs av."
        Start-Shutdown
    }
}

# Exporterar funktionen så att den kan användas via Import-Module
Export-ModuleMember -Function Start-GreenIT
