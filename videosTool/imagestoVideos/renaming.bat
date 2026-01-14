@echo off
setlocal enabledelayedexpansion

echo "Scanning for .jpeg and .png files.."


:: Rename .jpeg to .jpg
if exist *.jpeg (
	ren *.jpeg *.jpg
	echo "Converted .jpeg files to .jpg"
) else (
	echo "NO .jpeg files found. "
)

:: Rename .png to .jpg
if exist *.png (
	ren *.png *.jpg
	echo "Converted .png files to .jpg"
) else ( 
	echo "NO .png files found. "
)


echo "Task Completed!"
pause 