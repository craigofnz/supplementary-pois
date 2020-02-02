$outDir     = Join-Path $PSScriptRoot 'output'
$outGPXDir  = Join-Path $outDir 'gpx'
$outGPIDir  = Join-Path $outDir 'gpi'

@($outDir, $outGPXDir, $outGPIDir) | ForEach-Object {
    if (  -not (Test-Path -Path $PSItem -PathType Container)  )
    {
        New-Item -Path $PSItem -ItemType Container -Verbose
    }
}


#region RefillNZ

.\refillnz2garmin.ps1 -src (Resolve-Path (Join-Path (Join-Path '.' 'src-data') 'refillnz')) -dst (Join-Path $outGPXDir 'RefillNZ.gpx')

#endregion

#region Zenbu

Get-ChildItem -Path (Resolve-Path (Join-Path (Join-Path '.' 'src-data') 'zenbu')) -Filter "*.csv" | ForEach-Object {
    .\zenbu2garmin.ps1    -src $PSItem.FullName -dst (Join-Path $outGPXDir "$($PSItem.BaseName).gpx")
}

#endregion

#region KennettBrothers

(Get-ChildItem -filter "*.gpx" -Path (Resolve-Path (Join-Path (Join-Path '.' 'src-data') 'kennettbrothers')) | sort LastWriteTime -Descending)[0] | ForEach-Object {
    Copy-Item -Path $PSItem.FullName -Destination (Join-Path $outGPXDir 'TA-PhotoControls.gpx') -Force
} 

#endregion

#region GPSBabel

Get-ChildItem -Path $outGPXDir | ForEach-Object {
    $dstfile = Join-Path $outGPIDir "$($PSItem.BaseName).gpi"
    $cmdParams = "-w -i gpx -f $($PSItem.Fullname) -o garmin_gpi,category=$($PSItem.BaseName),unique=1 -F $dstFile"
    "${Env:ProgramFiles(x86)}\GPSBabel\gpsbabel.exe $cmdParams"
    Start-Process -Wait -FilePath  "C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -ArgumentList $cmdParams.split(" ")
}

#endregion

#region DocnScripts

Copy-Item (Join-Path $PSScriptRoot 'README.MD') $outDir -Verbose -Force
Copy-Item (Join-Path $PSScriptRoot 'install.ps1') $outDir -Verbose -Force

#endregion

#region Package

if (  Test-Path -Path (Join-Path $outDir 'supplementary-pois.zip') )
{
    Remove-Item -Path (Join-Path $outDir 'supplementary-pois.zip') -Force
}

Push-Location $outDir
  7z.exe a -tZip supplementary-pois.zip -r 
Pop-Location

#endregion