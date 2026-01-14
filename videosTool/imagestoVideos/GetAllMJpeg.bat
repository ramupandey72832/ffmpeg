@echo off
setlocal enabledelayedexpansion

:: Name of the output file
set "outputFile=inputsMJPEG.txt"

:: Clear the output file if it already exists
if exist "%outputFile%" del "%outputFile%"

echo Scanning files... Please wait.
echo ---------------------------------

:: Loop through files. We use /r if you want subfolders, but staying with current folder for now.
for %%f in (*) do (
    :: Reset codec variable for each file
    set "codec=unknown"

    :: Skip the script itself and the output file
    if not "%%~nxf"=="%~nx0" if not "%%~nxf"=="%outputFile%" (
        
        :: Run ffprobe. The '2^>nul' hides errors if a file isn't a valid media file (like the .bat itself)
        for /f "tokens=*" %%c in ('ffprobe -v error -select_streams v:0 -show_entries stream^=codec_name -of default^=noprint_wrappers^=1:nokey^=1 "%%f" 2^>nul') do (
            set "codec=%%c"
        )

        :: Check if the codec is mjpeg
        if /i "!codec!"=="mjpeg" (
            echo [MJPEG] %%f
            echo file '%%f' >> "%outputFile%"
			echo duration 3 >> "%outputFile%"
			set "lastfile=%%f"
        ) else (
            echo [SKIP]  %%f (!codec!)
        )
    )
)
echo file '%lastfile%' >> "%outputFile%"
echo ---------------------------------
echo Done! %outputFile% is ready.
pause