. $PSScriptRoot\ShutdownLogger.ps1
. $PSScriptRoot\ShutdownTest.ps1
. $PSScriptRoot\aktivaKlienter.ps1

function Start-GreenIT {

    Write-Host "1. Söker aktiva klienter..."
    $clients = Get-NetworkClients

    Write-Host ""
    Write-Host "2. Loggar datorinformation..."

    $logg = Write-Shutdownlog -ComputerName $env:COMPUTERNAME

    Write-Host "Datornamn: $($logg.ComputerName)"
    Write-Host "Användare: $($logg.UserName)"
    Write-Host "Tidpunkt: $($logg.TimeStamp)"

    Write-Host ""

    if ($clients.Count -gt 0) {
        Write-Host "Aktiva klienter hittades. Datorn sätts i viloläge."
        Start-Hibernate
    }
    else {
        Write-Host "Inga aktiva klienter hittades. Datorn stängs av."
        Start-Shutdown
    }
}

Export-ModuleMember -Function Start-GreenIT
