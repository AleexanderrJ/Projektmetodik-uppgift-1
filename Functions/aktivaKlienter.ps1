# Funktion för att skanna nätverket och lista aktiva klienter (IP-adresser)
function Get-NetworkClients {

    # Skapa loggmappen om den inte redan finns
    $logfolder = "C:\Gron-IT-Logs"
    if (-not (Test-Path $logfolder)) {
        New-Item -ItemType Directory -Path $logfolder | Out-Null  # Skapa mappen tyst
    }

    # Bestäm loggfilens sökväg (devices.csv sparas i loggmappen)
    $LogPath = Join-Path $logfolder "devices.csv"

    # Hämta nätverksinformation från datorn (IP-adress + gateway)
    $ipInfo = Get-CimInstance Win32_NetworkAdapterConfiguration |
    Where-Object { $_.IPAddress -ne $null -and $_.DefaultIPGateway -ne $null }

    # Plocka ut datorns IP-adress
    $ip = $ipInfo.IPAddress[0]

    # Beräkna nätverksbasen (ex: 192.168.1)
    $networkBase = ($ip -split '\.')[0..2] -join '.'

    # Skanna alla IP-adresser i nätverket (1–254)
    $results = 1..254 | ForEach-Object -Parallel {

        # Bygg IP-adressen som ska testas
        $testIP = "$using:networkBase.$_"

        # Testa om IP-adressen svarar på ping
        if (Test-Connection -ComputerName $testIP -Count 1 -Quiet -ErrorAction SilentlyContinue) {

          # Försök hämta hostname från IP-adressen
try {
    $hostname = [System.Net.Dns]::GetHostEntry($testIP).HostName
}
catch {
    $hostname = "Unknown"
}

# Returnera objekt med hostname istället för bara IP
[PSCustomObject]@{
    Hostname = $hostname
    IP       = $testIP
}
        }

    } -ThrottleLimit 20

    # Exportera resultatet till CSV i loggmappen
    $results | Export-Csv -Path $LogPath -NoTypeInformation -Force

    # Returnera resultatet (bra för felsökning eller vidare användning)
    return $results
}
