powercfg -h off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f > $null
powercfg -setactive SCHEME_MIN
try { tzutil /s "W. Europe Standard Time" } catch {}
$cs = Get-CimInstance Win32_ComputerSystem
Set-CimInstance -InputObject $cs -Property @{AutomaticManagedPagefile=$true}
Get-CimInstance Win32_PageFileSetting | ForEach-Object { Remove-CimInstance $_ }
