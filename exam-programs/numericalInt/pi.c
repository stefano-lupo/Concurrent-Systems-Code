#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>


#define NUM_THREADS 10
#define NUM_STEPS 10000

pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

float area = 0;
float dx;

typedef struct Param{
    int threadID;
    float start, end;
} Param;


float getHeight(float x){
    return (4/(1+(x*x)));
}

void* thread_func(void* paramP){
    Param* param = (Param*)paramP;
    printf("Thread %i: start = %f, end = %f\n",param->threadID,param->start,param->end);
    float localArea = 0;
    float tempI;
    for(float i=param->start;i<param->end;i+=dx){
        tempI = i+dx;
        localArea += (getHeight(i)*dx) + ((getHeight(tempI)-getHeight(i))/2)*dx;
    }

    pthread_mutex_lock(&lock);
    area+=localArea;
    pthread_mutex_unlock(&lock);

    free(param);
    pthread_exit(NULL);

}



int main(){

    dx = (float)1/NUM_STEPS;
    float threadStep = (float)1/NUM_THREADS;

    printf("Thread step = %f, dx = %f\n",threadStep,dx);

   pthread_t threads[NUM_THREADS];

   for(int i=0;i<NUM_THREADS;i++){
       Param* param = (Param*)malloc(sizeof(Param));
       param->start = i*threadStep;
       param->end = param->start + threadStep;
       param->threadID = i;
       pthread_create(&threads[i],NULL,thread_func,(void*)param);
   }


   for(int i=0;i<NUM_THREADS;i++){
       pthread_join(threads[i],NULL);
   }

   printf("%f \n\n",area);


    return 0;
}