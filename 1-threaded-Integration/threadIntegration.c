#include <pthread.h> 
#include <stdio.h> 
#include <stdlib.h> 
#include <math.h>
#include <sys/time.h>


#define NUM_THREADS 3
#define NUM_STEPS_PER_THREAD 50000000      // 6 decimal places correct
#define UPPER_BOUND 1
#define LOWER_BOUND -1

double totalArea = 0;

typedef struct myStruct {
    int start,end, threadNo;
} myStruct;


double getHeight(float x){
    // Integral from -1 to 1 of sqrt(1-x^2) gives pi
    return sqrt(1-(x*x));
}

void *compute_dA(void* params) { 
    // Retrieved data from passed struct
    myStruct* myS = (myStruct*)params;
    int start = myS->start;
    int end = myS->end;
    int threadNo = myS->threadNo;

    // timestep = distance thread has to work over / dx
    float timestep = ((float)(end-start))/NUM_STEPS_PER_THREAD;
    //printf("ThreadNo = %i, start = %i, end = %i, timestep = %f\n",threadNo,start,end,timestep);

    // Running area tracks cumulative area over this thread's interval
    double runningArea = 0;
    for(int i=0;i<NUM_STEPS_PER_THREAD;i++){
        // Slice area = dx * height
        runningArea += timestep * getHeight((start + (i*timestep)));
    }
    //printf("\nThreadNo %i total = %f\n\n",threadNo,runningArea);

    // Add this thread's area to total
    totalArea += runningArea;
	pthread_exit(NULL); 
} 

int main (int argc, const char * argv[]) { 
    struct timeval startTime, endTime, resultTime;
    gettimeofday(&startTime,NULL);      //pointer to timeval struct, timezone
    
    //clock_t begin = clock();
	pthread_t threads[NUM_THREADS]; 
	int rc;
    
    // How big a slice each thread should take
    float threadSpan = ((float)(UPPER_BOUND - LOWER_BOUND)) / NUM_THREADS;

	for (int t=0;t<NUM_THREADS;t++) { 
        myStruct* ms = (myStruct*)malloc(sizeof(myStruct));
        ms->start = LOWER_BOUND + (t*threadSpan);
        ms->end = LOWER_BOUND + ((1 + t)*threadSpan);
        ms->threadNo = t;

        rc = pthread_create(&threads[t],NULL,compute_dA, (void*)ms); 
		if (rc) { 
			printf("ERROR return code from pthread_create(): %d\n",rc); 
			exit(-1); 
		} 
	} 

	// wait for threads to exit 
	for(int t=0;t<NUM_THREADS;t++) { 
		pthread_join( threads[t], NULL); 
	} 

    // Mathematical formula yields pi/2
    double pi = totalArea * 2;

    // Calculate elapsed time
    gettimeofday(&endTime,NULL);
    //clock_t end = clock();
    //double time_spent = 1000*((double)(end - begin) / CLOCKS_PER_SEC);
    timersub(&endTime, &startTime, &resultTime);
    

    // Print results
    printf("\nPi = %.10f\n",pi);
    printf("Time elapsed (timeval) using %i threads: %ld.%06ld seconds\n\n",NUM_THREADS, (long int)resultTime.tv_sec, (long int)resultTime.tv_usec);

    
	return 0;
}