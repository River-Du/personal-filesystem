@echo off
setlocal EnableExtensions

rem Remove all .gitkeep placeholder files from this directory and its subdirectories.
set "SCRIPT_DIR=%~dp0"

for /r "%SCRIPT_DIR%" %%F in (.gitkeep) do (
    del /f /q "%%F" >nul 2>&1
    if errorlevel 1 (
        echo Failed to delete "%%F" 1>&2
        endlocal
        exit /b 1
    )
)

endlocal
exit /b 0
