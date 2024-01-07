@echo off
setlocal enabledelayedexpansion

echo Welcome to the interactive file renaming script by codding-nepal.
echo.

set /p "sourceFolder=Enter the source folder path (press Enter to use the current folder): "
if not defined sourceFolder set "sourceFolder=.."

echo Enter the file extensions you want to rename (separated by a space, e.g., js mjs):
set /p "fileExtensions=Extensions : "
if not defined fileExtensions (
    echo No extensions specified. The script will exit.
    pause
    exit /b
)

set /p "excludeFolders=Enter folders to exclude (separated by a space, press Enter to skip): "

echo.
echo Renaming in progress...

for %%E in (%fileExtensions%) do (
    for /r "%sourceFolder%" %%F in (*."%%E") do (
        set "filename=%%~nF"
        set "extension=%%~xF"
        set "newName=!filename!.ts"

        set "excludeFolder="
        if defined excludeFolders (
            for %%X in (%excludeFolders%) do (
                echo "!sourceFolder!\%%X"
                echo "!sourceFolder!\%%X" | findstr /i /c:"!sourceFolder!\%%~pnF" >nul && set "excludeFolder=1"
            )
        )

        if not defined excludeFolder (
            echo Renaming "%%F" to "!newName!"
            ren "%%F" "!newName!"
        )
    )
)

echo.
echo Renaming complete.
pause
