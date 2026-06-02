function Start-Hibernate {

    Write-Host "Datorn går till viloläge..."

    shutdown /h

}

function Start-Shutdown {

    Write-Host "Datorn stängs av om 10 sekunder..."

    shutdown /s /t 10

}
