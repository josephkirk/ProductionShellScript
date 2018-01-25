$Shell = (Get-Process powershell).id
Write-Output $Shell
Wait-Process -Id $Shell
explorer