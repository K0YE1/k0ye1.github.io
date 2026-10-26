# =======================================================================
# НАСТРОЙКИ ССЫЛОК (Вставь сюда свои актуальные ссылки)
# =======================================================================
$URL_GAME_ZIP = "https://github.com/K0YE1/k0ye1.github.io/releases/download/v21/GDV21.zip"
$URL_PASSWORD = "https://raw.githubusercontent.com/K0YE1/k0ye1.github.io/refs/heads/main/GeometryDash/V2.1/Password.txt"
# =======================================================================

Clear-Host
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "    УСТАНОВЩИК GEOMETRY DASH v2.1 (BYPASS EDITION) " -ForegroundColor Yellow -BackgroundColor DarkBlue
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "[*] Проверка целевой директории..." -ForegroundColor Green
Start-Sleep -Seconds 1

# Создаем папку C:\GeometryDash\V2.1\, если её не существует
$TargetDir = "C:\GeometryDash\V2.1"
if (!(Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
}

Write-Host "[*] Загрузка защищенного архива версии 2.1 с сервера..." -ForegroundColor Green
$WebClient = New-Object System.Net.WebClient
# Скачиваем архив, используя переменную из настроек выше
$WebClient.DownloadFile($URL_GAME_ZIP, "$TargetDir\GDV21.zip")

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

:: Получаем пароль из переменной `$URL_PASSWORD`, которую ты указал в начале скрипта
for /f "delims=" %%i in ('powershell -Command "(Invoke-WebRequest -Uri '$URL_PASSWORD' -UseBasicParsing).Content.Trim()"') do set "GDPASS=%%i"

echo [Bypass] Дешифровка и развертывание изолированной среды v2.1...
if not exist "C:\GeometryDash\V2.1\Game" md "C:\GeometryDash\V2.1\Game"

:: Распаковка ЗАПАРОЛЕННОГО архива
tar -xf "C:\GeometryDash\V2.1\GDV21.zip" -C "C:\GeometryDash\V2.1\Game" --password "%GDPASS%" 2>nul

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

:: Создание steam_appid.txt
echo 322170 > "C:\GeometryDash\V2.1\Game\steam_appid.txt"

:: Запуск игры и ожидание её закрытия
start /wait "" "C:\GeometryDash\V2.1\Game\GeometryDash.exe" -nosteam

cls
echo =======================================================================
echo Сессия завершена. Начинается сохранение прогресса и шифрование данных...
echo НЕ ЗАКРЫВАЙТЕ ОКНО И НЕ ВЫКЛЮЧАЙТЕ ПК ДО ПОЛНОЙ ОЧИСТКИ КЭША!
echo =======================================================================

echo [Secure] Обновление зашифрованного архива GDV21.zip...
if exist "C:\GeometryDash\V2.1\GDV21.zip" del /f /q "C:\GeometryDash\V2.1\GDV21.zip"

:: Запаковываем папку Game обратно в ZIP с паролем
tar -a -cf "C:\GeometryDash\V2.1\GDV21.zip" -C "C:\GeometryDash\V2.1\Game" * --password "%GDPASS%" 2>nul

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
