# oms-digital-motor
Embedded SW for mirror scanning

# Xilinx SDK

* uses xilinx gcc 7.3.1 20180425 for the microblaze

    * Supports c++ 17 standard.

# Project creation

NOTE: all directions in this document assume you are running in the docker container created by running `enter_container.sh`.

We need to create two projects, a microblaze application and a linux application. The linux application needs access to the memory map shared with the microblaze.

1. Create the microblaze application

    1. File -> New Application Project
    1. OS Platform -> standalone (bare metal) or freertos
    1. Target hardware -> correct hardware platform
    1. Target hardware -> Processor: microblaze
    1. Target software -> Board support package: new or existing as desired.

The hardware memory map is included in the bsp.

1. Create the linux application

    1. File -> New Application Project
    1. OS Platform: linux
    1. Target Hardware -> Processor Type: ps7_cortexa
    1. Target Software -> petalinux system root/toolchain if known, otherwise it will use the default built into the SDK.

The hardware memory map is not included in the application. We need to create a device tree or ....

1. Create the bsp

    1. The [device-tree-xlnx](https://github.com/Xilinx/device-tree-xlnx]) repo should be included in the docker image at `/opt/git/device-tree-xlnx`.

    1. Add the device-tree-xlnx repository to the work space:
       Xilinx menu -> repositories -> Global Repositories -> new and add the path to the repo.
    1. File -> New -> Device Tree Package
    1. Target Hardware -> CPU: ps7_cortexa9_0
    1. Board Support Package OS -> device_tree
    1. Configure the device tree.
    1. The memory map registers, for example the shared bram, are in the `pl.dtsi` file.
    1. **TODO** how to edit the device tree...
    1. Accessing the shared memory:

        1. open a file handle to /dev/mem as read/write with sync.
        1. mmap into virtual address space:
        ```c++
            mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0x41200000);
        ```
        1. **TODO** how do we get a generated header for the physical addresses instead of hard coding them... they appear not to exist and instead rely on the device tree and custom kernel drivers to expose them that way instead of mmap and a hard coded address.
