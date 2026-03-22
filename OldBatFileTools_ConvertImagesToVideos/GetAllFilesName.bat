for %%i in (*.jpg) do (
	echo file '%%i' >> inputs.txt
	echo duration 3 >> inputs.txt
	set "lastfile=%%i"
)

echo file '%lastfile%' >> inputs.txt
