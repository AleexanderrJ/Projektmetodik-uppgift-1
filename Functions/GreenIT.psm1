# Importera funktioner
. $PSScriptRoot\ShutdownLogger.ps1
. $PSScriptRoot\ShutdownTest.ps1
. $PSScriptRoot\aktivaKlienter.ps1
. $PSScriptRoot\Inactiveclients.ps1

function Start-GreenIT {
    param(
        # Använd -WhatIf för att testa utan att faktiskt stänga av klienter
        [switch]$WhatIf
    )

    Write-Host "1. Söker aktiva klienter..."
    $clients = Get-NetworkClients

    Write-Host ""

    Write-Host "2. Söker inaktiva klienter..."
    $inactiveClients = Find-InactiveClients

    Write-Host ""

    # Om inaktiva klienter hittas
    if ($inactiveClients.Count -gt 0) {

        Write-Host "$($inactiveClients.Count) inaktiva klienter hittades."

        if ($WhatIf) {
            Write-Host "Testläge är aktivt. Ingen dator kommer stängas av."
        }
        else {
            Write-Host "Shutdown startas..."
        }

        Start-Shutdown -WhatIf:$WhatIf

    }
    else {

        Write-Host "Inga inaktiva klienter hittades."

    }
}

Export-ModuleMember -Function Start-GreenIT, Test-GreenITLoggedOff
