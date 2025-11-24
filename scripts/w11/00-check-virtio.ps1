Get-PnpDevice | Where-Object { $_.FriendlyName -match 'VirtIO|Red Hat' -or $_.Manufacturer -match 'Red Hat' } | Format-Table -AutoSize Class, FriendlyName, Status, Problem, Manufacturer
