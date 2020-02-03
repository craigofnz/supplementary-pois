param(
    [parameter(Mandatory = $true)]
    [ValidateScript({  Test-Path -Path $_ -PathType Leaf  })]
    $src,

    [parameter(Mandatory = $true)]    
    $dst
)

#region functions
function load_countrydata
{
    # Much borrowed from: https://www.leedesmond.com/2018/02/powershell-get-list-of-two-letter-country-iso-3166-code-alpha-2-currency-language-and-more/
    if ($null -eq $Script:Sys_CountryData)
    {
        $Script:Sys_CountryData = @()
        $Script:Sys_CountryData = [System.Globalization.CultureInfo]::GetCultures([System.Globalization.CultureTypes]::SpecificCultures) | ForEach-Object {
            $dn = $_.DisplayName.Split("(|)");
            $RegionInfo = New-Object System.Globalization.RegionInfo $PsItem.name;
            [pscustomobject] @{
                Name = $RegionInfo.Name;
                EnglishName = $RegionInfo.EnglishName;
                TwoLetterISORegionName = $RegionInfo.TwoLetterISORegionName;
                GeoId = $RegionInfo.GeoId;
                ISOCurrencySymbol = $RegionInfo.ISOCurrencySymbol;
                CurrencySymbol = $RegionInfo.CurrencySymbol;
                IsMetric = $RegionInfo.IsMetric;
                LCID = $PsItem.LCID;
                Lang = $dn[0].Trim();
                Country = $dn[1].Trim();
            }        
        }
    }
}

function Get-CountryName
{
    param(
        #[parameter(mandatory=$true, Position=0)]
        $ISO2LetterCountryCode
    )

    if ($null -ne $ISO2LetterCountryCode)
    {
        load_countrydata

        ($Script:Sys_CountryData | where TwoLetterISORegionName -eq $ISO2LetterCountryCode)[0].EnglishName
    }
    else 
    {
        ""    
    }
}

function Get-Symbol
{
    param(
        [parameter(Mandatory = $true, Position=0)]
        $Waypoint
    )

    $cats = $Waypoint.Categories.Split(' ')

    if     ($cats -contains 'CivicStructure/Toilet')     { 'Restroom'       }
    elseif ($cats -contains 'Campground')                { 'Campground'     }
    elseif ($cats -contains 'DryCleaningOrLaundry')      { 'Contact, Cat'   }
    elseif ($cats -contains 'Playground')                { 'Amusement Park' }
    elseif ($cats -contains 'GasStation')                { 'Gas Station'    }
    elseif ($cats -contains 'Park')                      { 'Park'           }    
    elseif ($cats -contains 'Museum')                    { 'Museum'         }
    elseif ($cats -contains 'TouristInformationCenter')  { 'Information'    }
    elseif ($cats -contains 'TouristAttraction')         { 'Museum'         }
    elseif ($cats -contains 'RVPark')                    { 'RV Park'        }
    elseif ($cats -contains 'TrainStation')              { 'Railway'        }
    elseif ($cats -contains 'LodgingBusiness')           { 'Lodge'          }
    elseif ($cats -contains 'Restaurant')                { 'Restarant'      }
    elseif ($cats -contains 'CivicStructure/PublicPhone'){ 'Telephone'      }
    elseif ($cats -contains 'StadiumOrArena')            { 'Stadium'        }
    elseif ($cats -contains 'ExerciseGym')               { 'Fitness Center' }
    elseif ($cats -contains 'SportsActivityLocation')    { 'Fitness Center' }
    elseif ($cats -contains 'Store')                     { 'Shopping Center'}
    elseif ($cats -contains 'LocalBusiness')             { 'Restarant'      }
    elseif ($cats -contains 'TA-SpecialServices')        { 'Flag'           } # From manually built CSV
    else {
        $Waypoint.Categories | Write-Warning                
    }
    
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

Import-Csv -Path $src | ForEach-Object {
    @"
    <wpt lat="$($PSItem.latitude)" lon="$($PSItem.longitude)">
        <time>$($PSItem.updated_at)</time>
        <name>$($PSItem.name -replace '&', '&amp;')</name>          
        <type>user</type>
        <sym>$(Get-Symbol($PSITem))</sym>
"@ | Write-Output

    if (  ($null -ne $PSItem.opening_hours) -and ($PSItem.opening_hours.length -gt 0) -and ($null -ne $PSItem.description) -and ($PSItem.description.length -gt 0))
    {
        "        <cmt>$($PSItem.opening_hours -replace '&', '&amp;')$($PSItem.description -replace '&', '&amp;')</cmt>"
        "        <desc>$($PSItem.opening_hours -replace '&', '&amp;')$($PSItem.description -replace '&', '&amp;')</desc>"
    }

    if (  ($null -ne $PSItem.website) -and ($PSItem.website.length -gt 0)  )
    {
        "        <link href=`"$($PSItem.website -replace '&', '&amp;')`" />"  | Write-Output
    }
    if ($null -ne $PSItem.facebook_page -and ($PSItem.facebook_page.length -gt 0)  )
    {
        "        <link href=`"$($PSItem.facebook_page -replace '&', '&amp;')`" />"  | Write-Output
    }

    @"
    <extensions>
        <gpxx:WaypointExtension>
            <gpxx:DisplayMode>SymbolAndName</gpxx:DisplayMode>
            <gpxx:Categories>
"@ | Write-Output
    $PSItem.Categories.Split(' ') | ForEach-Object {
        "                  <gpxx:Category>$PSItem</gpxx:Category>"
    } | Write-Output

@"            
    </gpxx:Categories>
    <gpxx:Address>
            <gpxx:StreetAddress>$($PSItem.physical_address -replace '&', '&amp;')</gpxx:StreetAddress>
            <gpxx:City>$($PSItem.Region_2)</gpxx:City>
            <gpxx:State>$($PSItem.Region_1)</gpxx:State>
            <gpxx:Country>$(Get-CountryName($PSItem.country_code))</gpxx:Country>              
        </gpxx:Address>
"@ | Write-Output

    if ($null -ne $PSItem.phone)
    {
        "            <gpxx:PhoneNumber>$($PSItem.phone)</gpxx:PhoneNumber>" | Write-Output
    }
    
    @"
    </gpxx:WaypointExtension>
        <wptx1:WaypointExtension>
        <wptx1:DisplayMode>SymbolAndName</wptx1:DisplayMode>
        <wptx1:Categories>
"@ | Write-Output

    $PSItem.Categories.Split(' ') | ForEach-Object {
        "                      <wptx1:Category>$PSItem</wptx1:Category>"
    } | Write-Output
        
    @"
    </wptx1:Categories>
        <wptx1:Address>
            <wptx1:StreetAddress>$($PSItem.physical_address -replace '&', '&amp;')</wptx1:StreetAddress>
            <wptx1:City>$($PSItem.Region_2)</wptx1:City>
            <wptx1:State>$($PSItem.Region_1)</wptx1:State>
            <wptx1:Country>$(Get-CountryName($PSItem.country_code))</wptx1:Country>
        </wptx1:Address>
"@ | Write-Output
    if ($null -ne $PSItem.phone)
    {
        "             <wptx1:PhoneNumber>$($PSItem.phone)</wptx1:PhoneNumber>" | Write-Output        
    }

    @"
        </wptx1:WaypointExtension>
        <ctx:CreationTimeExtension>
        <ctx:CreationTime>2020-02-01T05:44:09Z</ctx:CreationTime>
        </ctx:CreationTimeExtension>
    </extensions>
    </wpt>

"@
} | Out-File -FilePath $dst -Encoding utf8 -Append

'</gpx>' | Out-File -FilePath $dst -Encoding utf8 -Append
