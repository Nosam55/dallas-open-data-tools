. ./DallasOpenData-Sources.ps1
. ./DallasOpenData-Util.ps1

function Get-CrimesInDistance {
    param(
        [Parameter(Mandatory,Position=0)]
        [object[]]$Crimes,
        [Parameter(Mandatory,Position=1)]
        [double]$Limit,
        [double] $Latitude,
        [double] $Longitude
    )

    $config = Read-Config;
    
    if($null -eq $Latitude -or $null -eq $Longitude){
        $Latitude = $config.Latitude;
        $Longitude = $config.Longitude;
    }

    $HomeLocation = New-Point $Latitude $Longitude;

    $InRange = $Crimes | Where-Object {(Get-Distance $HomeLocation (New-Point $_.geocoded_column.Latitude $_.geocoded_column.Latitude)) -lt $Limit};

    return $InRange;
}

function Get-CrimesByYear {
    param(
        [Parameter(Mandatory,Position=0)]
        [object[]] $Crimes
    )

    return $Crimes | Group-Object -Property {$_.servyr} | Sort-Object -Property {$_.Name} | ForEach-Object {[PsCustomObject]@{Year = $_.Name; Count = $_.Count}}
}

function Get-ArrestsByYear {
    param(
        [Parameter(Mandatory,Position=0)]
        [object[]]$Arrests
    )

    return $Arrests | Group-Object -Property {$_.arrestyr} | Sort-Object -Property {$_.Name} | ForEach-Object {[PsCustomObject]@{Year = $_.Name; Count = $_.Count}}
}