$MAYA = "C:\Progra~1\Autodesk\Maya2017\bin\maya.exe"
$SERVERPATH = "\\ssjp-010\SCC\NS57"
$DRIVELETTER = "N"
$PROJECTPATH = "$DRIVELETTER`:/Works/NS57"
&"$env:USERPROFILE\Desktop\ShellScript\setScriptPath.ps1"
If (-not (Get-PSDrive N -ErrorAction SilentlyContinue) -and (Get-Item $SERVERPATH -ErrorAction SilentlyContinue)) {
    New-PSDrive -Persist -Name $DRIVELETTER -PSProvider "FileSystem" -Root $SERVERPATH}
Write-Output "---- Setup Network Drive N: for $SERVERPATH ----"
Write-Output "Opening MAYA and set Project at $PROJECTPATH ..."
&$MAYA -command "setProject `"`"$PROJECTPATH`"`"" 
$RUNNINGMAYAID = (Get-Process maya).id
Wait-Process -Id $RUNNINGMAYAID
Write-Output "Remove Network Drive N: for $SERVERPATH"
#Get-PSDrive N | Remove-PSDrive -Force