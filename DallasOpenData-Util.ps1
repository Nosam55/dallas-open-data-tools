function New-Point {
    param(
        [Parameter(Mandatory,Position=0)]
        [double]$Latitude,
        [Parameter(Mandatory,Position=1)]
        [double]$Longitude
    )

    return [PSCustomObject]@{
        Latitude = $Latitude;
        Longitude = $Longitude;
    }
}

function Get-Distance {
    param(
        [Parameter(Mandatory,Position=0)]
        [object]$From,
        [Parameter(Mandatory,Position=1)]
        [object]$To
    )

    function To-Radians {
        param(
            [Parameter(Mandatory,Position=0)]
            [double] $degrees
        )
        return $degrees * [Math]::PI / 180; 
    }

    $delta = [PSCustomObject]@{
        Latitude = To-Radians ($To.Latitude - $From.Latitude);
        Longitude = To-Radians ($To.Longitude - $From.Latitude);
    }

    $ans = [math]::Pow([math]::Sin($delta.Latitude / 2), 2) + [math]::Cos($From.Latitude) * [math]::Cos($To.Latitude) * [math]::Pow([math]::Sin($delta.Longitude / 2), 2);

    $ans = [math]::Asin([math]::Sqrt($ans)) * 2 * 3956;

    return $ans;
}