::You must keep this file in the solution folder for it to work. 
::Make sure to pass the solution configuration when calling it (either Debug or Release)

::Set the directories in the setdirectories.bat file if you want a different folder than Kerbal Space Program
::EXAMPLE:
:: SET KSPPATH=C:\Program Files (x86)\Steam\steamapps\common\Kerbal Space Program
:: SET KSPPATH2=C:\Users\Malte\Desktop\Kerbal Space Program
call "%~dp0\SetDirectories.bat"

IF DEFINED KSPPATH (ECHO KSPPATH is defined) ELSE (SET KSPPATH=C:\Kerbal Space Program)
IF DEFINED KSPPATH2 (ECHO KSPPATH2 is defined)
::%1
SET SOLUTIONCONFIGURATION=Debug

mkdir "%KSPPATH%\GameData\TiltEm\"
IF DEFINED KSPPATH2 (mkdir "%KSPPATH2%\GameData\TiltEm\")

mkdir "%KSPPATH%\GameData\TiltEm\Plugins"
IF DEFINED KSPPATH2 (mkdir "%KSPPATH2%\GameData\TiltEm\Plugins")

del "%KSPPATH%\GameData\TiltEm\Plugins\*.*" /Q /F
IF DEFINED KSPPATH2 (del "%KSPPATH2%\GameData\TiltEm\Plugins\*.*" /Q /F)

"%~dp0..\External\pdb2mdb\pdb2mdb.exe" "%~dp0..\TiltEm\bin\%SOLUTIONCONFIGURATION%\TiltEm.dll"

xcopy /Y "%~dp0..\TiltEm\bin\%SOLUTIONCONFIGURATION%\*.*" "%KSPPATH%\GameData\TiltEm\Plugins"
IF DEFINED KSPPATH2 (xcopy /Y "%~dp0..\TiltEm\bin\%SOLUTIONCONFIGURATION%\*.*" "%KSPPATH2%\GameData\TiltEm\Plugins")
