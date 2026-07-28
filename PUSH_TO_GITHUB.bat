@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

echo ==========================================
echo   Publish AI Engineering Journal to GitHub
echo ==========================================
echo.

where git >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Git is not installed or not available in PATH.
  echo Install Git for Windows, then run this file again.
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
  set /p "GIT_NAME=Enter your GitHub display name: "
  git config user.name "%GIT_NAME%"
)

for /f "delims=" %%A in ('git config user.email 2^>nul') do set "GIT_EMAIL=%%A"
if not defined GIT_EMAIL (
  set /p "GIT_EMAIL=Enter the email used for Git commits: "
  git config user.email "%GIT_EMAIL%"
)

git add .
git diff --cached --quiet
if errorlevel 1 (
  git commit -m "Publish initial AI engineering journal"
) else (
  echo No new local changes need committing.
)

git branch -M main

git remote get-url origin >nul 2>&1
if errorlevel 1 (
  git remote add origin https://github.com/linjuhon/ai-engineering-journal.git
) else (
  git remote set-url origin https://github.com/linjuhon/ai-engineering-journal.git
)

echo.
echo Pushing to GitHub...
echo A browser sign-in window may appear. Sign in to GitHub and approve it.
echo.

git push -u origin main
if errorlevel 1 (
  echo.
  echo [FAILED] Push did not complete.
  echo Copy the error message above back to ChatGPT and I will diagnose it.
  pause
  exit /b 1
)

echo.
echo [SUCCESS] The journal has been pushed to:
echo https://github.com/linjuhon/ai-engineering-journal
echo.
pause
