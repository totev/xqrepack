.PHONY: build run

.SUFFIXES:

MI_FIRMWARE = miwifi_r3600_all_6510e_3.0.22_INT.bin

all:
	@echo "make clean -- cleans firmware build"
	@echo "make firmware    -- bakes firmware"

clean:
	rm -rf ubifs-root/*.bin
	rm -f r3600-raw-img.bin
	rm -f backed-firmware/r3600-raw-img.bin

firmware: clean
	ubireader_extract_images -w ${MI_FIRMWARE}
	fakeroot -- ./repack-squashfs.sh ubifs-root/${MI_FIRMWARE}/img-*_vol-ubi_rootfs.ubifs
	./ubinize.sh ubifs-root/${MI_FIRMWARE}/img-*_vol-kernel.ubifs ubifs-root/${MI_FIRMWARE}/img-*_vol-ubi_rootfs.ubifs.new
	mkdir -p backed-firmware
	cp r3600-raw-img.bin backed-firmware/r3600-raw-img.bin