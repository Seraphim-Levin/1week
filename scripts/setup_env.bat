@echo off
SETLOCAL

set ENV_NAME=week1_env
set PYTHON_VERSION=3.10

echo === Checking Conda ===
where conda >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Conda not found in PATH
    exit /b 1
)

echo === Checking environment ===
conda env list | findstr %ENV_NAME% >nul
IF %ERRORLEVEL% NEQ 0 (
    echo Creating environment %ENV_NAME% ...
    conda create -y -n %ENV_NAME% python=%PYTHON_VERSION%
    IF %ERRORLEVEL% NEQ 0 (
        echo [ERROR] Failed to create environment
        exit /b 1
    )
) ELSE (
    echo Environment already exists.
)

echo === Installing requirements ===
conda run -n %ENV_NAME% python -m pip install -r requirements.txt
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to install requirements
    exit /b 1
)

echo === Running smoke test ===
conda run -n %ENV_NAME% python broken_env.py
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR]
    exit /b 1
)

echo [OK]
exit /b 0