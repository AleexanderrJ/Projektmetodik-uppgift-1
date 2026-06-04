# Funktioner för att hitta inaktiva enheter i nätverket

function Get-LocalComputerIdentifiers {
    $ids = New-Object System.Collections.Generic.List[string]

    function Add-LocalId {
        param([string]$Value)

        # Lägg bara till om värdet inte är tomt
        if (-not [string]::IsNullOrWhiteSpace($Value)) {

            # Normalisera värdet (små bokstäver, ta bort punkt i slutet)
            $cleanValue = $Value.Trim().TrimEnd('.').ToLower()

            # Undvik dubbletter
            if (-not $ids.Contains($cleanValue)) {
                [void]$ids.Add($cleanValue)
            }
        }
    }

    # Lägg till vanliga identifierare
    Add-LocalId $env:COMPUTERNAME
    Add-LocalId "localhost"
    Add-LocalId "127.0.0.1"
    Add-LocalId "::1"

    # Försök lägga till DNS-namn
    try {
        Add-LocalId ([System.Net.Dns]::GetHostName())
        Add-LocalId ([System.Net.Dns]::GetHostEntry([System.Net.Dns]::GetHostName()).HostName)
    }
    catch { }

    # Lägg till alla lokala IP-adresser
    try {
        Get-CimInstance Win32_NetworkAdapterConfiguration |
        Where-Object { $_.IPAddress -ne $null } |
        ForEach-Object {
            foreach ($address in $_.IPAddress) {
                Add-LocalId $address
            }
        }
    }
    catch { }

    return @($ids)
}

# Funktion för att avgöra om datornamn/IP är servern själv

function Test-IsLocalComputer {
    param(
        [string]$ComputerName
    )

    if ([string]::IsNullOrWhiteSpace($ComputerName) -or $ComputerName -eq "Unknown") {
        return $false
    }

    # Normalisera värdet
    $target = $ComputerName.Trim().TrimEnd('.').ToLower()
    $targetShortName = ($target -split '\.')[0]

    # Hämta alla lokala identifierare
    $localIds = Get-LocalComputerIdentifiers
    $localShortName = $env:COMPUTERNAME.ToLower()

    # Returnera true om datorn matchar servern
    return (($localIds -contains $target) -or ($targetShortName -eq $localShortName))
}

# Funktion för att avgöra om en användare är inloggad på datorn eller inte 

function Test-GreenITLoggedOff {
    param(
        [Parameter(Mandatory)]
        [string]$ComputerName,

        [string]$IPAddress
    )

    # Om hostname saknas - hoppa över
    if ([string]::IsNullOrWhiteSpace($ComputerName) -or $ComputerName -eq "Unknown") {
        return [PSCustomObject]@{
            ComputerName = $ComputerName
            IPAddress    = $IPAddress
            UserName     = $null
            IsLoggedOff  = $false
            Status       = "Skipped - Missing hostname"
        }
    }

    # Om datorn är servern själv - hoppa över
    if ((Test-IsLocalComputer -ComputerName $ComputerName) -or (Test-IsLocalComputer -ComputerName $IPAddress)) {
        return [PSCustomObject]@{
            ComputerName = $ComputerName
            IPAddress    = $IPAddress
            UserName     = $env:USERNAME
            IsLoggedOff  = $false
            Status       = "Skipped - Local computer"
        }
    }

    try {
        # Hämta information om inloggad användare via CIM
        $computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName -ErrorAction Stop
        $loggedInUser = $computerSystem.UserName

        # Om ingen användare är inloggad - datorn är inaktiv
        if ([string]::IsNullOrWhiteSpace($loggedInUser)) {
            return [PSCustomObject]@{
                ComputerName = $ComputerName
                IPAddress    = $IPAddress
                UserName     = $null
                IsLoggedOff  = $true
                Status       = "Inactive - No logged in user"
            }
        }
        else {
            # Användare är inloggad - datorn är aktiv
            return [PSCustomObject]@{
                ComputerName = $ComputerName
                IPAddress    = $IPAddress
                UserName     = $loggedInUser
                IsLoggedOff  = $false
                Status       = "Active - User logged in"
            }
        }
    }
    catch {
        # Om datorn inte går att nå - hoppa över
        return [PSCustomObject]@{
            ComputerName = $ComputerName
            IPAddress    = $IPAddress
            UserName     = $null
            IsLoggedOff  = $false
            Status       = "Skipped - Could not query computer"
        }
    }
}

# Funktion för att identifiera vilka datorer i devices.csv som är inaktiva

function Find-InactiveClients {

    # Se till att loggmappen finns
    $logfolder = "C:\Gron-IT-Logs"
    if (-not (Test-Path $logfolder)) {
        New-Item -ItemType Directory -Path $logfolder | Out-Null
    }

    # Filvägar
    $devicesPath = Join-Path $logfolder "devices.csv"
    $inactivePath = Join-Path $logfolder "inactive_devices.csv"

    # Kontrollera att devices.csv finns
    if (-not (Test-Path $devicesPath)) {
        Write-Host "devices.csv saknas. Kör Get-NetworkClients först."
        return @()
    }

    # Läs in alla hittade klienter
    $devices = Import-Csv $devicesPath

    # Lista för inaktiva datorer
    $inactive = @()

    foreach ($device in $devices) {

        $ip = $device.IP
        $hostname = $device.Hostname

        # Hoppa över om hostname saknas
        if ([string]::IsNullOrWhiteSpace($hostname) -or $hostname -eq "Unknown") {
            Write-Host "Hoppar över $ip eftersom hostname saknas."
            continue
        }

        # Hoppa över servern själv
        if ((Test-IsLocalComputer -ComputerName $hostname) -or (Test-IsLocalComputer -ComputerName $ip)) {
            Write-Host "Hoppar över lokal dator: $hostname ($ip)"
            continue
        }

        # Kontrollera om datorn är utloggad
        $result = Test-GreenITLoggedOff -ComputerName $hostname -IPAddress $ip

        if ($result.IsLoggedOff) {
            Write-Host "$hostname ($ip) är utloggad och räknas som inaktiv."

            $inactive += [PSCustomObject]@{
                IP       = $ip
                Hostname = $hostname
                Status   = "Inactive - No logged in user"
            }
        }
        else {
            Write-Host "$hostname ($ip): $($result.Status)"
        }
    }

    # Spara endast inaktiva datorer
    $inactive | Export-Csv -Path $inactivePath -NoTypeInformation -Force

    Write-Host "Hittade $($inactive.Count) inaktiva klienter."
    return $inactive
}
