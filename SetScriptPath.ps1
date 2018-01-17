$PRODUCTIONPATH = "C:\Users\nphung\Documents\CodeProject\Production"
$DEVPATH = "C:\Users\nphung\Documents\CodeProject\Working"
$PYTHONPATH = ''
$PROMP = Read-Host "Working Script Directory (W->Dev; P->Production; Press other key to skip ...)"
IF ($PROMP -like 'P') {$PYTHONPATH = $PRODUCTIONPATH} elseIF ($PROMP -like 'W') {$PYTHONPATH = $DEVPATH}
IF ($PYTHONPATH) {
    If (-not $env:PYTHONPATH) {[Environment]::SetEnvironmentVariable("PYTHONPATH", ($PYTHONPATH))}
    elseIf ($env:PYTHONPATH.Split(';') -notcontains "$PYTHONPATH") {
        [Environment]::SetEnvironmentVariable("PYTHONPATH",($env:PYTHONPATH + ";$PYTHONPATH"))}
    Write-Output "----Setup MAYA PYTHON PATH---- $PYTHONPATH"
    If (-not $env:MAYA_SCRIPT_PATH) { [Environment]::SetEnvironmentVariable("MAYA_SCRIPT_PATH", ($PYTHONPATH)) }
    elseIf ($env:MAYA_SCRIPT_PATH.Split(';') -notcontains "$PYTHONPATH") {
        [Environment]::SetEnvironmentVariable("MAYA_SCRIPT_PATH", $PYTHONPATH, "Machine")}
    Write-Output "----Setup MAYA SCRIPT PATH---- $PYTHONPATH"}