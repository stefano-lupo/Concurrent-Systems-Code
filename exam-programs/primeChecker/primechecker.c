#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define NUM_THREADS 10

/**
    Note this only works for checking first n numbers if n%NUM_THREADS = 0;
*/


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
int n = 50; //checking number of primes from 1->50
int intervalSize;
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

void* countPrimes(void* params){
    int i = *((int*)params);    // typecast and derefence
    int start = (i*intervalSize) + 1;

    // Keep a local variable instead of trying to increment global (aqquire lock)
    // every time we find a prime
    int numPrimesThisInterval = 0;

    // loop through and check 
    for(int x = start;x<start+intervalSize;x++){
        if(isPrime(x) == 1){
            numPrimesThisInterval ++;
        }
    }

    // Now have how many primes in this interval, add this to global
    printf("Number of primes [%i - %i] = %i\n",start,start+intervalSize,numPrimesThisInterval);

    // Aqquire the mutex lock
    pthread_mutex_lock(&lock);
    printf("Thread %i aqquired the lock\n",i);
    numPrimes += numPrimesThisInterval;
    pthread_mutex_unlock(&lock);
    printf("Thread %i released the lock\n",i);

    pthread_exit(NULL);
}


int main(){

    // Declare array of threads
    pthread_t threads[NUM_THREADS];
    intervalSize = n / NUM_THREADS;

    // this is needed instead passing a refference to i as 
    // when the thread actually runs i may have changed
    int argsArray[NUM_THREADS];
    for(int i=0;i<NUM_THREADS;i++){
        argsArray[i] = i;
    }

    // Create and start each thread
    for(int i=0;i<NUM_THREADS;i++){
        //int tmp_i = i;            // Note this wont work as may go out of scope before thread runs
        pthread_create(&threads[i],NULL,countPrimes,(void*)&(argsArray[i]));
    }

    // Join threads
    for(int i=0;i<NUM_THREADS;i++){
        pthread_join(threads[i], NULL);
    }

    // Delete the lock
    pthread_mutex_destroy(&lock);
    
    printf("Number of primes from 1 to %i = %i\n\n",n,numPrimes);
    
    return 0;
}