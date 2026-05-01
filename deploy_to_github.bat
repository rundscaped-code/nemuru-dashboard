@echo off
cd /d "%~dp0"

echo.
echo ========================================
echo   GitHub Pages Deploy
echo ========================================
echo.

REM 初回チェック
if not exist ".git" (
    echo [初回セットアップ] git init します。
    git init
    git branch -M main
    echo.
    echo ※ 次にリポジトリURLを設定する必要があります:
    echo    git remote add origin https://github.com/rundscaped-code/nemuru-dashboard.git
    echo.
    echo .git ディレクトリは作成しました。
    echo setup_github_pages_guide.md の手順に従って、
    echo リモート設定後にこの bat を再実行してください。
    pause
    exit /b 0
)

echo [1/3] 変更を確認...
git status --short

echo.
echo [2/3] add + commit...
git add -A
set /p MSG="コミットメッセージ (空Enterで自動): "
if "%MSG%"=="" set MSG=Update dashboard %date% %time%
git commit -m "%MSG%"

echo.
echo [3/3] push to GitHub...
git push origin main

echo.
echo ========================================
echo   Done. GitHub Pages は約30秒-2分で更新されます。
echo   URL: https://rundscaped-code.github.io/nemuru-dashboard/
echo ========================================
pause
