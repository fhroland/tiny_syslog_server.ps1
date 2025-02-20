# Syslog Server PowerShell Script

A simple PowerShell script that acts as a Syslog server, receiving Syslog messages via UDP and:
- Printing them to the console
- Storing them in a log file

## 📌 Features
✔ Receives Syslog messages over **UDP Port 514**  
✔ Displays messages in the **PowerShell console**  
✔ Saves logs to a **file** (`C:\Logs\syslog.log`)  

## 🚀 Getting Started

### 🔹 1. Prerequisites
- Windows with **PowerShell 5+** (or PowerShell Core)
- Administrator privileges (to listen on port 514)
- Open UDP Port 514 in the firewall (run as Admin in PowerShell) if necessary:
  ```powershell
  New-NetFirewallRule -DisplayName "Allow Syslog UDP 514" -Direction Inbound -Protocol UDP -LocalPort 514 -Action Allow
