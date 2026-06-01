# Green IT - Inventering av dator

Write-Host "Inventering startar..."

# Fil där inventeringen sparas
$LogFile = "Inventering.txt"

# Hämtar datorinformation
$Computer = Get-CimInstance Win32_ComputerSystem
$OS = Get-CimInstance Win32_OperatingSystem
$CPU = Get-CimInstance Win32_Processor

# Visar information på skärmen
Write-Host "Datornamn:" $Computer.Name
Write-Host "Tillverkare:" $Computer.Manufacturer
Write-Host "Modell:" $Computer.Model
Write-Host "Operativsystem:" $OS.Caption
Write-Host "Processor:" $CPU.Name
Write-Host "RAM (GB):" ([math]::Round($Computer.TotalPhysicalMemory / 1GB, 2))

# Sparar information i textfil
Add-Content $LogFile "Inventering utförd: $(Get-Date)"
Add-Content $LogFile "Datornamn: $($Computer.Name)"
Add-Content $LogFile "Tillverkare: $($Computer.Manufacturer)"
Add-Content $LogFile "Modell: $($Computer.Model)"
Add-Content $LogFile "Operativsystem: $($OS.Caption)"
Add-Content $LogFile "Processor: $($CPU.Name)"
Add-Content $LogFile "RAM (GB): $([math]::Round($Computer.TotalPhysicalMemory / 1GB, 2))"
Add-Content $LogFile "----------------------------------------"

Write-Host "Inventering sparad i Inventering.txt"