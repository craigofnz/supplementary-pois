<#
.SYNOPSIS
Installs (copies) custom point of interest files to connected Garmin Devices.
#>

$found = 0
$installed = 0
Get-Volume | select DriveLetter, FileSystemLabel | where FileSystemLabel -eq 'GARMIN' | ForEach-Object {
    $garminFolder    = (Join-Path "$($PSItem.DriveLetter):" 'Garmin')
    $garminManifest  = (Join-Path $garminFolder 'GarminDevice.xml')
    $garminPOIFolder = (Join-Path $garminFolder 'POI')
    Write-Output "Found Garmin volume mounted on drive $($PSItem.DriveLetter):"
    if (  (Test-Path -Path $garminFolder -PathType Container)  )
    {
        if (  (Test-Path -Path $garminManifest -PathType Leaf)  )
        {
            [xml]$manifest = Get-Content -Raw $garminManifest            
            Write-Output "Found Device: id=$($manifest.Device.Id) model=$($manifest.Device.Model.Description) part=$($manifest.Device.Model.PartNumber) with software version $($manifest.Device.Model.SoftwareVersion)"
        }
        else 
        {
            Write-Warning "Could not find Garmin Device Manifest at $garminManifest"    
        }

        $found = $found + 1

        if (  (Test-Path -Path $garminPOIFolder -PathType Container)  )
        {
            Write-Output "POI Folder found at $garminPOIFolder"
        }
        else 
        {            
            New-Item -Path $garminPOIFolder -ItemType Directory -ErrorAction Stop -Verbose
        }

        Get-ChildItem -Path "$PSScriptRoot\gpi" -Filter "*.gpi" | ForEach-Object {
            Copy-Item -Path $PSItem.FullName -Destination $garminPOIFolder -Container -Verbose -Force -ErrorAction Stop
            $installed = $installed + 1
        }
    }
    else
    {
        Write-Error "Could not locate folder $garminFolder"
    }
}

Write-Output "Installed $installed POI files on $found device(s)"

try
{
    Write-Host 'Press any key to continue...'
    $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown') | Out-Null
}
catch
{
    Write-Warning "Host Terminal did not support ReadKey"
}