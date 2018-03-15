$Project = "N:\Works\NS57\scenes"
$RigMasterPath = "$Project\Scenes\Rig"
# Get All maya File
Write-Output "... Getting Maya Files ... Please Wait ..."
$AllMayaFiles = Get-Childitem $Project -recurse -include *.ma,*.mb
$AllMayaFileCount = $AllMayaFiles.Length
Write-Output "Found $AllMayaFileCount maya files"
$AllMayaFiles | ForEach-Object {
    mayapy "$PSScriptRoot\cleanFiles.py" $_
}
Write-Output "
---------------- Final Rig Copied ----------------"
Pause