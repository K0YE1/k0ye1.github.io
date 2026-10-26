# --- НАСТРОЙКИ ---
# Вставьте сюда прямую ссылку на архив с Geometry Dash 2.1
$downloadUrl = "https://github.com/K0YE1/k0ye1.github.io/releases/download/v21/GDV21.zip"

# Пути для установки
$targetDir = "C:\GeometryDash\V21"
$zipPath = "$targetDir\gd21.zip"
$desktopPath = [System.IO.Path]::Combine([Environment]::GetFolderPath("Desktop"), "Geometry Dash.bat")

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
    Write-Host "Игра успешно распакована в $targetDir" -ForegroundColor Green
    
    # Удаление временного zip-архива после распаковки
    Remove-Item -Path $zipPath -Force
} catch {
    Write-Host "Ошибка при распаковке архива!" -ForegroundColor Red
    Pause
    Exit
}

# 4. Создание батника на рабочем столе
Write-Host "Создание ярлыка на Рабочем столе..." -ForegroundColor Cyan
$batContent = "@echo off`nstart `"`" `"$targetDir\GeometryDash.exe`""
[System.IO.File]::WriteAllText($desktopPath, $batContent)

Write-Host "Установка полностью завершена! Батник создан на рабочем столе." -ForegroundColor Green
Pause
