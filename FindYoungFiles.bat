@echo off
:: ���Ҹ��µ��ļ�
:: by johnsing
:: modified 2023-06-27
:: 
SetLocal EnableDelayedExpansion

set SEARCH_DATE="2023/06/27 14:30"

set SRC_DIR=%1
if "%SRC_DIR%"=="" set SRC_DIR=.

REM ����Ŀ¼�Ƚ����ʱ��dir /s�ķ���ʱ���ǳ���
REM 
for /f %%f in ('dir /s /b %SRC_DIR%') do (
  CompareFD -c -t %SEARCH_DATE% %%f
  REM echo errorlevel=!ERRORLEVEL!
  if !ERRORLEVEL! EQU 1 (
    echo %%f
  )
)

