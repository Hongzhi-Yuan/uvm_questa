@echo off
setlocal enabledelayedexpansion

REM ============================================================
REM  QuestaSim 10.6c UVM Runner (FORCE UVM-1.2)
REM
REM  - Compile external UVM-1.2 source into work (override built-in 1.1d)
REM  - Load Questa built-in uvm_dpi.dll
REM  - Incremental compile + vopt cache
REM  - All outputs in ./sim
REM
REM  Commands:
REM    run.bat run   [uvm_test] [seed]  -> comp + console sim (FAST)
REM    run.bat debug [uvm_test] [seed]  -> comp + GUI sim (waveform)
REM    run.bat clean
REM ============================================================

set ROOT=%~dp0
cd /d %ROOT%

REM ---- user config ------------------------------
set QUESTA_HOME=C:\questasim64_10.6c
set TOP=sim_top
set FILELIST=tb\filelist.f

set SIMDIR=sim
set WORKDIR=%SIMDIR%\work

set DEFAULT_CASE=my_test
set CASE=%DEFAULT_CASE%

set DEFAULT_SEED=1
set SEED=%DEFAULT_SEED%

REM External UVM-1.2 source (Questa built-in)
set UVM_HOME=%QUESTA_HOME%\verilog_src\uvm-1.2\src

REM Use Questa built-in UVM DPI dll (base name, no .dll)
set UVM_DPI_BASE=%QUESTA_HOME%\uvm-1.2\win64\uvm_dpi

REM vlog: incremental + mfcu
set VLOG_OPTS=-sv -timescale=1ns/1ps -work work -l %SIMDIR%\vlog.log -mfcu -incr

REM vopt cache name
set OPT_TOP=%TOP%_opt
REM ------------------------------------------------

REM ---- setup PATH for questa --------------------
if exist "%QUESTA_HOME%\win64\vsim.exe" (
    set PATH=%QUESTA_HOME%\win64;%PATH%
) else (
    echo [ERROR] QUESTA_HOME invalid: %QUESTA_HOME%
    exit /b 1
)

REM ---- parse cmd --------------------------------
if "%1"=="" goto HELP
set CMD=%1

if not "%2"=="" set CASE=%2
if not "%3"=="" set SEED=%3

set UVM_OPTS=+UVM_TESTNAME=%CASE% +ntb_random_seed=%SEED%

if /i "%CMD%"=="clean" goto CLEAN
if /i "%CMD%"=="run"   goto RUN_GROUP
if /i "%CMD%"=="debug" goto DEBUG_GROUP
if /i "%CMD%"=="comp"  goto COMP
if /i "%CMD%"=="sim"   goto SIM
if /i "%CMD%"=="gui"   goto GUI
goto HELP

REM ============================================================
:CLEAN
echo [CLEAN] cleaning outputs under %SIMDIR% ...
if exist "%SIMDIR%" (
    if exist "%WORKDIR%" vdel -lib "%WORKDIR%" -all >nul 2>nul
    del /f /q "%SIMDIR%\*.log" >nul 2>nul
    del /f /q "%SIMDIR%\*.wlf" >nul 2>nul
    del /f /q "%SIMDIR%\transcript" >nul 2>nul
    del /f /q "%SIMDIR%\*.ucdb" >nul 2>nul
    del /f /q "modelsim.ini" >nul 2>nul
    del /f /q "sim_top_opt" >nul 2>nul
)
echo [CLEAN] done.
exit /b 0

REM ============================================================
:COMP
echo [COMP] prepare sim folder...

if not exist "%SIMDIR%" mkdir "%SIMDIR%"
if not exist "%WORKDIR%" vlib "%WORKDIR%"

REM map logical lib "work" -> physical path sim\work
vmap work "%WORKDIR%" >nul 2>nul

REM check external UVM source
if not exist "%UVM_HOME%\uvm_pkg.sv" (
    echo [ERROR] uvm_pkg.sv not found under %UVM_HOME%
    exit /b 7
)

REM check DPI dll
if not exist "%UVM_DPI_BASE%.dll" (
    echo [ERROR] built-in uvm_dpi.dll not found: %UVM_DPI_BASE%.dll
    exit /b 11
)

REM check filelist
if not exist "%FILELIST%" (
    echo [ERROR] filelist not found: %FILELIST%
    exit /b 2
)

REM ---- 1) compile external UVM-1.2 into work (override built-in)
echo [COMP] compile external UVM-1.2 into work
vlog %VLOG_OPTS% +incdir+%UVM_HOME% "%UVM_HOME%\uvm_pkg.sv"
if errorlevel 1 (
    echo [ERROR] compile UVM-1.2 failed. Check %SIMDIR%\vlog.log
    exit /b 8
)

REM ---- 2) compile your TB/RTL
REM 关键修改：给 TB 编译也加上 UVM include 路径，确保能找到 uvm_macros.svh
echo [COMP] vlog (incremental) -f %FILELIST%
vlog %VLOG_OPTS% +incdir+%UVM_HOME% -f "%FILELIST%"
if errorlevel 1 (
    echo [ERROR] vlog failed. Check %SIMDIR%\vlog.log
    exit /b 3
)

REM ---- 3) vopt cache after compile
echo [COMP] vopt cache -> %OPT_TOP%
vopt %TOP% -o %OPT_TOP% -work work -l %SIMDIR%\vopt.log
if errorlevel 1 (
    echo [ERROR] vopt failed. Check %SIMDIR%\vopt.log
    exit /b 4
)

echo [COMP] done.
exit /b 0

REM ============================================================
:SIM
echo [SIM] running UVM-1.2 test=%CASE% seed=%SEED% (FAST console)...

vsim %OPT_TOP% ^
  -lib work ^
  -l %SIMDIR%\vsim.log ^
  -voptargs=+acc ^
  -sv_lib "%UVM_DPI_BASE%" ^
  -sv_seed %SEED% ^
  -onfinish stop ^
  -c ^
  %UVM_OPTS% ^
  -do "run -all; quit -f"

if errorlevel 1 (
    echo [ERROR] sim failed. Check %SIMDIR%\vsim.log
    exit /b 5
)

echo [SIM] done.
exit /b 0

REM ============================================================
:GUI
echo [GUI] running UVM-1.2 test=%CASE% seed=%SEED% (GUI + WLF)...

vsim %OPT_TOP% ^
  -lib work ^
  -l %SIMDIR%\vsim.log ^
  -voptargs=+acc ^
  -sv_lib "%UVM_DPI_BASE%" ^
  -sv_seed %SEED% ^
  -onfinish stop ^
  -wlf %SIMDIR%\vsim.wlf ^
  %UVM_OPTS%

exit /b 0

REM ============================================================
:RUN_GROUP
call "%~f0" comp
if errorlevel 1 exit /b !errorlevel!
call "%~f0" sim %CASE% %SEED%
exit /b 0

REM ============================================================
:DEBUG_GROUP
call "%~f0" comp
if errorlevel 1 exit /b !errorlevel!
call "%~f0" gui %CASE% %SEED%
exit /b 0

REM ============================================================
:HELP
echo.
echo Usage:
echo   run.bat run   [uvm_test] [seed]   ^<-- FORCE UVM-1.2, FAST (no WLF)
echo   run.bat debug [uvm_test] [seed]   ^<-- FORCE UVM-1.2, GUI + WLF
echo   run.bat clean
echo.
echo External UVM-1.2: %UVM_HOME%
echo DPI dll         : %UVM_DPI_BASE%.dll
echo Default test    : %DEFAULT_CASE%
echo Default seed    : %DEFAULT_SEED%
echo.
exit /b 0
