$CHSend = @("*MK*", "*UK*", "*OS*")
$FRPath = get-item N:\Works\NS57\scenes\Model\CH\_Common\FacialRetake
$SendFolder = get-item N:\to\180112_03\Works\NS57
$FRCHPaths = get-childitem $FRPath -directory
$FRFiles = ForEach ($FR in $FRCHPaths) { get-childitem $FR.FullName | Sort-Object LastAccessTime -Descending | Select-Object -First 1}
$CHSendPaths = ForEach ($CHName in $CHSend) { $FRFiles | Where-Object Name -like $CHName }
$CHDesSendPaths = ForEach ($File in $CHSendPaths) { new-item ($SendFolder.FullName + "\scenes\Model\CH\" + $File.Directory.Name + "\FacialRetake") -ItemType Directory}
0,1,2 | ForEach-Object {copy-item $CHSendPaths[$_].fullname ($CHDesSendPaths[$_].fullname + '\' + $CHSendPaths[$_].name)}