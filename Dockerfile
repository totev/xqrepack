FROM ubuntu:latest

ARG MI_FIRMWARE=miwifi_r3600_all_6510e_3.0.22_INT.bin

# Install general dependencies
RUN apt update && apt upgrade
RUN apt install python3 liblzo2-dev python3-setuptools mtd-utils bsdmainutils python3-pip squashfs-tools git -y
RUN pip3 install python-lzo

WORKDIR /opt

# Install ubi_reader needed for ubireader_extract_images
RUN git clone https://github.com/jrspruitt/ubi_reader --depth 1
RUN cd ubi_reader &&  python3 setup.py install
RUN cd /opt

# Get original firmware file
RUN git clone https://github.com/odedlaz/ax3600-files.git --depth 1
RUN cp ax3600-files/firmwares/${MI_FIRMWARE} /opt/${MI_FIRMWARE}

ADD . /opt

CMD ["make", "firmware"]