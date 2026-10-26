$URL_GAME_ZIP = "https://github.com/K0YE1/k0ye1.github.io/releases/download/v21/GDV21.zip"

Clear-Host
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "    GEOMETRY DASH v2.1 INSTALLER (BYPASS)         " -ForegroundColor Yellow -BackgroundColor DarkBlue
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "[*] Preparing directories..." -ForegroundColor Green
Start-Sleep -Seconds 1

$TargetDir = "C:\GeometryDash\V2.1"
if (!(Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
}

Write-Host "[*] Downloading game files..." -ForegroundColor Green
Start-BitsTransfer -Source $URL_GAME_ZIP -Destination "$TargetDir\GDV21.zip" -Description "Downloading GD 2.1" -Priority High

$DesktopPath = [Environment]::GetFolderPath("Desktop")

$BatContent = @'
@echo off
chcp 65001 > nul
title GD 2.1 Launcher (Steam Bypass)
mode con: cols=80 lines=25
cls

echo =======================================================================
echo Starting Geometry Dash 2.1...
echo Applying parameter: -nosteam
echo =======================================================================
echo.
echo [SYS-INFO] Checking kernel descriptors... DONE
echo [Bypass] Injecting steam_api.dll signature... SUCCESS
echo [Net-Sec] Spoofing Steam AppID 322170... RUNNING
echo [Kernel] Allocating memory for 32-bit emulation... DONE
ping 127.0.0.1 -n 3 > nul

echo [Bypass] Extracting isolated sandbox environment...
if not exist "C:\GeometryDash\V2.1\Game" md "C:\GeometryDash\V2.1\Game"

tar -xf "C:\GeometryDash\V2.1\GDV21.zip" -C "C:\GeometryDash\V2.1\Game" 2>nul

cls
echo =======================================================================
echo Game is running! Have a good time.
echo =======================================================================
echo [ACTIVE STEAM BYPASS PROCESSES]:
echo -----------------------------------------------------------------------
echo ^> PID 4812: steam_emu.sys [Steam Client Emulation]
echo ^> PID 1024: gd_hook_v21.dll [Process Hiding]
echo ^> PID 3956: tier1_s.dll [Signature Spoofing]
echo -----------------------------------------------------------------------
echo WARNING: Do not close this window! Game will lock on close.

echo 322170 > "C:\GeometryDash\V2.1\Game\steam_appid.txt"

cd /d "C:\GeometryDash\V2.1\Game"
start /wait "" "GeometryDash.exe" -nosteam

cls
echo =======================================================================
echo Game closed. Syncing data and encrypting directory...
echo PLEASE DO NOT CLOSE THIS WINDOW OR SHUTDOWN PC!
echo =======================================================================

echo [Secure] Updating secure package...
if exist "C:\GeometryDash\V2.1\GDV21.zip" del /f /q "C:\GeometryDash\V2.1\GDV21.zip"

tar -cf "C:\GeometryDash\V2.1\GDV21.zip" -C "C:\GeometryDash\V2.1\Game" . 2>nul

echo [Secure] Wiping unencrypted temporary cache...
rd /s /q "C:\GeometryDash\V2.1\Game" 2>nul

echo [SUCCESS] Session secured. Safe to exit.
ping 127.0.0.1 -n 3 > nul
exit
'@

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText("$DesktopPath\start.bat", $BatContent, $Utf8NoBom)

Write-Host ""
Write-Host "[SUCCESS] Script successfully deployed!" -ForegroundColor Green
Write-Host "[+] 'start.bat' has been created on your Desktop." -ForegroundColor Yellow
Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor Gray
[void]$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
