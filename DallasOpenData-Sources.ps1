. ./Parse-Data.ps1 # Include Request-RestData

function Request-Dataset {
    param(
        [Parameter(Mandatory,Position=0)]
        [string]$URL,
        [switch]$Anonymous
    )

    $AppToken = (Read-Config).AppToken;
    

    if($Anonymous){
        return Request-RestData $URL;
    }
    else {
        return Request-RestData -Headers "@{'X-App-Token' = '$AppToken'}" $URL;
    }
}

function Request-PoliceActiveCallsDPD {
    return Request-Dataset "https://www.dallasopendata.com/resource/9fxf-t2tr.json"
}

function Request-PoliceIncidentsDPD {
    return Request-Dataset "https://www.dallasopendata.com/resource/qv6i-rri7.json"
}

function Request-PoliceUnknownSuspectsDPD {
    return Request-Dataset "https://www.dallasopendata.com/resource/jitt-qwwh.json"
}

function Request-PoliceArrestChargesDPD {
    return Request-Dataset "https://www.dallasopendata.com/resource/9u3q-af6p.json"
}

function Request-PoliceArrestsDPD {
    return Request-Dataset "https://www.dallasopendata.com/resource/sdr7-6v3j.json"
}

function Request-PolicePersonDPD {
    return Request-Dataset "https://www.dallasopendata.com/resource/chez-ydz4.json"
}

function Request-DogBiteDataDPD {
    return Request-Dataset "https://www.dallasopendata.com/resource/pe63-26ny.json"
}

function Request-PoliceInvolvedVehiclesDPD {
    return Request-Dataset "https://www.dallasopendata.com/resource/hd9z-g72a.json"
}

function Request-Police311ServiceRequestsDPD {
    return Request-Dataset "https://www.dallasopendata.com/resource/d7e7-envw.json"
}

function Request-RainfallReportDPD {
    return Request-Dataset "https://www.dallasopendata.com/resource/jus4-wys9.json"
}