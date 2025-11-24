$targetName = "VM_Office"
$current = (Get-ComputerInfo).CsName
if ($current -ne $targetName) { Rename-Computer -NewName $targetName -Force -PassThru; Restart-Computer } else { Write-Host "Computer name already $targetName." }
