# Get Stats as markdown table

@"
# Statistics

Count of PoI (Points of Interest) per category

| Category                  | Count     |
| ------------------------- | --------- |
"@


$total = 0
Get-ChildItem -path "$PSScriptRoot\output\gpx" -filter "*.gpx" | ForEach-Object {    
    [xml]$xmlDoc = Get-Content -Raw $PSItem.FullName
    "| $($PSItem.BaseName.PadRight(25)) | $($xmldoc.gpx.wpt.count.tostring().padright(9)) |"
    $total = $total + $xmldoc.gpx.wpt.count
}

"| $('__TOTAL__'.PadRight(25)) | " + "__$($total)__".padright(9) + ' |'


