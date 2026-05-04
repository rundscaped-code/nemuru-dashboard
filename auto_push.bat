@echo off
REM Cowork Claude が生成したコミットを「未push commitがあれば」push する bat
REM タスクスケジューラから5分間隔で叩かれる前提
REM 未push commitが無ければ何もしない（git push は冪等で "Everything up-to-date" になるだけだが、ログ汚染を抑える）

cd /d "%~dp0"

REM ログファイルが大きくなりすぎたら rotate（10MB超過時）
if exist push_result.log (
  for %%I in (push_result.log) do if %%~zI gtr 10485760 move /y push_result.log push_result.log.old > nul
)

REM 未push commit数をチェック（origin/main との差分）
git fetch origin main --quiet 2>nul
for /f %%C in ('git rev-list origin/main..HEAD --count 2^>nul') do set UNPUSHED=%%C
for /f %%S in ('git status --porcelain 2^>nul ^| find /c /v ""') do set UNCOMMITTED=%%S

REM 未commit / 未push どちらも無ければ即終了（ログも残さない）
if "%UNPUSHED%"=="0" if "%UNCOMMITTED%"=="0" exit /b 0

echo ======================================== >> push_result.log
echo   Auto Push %date% %time% >> push_result.log
echo   unpushed=%UNPUSHED% uncommitted=%UNCOMMITTED% >> push_result.log
echo ======================================== >> push_result.log

REM 未commitファイルがあれば自動コミット
if not "%UNCOMMITTED%"=="0" (
  echo [auto-commit] >> push_result.log
  git add -A >> push_result.log 2>&1
  git commit -m "Auto: weekly report deploy %date%" >> push_result.log 2>&1
)

echo [git push origin main] >> push_result.log
git push origin main >> push_result.log 2>&1

echo Done at %date% %time% >> push_result.log
echo. >> push_result.log

exit /b 0
