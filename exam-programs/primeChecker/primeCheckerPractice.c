#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

typedef struct Param{
    int start, end, threadID;

} Param;

int isPrime(int x){

    if(x<=1){
        return 0;
    }
    
    for(int i=2;i<x;i++){
        if(x%i==0){
            // not prime
            return 0;
        }
    }



    printf("%i is prime\n",x);
    return 1;
}


#define NUM_THREADS 5
int totalPrimes = 0;
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

void *thread_func(void * paramP){
    Param* param = (Param*)paramP;
    printf("Thread %i: start = %i, end = %i\n",param->threadID,param->start, param->end);
    int localPrimeCount = 0;
    for(int i=param->start;i<=param->end;i++){
        if(isPrime(i)){
            localPrimeCount++;
        }
    }

    pthread_mutex_lock(&lock);
    totalPrimes += localPrimeCount;
    pthread_mutex_unlock(&lock);

    free(param);
    pthread_exit(NULL);

    // exit and free
}


int main(){
    int max = 33;
    int interval = max / NUM_THREADS;   // 6

    pthread_t threads[NUM_THREADS];

    for(int i=0;i<NUM_THREADS-1;i++){
        Param* param = (Param*)malloc(sizeof(Param));
        param->start = i*interval;
        param->end = (i*interval)+interval-1;
        param->threadID = i;
        pthread_create(&threads[i],NULL,thread_func,(void*)param);
    }

    // Create last one - also tidies up remaider
    Param* param = (Param*)malloc(sizeof(Param));
    param->threadID = NUM_THREADS-1;
    param->start = (NUM_THREADS-1)*interval;
    param->end = max;
    pthread_create(&threads[NUM_THREADS-1],NULL,thread_func,(void*)param);


    // Wait for threads to exit
    for(int i=0;i<NUM_THREADS;i++){
        pthread_join(threads[i],NULL);
    }

    printf("Total Number of primes = %i\n",totalPrimes);

    pthread_mutex_destroy(&lock);
    return 0;
}