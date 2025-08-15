@echo off
setlocal EnableDelayedExpansion
echo ==========================================
echo Python AI Development Session Starter (v4)
echo ==========================================

REM --- Check if this is an existing project ---
if exist "venv" (
    echo Found existing project! Quick starting...
    goto :QuickStart
)

REM --- 1. Interactive Setup ---
for %%i in (.) do set "defaultProjectName=%%~nxi"
set /p "projectName=Project name (default: %defaultProjectName%): "
if "%projectName%"=="" set "projectName=%defaultProjectName%"

set /p "mainScriptFile=Main script file (default: main.py): "
if "%mainScriptFile%"=="" set "mainScriptFile=main.py"

set /p "isApp=Will this project be packaged as .exe? (y/n): "

REM --- 2. Check and create venv ---
if not exist "venv" (
    echo Virtual environment not found, creating new venv...
    python -m venv venv
    if errorlevel 1 (
        echo ERROR: Failed to create venv. Please check Python installation.
        pause
        exit /b 1
    )
    echo Virtual environment created successfully!
) else (
    echo Found existing virtual environment.
)

echo Installing/updating packages...
call venv\Scripts\activate.bat
python -m pip install --upgrade pip
pip install ruff

if /i "%isApp%"=="y" (
    echo Installing FreeSimpleGUI and PyInstaller for app project...
    pip install FreeSimpleGUI
    pip install pyinstaller
)

call deactivate
echo Package installation completed!

REM --- 3. Generate build.bat if app project ---
if /i "%isApp%"=="y" (
    set /p "isGuiApp=Is this a GUI app? (y/n): "
    
    echo Creating project folders...
    if not exist "src" mkdir src
    if not exist "assets" mkdir assets
    if not exist "config" mkdir config
    if not exist "data" mkdir data
    
    echo Generating AI configuration files...
    
    REM Generate CLAUDE.md
    echo # Project: %projectName% > CLAUDE.md
    echo. >> CLAUDE.md
    echo ## Project Structure >> CLAUDE.md
    echo src/           - Python source code >> CLAUDE.md
    echo assets/        - Static files >> CLAUDE.md
    echo config/        - Configuration files >> CLAUDE.md
    echo data/          - Data files >> CLAUDE.md
    echo venv/          - Virtual environment >> CLAUDE.md
    echo build.bat      - Build script >> CLAUDE.md
    echo. >> CLAUDE.md
    echo ## Commands >> CLAUDE.md
    echo - Build: build.bat >> CLAUDE.md
    echo - Main file: src/%mainScriptFile% >> CLAUDE.md
    
    REM Generate GEMINI.md (same content)
    copy CLAUDE.md GEMINI.md >nul
    
    echo Generating build.bat...
    
    (
        echo @echo off
        echo echo ==========================================
        echo echo Build %projectName%
        echo echo ==========================================
        echo.
        echo if not exist "venv" ^(
        echo     echo ERROR: venv not found!
        echo     pause
        echo     exit /b 1
        echo ^)
        echo.
        echo call venv\Scripts\activate.bat
        echo.
        echo echo Testing program import...
        echo python -c "import sys; sys.path.append('src'); import %mainScriptFile:.py=%; print('Program import successful')"
        echo if errorlevel 1 ^(
        echo     echo ERROR: Program cannot run properly!
        echo     pause
        echo     exit /b 1
        echo ^)
        echo.
        echo echo Installing PyInstaller if needed...
        echo pip show pyinstaller ^>nul 2^>^&1 ^|^| python -m pip install pyinstaller
        echo.
        echo echo Cleaning old build files...
        echo if exist "dist" rmdir /s /q "dist"
        echo if exist "build" rmdir /s /q "build"
        echo del *.spec 2^>nul
        echo.
        echo echo Starting packaging with PyInstaller...
        if /i "%isGuiApp%"=="y" (
            echo pyinstaller --onefile --noconsole --optimize=2 --strip --name="%projectName%" "src/%mainScriptFile%"
        ) else (
            echo pyinstaller --onefile --optimize=2 --strip --name="%projectName%" "src/%mainScriptFile%"
        )
        echo.
        echo if exist "dist\%projectName%.exe" ^(
        echo     echo Packaging successful!
        echo     dir "dist\*.exe"
        echo.
        echo     echo Copying project folders to dist...
        echo     if exist "assets" xcopy "assets" "dist\assets\" /E /I /Y ^>nul
        echo     if exist "config" xcopy "config" "dist\config\" /E /I /Y ^>nul  
        echo     if exist "data" xcopy "data" "dist\data\" /E /I /Y ^>nul
        echo     echo Project folders copied to dist directory.
        echo     echo ==========================================
        echo     echo Build process completed!
        echo ^) else ^(
        echo     echo ERROR: Packaging failed!
        echo ^)
        echo.
        echo pause
    ) > build.bat
    
    echo build.bat created successfully!
    
    echo.
    echo ==========================================
    echo PROJECT STRUCTURE GUIDE
    echo ==========================================
    echo Please organize your files as follows:
    echo.
    echo src/           - Place your Python source code here
    echo   %mainScriptFile%  - Your main program file
    echo   *.py         - Other Python modules
    echo.
    echo assets/        - Static files (images, sounds, etc.)
    echo config/        - Configuration files
    echo data/          - Data files (CSV, JSON, etc.)
    echo.
    echo venv/          - Virtual environment (auto-generated)
    echo build.bat      - Build script (auto-generated)
    echo.
    echo To build your app: run build.bat
    echo ==========================================
)

REM --- 4. Choose and start AI assistant ---
echo ------------------------------------------
echo Choose AI assistant:
echo 1: Gemini (default)
echo 2: Claude
set /p "aiChoice=Enter choice (1/2): "

set "aiCommand=gemini"
if "%aiChoice%"=="2" set "aiCommand=claude"

echo Starting %aiCommand% session...

start "AI Development Session" cmd /k "venv\Scripts\activate.bat && %aiCommand%"

echo ==========================================
echo New %aiCommand% window opened. You can close this window.
echo ==========================================
goto :EOF

REM --- Quick Start Mode ---
:QuickStart
setlocal EnableDelayedExpansion
echo Quick start mode - skipping setup...
echo ------------------------------------------
echo Choose AI assistant:
echo 1: Gemini (default)
echo 2: Claude
set /p "aiChoice=Enter choice (1/2): "

set "aiCommand=gemini"
if "%aiChoice%"=="2" set "aiCommand=claude"

echo Starting %aiCommand% session in existing project...
start "AI Development Session" cmd /k "venv\Scripts\activate.bat && %aiCommand%"

echo ==========================================
echo Resumed %aiCommand% session. You can close this window.
echo ==========================================