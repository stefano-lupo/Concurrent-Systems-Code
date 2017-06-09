
#!/bin/bash
clear
gcc -o threadIntegration threadIntegration.c -pthread -lm
./threadIntegration
