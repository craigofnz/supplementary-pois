param(
    $src,
    $dst
)

#region functions

function Get-Symbol
{
    param(
        [parameter(Mandatory = $true, Position=0)]
        $Waypoint
    )

    # TODO (but possibly enough for this set?)
    "Drinking Water"
}

#endregion

$processedDateTime = (Get-Date).ToUniversalTime() | Get-Date -UFormat "%Y-%m-%dT%H:%M:%SZ"

@"
<?xml version="1.0" encoding="utf-8"?><gpx creator="randonneur.nz" version="1.1" xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd http://www.garmin.com/xmlschemas/WaypointExtension/v1 http://www8.garmin.com/xmlschemas/WaypointExtensionv1.xsd http://www.garmin.com/xmlschemas/TrackPointExtension/v1 http://www.garmin.com/xmlschemas/TrackPointExtensionv1.xsd http://www.garmin.com/xmlschemas/GpxExtensions/v3 http://www8.garmin.com/xmlschemas/GpxExtensionsv3.xsd http://www.garmin.com/xmlschemas/ActivityExtension/v1 http://www8.garmin.com/xmlschemas/ActivityExtensionv1.xsd http://www.garmin.com/xmlschemas/AdventuresExtensions/v1 http://www8.garmin.com/xmlschemas/AdventuresExtensionv1.xsd http://www.garmin.com/xmlschemas/PressureExtension/v1 http://www.garmin.com/xmlschemas/PressureExtensionv1.xsd http://www.garmin.com/xmlschemas/TripExtensions/v1 http://www.garmin.com/xmlschemas/TripExtensionsv1.xsd http://www.garmin.com/xmlschemas/TripMetaDataExtensions/v1 http://www.garmin.com/xmlschemas/TripMetaDataExtensionsv1.xsd http://www.garmin.com/xmlschemas/ViaPointTransportationModeExtensions/v1 http://www.garmin.com/xmlschemas/ViaPointTransportationModeExtensionsv1.xsd http://www.garmin.com/xmlschemas/CreationTimeExtension/v1 http://www.garmin.com/xmlschemas/CreationTimeExtensionsv1.xsd http://www.garmin.com/xmlschemas/AccelerationExtension/v1 http://www.garmin.com/xmlschemas/AccelerationExtensionv1.xsd http://www.garmin.com/xmlschemas/PowerExtension/v1 http://www.garmin.com/xmlschemas/PowerExtensionv1.xsd http://www.garmin.com/xmlschemas/VideoExtension/v1 http://www.garmin.com/xmlschemas/VideoExtensionv1.xsd" xmlns="http://www.topografix.com/GPX/1/1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:wptx1="http://www.garmin.com/xmlschemas/WaypointExtension/v1" xmlns:gpxtrx="http://www.garmin.com/xmlschemas/GpxExtensions/v3" xmlns:gpxtpx="http://www.garmin.com/xmlschemas/TrackPointExtension/v1" xmlns:gpxx="http://www.garmin.com/xmlschemas/GpxExtensions/v3" xmlns:trp="http://www.garmin.com/xmlschemas/TripExtensions/v1" xmlns:adv="http://www.garmin.com/xmlschemas/AdventuresExtensions/v1" xmlns:prs="http://www.garmin.com/xmlschemas/PressureExtension/v1" xmlns:tmd="http://www.garmin.com/xmlschemas/TripMetaDataExtensions/v1" xmlns:vptm="http://www.garmin.com/xmlschemas/ViaPointTransportationModeExtensions/v1" xmlns:ctx="http://www.garmin.com/xmlschemas/CreationTimeExtension/v1" xmlns:gpxacc="http://www.garmin.com/xmlschemas/AccelerationExtension/v1" xmlns:gpxpx="http://www.garmin.com/xmlschemas/PowerExtension/v1" xmlns:vidx1="http://www.garmin.com/xmlschemas/VideoExtension/v1">
  <metadata>
    <link href="https://randonneur.nz">
      <text>randonneur.nz</text>
    </link>
    <time>$ProcessedDateTime</time>
    <bounds maxlat="-35.22676" maxlon="178.00417" minlat="-46.56069" minlon="-176.55973" />
  </metadata>
"@ | Out-File -FilePath $dst -Encoding utf8 -Force

(Get-ChildItem -Path $src -Filter "*.json" | sort LastWriteTime -Descending)[0] | ForEach-Object {
    foreach ($row in (Get-Content -Raw -Path $PSItem.Fullname | ConvertFrom-Json)  )
    {
        @"
        <wpt lat="$($row.lat)" lon="$($row.lng)">          
            <name>$($row.title -replace '&', '&amp;')</name>          
            <type>user</type>
            <sym>$(Get-Symbol($row))</sym>
            <extensions>
                <gpxx:WaypointExtension>
                    <gpxx:DisplayMode>SymbolAndName</gpxx:DisplayMode>
                    <gpxx:Categories>
                        <gpxx:Category>Water</gpxx:Category>
                    </gpxx:Categories>
                </gpxx:WaypointExtension>
                <wptx1:WaypointExtension>
                    <wptx1:DisplayMode>SymbolAndName</wptx1:DisplayMode>
                    <wptx1:Categories>
                        <wptx1:Category>Water</wptx1:Category>        
                   </wptx1:Categories>
                </wptx1:WaypointExtension>
            </extensions>
        </wpt>
"@
    }
} | Out-File -FilePath $dst -Encoding utf8 -Append

'</gpx>' | Out-File -FilePath $dst -Encoding utf8 -Append
