@echo off
title 注册清除垃圾工具
COLOR 3f
MODE con: COLS=33 LINES=19

SETLOCAL
set var=0

Rd "%WinDir%\system32\test_permissions" >NUL 2>NUL
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo 请使用右键管理员身份运行！&&PAUSE >NUL&&EXIT)
Rd "%WinDir%\System32\test_permissions" 2>NUL

@IF /I "%PROCESSOR_ARCHITECTURE%"=="x86" (
	set INS_DLL=%~dp0CleanDirX86.dll
) ELSE (
	set INS_DLL=%~dp0CleanDirX64.dll
)
echo %INS_DLL%

:start
set tm1=%time:~0,2%
set tm2=%time:~3,2%
set tm3=%time:~6,2%
echo %date% %tm1%点%tm2%分%tm3%秒 
echo ================================
echo 注册清除垃圾的shell插件，
echo 这样就可以通过选中文件夹右击来进行清除了。
echo ──────────────────────────────
echo.
echo 1.安装用于shell插件
echo 2.卸载shell插件
echo q.退出
echo.
if %var% equ 1 echo 第%badenv%个选择无效，请重新输入
if %var% equ 2 echo 参数过长，请重新输入
set /p choice=选择：
set choice1=%choice:~0,1% 
set env=%choice1%2
goto env
:choice2
set choice2=%choice:~1,1% 
if "%choice2%" equ " " goto back
set env=%choice2%3
goto env
cls
set var=2 
goto start
echo.
:env
if /i "%env:~0,1%" equ "1" goto install
if /i "%env:~0,1%" equ "2" goto uninstall
if /i "%env:~0,1%" equ "q" goto end
set /A badenv="%env:~2,1%"-1
cls
set var=1
goto start

:install
regsvr32 %INS_DLL%
goto end

:uninstall
regsvr32 /u %INS_DLL%
goto end

rem ------------------------------
:back
cls
set var=0
goto start

:end
rem exit