@echo off
REM ============================================================
REM   Nemuru Dashboard - 自動push用タスクスケジューラ登録
REM   1回だけ実行すれば、以後5分間隔で auto_push.bat が走る
REM ============================================================

cd /d "%~dp0"

set TASK_NAME=NemuruDashboardAutoPush
set BAT_PATH=%~dp0auto_push.bat

echo [1/3] 既存タスクを削除（あれば）...
schtasks /delete /tn "%TASK_NAME%" /f >nul 2>&1

echo [2/3] タスクを新規登録（5分間隔・ユーザー権限）...
schtasks /create /tn "%TASK_NAME%" /tr "\"%BAT_PATH%\"" /sc minute /mo 5 /st 00:00 /f
if errorlevel 1 (
  echo [ERROR] タスク登録失敗
  pause
  exit /b 1
)

echo [3/3] 即座に1回実行してテスト...
schtasks /run /tn "%TASK_NAME%"

echo.
echo ============================================================
echo   登録完了。以後5分ごとに auto_push.bat が自動実行されます。
echo   未push commit がある時のみ push します（無ければ何もしない）。
echo   ログ: web\push_result.log
echo
echo   タスク確認: taskschd.msc を開いて "%TASK_NAME%" を探す
echo   タスク削除: schtasks /delete /tn "%TASK_NAME%" /f
echo ============================================================

REM 5秒待ってから自動でウィンドウを閉じる
timeout /t 5 /nobreak >nul
exit /b 0
