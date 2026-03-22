@echo off
:: Switch console to UTF-8
chcp 65001 >nul

:: Clear the file first
if exist inputs.txt del inputs.txt

echo Processing files with Hindi names...

for %%i in (*.mp4) do (
    echo file '%%i' >> inputs.txt
)

echo Done.
pause