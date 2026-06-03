# Importera funktioner
. $PSScriptRoot\ShutdownLogger.ps1
. $PSScriptRoot\ShutdownTest.ps1
. $PSScriptRoot\aktivaKlienter.ps1
. $PSScriptRoot\Inactiveclients.ps1

function Start-GreenIT {

    Write-Host "1. Söker aktiva klienter..."
    $clients = Get-NetworkClients

    Write-Host ""

    Write-Host "2. Söker inaktiva klienter..."
    $inactiveClients = Find-InactiveClients

    Write-Host ""

    # Logga serverinformation
    $logg = Write-Shutdownlog -ComputerName $env:COMPUTERNAME

    Write-Host "Datornamn: $($logg.ComputerName)"
    Write-Host "Användare: $($logg.UserName)"
    Write-Host "Tidpunkt: $($logg.TimeStamp)"

    Write-Host ""

    # Om inaktiva klienter hittas
    if ($inactiveClients.Count -gt 0) {

        Write-Host "$($inactiveClients.Count) inaktiva klienter hittades."
        Write-Host "Shutdown startas..."

        Start-Shutdown

    }
    else {

        Write-Host "Inga inaktiva klienter hittades."

    }
}

Export-ModuleMember -Function Start-GreenIT
