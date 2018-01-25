$Project = "N:\Works\NS57\scenes"
$RigMasterPath = "$Project\Rig"
Write-Output "Publish Path: $RigMasterPath"
# Get All maya File
Write-Output "... Getting Maya Files ... Please Wait ..."
$RNFILES = Get-Childitem "$RigMasterPath\RN" -recurse -include *.ma,*.mb
mayapy "$PSScriptRoot\ReplaceReference.py" $RigMasterPath $RNFILES
Pause