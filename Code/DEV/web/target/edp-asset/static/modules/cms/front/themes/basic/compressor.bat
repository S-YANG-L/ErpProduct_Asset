@echo off
rem author thinkgem@163.com
echo Compressor JS and CSS?
pause
%~d0
cd %~dp0

call ..\..\..\..\..\compressor\compressor.bat style.css
call ..\..\..\..\..\compressor\compressor.bat script.js

echo.
echo Compressor Success
ping 127.0.0.1 -n 10 >nul
rem pause
echo on