1..254 | ForEach-Object -Parallel {

    $ip = "192.168.1.$_"

    if(Test-Connection $ip -Count 1 -Quiet){

        [PSCustomObject]@{

            IP = $ip

        }

    }

} -ThrottleLimit 20 | Export-Csv devices.csv -NoTypeInformation