# uorhousepositions
Designed for UO Renaissance - http://www.uorenaissance.com/

Simple Powershell Script to download UOR housing positions and create a UOAM mapfile.  This script will offset the positions provided by http://www.uorenaissance.com/map/house.txt so they display properly in UOAM.

## Instructions:

1. Download the Powershell script
2. (Optional) The script will create a file in C:\Program Files\UOAM by default.  If you have UOAM installed elsewhere, modify the value at the top of the script to reflect the proper location.  You can also modify the name of the file that is generated. 

```powershell
$UOAMHousesFile = "C:\Program Files\UOAM\UORHouses.map"
```

3. Run Powershell script (You may need to run script as an administrator)
4. After a few moments, a file will be generated in C:\Program Files\UOAM\
5. If you haven't already, open up UOAM, hit CTRL-A, click the Files tab and Add UORHouses.map.

## Scheduling:

To make this completely automated, you can setup a job manually in Windows Task Scheduler or you can run the following Powershell commands to create a scheduled task.  Here's an example of setting this script to run every day at 9AM.

```powershell
$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-NoProfile -WindowStyle Hidden C:\Path\To\Script\UORHousePositions.ps1' 
$trigger =  New-ScheduledTaskTrigger -Daily -At 9am 
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "UOR House Map Update" -Description "Daily update of the UOR house locations for UOAM" -RunLevel Highest
```
