function Get-NetworkClients {

    $ipInfo = Get-CimInstance Win32_NetworkAdapterConfiguration |
    Where-Object { $_.IPAddress -ne $null -and $_.DefaultIPGateway -ne $null }

    $ip = $ipInfo.IPAddress[0]
    $networkBase = ($ip -split '\.')[0..2] -join '.'

    $results = 1..254 | ForEach-Object -Parallel {

        $testIP = "$using:networkBase.$_"

        if (Test-Connection -ComputerName $testIP -Count 1 -Quiet -ErrorAction SilentlyContinue) {

            [PSCustomObject]@{
                IP = $testIP
            }
        }

    } -ThrottleLimit 20

    $results | Export-Csv -Path "devices.csv" -NoTypeInformation -Force

    return $results
}

# RUN IT
Get-NetworkClients