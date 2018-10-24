# 
# Synthesis run script generated by Vivado
# 

create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.cache/wt [current_project]
set_property parent.project_path C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/sources_1/imports/imports/6/vhds/ALU.vhd
  C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/sources_1/imports/imports/6/vhds/ALUControl.vhd
  C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/sources_1/imports/imports/6/vhds/Add.vhd
  C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/sources_1/imports/imports/6/vhds/Control.vhd
  C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/sources_1/imports/imports/6/Lab6_Vivado/Lab6_Vivado.srcs/sources_1/new/Data_Memory_VHDL.vhd
  C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/sources_1/imports/imports/6/vhds/Instruction_Mem.vhd
  C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/sources_1/imports/imports/Proyecto/LWDECODER.vhd
  C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/sources_1/imports/imports/6/vhds/Mux2to1_32bit.vhd
  C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/sources_1/imports/imports/6/vhds/Mux2to1_5bit.vhd
  C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/sources_1/imports/imports/6/vhds/PCounter.vhd
  C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/sources_1/imports/imports/6/vhds/Register_MEM.vhd
  C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/sources_1/imports/imports/Proyecto/SWDECODER.vhd
  C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/sources_1/imports/imports/6/vhds/ShiftLeft2.vhd
  C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/sources_1/imports/imports/6/vhds/Sign_extend.vhd
  C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/sources_1/imports/imports/6/vhds/MIPS_Top.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/constrs_1/imports/new/MIPS.xdc
set_property used_in_implementation false [get_files C:/Users/Alessio/Desktop/Proyecto_Final/Proyecto_Final.srcs/constrs_1/imports/new/MIPS.xdc]


synth_design -top MIPS_Top -part xc7a35tcpg236-1


write_checkpoint -force -noxdef MIPS_Top.dcp

catch { report_utilization -file MIPS_Top_utilization_synth.rpt -pb MIPS_Top_utilization_synth.pb }