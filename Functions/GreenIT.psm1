. $PSScriptRoot\ShutdownLogger.ps1
. $PSScriptRoot\ShutdownTest.ps1
. $PSScriptRoot\aktivaKlienter.ps1

function Start-GreenIT {

    Write-Host "1. Söker aktiva klienter..."
    Get-NetworkClients

    Write-Host "2. Loggar datorinformation..."
    Write-Shutdownlog -ComputerName $env:COMPUTERNAME

    $choice = Read-Host "1 = Viloläge | 2 = Avstängning"

    if ($choice -eq "1") {
        Start-Hibernate
    }
    elseif ($choice -eq "2") {
        Start-Shutdown
    }
    else {
        Write-Host "Felaktigt val."
    }
}

Export-ModuleMember -Function Start-GreenIT
