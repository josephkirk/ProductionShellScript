$Project = "N:\Works\NS57\scenes"
$RigMasterPath = "$Project\scenes\Rig"
Write-Output "Publish Path: $RigMasterPath"
$NewPath = Read-Host "Do You Want To Change Collect Path
Enter New Path (enter to skip)"
IF ($NewPath) { 
    $RigMasterPath = $NewPath
    Write-Output "Publish Path: $RigMasterPath"}
# Get All maya File
Write-Output "... Getting Maya Files ... Please Wait ..."
$AllMayaFiles = Get-Childitem $Project -recurse -include *.ma,*.mb
$AllMayaFileCount = $AllMayaFiles.Length
Write-Output "Found $AllMayaFileCount maya files"
# function
function CollectFile ($WildCard,$FolderName,$MasterFolder,$SourcesFiles) {
    $DestPath = "$MasterFolder\$FolderName"
    If ((Test-Path $DestPath) -ne $True) { New-Item $DestPath -itemType Directory }
    Write-Output "
    ... Getting Files ... Please Wait ..."
    $Files = $SourcesFiles | Where-Object Name -like $WildCard
    Write-Output "
    Copying Files ..."
    ForEach ($File in $Files) {
        Copy-Item $File.FullName $DestPath -Force
        Write-Output ($File.Name + " Modified:" + $File.LastWriteTime)
        }
    $Files
}
# Collect Facial Rig Files
CollectFile "*_facialRig.ma" "FacialRig" $RigMasterPath $AllMayaFiles
Write-Output "
---------------- Facial Rig Copied ----------------"
# Collect Secondary Rig Files
CollectFile "*_secondaryRig.ma" "SecondaryRig" $RigMasterPath $AllMayaFiles
Write-Output "
---------------- Secondary Rig Copied ----------------"
# Collect Xgen Files
"*_Xgen.mb", "*_Xgen.ma" | ForEach-Object {CollectFile $_ "Xgen" $RigMasterPath $AllMayaFiles}
Write-Output "
---------------- Xgen Copied ----------------"
# Collect Animatic Rig Files
$ANFILES = CollectFile "*_AN.mb" "AN" $RigMasterPath $AllMayaFiles
mayapy "$PSScriptRoot\ReplaceReference.py" $RigMasterPath $ANFILES
Write-Output "
---------------- Animatic Copied ----------------"
# Collect Render Rig Files
$RNFILES = CollectFile "*_RN.mb" "RN" $RigMasterPath $AllMayaFiles
mayapy "$PSScriptRoot\ReplaceReference.py" $RigMasterPath $RNFILES
Write-Output "
---------------- Final Rig Copied ----------------"
explorer $RigMasterPath
Pause