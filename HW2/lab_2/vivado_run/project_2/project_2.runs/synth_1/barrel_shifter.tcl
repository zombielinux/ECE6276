# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xcku115-flva2104-3-e

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /nethome/wsutton8/ECE6276/ECE6276/HW2/lab_2/vivado_run/project_2/project_2.cache/wt [current_project]
set_property parent.project_path /nethome/wsutton8/ECE6276/ECE6276/HW2/lab_2/vivado_run/project_2/project_2.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
read_vhdl -library xil_defaultlib /nethome/wsutton8/ECE6276/ECE6276/HW2/lab_2/src/barrel_shifter_16.vhd
synth_design -top barrel_shifter -part xcku115-flva2104-3-e
write_checkpoint -noxdef barrel_shifter.dcp
catch { report_utilization -file barrel_shifter_utilization_synth.rpt -pb barrel_shifter_utilization_synth.pb }
