# Install vivado in temporary container
FROM ubuntu:18.04

ARG VIVADO=Xilinx_Vivado_SDK_2018.3_1207_2324

ADD ${VIVADO}.tar.gz /
ADD xsetup_config_2018.3.txt /

RUN apt-get update && apt-get install -y libx11-6 git
RUN ./${VIVADO}/xsetup --batch Install --agree XilinxEULA,3rdPartyEULA,WebTalkTerms --config /xsetup_config_2018.3.txt

WORKDIR /tmp
RUN git clone https://github.com/Avnet/bdf
WORKDIR /tmp/bdf
RUN git checkout 2eaed2a099abc9
RUN cp -a . /opt/Xilinx/Vivado/2018.3/data/boards/board_files
WORKDIR /tmp
RUN rm -rf /tmp/bdf

# Create Vivado container
FROM ubuntu:18.04

# Start by adding Vivado - we do this first to utilize AUFS layer reusability so
# we dont get many versions of a 9 GB layer lying around
COPY --from=0 /opt/Xilinx /opt/Xilinx

ARG DIGILENT_UTILS=digilent.adept.utilities_2.3.2-x86_64
ARG DIGILENT_RUNTIME=digilent.adept.runtime_2.26.1-x86_64
ARG FTDI_DRIVERS=ftdi.drivers_1.4.24-x86_64
ARG VIVADO_VERSION=2018.3

# Install Vivado dependencies
RUN dpkg --add-architecture i386 && apt-get update && apt-get -y install \
    build-essential \
    gnat-5 \
    libbz2-1.0:i386 \
    lib32ncurses5 \
    libstdc++6:i386 \
    lib32z1 \
    libfontconfig1 \
    libfreetype6 \
    libglib2.0-0 \
    libgtk2.0-0 \
    libsm6 \
    libusb-1.0-0 \
    libxcursor1 \
    libxext6 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxtst6 \
    libx11-6 \
    zlib1g-dev
RUN apt-get update --fix-missing

# Install utils
# note: man is a dependency for JTAG drivers
RUN apt-get update && apt-get -y install \
    bash-completion \
    git \
    man \
    vim

# Install JTAG USB drivers
ADD ${DIGILENT_UTILS}.tar.gz /
RUN mkdir /etc/hotplug
RUN mkdir /etc/hotplug/usb
WORKDIR /${DIGILENT_UTILS}
RUN ./install.sh libpath=/usr/local/lib64/digilent/adept sbinpath=/usr/sbin datapath=/usr/share/digilent/adept/data silent=1

ADD ${DIGILENT_RUNTIME}.tar.gz /
WORKDIR /${DIGILENT_RUNTIME}/${FTDI_DRIVERS}
RUN ./install.sh silent=1
WORKDIR /${DIGILENT_RUNTIME}
RUN ./install.sh

# Install dfu-util, python3, pip3, and pyyaml. Needed for sumo flashing tools.
RUN apt-get update && apt-get -y install dfu-util python-serial python3 python3-pip
RUN pip3 install pyyaml==5.1

# Remove apt cache to save space
RUN rm -rf /var/lib/apt/lists/*

# In cases where docker is run as another user, Vivado needs write access to this dir
RUN chmod o+w /opt/Xilinx/Vivado/${VIVADO_VERSION}/

# Make startup script with commands to call when starting bash
RUN touch /opt/bash-init-script.sh
RUN echo "# If you want to run any commands when starting a container put them in this file" >> /opt/bash-init-script.sh
RUN echo "source /opt/Xilinx/Vivado/2018.3/settings64.sh" >> /opt/bash-init-script.sh
RUN chmod a+x /opt/bash-init-script.sh

# Make entry point that uses bash and calls the startup script
RUN touch /opt/docker-entry-script.sh
RUN echo "#!/bin/bash" >> /opt/docker-entry-script.sh
RUN echo "source /opt/bash-init-script.sh" >> /opt/docker-entry-script.sh
RUN echo "/bin/bash -c \"\$*\"" >> /opt/docker-entry-script.sh
RUN chmod a+x /opt/docker-entry-script.sh

# Save image version inside image - note that everything below this line is run
# every time since arguments can change
ARG VERSION_FILE=/etc/priv-viv-release
ARG VERSION=priv
RUN echo $VERSION > $VERSION_FILE

# Add developer user
RUN adduser --disabled-password --gecos "" --uid 1000 developer
RUN usermod -aG dialout developer
USER developer
ENV HOME=/home/developer
# In cases where docker is run as another user, write access to the developer home dir is requried
RUN chmod o+w /home/developer
WORKDIR /home/developer
ENTRYPOINT ["/opt/docker-entry-script.sh"]
