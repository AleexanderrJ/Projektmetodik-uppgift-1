function Start-Shutdown {

Write-Host "Läser in inaktiva klienter..."

# Läs in listan över inaktiva klienter
$devices = Import-Csv "C:\Gron-IT-Logs\inactive_devices.csv"

foreach ($device in $devices) {

# Hämta hostname från CSV-filen
$hostname = $device.HostName

try {
Stop-Computer -ComputerName $hostname -Force -ErrorAction Stop
Write-Host "Stängde av $hostname"
}
catch {
Write-Host "Kunde inte stänga av $hostname"
}
}
}
