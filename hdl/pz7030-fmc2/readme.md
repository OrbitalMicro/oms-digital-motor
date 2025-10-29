
Picozed FMC2 with Microblaze (Vivado 2018.3)
===========================

This project file was originally created using the Avnet HDL scripts

Scripts/ProjectScripts/pz_petalinux.tcl

Modification was made to build on the updated board definition files:
https://github.com/Avnet/bdf/tree/2eaed2a099abc9eeee71c9342ef47fe1e12b8ad6

Follow the instructions from the above repo to install the board definition files for Vivado 2018.3



Current Tools Version:
----------------------

* **Xilinx Vivado Design Suite**: [Vivado 2018.3]

Build Instructions
----------------------

1) Make sure you installed the board definition files from Avnet (see above). Not doing so will lead to errors about "avnet-tria:picozed_7030_fmc2" not being found.

2) Open Vivado 2018.3 and source the tcl script with the command ''source create_pz7030_fmc2_microblaze.tcl''

3) Build the entire project and bitstream

4) Export the hdf file after by going to File -> Export -> Export Hardware

5) If you wish, you can launch Vivado SDK here which will use the exported HDF file to create a new project

Project Description:
----------------------

This Vivado project will target the Picozed FMC2 carrier card development kit. It will instantiate a Microblaze soft-processor core and a user-written IP to help trigger interrupts on the Microblaze. The registers of this user-written IP is also accessible through ARM-Linux such that one can trigger interrupts from Linux user-space or access some latency measurements.

When generating the bit file, create a hardware-description file to allow you to instantiate a Vivado SDK project. From there, you can write Microblaze SW to load onto the device using JTAG.

The Vivado project will also contain BRAM that is treated as a shared memory space between ARM-Linux and the Microblaze on the FPGA.


Microblaze SW:
----------------------
https://github.com/dleews/oms-digital-motor/tree/picozed_fmc2_demo

Use this .C file as part of the Vivado SDK project generated from the HDF file of this design. The C-Application can be used to validate shared memory between ARM-Linux and the Microblaze as well as test interrupt support.


Test Instructions
----------------------
Please see the readme.md here for more details
https://github.com/dleews/oms-digital-motor/tree/picozed_fmc2_demo
