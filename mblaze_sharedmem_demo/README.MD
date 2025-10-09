Microblaze Application Demo (SDK 2018.3)
=======================================

This repository will contain a source file for demonstrating shared 
memory access and interrupt routines with a Microblaze core.

To create the SDK project, use the generated HDF file (or the one provided in the HDL repo) to generate libraries, header-files, and other dependencies needed to compile an application. 
https://github.com/dleews/avnet_hdl/tree/picozed_mblaze_dev_2018_3/WsxProjects


New SDK Project 
=======================================

With Vivado SDK open, go to 
File-> Application Project


<img src="sdk_info.png" width="400" />

Give the project a name then assign the mblaze_demo_app.c file to the list of source files.

Memory map layout
=======================================

The high-lighted sections show the memory regions of interest

<img src="memory_map.png" width="500" />

In this example, address 0x40000000 accesses a shared block-ram memory space that is made accessible to the ARM-Linux system. From the Microblaze poitn of view 0x42000000 accesses the same block-ram but using a different address. The reason why separate addresses are used is due to allow for simulatneous reads/write operations from both the Microblaze and the ARM PS7.

<img src="vivado_interconnect.png" width="800" />

Despite having different addresses, you can still access the same data. For example, ARM-Linux writing a value 0xA to 0x40000004 will show up in 0x420000004 from the Microblaze.


Loading Microblaze Application via JTAG
=======================================


Test Scripts
=======================================