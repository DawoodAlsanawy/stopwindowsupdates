# يتطلب تشغيل البرنامج النصي بصلاحيات مدير
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# تعطيل خدمة Windows Update
Stop-Service -Name wuauserv -Force
Set-Service -Name wuauserv -StartupType Disabled

# تعطيل خدمة التحديثات التلقائية
Stop-Service -Name UsoSvc -Force
Set-Service -Name UsoSvc -StartupType Disabled

# تعديل سياسات المجموعة عبر الريجستري
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}
Set-ItemProperty -Path $registryPath -Name NoAutoUpdate -Value 1
Set-ItemProperty -Path $registryPath -Name AUOptions -Value 1

# تعطيل ميزة التحديثات التلقائية في الريجستري
$autoUpdatePath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update"
if (-not (Test-Path $autoUpdatePath)) {
    New-Item -Path $autoUpdatePath -Force
}
Set-ItemProperty -Path $autoUpdatePath -Name IncludeRecommendedUpdates -Value 0

# إيقاف خدمة توصيل التحديثات
Stop-Service -Name DoSvc -Force
Set-Service -Name DoSvc -StartupType Disabled

# إضافة قواعد جدار الحماية
New-NetFirewallRule -DisplayName "Block Windows Update" -Direction Outbound -Action Block -Program "C:\Windows\System32\svchost.exe" -Service wuauserv

Write-Host "تم تعطيل تحديثات Windows بنجاح!" -ForegroundColor Green
Write-Warning "تحذير: إيقاف التحديثات قد يعرض النظام لمخاطر أمنية!"