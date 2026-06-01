# Green IT - Avstängning av inaktiv dator

# Skriver ut att scriptet startar
Write-Host "Scriptet startar"

# Hämtar aktuell tid
$Time = Get-Date

# Sparar tidpunkten i loggfilen
Add-Content -Path ".\log.txt" -Value "Avstängning testad: $Time"

# Bekräftar att loggen skapats
Write-Host "Logg skapad"

# Väntar 10 sekunder
Start-Sleep -Seconds 10

# Stänger av datorn
shutdown /s /t 10