# **Disable Windows Updates Permanently - PowerShell Script**

## **⚠️ Important Warning**
- This script **stops Windows updates**, which may expose your system to security vulnerabilities.
- **Not recommended** for work devices or systems containing sensitive data.
- Best use case: Devices with **metered internet connections**.

---

## **📥 Download and Run via PowerShell**

### **1️⃣ Download the Script from GitHub**
Open **PowerShell as Administrator** and run these commands:

```powershell
# Download the script from GitHub
Invoke-WebRequest -Uri "https://github.com/DawoodAlsanawy/stopwindowsupdates.git/main/Disable-WindowsUpdates.ps1" -OutFile "$env:TEMP\Disable-WindowsUpdates.ps1"

# Navigate to the download folder
cd $env:TEMP

# Execute the script
.\Disable-WindowsUpdates.ps1
```

### **2️⃣ Run the Script Directly (Without Downloading)**
If you want to run it **without saving** to your device:
```powershell
irm "https://github.com/DawoodAlsanawy/stopwindowsupdates.git/main/Disable-WindowsUpdates.ps1" | iex
```
*(Note: `irm` is short for `Invoke-WebRequest` and `iex` is short for `Invoke-Expression`)*

---

## **🔄 Re-enable Updates (If Needed)**
```powershell
# Re-enable services
Set-Service -Name wuauserv -StartupType Automatic
Set-Service -Name UsoSvc -StartupType Automatic
Set-Service -Name DoSvc -StartupType Automatic

# Remove firewall rule
Remove-NetFirewallRule -DisplayName "Block Windows Update" -ErrorAction SilentlyContinue

# Reset registry settings
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -ErrorAction SilentlyContinue

# Restart services
Start-Service -Name wuauserv
Start-Service -Name UsoSvc
```

---

## **❓ Frequently Asked Questions (FAQ)**
### **❌ Does this work on Windows 10 and 11?**
- **Yes**, but Microsoft may enforce mandatory updates occasionally.

### **📶 Can I update manually after disabling automatic updates?**
- **Yes**, but you must **re-enable the services** first (see commands above).

### **🔧 What if the script fails to run?**
- Ensure you opened **PowerShell as Administrator**.
- Try changing the execution policy first:
  ```powershell
  Set-ExecutionPolicy Bypass -Scope Process -Force
  ```

---

## **📜 License**
This script is provided **as-is** without any warranties. Use at your own risk.
