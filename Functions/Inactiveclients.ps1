# Funktion för att hitta inaktiva enheter i nätverket

function Find-InactiveClients {

    # Skapa loggmappen om den inte redan finns
    $logfolder = "C:\Gron-IT-Logs"
    if (-not (Test-Path $logfolder)) {
        New-Item -ItemType Directory -Path $logfolder | Out-Null # Kör kommandot men visa inget i terminalen
    }

    # Bestäm loggfilarnas sökväg
    $devicesPath = Join-Path $logfolder "devices.csv"
    $inactivePath = Join-Path $logfolder "inactive_devices.csv"

    # Kontrollera att devices.csv finns - annars skriv att funktion för nätverksscan behöver köras
    if (-not (Test-Path $devicesPath)) {
        Write-Host "devices.csv saknas. Kör Get-NetworkClients först."
        return
    }

    # Läs in aktiva klienter
    $devices = Import-Csv $devicesPath

    # Lista för inaktiva klienter
    $inactive = @()

    foreach ($device in $devices) {
        $ip = $device.IP

        try {
            # Hämta information från datorn för att kunna se hur länge den varit aktiv/inaktiv
            $os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $ip -ErrorAction Stop

            # Hämta senaste input-tid
            $lastInput = $os.LastInputTime

            # Räkna ut hur länge datorn varit inaktiv
            $idleMinutes = (New-TimeSpan -Start $lastInput -End (Get-Date)).TotalMinutes

            # Om datorn varit inaktiv längre än 2 minuter → markera som inaktiv
            if ($idleMinutes -gt 2) {
                $inactive += [PSCustomObject]@{
                    IP = $ip
                    IdleMinutes = [math]::Round($idleMinutes, 0)
                }
            }
        }
        catch {
            # Om vi inte kan ansluta → räkna som inaktiv
            $inactive += [PSCustomObject]@{
                IP = $ip
                IdleMinutes = "No response"
            }
        }
    }

    # Spara resultatet
    $inactive | Export-Csv -Path $inactivePath -NoTypeInformation -Force

    Write-Host "Hittade $($inactive.Count) inaktiva klienter."
    return $inactive
}

