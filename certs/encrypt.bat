@echo off
set arg1=%1
SET mypath=%~dp0

powershell -File %mypath%encrypt.ps1 %arg1% %mypath%
