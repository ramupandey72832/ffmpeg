@echo off
setlocal enabledelayedexpansion

set "outputFile=inputsPNG.txt"
if exist "%outputFile%" del "%outputFile%"

echo Deep Scanning for PNGs only...
echo --------------------------------------------------------

for %%f in (*) do (
    :: 1. Skip the script and the output file
    if not "%%~nxf"=="%~nx0" if not "%%~nxf"=="%outputFile%" (
        
        :: 2. CRITICAL: Reset codec to 'none' for every single file
        set "codec=none"

        :: 3. Get the codec name
        for /f "tokens=*" %%c in ('ffprobe -v error -select_streams v:0 -show_entries stream^=codec_name -of default^=noprint_wrappers^=1:nokey^=1 "%%f" 2^>nul') do (
            set "codec=%%c"
        )

        :: 4. Filter Logic (Strict check)
        if /i "!codec!"=="png" (
            echo [KEEP]  "%%f"
            :: Use double quotes for the echo to handle filenames with single quotes or spaces
            echo file '%%f' >> "%outputFile%"
			echo duration 3 >> "%outputFile%"
			set "lastfile=%%f"
        ) else if /i "!codec!"=="mjpeg" (
            echo [BLOCK] "%%f" (MJPEG ignored)
        ) else (
            echo [SKIP]  "%%f" (Codec: !codec!)
        )
    )
)
echo file '%lastfile%' >> "%outputFile%"

echo --------------------------------------------------------
echo Final list saved to: %outputFile%
pause