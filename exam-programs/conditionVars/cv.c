#include<stdio.h>
#include<stdlib.h>
#include<pthread.h>

// sleep function
#include<unistd.h>

// Create and initialize global refernce to CV and Mutex
pthread_mutex_t countLock = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t countCV = PTHREAD_COND_INITIALIZER;


// Global reference to our counter
int counter = 0;

// Worker function incrememnts counter (like producer)
void* worker(void* arg){
    int threadID = *((int*)arg);
    printf("hello im worker thread %i\n",threadID);

    // the workers will try increment counter 10 times each
    for(int i=0;i<10;i++){
        // try aqquire the mutex 
        pthread_mutex_lock(&countLock);

        // increment counter
        printf("Worker %i (%i) aqquired mutex, incrementing counter to %i\n",threadID,i,1+counter);
        counter ++;

        // Check if the watcher condition has been reached
        if(counter == 12){
            // Signal the watcher thread using the CV
            // Note this will happen once we RELEASE the mutex and
            // the mutex will be given directly to the watcher thread
            pthread_cond_signal(&countCV);
            printf("Worker %i signaling watcher and releasing MUTEX \n",threadID);
        }
        pthread_mutex_unlock(&countLock);

        // sleep for 1 second to allow other producer thread chance to access data
        // Otherwise this would blast through all of its 10 incrememnts before other thread has even started
        sleep(1);
    }
    printf("Worker thread %i finishing\n\n",threadID);
    pthread_exit(NULL);
}

void* watcher(void* arg){
    int threadID = *(int*)arg;

    printf("hello im watcher thread %i\n",threadID);

    
    // We dont know when watcher will actually start 
    // Maybe the threads have already gotten the counter to 12
    // Watcher needs to acquire the mutex and check the counter
    pthread_mutex_lock(&countLock);


    // Now has lock and needs to check counter value
    while(counter != 12){
        // go to sleep until worker thread wakes me
        printf("Watcher: Count != 12, sleeping..\n");

        // Note cond_wait auto unlcoks the MUTEX lock
        pthread_cond_wait(&countCV, &countLock);

        // Upon awaking we are also given the mutex lock back
        printf("Watcher: Awoken\n");
    }


    printf("Watcher: Counter = 12, consuming the 12\n");
    counter = 0;

    // Remember still need to unlock the mutex
    pthread_mutex_unlock(&countLock);

    printf("Watcher: Unlocking the mutex\n\n");

    pthread_exit(NULL);
}




int main(){

    pthread_t threads[3];
    int t0 = 0, t1 = 1, t2 = 2;

    // Create all three threads
    pthread_create(&threads[0],NULL,worker,(void*)(&t0));
    pthread_create(&threads[1],NULL,worker,(void*)(&t1));
    pthread_create(&threads[2],NULL,watcher,(void*)(&t2));


    // Join all three threads
    for(int i=0;i<3;i++){
        pthread_join(threads[i],NULL);
    }

    printf("\n\n All threads finished: counter = %i\n\n",counter);

    // tidy up
    pthread_mutex_destroy(&countLock);
    pthread_cond_destroy(&countCV);


    return 0;
}