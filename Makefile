#ffmpeg src
FFMPEG_VERSION = 3.2.12
SRC_FFMPEG = ffmpeg-$(FFMPEG_VERSION).tar.bz2

BUILDPATH=build_pc
WORK_PATH := $(shell pwd)

all: ffmpeg_demo
clean: 
	rm -rf $(BUILDPATH)
	rm -rf dist
	rm -rf demo
	rm ./ffmpeg-pc/*.o
	rm ./ffmpeg-pc/ffmpeg_demo

#ready action
SOURCE_REDAY = cp_source_code tar_source_code 
cp_source_code:
	mkdir $(BUILDPATH) && \
	cp src/$(SRC_FFMPEG) $(BUILDPATH)

tar_source_code:
	cd $(BUILDPATH) && \
	tar xvf $(SRC_FFMPEG) && rm $(SRC_FFMPEG)


#common ffmpeg filter and demuxer and decoder
COMMON_FILTERS = anull acopy aresample scale crop overlay
COMMON_DEMUXERS = matroska ogg avi mov flv mpegps image2 mp3 aac adts ac3 wav concat
COMMON_DECODERS = \
	vp8 vp9 theora \
	mpeg2video mpeg4 h264 hevc \
	png mjpeg \
	vorbis opus \
	mp3 ac3 aac \
	pcm_s16le pcm_s16be \
	ass ssa srt webvtt
COMMON_ENCODERS = aac mjpeg pcm_s16be pcm_s16le
COMMON_MUXERS = mp4 mp3 adts wav image2 webm ogg null


FFMPEG_COMMON_ARGS = \
	--target-os=none \
	--enable-shared \
	--disable-static \
	--disable-doc \
	--disable-doc \
	--disable-yasm \
	--disable-symver \
	\
	--disable-all \
	--enable-avcodec \
	--enable-avdevice \
	--enable-avformat \
	--enable-avfilter \
	--enable-avutil \
	--enable-swresample \
	--enable-swscale \
	--enable-network \
	--enable-protocol=rtmp\
	--enable-protocol=http\
	--enable-protocol=file \
	$(addprefix --enable-decoder=,$(COMMON_DECODERS)) \
	$(addprefix --enable-demuxer=,$(COMMON_DEMUXERS)) \
	$(addprefix --enable-encoder=,$(COMMON_ENCODERS)) \
	$(addprefix --enable-muxer=,$(COMMON_MUXERS)) \
	$(addprefix --enable-filter=,$(COMMON_FILTERS)) \
	--disable-bzlib \
	--disable-iconv \
	--disable-libxcb \
	--disable-lzma \
	--disable-sdl2 \
	--disable-securetransport \
	--disable-xlib \
	--disable-zlib


ffmpeg: $(SOURCE_REDAY)
	cd $(BUILDPATH)/ffmpeg-$(FFMPEG_VERSION) && \
	./configure \
		$(FFMPEG_COMMON_ARGS) \
		--prefix=$(WORK_PATH)/dist/ffmpeg-$(FFMPEG_VERSION)/pc \
		--cross-prefix=$(CROSS_PREFIX) \
		--arch=x86 \
		--extra-cflags="-fPIC" \
		--extra-ldflags="" \
		&& \
	make -j4 && \
	make install

ffmpeg-pc: ffmpeg
	cd $(WORK_PATH)/ffmpeg-pc && make clean && make

ffmpeg_demo: ffmpeg-pc
	cd $(WORK_PATH) && \
	mkdir demo && \
	cp ./dist/ffmpeg-$(FFMPEG_VERSION)/pc/lib/*.so* ./demo
	cp ./ffmpeg-pc/ffmpeg_demo ./demo
