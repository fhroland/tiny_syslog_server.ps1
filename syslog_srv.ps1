# Starte den Syslog-Server (UDP 514)
$port = 514
try {
    $udpClient = New-Object System.Net.Sockets.UdpClient($port)
    Write-Host "Syslog-Server läuft auf UDP Port $port..." -ForegroundColor Green
    Write-Host "Drücke STRG+C zum Beenden."
} catch {
    Write-Host "Fehler: Konnte den UDP-Port $port nicht öffnen. Wird er bereits genutzt?" -ForegroundColor Red
    exit
}

# Speicherort für Syslog-Nachrichten
$logFile = "C:\Logs\syslog.log"
if (!(Test-Path $logFile)) { New-Item -ItemType File -Path $logFile -Force }

# Endlosschleife zum Empfangen von Syslog-Nachrichten
while ($true) {
    try {
        $remoteEndPoint = New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Any, 0)
        $data = $udpClient.Receive([ref]$remoteEndPoint)  # Daten empfangen
        if ($data -ne $null) {
            $message = [System.Text.Encoding]::ASCII.GetString($data)
            $timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            $logEntry = "$timeStamp [$($remoteEndPoint.Address)]: $message"

            # Ausgabe in Konsole & Datei
            Write-Host $logEntry -ForegroundColor Cyan
            $logEntry | Out-File -Append -FilePath $logFile
        }
    } catch {
        Write-Host "Fehler beim Empfangen von Daten: $_" -ForegroundColor Red
    }
}

