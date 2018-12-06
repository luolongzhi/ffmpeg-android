#ffmpeg src
FFMPEG_VERSION = 3.2.12
SRC_FFMPEG = ffmpeg-$(FFMPEG_VERSION).tar.bz2

BUILDPATH=build_pc
WORK_PATH := $(shell pwd)

all: ffmpeg 
clean: 
	rm -rf $(BUILDPATH)

#ready action
SOURCE_REDAY = cp_source_code tar_source_code 
cp_source_code:
	mkdir $(BUILDPATH) && \
	cp src/$(SRC_FFMPEG) $(BUILDPATH)

tar_source_code:
	cd $(BUILDPATH) && \
	tar xvf $(SRC_FFMPEG) && rm $(SRC_FFMPEG)

FFMPEG_COMMON_ARGS = \
	--target-os=none \
	--enable-shared \
	--disable-static \
	--disable-doc \
	--disable-ffmpeg \
	--disable-ffplay \
	--disable-ffprobe \
	--enable-avdevice \
	--disable-doc \
	--disable-symver 

ffmpeg: $(SOURCE_REDAY)
	cd $(BUILDPATH)/ffmpeg-$(FFMPEG_VERSION) && \
	./configure \
		$(FFMPEG_COMMON_ARGS) \
		--prefix=$(WORK_PATH)/dist/ffmpeg-$(FFMPEG_VERSION)/pc \
		--cross-prefix=$(CROSS_PREFIX) \
		--arch=x86 \
		--extra-cflags="-Os -fpic \
		--extra-ldflags="" \
		&& \
	make -j4 && \
	make install

