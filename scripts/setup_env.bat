@echo off
setlocal

set ENV_NAME=week1_env
set PYTHON_VERSION=3.10

echo === Checking Conda ===
where conda >nul 2>nul
if errorlevel 1 (
    echo Conda not found
    pause
    exit /b 1
)

echo === Checking environment ===
conda env list | findstr %ENV_NAME% >nul 2>nul
if errorlevel 1 (
    echo Creating environment...
    conda create -y -n %ENV_NAME% python=%PYTHON_VERSION%
)

echo === Activating environment ===
call conda activate %ENV_NAME%

echo === Installing requirements ===
python -m pip install -r requirements.txt

echo === Running smoke test ===
python broken_env.py

echo.
echo ============
echo     [OK]
echo ============
pause