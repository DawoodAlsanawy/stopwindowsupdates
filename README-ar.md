# **تعطيل تحديثات Windows نهائياً - PowerShell Script**

## **⚠️ تحذير مهم**
- هذا البرنامج **يوقف تحديثات Windows** مما قد يعرّض نظامك لثغرات أمنية.
- **غير موصى به** لأجهزة تستخدم للعمل أو تحتوي على بيانات حساسة.
- الاستخدام الأمثل: أجهزة تستخدم اتصال **محدود بالإنترنت** (مثل شبكات الـ **Metered Connection**).

---

## **📥 طريقة التنزيل والتشغيل عبر PowerShell**

### **1️⃣ تنزيل البرنامج النصي من GitHub**
افتح **PowerShell** كـ **مسؤول (Administrator)** ثم نفّذ الأوامر التالية:

```powershell
# تنزيل البرنامج النصي من GitHub
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/YourUsername/YourRepo/main/Disable-WindowsUpdates.ps1" -OutFile "$env:TEMP\Disable-WindowsUpdates.ps1"

# الانتقال إلى مجلد التحميل
cd $env:TEMP

# تشغيل البرنامج النصي
.\Disable-WindowsUpdates.ps1
```

### **2️⃣ تشغيل البرنامج النصي مباشرةً (بدون تنزيل)**
إذا كنت تريد تشغيله **دون حفظه** على جهازك:
```powershell
irm "https://raw.githubusercontent.com/YourUsername/YourRepo/main/Disable-WindowsUpdates.ps1" | iex
```
*(ملاحظة: `irm` اختصار لـ `Invoke-WebRequest` و `iex` اختصار لـ `Invoke-Expression`)*

---

## **🔄 إعادة تمكين التحديثات (إذا لزم الأمر)**
```powershell
# تشغيل الخدمات مرة أخرى
Set-Service -Name wuauserv -StartupType Automatic
Set-Service -Name UsoSvc -StartupType Automatic
Set-Service -Name DoSvc -StartupType Automatic

# حذف قاعدة جدار الحماية
Remove-NetFirewallRule -DisplayName "Block Windows Update" -ErrorAction SilentlyContinue

# إعادة ضبط إعدادات الريجستري
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -ErrorAction SilentlyContinue

# إعادة تشغيل الخدمات
Start-Service -Name wuauserv
Start-Service -Name UsoSvc
```

---

## **❓ الأسئلة الشائعة (FAQ)**
### **❌ هل يعمل هذا على Windows 10 و 11؟**
- **نعم**، لكن مايكروسوفت قد تفرض تحديثات إلزامية أحيانًا.

### **📶 هل يمكنني التحديث يدويًا بعد تعطيل التحديثات التلقائية؟**
- **نعم**، لكن يجب **إعادة تمكين الخدمات** أولاً (انظر الأوامر أعلاه).

### **🔧 ماذا لو فشل التشغيل؟**
- تأكد أنك فتحت **PowerShell كمسؤول**.
- جرب تغيير سياسة التنفيذ أولاً:
  ```powershell
  Set-ExecutionPolicy Bypass -Scope Process -Force
  ```

---

## **📜 الرخصة**
هذا البرنامج مقدم **كما هو** دون أي ضمانات. الاستخدام على مسؤوليتك الخاصة.

---

### **📌 ملاحظات إضافية**
- إذا كنت تستخدم **GitHub خاص بك**، استبدل رابط `https://raw.githubusercontent.com/...` برابط الملف الأصلي في مستودعك.
- لتفادي مشاكل **سياسة التنفيذ (ExecutionPolicy)**، يمكنك استخدام `-ExecutionPolicy Bypass` عند التشغيل:
  ```powershell
  powershell -ExecutionPolicy Bypass -File "$env:TEMP\Disable-WindowsUpdates.ps1"
  ```
