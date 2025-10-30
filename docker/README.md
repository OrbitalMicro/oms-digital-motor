# Vivado build environment
Docker container-based Vivado build environment. Based on the setup in the oms-digital-hdl repository.

## Packages
This guide and Dockerfile can be used to build a Docker image which includes

* Vivado
* Digilent JTAG communication
* DFU utils

## Installing Docker
Docker CE 28 or later is required. This section describes how to install it on Ubuntu. For more details, refer to the [Docker installation docs](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository).

Install dependencies:

```
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
```

Use Ubuntu's supported docker:

Install Ubuntu's supported docker:

```
sudo apt-get update
sudo apt-get install docker.io
```

Add yourself to the docker group. For this change to take effect, you must log out and back in.

```
sudo usermod -aG docker <username>
```

## Building Docker image

Copy the following files into this folder. They are archived in the engineering NAS:

* `Xilinx_Vivado_SDK_2018.2_0614_1954.tar.gz` (can be found at [Xilinx hompage](https://www.xilinx.com/member/forms/download/xef-vivado.html?filename=Xilinx_Vivado_SDK_2018.2_0614_1954.tar.gz). Requires login)
* `digilent.adept.runtime_2.19.2-x86_64.tar.gz` (can be found at [Digilent homepage](https://reference.digilentinc.com/lib/exe/fetch.php?tok=cb873b&media=https%3A%2F%2Fmautic.digilentinc.com%2Fadept-for-linux-runtime-64-bit-zip-landing-page) )
* `digilent.adept.utilities_2.2.1-x86_64.tar.gz` (can be found at [Digilent homepage](https://reference.digilentinc.com/lib/exe/fetch.php?tok=2b259e&media=https%3A%2F%2Fmautic.digilentinc.com%2Fadept-for-linux-utility-64-bit-zip-landing-page) )

You may need to update the digilent installation .tar.gz filenames in Dockerfile, depending on the version available for download. When all the files are available, start the build with:

```
make
```

## Usage

To open an interactive shell in the environment, run:

```
# start the container on the host
./enter_container.sh --tag latest
# launch vivado in the background inside the container
vivado &
```
from the root of the repository. It assumes that the current working directory is the container work directory.

## Untested below this point!

The following was stolen from the oms-micro-digital-hdl and has not been tested.

This assumes you have a Xilinx license file in `~/.Xilinx` on your host machine if it is needed. A license can be obtained on the [Xilinx website](http://www.xilinx.com/getlicense).

You can mount as many folders as you want.

In case you run docker as a non-standard Ubuntu user (user id != 1000), you must ensure that the user inside docker (which by default has id 1000) has permissions to access the files you mount from the host system. This can be accomplished with something like:

```
-u $( id -u $USER ) -v /etc/passwd:/etc/passwd:ro
```

This should be added to the docker run command, **before** the -i argument.

## JTAG

In order to be able to use USB for JTAG access to the target, you need the following udev rule on your host OS.

Add this content to `/etc/udev/rules.d/99-xilinx.rules`
```
SUBSYSTEMS=="usb" ACTION=="add" ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6014", \
    MODE="660", GROUP="dialout"
SUBSYSTEMS=="usb" ACTION=="add" ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0300", \
    MODE="660", GROUP="dialout"
```
