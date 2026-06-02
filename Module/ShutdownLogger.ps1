# Funktion för att logga datornamn, inloggad användare och tidpunkt när ett avstängningskommando skickas.

function Write-Shutdownlog {
    param (
        # Obligatorisk parameter: namnet på datorn som ska loggas
        [Parameter(Mandatory)]
        [string]$Computername
    )

    # Skapa loggmappen om den inte redan finns
    $logfolder = "C:\Gron-IT-Logs"
    if (-not (Test-Path $logfolder)) {
        New-Item -ItemType Directory -Path $logfolder | Out-Null # Kör kommandot men visa inget i terminalen
    }

    # Bestäm loggfilens sökväg
    $Logpath = Join-Path $logfolder "shutdown_log.csv"

    # Försök hämta systeminformation från den angivna datorn via CIM (ex. inloggad användare och datornamn)
    try {
        $systemInfo = Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $Computername -ErrorAction Stop
        # Plockar ut inloggad användare från systeminformationen
        $user = $systemInfo.UserName
        # Plockar ut datornamnet från systeminformationen
        $name = $systemInfo.Name
    }
    catch {
        # Om CIM-anropet misslyckas (t.ex. pga brandvägg eller ingen användare), logga Unknown men krascha inte
        $user = "Unknown"
        $name = $Computername
    } 

    # Skapar en tidsstämpel för när loggningen sker
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Skapa loggpost med all logginformation som ska sparas i CSV-filen
    $entry = [PSCustomObject]@{
        ComputerName = $name
        UserName = $user
        TimeStamp = $timestamp
    }

    # Om loggfilen inte finns skapas den, annars läggs posten till i slutet av filen
    if (-not (Test-Path $LogPath)) {
        $entry | Export-Csv -Path $LogPath -NoTypeInformation
    }
    else {
        $entry | Export-Csv -Path $LogPath -Append -NoTypeInformation # Append = lägger till loggposten längst ner i filen utan att skriva över tidigare poster
    }

    # Returnerar loggposten som output (bra för felsökning eller vidare användning)
    return $entry

}