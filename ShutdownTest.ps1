function Start-Hibernate {

    Write-Host "Datorn går till viloläge..."

    shutdown /h

}

function Start-Shutdown {

    Write-Host "Datorn stängs av om 10 sekunder..."

    shutdown /s /t 10

}

$Choice = Read-Host "Välj: 1 = Viloläge | 2 = Avstängning"

if ($Choice -eq "1") {

    Start-Hibernate

}
elseif ($Choice -eq "2") {

    Start-Shutdown

}
else {

    Write-Host "Felaktigt val."

}