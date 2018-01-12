$RigMasterPath = "N:\Works\NS57\scenes\Rig"
Write-Output "Publish Path: $RigMasterPath"
$FacialRigWC = "*_facialRig.ma"
$FacialMasterPath = "$RigMasterPath\FacialRig"
If ((Test-Path $FacialMasterPath) -ne $True) { New-Item $FacialMasterPath -itemType Directory }
Write-Output "
... Getting Facial Rig Files ... Please Wait ..."
$FacialRigFiles = Get-Childitem N:\Works -recurse -include *.ma | Where-Object Name -like $FacialRigWC
Write-Output "
Copying FacialRig ..."
ForEach ($File in $FacialRigFiles) {
    Copy-Item $File.FullName $FacialMasterPath -Force
    Write-Output $File.Name
    }
Write-Output "
---------------- Facial Rig Copied ----------------"
$SecRigWC = "*_secondaryRig.ma"
$SecMasterPath = "$RigMasterPath\SecondaryRig"
If ((Test-Path $SecMasterPath) -ne $True) { New-Item $SecMasterPath -itemType Directory}
Write-Output "
... Getting Secondary Rig Files ... Please Wait ..."
$SecRigFiles = Get-Childitem N:\Works -recurse -include *.ma | Where-Object Name -like $SecRigWC
Write-Output "
Copying SecondaryRig ...
"
ForEach ($File in $SecRigFiles) {
    Copy-Item $File.FullName $SecMasterPath -Force
    Write-Output $File.Name
    }
Write-Output "
---------------- Secondary Rig Copied ----------------"
$RNWC = "*_RN.mb"
$RNMasterPath = "$RigMasterPath\RN"
If ((Test-Path $RNMasterPath) -ne $True) { New-Item $RNMasterPath -itemType Directory}
Write-Output "... Getting Final Rig Files ... Please Wait ..."
$RNFiles = Get-Childitem N:\Works -recurse -include *.mb | Where-Object Name -like $RNWC
Write-Output "
Copying Final Rig ..."
ForEach ($File in $RNFiles) {
    Copy-Item $File.FullName $RNMasterPath -Force
    Write-Output $File.Name
    }
Write-Output "
---------------- Final Rig Copied ----------------"
$ANWC = "*_AN.mb"
$ANMasterPath = "$RigMasterPath\AN"
If ((Test-Path $ANMasterPath) -ne $True) { New-Item $ANMasterPath  -itemType Directory}
Write-Output "
... Getting Animatic Rig Files ... Please Wait ..."
$ANFiles = Get-Childitem N:\Works -recurse -include *.mb | Where-Object Name -like $ANWC
Write-Output "
Copying Animatic Rig ..."
ForEach ($File in $ANFiles) {
    Copy-Item $File.FullName $ANMasterPath -Force
    Write-Output $File.Name
    }
Write-Output "---------------- Animatic Copied ----------------"
explorer $RigMasterPath
Pause