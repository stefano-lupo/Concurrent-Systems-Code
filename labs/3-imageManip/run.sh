#!/bin/bash

clear
gcc decompresser.c -ljpeg -o decompresser -Ljpeg-6b -pthread
./decompresser landscape.jpg landscape_grey.jpg 2