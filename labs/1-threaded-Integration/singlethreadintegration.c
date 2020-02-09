#include <stdlib.h>
#include <stdio.h>
#include <math.h>


#define NUM_THREADS 2
#define NUM_STEPS_PER_THREAD 5
#define UPPER_BOUND 1
#define LOWER_BOUND -1

double getHeight(float x){
    // Integral from -1 to 1 of sqrt(1-x^2) gives pi
    return sqrt(1-(x*x));
}

int main(){
    int numSteps = NUM_THREADS * NUM_STEPS_PER_THREAD;      //same as multithread
    double stepSize = (UPPER_BOUND-LOWER_BOUND)/(float)numSteps;
    printf("step %f\n",stepSize);

    double sum = 0;
    for (double i=LOWER_BOUND; i<=UPPER_BOUND; i+=stepSize){
        //printf("%f\n",getHeight(LOWER_BOUND + i));
        double height = (getHeight(LOWER_BOUND + i));
        printf("Height = %f\n",height);
        sum = sum + height;
    }

   printf("sum = %f\n",sum);

}