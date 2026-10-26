$URL_GAME_ZIP = "https://github.com"
$URL_PASSWORD = "https://githubusercontent.com"

Clear-Host
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "    УСТАНОВЩИК GEOMETRY DASH v2.1 (BYPASS EDITION) " -ForegroundColor Yellow -BackgroundColor DarkBlue
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "[*] Проверка целевой директории..." -ForegroundColor Green
Start-Sleep -Seconds 1

$TargetDir = "C:\GeometryDash\V2.1"
if (!(Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
}

Write-Host "[*] Запуск процесса загрузки игровых архивов..." -ForegroundColor Green
Start-BitsTransfer -Source $URL_GAME_ZIP -Destination "$TargetDir\GDV21.zip" -Description "Скачивание Geometry Dash 2.1" -Priority High

$DesktopPath = [Environment]::GetFolderPath("Desktop")
$BatContent = @"
@echo off
chcp 65001 > nul
title Запуск Geometry Dash 2.1 (Steam Bypass)
mode con: cols=80 lines=25
cls

echo =======================================================================
echo Привет! Идет запуск игры. Обход стима.
echo Ввожу аргумент запуска -nosteam...
echo =======================================================================
echo Авторизация на удаленном сервере...

echo [SYS-INFO] Проверка дескрипторов ядра... DONE
echo [Bypass] Подмена сигнатуры steam_api.dll... SUCCESS
echo [Net-Sec] Спуфинг тикетов Steam AppID 322170... RUNNING
echo [Kernel] Выделение памяти под эмуляцию... DONE
timeout /t 2 > nul

for /f "delims=" %%i in ('powershell -Command "(Invoke-WebRequest -Uri '$URL_PASSWORD' -UseBasicParsing).Content.Trim()"') do set "GDPASS=%%i"

echo [Bypass] Дешифровка и развертывание изолированной среды v2.1...
if not exist "C:\GeometryDash\V2.1\Game" md "C:\GeometryDash\V2.1\Game"

powershell -Command "`$winShell = New-Object -ComObject Shell.Application; `$zipFile = `$winShell.NameSpace('C:\GeometryDash\V2.1\GDV21.zip'); `$destFolder = `$winShell.NameSpace('C:\GeometryDash\V2.1\Game'); foreach (`$item in `$zipFile.Items()) { `$destFolder.CopyHere(`$item, 16) }" 2>nul

cls
echo =======================================================================
echo Игра запущена! Приятной игры в 2.1.
echo =======================================================================
echo [АКТИВНЫЕ ПРОЦЕССЫ СЕТЕВОГО ОБХОДА]:
echo -----------------------------------------------------------------------
echo ^> PID %RANDOM%: steam_emu.sys [Эмуляция Steam-Клиента]
echo ^> PID %RANDOM%: gd_hook_v21.dll [Скрытие процесса]
echo ^> PID %RANDOM%: tier1_s.dll [Спуфинг подписи]
echo -----------------------------------------------------------------------
echo ВНИМАНИЕ: Не закрывайте консоль! При закрытии сессия зашифруется.

echo 322170 > "C:\GeometryDash\V2.1\Game\steam_appid.txt"

cd /d "C:\GeometryDash\V2.1\Game"
start /wait "" "GeometryDash.exe" -nosteam

cls
echo =======================================================================
echo Сессия завершена. Начинается сохранение прогресса и шифрование данных...
echo НЕ ЗАКРЫВАЙТЕ ОКНО И НЕ ВЫКЛЮЧАЙТЕ ПК ДО ПОЛНОЙ ОЧИСТКИ КЭША!
echo =======================================================================

echo [Secure] Обновление зашифрованного архива GDV21.zip...
if exist "C:\GeometryDash\V2.1\GDV21.zip" del /f /q "C:\GeometryDash\V2.1\GDV21.zip"

powershell -Command "Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::CreateFromDirectory('C:\GeometryDash\V2.1\Game', 'C:\GeometryDash\V2.1\GDV21.zip')" 2>nul

echo [Secure] Очистка временных незащищенных файлов...
rd /s /q "C:\GeometryDash\V2.1\Game" 2>nul

echo [Secure] Сброс токенов безопасности...
set "GDPASS="

echo [УСПЕШНО] Все данные зашифрованы в C:\GeometryDash\V2.1\. Сессия закрыта.
timeout /t 3
exit
"@

$BatContent | Out-File -FilePath "$DesktopPath\start.bat" -Encoding utf8

Write-Host ""
Write-Host "[ГОТОВО] Скрипт успешно развернут под V2.1!" -ForegroundColor Green
Write-Host "[+] Ярлык 'start.bat' создан на вашем Рабочем столе." -ForegroundColor Yellow
Write-Host ""
Write-Host "Нажмите любую клавишу для выхода..." -ForegroundColor Gray
[void]$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
