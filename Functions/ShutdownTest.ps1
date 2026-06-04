function Start-Shutdown {
    param([switch]$Simulate)

Write-Host "Läser in inaktiva klienter..."

# Läs in listan över inaktiva klienter
$devices = Import-Csv "C:\Gron-IT-Logs\inactive_devices.csv"

foreach ($device in $devices) {

# Hämta hostname från CSV-filen
$hostname = $device.HostName

# SÄKERHETSSPÄRR: Stäng inte av den lokala servern som kör skriptet
# Vi kollar både exakt matchning och om hostname börjar med datornamnet (för att hantera FQDN som server.domain.local)
if ($hostname -eq $env:COMPUTERNAME -or $hostname.StartsWith("$($env:COMPUTERNAME).") -or $hostname -eq "localhost" -or $hostname -eq "127.0.0.1") {
    Write-Host "SÄKERHETSKONTROLL: Hoppar över $hostname (detta är den lokala servern)." -ForegroundColor Yellow
    continue
}

try {
if ($Simulate) {
    Stop-Computer -ComputerName $hostname -Force -WhatIf
} else {
    Stop-Computer -ComputerName $hostname -Force -ErrorAction Stop
}
Write-Host "Stängde av $hostname"
}
catch {
Write-Host "Kunde inte stänga av $hostname"
}
}
}
