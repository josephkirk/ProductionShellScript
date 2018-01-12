# Variable Declaration
$WorkSpace = "N:\Works\NS57"
$Scenes = "$WorkSpace\scenes\Model"
$Tex = "$WorkSpace\sourceimages\Model"
$Category = ''
$AssetName = ''
$AssetVerName = ''
$AssetType = ''
# Function
While (-not $Category) {$Category = Read-Host "Asset Category"}
While (-not $AssetName) {$AssetName = Read-Host "Asset Name"}
$SeachDir = "$Scenes\$Category"
$AssetDir = Get-ChildItem $SeachDir | Where-Object Name -Like "*$AssetName"
Write-Output $AssetDir[0].FullName
$AssetVersions = Get-ChildItem $AssetDir[0].FullName | Sort-Object Name | Where-Object Name -Like "$AssetName*"
Write-Output $AssetVersions
$AssetFiles = @{}
$AssetVersions | ForEach-Object {
    $Ver = $_.Name.Split('_')[1]
    $Files = Get-ChildItem -Path $_.FullName -File | Sort-Object LastWriteTime -Descending
    $RNFile = $Files | Where-Object Name -like "*RN*" | Select-Object -First 1
    $ANFile = $Files | Where-Object Name -like "*AN*" | Select-Object -First 1
    $LastestFile = $Files | Where-Object {
        ($_.Name -notLike "*RN*") -and ($_.Name -NotLike "*AN*")} | Select-Object -First 1
    $AssetFiles.Add($Ver, @{"Lastest" = $LastestFile; "RN" = $RNFile; "AN" = $ANFile})}
Write-Output $AssetFiles
If ($AssetName.Split('_').length -ge 2) {
    $AssetVerName = $AssetName.Split('_')[1]
} else {
    While (-not $AssetVerName) {$AssetVerName = Read-Host "Asset Version"}
}
While (-not $AssetType) {$AssetType = Read-Host "Asset Type"}
$FileOpen = $AssetFiles[$AssetVerName][$AssetType]
If ($FileOpen) {
    maya -file $FileOpen.FullName
    Write-Output "Starting Maya ..."
    Write-Output ("Open File " + $FileOpen.Name + "...")}
else {
    Write-Output "Asset Version $AssetVerName is not valid or Asset Type $AssetType is Empty"
}
Pause