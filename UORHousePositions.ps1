<#
.SYNOPSIS
  A small script to pull down the latest UOR house positions
  and generate an UOAM house file
.NOTES
  Version:        1.0
  Author:         Quick
  Creation Date:  4/2/2018  
#>

# Modify this value to point 
$UOAMHousesFile = "C:\Program Files\UOAM\UORHouses.map"

# Set the offsets for each out
$HouseOffsets = @{
    "castle"          = "1,11";
    "fortress"        = "1,11";
    "keep"            = "1,6";
    "large house"     = "0,2";
    "log cabin"       = "1,0";
    "marble patio"    = "-3,-1";
    "marble shop"     = "-2,-4";
    "patio house"     = "-3,2";
    "sandstone patio" = "-1,-1";
    "small house"     = "0,-1";
    "small tower"     = "3,-1";
    "stone shop"      = "-2,-4";
    "tower"           = "1,2";
    "two story house" = "-2,2";
    "villa"           = "4,-3";
}

try {
    # Get the current housing positions from the UOR master list
    $CurrentHousePositions = Invoke-WebRequest -Uri "http://www.uorenaissance.com/map/house.txt"

    # Create a blank file or clear out the existing and set it in the UOAM format
    "3" | Out-File -FilePath $UOAMHousesFile -Encoding ASCII

    # Keep count, why not?
    $HouseCount = 0

    Write-Host "Generating $($UOAMHousesFile).."

    # Loop through each house position, use the key above to adjust the position value
    foreach ($CurrentHouse in $CurrentHousePositions.Content.Split("`n`r")) {  

        if ($CurrentHouse.Length -gt 0 -And $CurrentHouse.Contains(":")) {
            $HouseType = $CurrentHouse.Substring(1, $CurrentHouse.IndexOf(":") - 1)
            $HousePosition = $CurrentHouse.Substring($CurrentHouse.IndexOf(":") + 2).Split(" ")

            $HouseOffsetPosition = $HouseOffsets."$($HouseType)".Split(",")

            #$HouseOffsets."$($HouseType)"
            $NewXPosition = [int]$HousePosition[0] + [int]$HouseOffsetPosition[0]
            $NewYPosition = [int]$HousePosition[1] + [int]$HouseOffsetPosition[1]

            "+$($HouseType): $NewXPosition $NewYPosition $($HousePosition[2]) $HouseType" | Out-File -FilePath $UOAMHousesFile -Encoding ASCII -Append

            $HouseCount++
        }
    }

    Write-Host "$UOAMHousesFile was created with $HouseCount houses"
}
catch {
    Write-Host "Something didn't work. Maybe you need to run this in Admin mode?"
}


