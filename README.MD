# Supplementary Points of Interest for Randonneurs and Bikepackers in Aotearoa New Zealand

This project provides a set of supplementary "points of interest" (POI) datasets which may be of assistance for Randonneuring or Bikepacking in Aotearoa New Zealand.
These POI's are updated from upstream data sources, so for any inaccuracies logged as Github issues, I will endeavour to correct upstream data sources for any errrors logged as Issues in GitHub.

Source data is as per its upstream source terms (such as Creative Commons etc).

## Installation

### Via manual Copy

1. Connect your Garmin GPS to your computer in 'Mass Storage Mode'
2. Open the `Garmin` folder on your GPS
3. (If not present) create a folder named `POI`
4. Manually - Copy the .gpi files from output/gpi to the Garmin/POI folder to your Garmin GPS.

### Windows Powershell

1. Connect your Garmin GPS to your computer in 'Mass Storage Mode'
2. Right click on `install.ps1`, select Run with Powershell

The script should find any Garmin devices connected to your computer and copy the files with out

```
Found Garmin volume mounted on drive G:
Found Device: id=3890552419 model=eTrex 30 part=006-B1305-00 with software version 431
VERBOSE: Performing the operation "Create Directory" on target "Destination: G:\Garmin\POI".


    Directory: G:\Garmin


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        3/02/2020  10:28 AM                POI
VERBOSE: Performing the operation "Copy File" on target "Item:
D:\craig\Downloads\supplementary-pois\gpi\laundry.gpi Destination: G:\Garmin\POI\laundry.gpi".
VERBOSE: Performing the operation "Copy File" on target "Item:
D:\craig\Downloads\supplementary-pois\gpi\RefillNZ.gpi Destination: G:\Garmin\POI\RefillNZ.gpi".
VERBOSE: Performing the operation "Copy File" on target "Item:
D:\craig\Downloads\supplementary-pois\gpi\TA-PhotoControls.gpi Destination:
G:\Garmin\POI\TA-PhotoControls.gpi".
VERBOSE: Performing the operation "Copy File" on target "Item:
D:\craig\Downloads\supplementary-pois\gpi\toilet.gpi Destination: G:\Garmin\POI\toilet.gpi".
Found Garmin volume mounted on drive E:
Found Device: id=3967014826 model=Edge 1030 part=006-B2713-00 with software version 910
POI Folder found at E:\Garmin\POI
VERBOSE: Performing the operation "Copy File" on target "Item:
D:\craig\Downloads\supplementary-pois\gpi\laundry.gpi Destination: E:\Garmin\POI\laundry.gpi".
VERBOSE: Performing the operation "Copy File" on target "Item:
D:\craig\Downloads\supplementary-pois\gpi\RefillNZ.gpi Destination: E:\Garmin\POI\RefillNZ.gpi".
VERBOSE: Performing the operation "Copy File" on target "Item:
D:\craig\Downloads\supplementary-pois\gpi\TA-PhotoControls.gpi Destination:
E:\Garmin\POI\TA-PhotoControls.gpi".
VERBOSE: Performing the operation "Copy File" on target "Item:
D:\craig\Downloads\supplementary-pois\gpi\toilet.gpi Destination: E:\Garmin\POI\toilet.gpi".
Installed 8 POI files on 2 device(s)
Press any key to continue...
```



## Data Sources

### Tour Aotearoa Photo Control Points

[![Kennett Brothers](https://www.kennett.co.nz/wp-content/themes/kennett/imgs/kennett-logo.png)](https://www.kennett.co.nz)

These are the official Photo Control Points for [Tour Aotearoa](http://www.touraotearoa.nz/p/home.html). This data is graciously supplied by the [Kennett Brothers](https://www.kennett.co.nz).

### RefillNZ

[![RefillNZ](https://refillnz.org.nz/wp-content/uploads/2019/02/logo_refil_S.png)](https://refillnz.org.nz/)

Courtesy of [RefillNZ](https://refillnz.org.nz/). This dataset includes many public fountains as well as all of the cafes and other establishments that are participating. My personal recommendation is to consider stopping at many of the cafe and establishments that support this scheme on your travels.

### Toilets

A few local authorities have officially published sets on [data.govt.nz](https://data.govt.nz). Unfortunately this is far from complete, due to areas where this data is not published. I have therefore extracted all the facilities contained in the [Zenbu](https://www.zenbu.co.nz) database to gain greater coverage, and in future may use some scripts to validate the Zenbu set against local authority sets when they are provided.

[![Zenbu](https://www.zenbu.co.nz/images/zenbu_logo3.gif)](https://www.zenbu.co.nz/)

This data is supplied by [Zenbu](https://www.zenbu.co.nz) and contains public toilets, service stations, parks and other locations where facilities may be provided.

[![CC By](https://www.zenbu.co.nz/images/CC-attribution.png)](https://creativecommons.org/licenses/by/3.0/)
Zenbu data is released under the Creative Commons Attribution license which basically says

You are free:
* to Share -- to copy, distribute and transmit the work
* to Remix -- to adapt the work
Under the following conditions:
* Attribution. You must give attribution to 'Zenbu' and link to https://www.zenbu.co.nz/.

### Laundry

[![Zenbu](https://www.zenbu.co.nz/images/zenbu_logo3.gif)](https://www.zenbu.co.nz/)

This data is supplied by [Zenbu](https://www.zenbu.co.nz) and is an extract of the [Dry Cleaning or Laundry](https://www.zenbu.co.nz/categories/24-drycleaningorlaundry) category stored in [Zenbu](https://www.zenbu.co.nz).

[![CC By](https://www.zenbu.co.nz/images/CC-attribution.png)](https://creativecommons.org/licenses/by/3.0/)
Zenbu data is released under the Creative Commons Attribution license which basically says

You are free:
* to Share -- to copy, distribute and transmit the work
* to Remix -- to adapt the work
Under the following conditions:
* Attribution. You must give attribution to 'Zenbu' and link to https://www.zenbu.co.nz/.

