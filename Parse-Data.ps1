function Request-RestData {
    param(
        [Parameter(Mandatory, Position=0)]
        [string]$URL,
        [Parameter(ValueFromRemainingArguments)]
        [string] $CurlArgs
    )

    $request = "Invoke-WebRequest $($CurlArgs -join ' ') $URL";

    $response = Invoke-Expression $request;

    if($response.Headers['Content-Type'] -like '*/json*'){
        return ConvertFrom-Json $response.Content;
    }
    elseif ($response.Headers['Content-Type'] -like '*/csv*'){
        return ConvertFrom-Csv $response.Content;
    }
    else 
    {
        $ctype = $response.Headers['Content-Type']
        Write-Warning "Could not parse Content-Type '$ctype'! Returning null";

        return $null;
    }
}

function Get-Schema {
    param(
        [Parameter(Mandatory,Position=0,ValueFromPipeline)]
        [object] $Object
    )

    return $Object | Get-Member -MemberType NoteProperty | ForEach-Object {$_.Name} | ForEach-Object {"${_}: $($Object.$_.GetType())"};
}

function Read-Config {
    return ConvertFrom-Json ((Get-Content './config.json') -join "`n");
}