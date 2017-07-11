@echo off
setlocal enabledelayedexpansion


echo.
echo Giffer (1.0.20131121), http://tpkn.me
echo.


set FPS=24

echo.
echo Select FPS:
echo 1. 8
echo 2. 16
echo 3. 24 (default)
echo 4. 30
echo 5. 60
echo 6. custom
CHOICE /T 5 /C 123456 /D 3 /N
call goto %ERRORLEVEL%
:1
set FPS=8
goto action
:2
set FPS=16
goto action
:3
set FPS=24
goto action
:4
set FPS=30
goto action
:5
set FPS=60
goto action
:6
goto custom


:custom
echo.
set /p FPS="Input FPS: "
goto action


:action
for %%i in ("%*") do (
	ffmpeg -i "%%i" -vf palettegen "%%~dpni_palette.png"
	ffmpeg -i "%%i" -i "%%~dpni_palette.png" -lavfi paletteuse -r %FPS% "%%~dpni.gif"

	:: Remove palette
	del /s /q "%%~dpni_palette.png"
)
goto complete


:complete
echo.
echo +-----------------------+
echo ^|         DONE          ^|
echo +-----------------------+
timeout /t 10