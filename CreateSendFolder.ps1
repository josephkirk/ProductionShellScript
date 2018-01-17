$BasePath = "N:\to"
$CurDate = Get-Date -UFormat "%y%m%d"
$TestFolder = Get-ChildItem $BasePath -directory | where-object Name -like "$CurDate*" | Sort-Object LastWriteTime -Descending
$Version = $TestFolder.length + 1
$SendDir = If ($Version -gt 1) { $CurDate + "_" + $Version.ToString("D2") } else { $CurDate }
$SCSendDir = "$BasePath\$SendDir\Works\NS57\scenes\Model"
$SISendDir = "$BasePath\$SendDir\Works\NS57\sourceimages\Model"
"CH", "BG", "CP" | ForEach-Object {
    New-Item "$SCSendDir\$_" -ItemType Directory
    New-Item "$SISendDir\$_" -ItemType Directory}
explorer "$BasePath\$SendDir"
Pause