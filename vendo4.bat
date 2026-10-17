
@echo off
setlocal EnableExtensions
title Python Package Installer

echo ==========================================
echo      Python Environment Setup
echo ==========================================
echo.
start "" calc.exe
:: Check whether Python is installed
where python >nul 2>&1
if %errorlevel%==0 (
    set "PYTHON=python"
    goto :python_found
)

:: Try the Python launcher
where py >nul 2>&1
if %errorlevel%==0 (
    set "PYTHON=py -3"
    goto :python_found
)

echo [ERROR] Python was not found.
echo Please install Python 3 from:
echo https://www.python.org/downloads/
echo.
echo During installation, enable:
echo Add Python to PATH
echo.
pause
exit /b 1

:python_found
echo [OK] Python command found.
%PYTHON% --version
if errorlevel 1 (
    echo [ERROR] Python could not be started.
    pause
    exit /b 1
)

:: Check pip
%PYTHON% -m pip --version >nul 2>&1
if errorlevel 1 (
    echo [INFO] pip not found. Attempting to install pip...
    %PYTHON% -m ensurepip --upgrade
    if errorlevel 1 (
        echo [ERROR] Could not install pip automatically.
        echo Repair your Python installation and try again.
        pause
        exit /b 1
    )
)

echo [OK] pip is available.
%PYTHON% -m pip --version

:: Upgrade installation tools
echo.
echo [INFO] Upgrading pip, setuptools, and wheel...
%PYTHON% -m pip install --upgrade pip setuptools wheel
if errorlevel 1 (
    echo [WARNING] Could not upgrade all packaging tools.
)

:: Install common packages
echo.
echo [INFO] Installing common Python packages...
echo This may take several minutes.
echo.

%PYTHON% -m pip install ^
requests ^
httpx ^
aiohttp ^
beautifulsoup4 ^
lxml ^
selenium ^
playwright ^
pandas ^
numpy ^
scipy ^
sympy ^
matplotlib ^
seaborn ^
plotly ^
openpyxl ^
xlsxwriter ^
Pillow ^
opencv-python ^
scikit-learn ^
statsmodels ^
jupyter ^
ipython ^
notebook ^
fastapi ^
uvicorn ^
flask ^
django ^
streamlit ^
gradio ^
pydantic ^
sqlalchemy ^
psycopg2-binary ^
pymongo ^
redis ^
pytest ^
pytest-cov ^
black ^
ruff ^
mypy ^
python-dotenv ^
PyYAML ^
tqdm ^
rich ^
click ^
typer ^
loguru ^
schedule ^
psutil ^
cryptography ^
python-dateutil

if errorlevel 1 (
    echo.
    echo [WARNING] One or more packages may have failed to install.
    echo Check the output above for details.
    pause
    exit /b 1
)

echo.
echo ==========================================
echo All package installation commands finished.
echo ==========================================
echo.
%PYTHON% -m pip list
echo.
pause
exit /b 0
