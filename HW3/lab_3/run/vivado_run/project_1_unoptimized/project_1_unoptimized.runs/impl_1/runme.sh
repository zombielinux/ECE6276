#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/tools/xilinx/vivado201504/SDK/2015.4/bin:/tools/xilinx/vivado201504/Vivado/2015.4/ids_lite/ISE/bin/lin64:/tools/xilinx/vivado201504/Vivado/2015.4/bin
else
  PATH=/tools/xilinx/vivado201504/SDK/2015.4/bin:/tools/xilinx/vivado201504/Vivado/2015.4/ids_lite/ISE/bin/lin64:/tools/xilinx/vivado201504/Vivado/2015.4/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/tools/xilinx/vivado201504/Vivado/2015.4/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/tools/xilinx/vivado201504/Vivado/2015.4/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/nethome/wsutton8/ECE6276/ECE6276/HW3/lab_3/run/vivado_run/project_1_unoptimized/project_1_unoptimized.runs/impl_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .init_design.begin.rst
EAStep vivado -log mac.vdi -applog -m64 -messageDb vivado.pb -mode batch -source mac.tcl -notrace


