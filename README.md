Here's the English translation of your `README.md` file:

---

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
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/YourUsername/YourRepo/main/Disable-WindowsUpdates.ps1" -OutFile "$env:TEMP\Disable-WindowsUpdates.ps1"

# Navigate to the download folder
cd $env:TEMP

# Execute the script
.\Disable-WindowsUpdates.ps1
```

### **2️⃣ Run the Script Directly (Without Downloading)**
If you want to run it **without saving** to your device:
```powershell
irm "https://raw.githubusercontent.com/YourUsername/YourRepo/main/Disable-WindowsUpdates.ps1" | iex
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

---

### **📌 Additional Notes**
- If using **your own GitHub**, replace `https://raw.githubusercontent.com/...` with your repo's raw file link.
- To avoid **execution policy issues**, use `-ExecutionPolicy Bypass` when running:
  ```powershell
  powershell -ExecutionPolicy Bypass -File "$env:TEMP\Disable-WindowsUpdates.ps1"
  ```

---

This updated file explains how to **download directly from GitHub** and run the script using **PowerShell commands** in a simple way. Let me know if you need any further additions!