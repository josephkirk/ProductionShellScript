$Project = "N:\Works\NS57\scenes"
$RigMasterPath = "$Project\Scene\Rig"
$RNFILES = Get-ChildItem "$RigMasterPath\RN" | % { $_.FullName }
mayapy "$PSScriptRoot\processFiles.py" $RigMasterPath $RNFILES
Write-Output "
---------------- Final Rig Copied ----------------"
explorer $RigMasterPath
Pause