# --- НАСТРОЙКИ ---
$downloadUrl = "https://github.com/K0YE1/k0ye1.github.io/releases/download/v21/GDV21.zip"

# Пути для установки
$targetDir = "C:\GeometryDash\V21"
$zipPath = "$targetDir\gd21.zip"
$shortcutPath = [System.IO.Path]::Combine([Environment]::GetFolderPath("Desktop"), "Geometry Dash.lnk")

# --- ПРОЦЕСС УСТАНОВКИ ---

# 1. Создание рабочей папки
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
    Write-Host "Папка $targetDir успешно создана." -ForegroundColor Green
}

# 2. Скачивание архива
Write-Host "Скачивание Geometry Dash 2.1..." -ForegroundColor Cyan
try {
    Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath -ErrorAction Stop
    Write-Host "Архив успешно скачан." -ForegroundColor Green
} catch {
    Write-Host "Ошибка при скачивании файла! Проверьте ссылку." -ForegroundColor Red
    Pause
    Exit
}

# 3. Распаковка архива
Write-Host "Распаковка файлов..." -ForegroundColor Cyan
try {
    Expand-Archive -Path $zipPath -DestinationPath $targetDir -Force
    Write-Host "Игра успешно распакована." -ForegroundColor Green
    Remove-Item -Path $zipPath -Force
} catch {
    Write-Host "Ошибка при распаковке архива!" -ForegroundColor Red
    Pause
    Exit
}

# 4. Авто-поиск EXE и создание нормального ярлыка
Write-Host "Создание ярлыка на Рабочем столе..." -ForegroundColor Cyan

# Скрипт сам найдет, куда распаковался exe-шник
if (Test-Path "$targetDir\GDV21\GeometryDash.exe") {
    $exePath = "$targetDir\GDV21\GeometryDash.exe"
    $workingDir = "$targetDir\GDV21"
} else {
    $exePath = "$targetDir\GeometryDash.exe"
    $workingDir = $targetDir
}

try {
    # Создаем полноценный ярлык через COM-объект Windows
    $wshShell = New-Object -ComObject WScript.Shell
    $shortcut = $wshShell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $exePath
    $shortcut.WorkingDirectory = $workingDir
    $shortcut.IconLocation = "$exePath,0" # Берем родную иконку из самого exe игры
    $shortcut.Save()
    
    Write-Host "Ярлык 'Geometry Dash' с иконкой успешно создан на рабочем столе!" -ForegroundColor Green
} catch {
    Write-Host "Не удалось создать ярлык." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor DarkRed
}

Write-Host "`nУстановка полностью завершена!" -ForegroundColor Green
Pause
