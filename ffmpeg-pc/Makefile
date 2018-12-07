#  llzlab - luolongzhi algorithm lab 
#  Copyright (C) 2012 luolongzhi (Chengdu, China)
#
#  This program is part of llzlab, all copyrights are reserved by luolongzhi. 
#
#  filename: Makefile
#  time    : 2012/07/07 18:42 
#  author  : luolongzhi ( luolongzhi@gmail.com )
#
#


include Makefile.include

#INCLUDEDIR = ../dist/ffmpeg-3.2.12/build_pc/ffmpeg-3.2.12/include
INCLUDEDIR = ../build_pc/ffmpeg-3.2.12

ifeq ($(ARCH),ARCH_ARM)
LDFLAGS += -lm -lpthread 
else
LDFLAGS += -lm -lpthread -lavcodec -lavdevice -lavfilter -lavformat -lavutil -lswresample -lswscale
endif

LIBPATH  = -L../dist/ffmpeg-3.2.12/pc/lib

TARGET    =  ffmpeg_demo 
CSRCFILES =  $(shell ls *.c)
COBJFILES =  $(patsubst %.c,%.o,$(CSRCFILES))

SRCFILES  =	 $(CSRCFILES) 
OBJFILES  =	 $(COBJFILES) 

CFLAGS    += -I.  -I$(INCLUDEDIR)

all: $(OBJFILES) 
	rm -f $(TARGET) 
	$(CC) -o $(TARGET) $(OBJFILES) $(LIBPATH) $(LDFLAGS)	 

clean : 
	@rm -f *.o
	@rm -f *.out	
	@rm -f $(TARGET)	

install :

