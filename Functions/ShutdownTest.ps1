function Start-Shutdown {

    Write-Host "Läser in inaktiva klienter..."
    
    # Läs in listan över inaktiva klienter
    $devices = Import-Csv "C:\Gron-IT-Logs\inactive_devices.csv"

    foreach ($device in $devices) {

        $ip = $device.IP

        try {
            Stop-Computer -ComputerName $ip -Force -ErrorAction Stop
            Write-Host "Stängde av $ip"
        }
        catch {
            Write-Host "Kunde inte stänga av $ip"
        }
    }
}
