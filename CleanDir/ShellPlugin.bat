@echo off
title ע�������������
COLOR 3f
MODE con: COLS=33 LINES=19

SETLOCAL
set var=0

Rd "%WinDir%\system32\test_permissions" >NUL 2>NUL
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo ��ʹ���Ҽ�����Ա������У�&&PAUSE >NUL&&EXIT)
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
echo %date% %tm1%��%tm2%��%tm3%�� 
echo ================================
echo ע�����������shell�����
echo �����Ϳ���ͨ��ѡ���ļ����һ�����������ˡ�
echo ������������������������������������������������������������
echo.
echo 1.��װ����shell���
echo 2.ж��shell���
echo q.�˳�
echo.
if %var% equ 1 echo ��%badenv%��ѡ����Ч������������
if %var% equ 2 echo ��������������������
set /p choice=ѡ��
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