function Show-Menu {
    Clear-Host
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "          ПОЛЬЗОВАТЕЛЬСКИЙ ХАБ          " -ForegroundColor Yellow
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "1. Geometry Dash"
    Write-Host "Q. Выйти" -ForegroundColor Red
    Write-Host "=========================================" -ForegroundColor Cyan
}

function Show-GD-Menu {
    Clear-Host
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "             GEOMETRY DASH              " -ForegroundColor Yellow
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "1. Установить Geometry Dash v2.0"
    Write-Host "2. Установить Geometry Dash v2.1"
    Write-Host "B. Назад в главное меню" -ForegroundColor DarkGray
    Write-Host "=========================================" -ForegroundColor Cyan
}

$mainExit = $false

do {
    Show-Menu
    $choice = Read-Host "Выберите пункт меню"
    
    switch ($choice) {
        '1' {
            $gdExit = $false
            do {
                Show-GD-Menu
                $gdChoice = Read-Host "Выберите версию игры"
                
                switch ($gdChoice) {
                    '1' {
                        Clear-Host
                        Write-Host "Запуск установщика Geometry Dash v2.0..." -ForegroundColor Cyan
                        try {
                            $url20 = "https://raw.githubusercontent.com/K0YE1/k0ye1.github.io/refs/heads/main/GeometryDash/V2.0/Script.ps1"
                            $script20 = Invoke-WebRequest -Uri $url20 -UseBasicParsing -ErrorAction Stop
                            Invoke-Expression $script20.Content
                        } catch {
                            Write-Host "Не удалось загрузить скрипт v2.0. Проверьте подключение к сети." -ForegroundColor Red
                            Read-Host "Нажмите Enter для продолжения"
                        }
                    }
                    '2' {
                        Clear-Host
                        Write-Host "Запуск установщика Geometry Dash v2.1..." -ForegroundColor Cyan
                        try {
                            $url21 = "https://raw.githubusercontent.com/K0YE1/k0ye1.github.io/refs/heads/main/GeometryDash/V2.1/Script.ps1"
                            $script21 = Invoke-WebRequest -Uri $url21 -UseBasicParsing -ErrorAction Stop
                            Invoke-Expression $script21.Content
                        } catch {
                            Write-Host "Не удалось загрузить скрипт v2.1. Проверьте подключение к сети." -ForegroundColor Red
                            Read-Host "Нажмите Enter для продолжения"
                        }
                    }
                    'b' { $gdExit = $true }
                    'и' { $gdExit = $true } # Защита от русской раскладки (буква 'и' вместо 'b')
                }
            } while (-not $gdExit)
        }
        'q' { $mainExit = $true }
        'й' { $mainExit = $true } # Защита от русской раскладки (буква 'й' вместо 'q')
    }
} while (-not $mainExit)
