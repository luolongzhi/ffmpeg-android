#include <stdio.h>
#include <stdlib.h>
#include "ffmpeg_thread.h"

void ffmpeg_callback(int ret) {
    printf("==========================> this is call back\n");
}

int main(int argc, char **argv) {

    ffmpeg_thread_callback(ffmpeg_callback);
    ffmpeg_thread_run_cmd(argc, argv); 
    ffmpeg_thread_exit(0); 

    return 0;
}
