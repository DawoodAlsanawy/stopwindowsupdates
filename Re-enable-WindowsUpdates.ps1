Set-Service -Name wuauserv -StartupType Automatic
Set-Service -Name UsoSvc -StartupType Automatic
Set-Service -Name DoSvc -StartupType Automatic
Remove-NetFirewallRule -DisplayName "Block Windows Update"
Remove-ItemProperty -Path $registryPath -Name NoAutoUpdate, AUOptions