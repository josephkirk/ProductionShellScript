If ($env:Path.Split(';') -notcontains "C:\Python27") {
    [Environment]::SetEnvironmentVariable("Path", ($env:Path + ";C:\Python27"), "Machine")}
else {
    Write-Output "Path Enviroment contain Python Path"}
If ($env:Path.Split(';') -notcontains "C:\Program Files\Autodesk\Maya2017\bin") {
    [Environment]::SetEnvironmentVariable("Path", ($env:Path + ";C:\Program Files\Autodesk\Maya2017\bin"), "Machine")}
else {
    Write-Output "Path Enviroment contain Mayapy Path"}