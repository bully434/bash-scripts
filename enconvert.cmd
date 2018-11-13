
@ECHO OFF 

where /Q iconv.exe  
IF ERRORLEVEL 1 (
	echo Iconv Wan't Dound In PATH
	exit /b 1
)

IF "%1"=="/?" (
	echo USAGE: enconvert.cmd directory
	exit /b
)

IF "%1"=="" (
	echo Wrong USAGE. Try /?
	exit /b 1
)

:loop
set tempFile=%temp%\tempEnconv%random%.tmp 
if exist "%tempFile%" goto :loop

SET DIRECTORY= %1
IF NOT EXIST %1 (
	echo The Directory Doesn't Exist
	exit /b 1
)
FOR /R %DIRECTORY% %%F IN ("*.txt") DO (
	iconv.exe -f CP866 -t UTF-8 %%F > %tempFile%
	MOVE /Y %tempFile% %%F > nul
)
echo The Job Is Done
