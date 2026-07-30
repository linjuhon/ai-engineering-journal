@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

echo ==========================================
echo   Publish AI Engineering Journal to GitHub
echo   = 發佈 AI 工程日誌到 GitHub
echo ==========================================
echo.

where git >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Git is not installed or not available in PATH.
  echo [錯誤] 未安裝 Git 或 Git 不在 PATH 中。
  echo Install Git for Windows, then run this file again.
  echo 請安裝 Git for Windows，然後重新執行此檔案。
  pause
  exit /b 1
)

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
  git init -b main
  if errorlevel 1 (
    git init
    git branch -M main
  )
)

for /f "delims=" %%A in ('git config user.name 2^>nul') do set "GIT_NAME=%%A"
if not defined GIT_NAME (
  set /p "GIT_NAME=Enter your GitHub display name / 請輸入您的 GitHub 顯示名稱: "
  git config user.name "%GIT_NAME%"
)

for /f "delims=" %%A in ('git config user.email 2^>nul') do set "GIT_EMAIL=%%A"
if not defined GIT_EMAIL (
  set /p "GIT_EMAIL=Enter the email used for Git commits / 請輸入 Git 提交使用的電子郵件: "
  git config user.email "%GIT_EMAIL%"
)

git add .
git diff --cached --quiet
if errorlevel 1 (
  git commit -m "Publish initial AI engineering journal"
) else (
  echo No new local changes need committing.
  echo 沒有新的本地變更需要提交。
)

git branch -M main

git remote get-url origin >nul 2>&1
if errorlevel 1 (
  git remote add origin https://github.com/linjuhon/ai-engineering-journal.git
) else (
  git remote set-url origin https://github.com/linjuhon/ai-engineering-journal.git
)

echo.
echo Pushing to GitHub... / 正在推送到 GitHub...
echo A browser sign-in window may appear. Sign in to GitHub and approve it.
echo 可能會出現瀏覽器登入視窗。請登入 GitHub 並授權。
echo.

git push -u origin main
if errorlevel 1 (
  echo.
  echo [FAILED] Push did not complete. / [失敗] 推送未完成。
  echo Copy the error message above back to ChatGPT and I will diagnose it.
  echo 請將上方的錯誤訊息複製回 ChatGPT，我會診斷問題。
  pause
  exit /b 1
)

echo.
echo [SUCCESS] The journal has been pushed to:
echo [成功] 日誌已推送至：
echo https://github.com/linjuhon/ai-engineering-journal
echo.
pause
