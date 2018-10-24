@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xsim MIPS_Top_tb_behav -key {Behavioral:sim_1:Functional:MIPS_Top_tb} -tclbatch MIPS_Top_tb.tcl -view C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/sim_1/imports/Proyecto/MIPS_Top_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
