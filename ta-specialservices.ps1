
#region UpdateLatLong

<# If not set, update latitude and longitude via Google Maps API #>

$srcData = Import-Csv -Path .\src-data\ta2020-special-services\TA-SpecialServices.csv

$srcData | ForEach-Object {
    if ($PSItem.Name -ne "")
    {
        if ($PSItem.latitude -eq "" -or $PSItem.longitude -eq "")
        {
            $addr = [System.Web.HttpUtility]::UrlEncode("$($PSItem.Name), $($PSItem.Address), NZ")
            $result = Invoke-RestMethod -Method GET -UseBasicParsing -Uri "https://maps.googleapis.com/maps/api/geocode/json?address=$addr&key=$Env:GOOGLE_MAPS_API_KEY"

            $PSItem.latitude = $result.results[0].geometry.location.lat
            $PSItem.longitude = $result.results[0].geometry.location.lng
        }
    }
}

$srcData | Export-Csv -Path .\src-data\ta2020-special-services\TA-SpecialServices.csv -Force -NoTypeInformation -Verbose

#endregion