# **Disable Windows Updates Permanently - PowerShell Script**

This PowerShell script disables **automatic Windows updates** to prevent unwanted internet data usage. It stops and disables Windows Update services, modifies registry settings, and blocks update-related network traffic.

## **⚠️ Warning**
- Disabling updates **exposes your system to security risks** (viruses, exploits, etc.).
- Some apps/games may **require the latest updates** to function properly.
- Use at your own risk. Recommended only for **offline machines** or **metered connections**.

---

## **📜 Script Functions**
The script performs the following actions:
1. **Stops & disables Windows Update services** (`wuauserv`, `UsoSvc`, `DoSvc`).
2. **Modifies registry keys** to prevent automatic updates.
3. **Blocks Windows Update traffic** via Windows Firewall.
4. Requires **administrator privileges** to run.

---

## **🛠️ How to Use**
1. **Save the script** as `Disable-WindowsUpdates.ps1`.
2. **Run as Administrator** (Right-click → *Run as Administrator*).
3. **Restart your PC** for changes to take effect.

### **▶️ Run the Script**
```powershell
.\Disable-WindowsUpdates.ps1
```

### **🔄 Re-enable Updates (If Needed)**
Run this in PowerShell (Admin) to revert changes:
```powershell
Set-Service -Name wuauserv -StartupType Automatic
Set-Service -Name UsoSvc -StartupType Automatic
Set-Service -Name DoSvc -StartupType Automatic
Remove-NetFirewallRule -DisplayName "Block Windows Update" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -ErrorAction SilentlyContinue
Start-Service -Name wuauserv
Start-Service -Name UsoSvc
```

---

## **❓ Frequently Asked Questions (FAQ)**
### ❌ **Will this break my Windows?**
- No, but your system **won't receive security patches**, making it vulnerable.

### 🌐 **Does this work on Windows 10 & 11?**
- **Yes**, but Microsoft may bypass these settings in future updates.

### 📶 **Can I still manually update?**
- **Yes**, but you must **re-enable services** first (see above).

### 🔥 **What if Windows re-enables updates automatically?**
- Some Windows versions **force updates**. You may need to run the script again.

---

## **📜 License**
This script is provided **as-is** without warranties. Use responsibly.
