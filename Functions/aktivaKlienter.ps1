function Get-NetworkClients {

    $logfolder = "C:\Gron-IT-Logs"

    if (-not (Test-Path $logfolder)) {
        New-Item -ItemType Directory -Path $logfolder | Out-Null
    }

    $LogPath = Join-Path $logfolder "devices.csv"

    $ipInfo = Get-CimInstance Win32_NetworkAdapterConfiguration |
    Where-Object { $_.IPAddress -ne $null -and $_.DefaultIPGateway -ne $null }

    # Serverns egen IP
    $myIP = $ipInfo.IPAddress[0]

    # Nätverksbas, t.ex. 192.168.1
    $networkBase = ($myIP -split '\.')[0..2] -join '.'

    $results = 1..254 | ForEach-Object -Parallel {

        $testIP = "$using:networkBase.$_"

        # Hoppa över serverns egen IP
        if (
            $testIP -ne $using:myIP -and
            (Test-Connection -ComputerName $testIP -Count 1 -Quiet -ErrorAction SilentlyContinue)
        ) {

            [PSCustomObject]@{
                IP = $testIP
            }
        }

    } -ThrottleLimit 20

    $results | Export-Csv -Path $LogPath -NoTypeInformation -Force

    return $results
}
