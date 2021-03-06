# 
# Synthesis run script generated by Vivado
# 

create_project -in_memory -part xcku035-ffva1156-3-e

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/will/DSP/HW6/lab_6/run/project_2/project_2.cache/wt [current_project]
set_property parent.project_path /home/will/DSP/HW6/lab_6/run/project_2/project_2.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo /home/will/DSP/HW6/lab_6/run/project_2/project_2.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  /home/will/DSP/HW6/lab_6/src/fft_pkg.vhd
  /home/will/DSP/HW6/lab_6/src/butterfly_st1.vhd
  /home/will/DSP/HW6/lab_6/src/butterfly_st2.vhd
  /home/will/DSP/HW6/lab_6/src/butterfly_st3.vhd
  /home/will/DSP/HW6/lab_6/src/complex_addsub.vhd
  /home/will/DSP/HW6/lab_6/src/complex_mult.vhd
  /home/will/DSP/HW6/lab_6/src/eight_right_shift.vhd
  /home/will/DSP/HW6/lab_6/src/mult_add_block.vhd
  /home/will/DSP/HW6/lab_6/src/fft_top.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/will/DSP/HW6/constraints_lab6.xdc
set_property used_in_implementation false [get_files /home/will/DSP/HW6/constraints_lab6.xdc]


synth_design -top fft_top -part xcku035-ffva1156-3-e


write_checkpoint -force -noxdef fft_top.dcp

catch { report_utilization -file fft_top_utilization_synth.rpt -pb fft_top_utilization_synth.pb }
