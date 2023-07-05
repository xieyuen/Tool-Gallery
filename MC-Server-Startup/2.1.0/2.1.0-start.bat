@echo off

echo Read the configuration file...
if not exist .\.startup\config.bat (
    
    call .\.startup\File-Edit.bat Config_Save
    
    pause >nul
    exit /b
) else (
    call .\.startup\config.bat
)

echo Open the main file...

call .\.startup\main.bat
