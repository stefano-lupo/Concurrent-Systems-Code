#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include "jpeg-6b/jpeglib.h"
#include <sys/time.h>

typedef struct myStruct
{
    unsigned char *data;
    int threadNo;
    int threadGap;
} myStruct;


void *pixelChanger(void *params)
{
    // Retrieved data from passed struct
    myStruct *myS = (myStruct *)params;
    unsigned char *data = myS->data;
    int threadNo = myS->threadNo;
    int threadGap = myS->threadGap;
    unsigned char r = 0;
    unsigned char g = 0;
    unsigned char b = 0;
    if(threadNo == 0 ){
        r = 255;
    } else{
        b = 255;
    }


    for(int i=threadNo * threadGap; i<(threadNo*threadGap)+threadGap;i+=3){
        int total = data[i] + data[i+1] + data[i+2];
        unsigned char grey = total/ 3;
        data[i] = grey;
        data[i+1] = grey;
        data[i+2] = grey;
    }

    free(params);   // Ask about this?
    pthread_exit(NULL);
}

int main(int argc, char *argv[])
{

    if (argc != 4)
    {
        printf("Please provide 3 arguments: \ninput jpeg, output jpeg and number of threads to use \n");
        exit(0);
    }

    int numThreads = atoi(argv[3]);


    unsigned long width, height;
    unsigned int texture_id;
    unsigned long data_size; // length of the file
    int channels;            //  3 =>RGB   4 =>RGBA
    unsigned int type;
    unsigned char *rowptr[1];           // pointer to an array
    unsigned char *jdata;               // data for the image
    struct jpeg_decompress_struct info; // for our jpeg info
    struct jpeg_error_mgr err;          // the error handler

    FILE *file = fopen(argv[1], "rb");

    info.err = jpeg_std_error(&err);
    jpeg_create_decompress(&info); //fills info structure

    // if the jpeg file doesn't load
    if (!file)
    {
        fprintf(stderr, "Error reading JPEG file %s!", argv[1]);
        return 0;
    }

    jpeg_stdio_src(&info, file);
    jpeg_read_header(&info, TRUE); // read jpeg file header

    jpeg_start_decompress(&info); // decompress the file

    // set width and height
    width = info.output_width;
    height = info.output_height;
    // set num colours
    channels = info.num_components;

    data_size = width * height * channels;
    int perRow = width * channels;

    //--------------------------------------------
    //  read scanlines one at a time & put bytes
    //  in jdata[] array. Assumes an RGB image
    //--------------------------------------------
    jdata = (unsigned char *)malloc(data_size);
    while (info.output_scanline < info.output_height) // loop
    {
        // Enable jpeg_read_scanlines() to fill our jdata array
        // this line files memory address starting at jdata + (number of rows we have scanned * number of pixels per row * number of colours per pixel)
        rowptr[0] = (unsigned char *)jdata + info.output_width * info.output_scanline * 3;
        // Read a scanline and store it @ the address of row ptr (which is the next slot in jdata array)
        jpeg_read_scanlines(&info, rowptr, 1);
    }

    FILE *fp;
    fp = fopen("pixels.txt", "w+");
    int cnt = 1;
    int cnt2 = 1;
    // Write it in viewable text file
    for (int i = 0; i < data_size; i++)
    {
        if (cnt2 == 1)
        {
            //jdata[i] = jdata[i] - 25;
            fprintf(fp, "(");
            fprintf(fp, "%u", jdata[i]);
            cnt2++;
        }
        else if (cnt2 == 2)
        {
            fprintf(fp, ",");
            //jdata[i] = jdata[i] - 25;
            fprintf(fp, "%u", jdata[i]);
            cnt2++;
        }
        else
        {
            fprintf(fp, ",");
            //jdata[i] = jdata[i] - 25;
            fprintf(fp, "%u", jdata[i]);
            fprintf(fp, ")");
            cnt2 = 1;
        }

        // handle new lines
        if (cnt % perRow == 0)
        {
            fprintf(fp, "\n");
        }
        cnt++;
    }


    struct timeval startTime, endTime, resultTime;
    gettimeofday(&startTime,NULL);      //pointer to timeval struct, timezone
    int threadGap = data_size / numThreads;
    pthread_t threads[numThreads];
    int rc;

    

    for (int t = 0; t < numThreads; t++)
    {
        myStruct *ms = (myStruct *)malloc(sizeof(myStruct));
        ms->data = jdata;
        ms->threadGap = threadGap;
        ms->threadNo = t;

        rc = pthread_create(&threads[t], NULL, pixelChanger, (void *)ms);
        if (rc)
        {
            printf("ERROR return code from pthread_create(): %d\n", rc);
            exit(-1);
        }
    }

    // wait for threads to exit
    for(int t=0;t<numThreads;t++) {
    	pthread_join( threads[t], NULL);
    }


    // Calculate elapsed time
    gettimeofday(&endTime,NULL);
    timersub(&endTime, &startTime, &resultTime);

   






    // compressing code

    jpeg_finish_decompress(&info); //finish decompressing
    jpeg_destroy_decompress(&info);

    // Compress and write to jpeg
    int output_height = height;
    int output_width = width;
    JSAMPLE *image_buffer;

    struct jpeg_compress_struct cinfo;
    struct jpeg_error_mgr jerr;

    FILE *outfile;
    JSAMPROW row_pointer[1];
    int row_stride;

    cinfo.err = jpeg_std_error(&jerr);
    jpeg_create_compress(&cinfo);

    if ((outfile = fopen(argv[2], "wb")) == NULL)
    {
        printf("Error opening file");
        exit(1);
    }

    jpeg_stdio_dest(&cinfo, outfile);

    cinfo.image_width = output_width;
    cinfo.image_height = output_height;
    cinfo.input_components = 3;
    cinfo.in_color_space = JCS_RGB;

    jpeg_set_defaults(&cinfo);
    jpeg_set_quality(&cinfo, 100, TRUE);

    jpeg_start_compress(&cinfo, TRUE);

    row_stride = output_width * 3;

    while (cinfo.next_scanline < cinfo.image_height)
    {
        row_pointer[0] = &jdata[cinfo.next_scanline * row_stride];
        (void)jpeg_write_scanlines(&cinfo, row_pointer, 1);
    }

    jpeg_finish_compress(&cinfo);
    fclose(outfile);

    free(jdata);

    printf("Image size (px) : %i x %i \n",output_width,output_height);
    printf("Total number of pixels : %i\n",output_width * output_height );
    printf("Pixel format : 8 Bit RGB\n");
    printf("Image conversion: greyscale\n");
    printf("Threads Used: %i\n",numThreads);
    printf("Time elapsed: %ld.%06ld seconds\n\n", (long int)resultTime.tv_sec, (long int)resultTime.tv_usec);
}