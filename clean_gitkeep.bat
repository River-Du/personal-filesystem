@echo off
setlocal EnableExtensions DisableDelayedExpansion

rem Remove all .gitkeep placeholder files from this directory and its subdirectories.
set "SCRIPT_DIR=%~dp0"
set /a DELETED_COUNT=0
set /a FAILED_COUNT=0

for /r "%SCRIPT_DIR%" %%F in (.gitkeep) do (
    if exist "%%F" if not exist "%%F\" (
        del /f /q /a "%%F" >nul 2>&1
        rem DEL does not reliably report deletion failures through ERRORLEVEL.
        if exist "%%F" (
            echo Failed to delete "%%F" 1>&2
            set /a FAILED_COUNT+=1 >nul
        ) else (
            set /a DELETED_COUNT+=1 >nul
        )
    )
)

if %FAILED_COUNT% gtr 0 (
    echo Removed %DELETED_COUNT% .gitkeep file(s^). Failed to remove %FAILED_COUNT%. 1>&2
    pause
    endlocal
    exit /b 1
)

if %DELETED_COUNT% equ 0 (
    echo No .gitkeep files found.
) else (
    echo Removed %DELETED_COUNT% .gitkeep file(s^).
)

pause
endlocal
exit /b 0
