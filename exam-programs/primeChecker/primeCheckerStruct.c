#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define NUM_THREADS 5


typedef struct Param {
    int start, end;
    int threadID;
} Param;

// Function to check if n is prime
int isPrime(int n){
    for(int i=2;i<n;i++){
        if(n%i ==0){
           // printf("%i is not prime as %i divides into it\n",n,i);
            return 0;
        }
    }
    // 1 is not a prime number
    if(n==1){
        return 0;
    }
    //printf("%i is prime\n",n);
    return 1;
}

int numPrimes = 0; 
int n = 33;         // checking number of primes from 1->50
int intervalSize;   // save this as global so only stored once
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

void* countPrimes(void* paramP){
    // Always make a copy of the void* cast
    Param* param = (Param*)paramP;

    // Keep a local variable instead of trying to increment 
    // the global (aqquire lock) every time we find a prime
    int numPrimesThisInterval = 0;

    // loop from 1->n(inclusive) of this interval
    for(int x = param->start;x<=param->end;x++){
        if(isPrime(x) == 1){
            numPrimesThisInterval ++;
        }
    }

    // Now have how many primes in this interval, add this to global
    printf("Number of primes [%i - %i] = %i\n",param->start,param->end,numPrimesThisInterval);

    // Aqquire the mutex lock
    pthread_mutex_lock(&lock);
    numPrimes += numPrimesThisInterval;
    pthread_mutex_unlock(&lock);

    // Free the malloced parameter on the heap
    // Note this must be done here as the pointer to it in main goes out of scope in the loop
    free(param);
    pthread_exit(NULL);
}




int main(){

    // Declare array of threads
    pthread_t threads[NUM_THREADS];

    // int division
    intervalSize = n / NUM_THREADS;

    // Create and start each thread
    for(int i=0;i<NUM_THREADS-1;i++){
        // Allocate the function parameter on the heap (even primatives)
        // The pointer goes out of scope here but can be freed in the thread function
        Param* param = (Param*)malloc(sizeof(Param));
        param->start = (i * intervalSize)+1;            // +1 to start from 1 
        param->end = (i*intervalSize) + intervalSize;  
        param->threadID = i;
        pthread_create(&threads[i],NULL,countPrimes,(void*)param);
    }

    // Last thread does its interval and the remainder
    Param* param = (Param*)malloc(sizeof(Param));
    param->threadID = NUM_THREADS-1;
    param->start = ((NUM_THREADS - 1)*intervalSize) + 1;
    param->end = n;
    pthread_create(&threads[NUM_THREADS-1],NULL,countPrimes,(void*)param);


    // Join threads
    for(int i=0;i<NUM_THREADS;i++){
        pthread_join(threads[i], NULL);
    }

    // Delete the lock
    pthread_mutex_destroy(&lock);
    
    printf("Number of primes from 1 to %i = %i\n\n",n,numPrimes);
    
    return 0;
}