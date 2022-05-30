@echo off
set arg1=%1
set arg2=%2
set arg3=%3
SET mypath=%~dp0

powershell -File %mypath%verify.ps1 %arg1% %arg2% %arg3% %mypath%
