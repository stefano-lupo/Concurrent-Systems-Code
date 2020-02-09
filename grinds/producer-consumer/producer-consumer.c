
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include "cond.c"

// We want threads to be "working" for less than a second
int work (int ms, struct timespec *ts) {
    ts->tv_sec = 0;
    ts->tv_nsec = 1000 * ms;
    nanosleep(ts,NULL);
    return 0;
}
// timespecs for producer and consumer
struct timespec tsP,tsC;

int pnum;  // number updated when producer runs.
int csum;  // sum computed using pnum when consumer runs.

int (*pred)(int); // predicate indicating number to be consumed

// S: Create and initialize global refernce to CV and Mutex
// S: Also create a variable to track whether or not the value has been consumed
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cv = PTHREAD_COND_INITIALIZER;
int newValueExists = 0;

int produceT() {
  scanf("%d",&pnum); // read a number from stdin
  return pnum;
}

void *Produce(void *a) {
  int p;

  p=1;
  while (p) {
    printf("@P-WORK\n");
    work(100,&tsP); // "work" for 100ms
    printf("@P-READY\n");

    // S: Acquire lock before updating pnum
    printf("P: Trying to acquire lock\n");
    pthread_mutex_lock(&lock);
    printf("P: Acquired the lock \n");

    while (newValueExists) {
      printf("P: Had the lock but new value existed still\n");
      pthread_cond_wait(&cv, &lock);
    }

    printf("P: Have the lock and no new value\n");

    // TODO: Probably remove this as it _should_ be an impossibility, provided we have implemented the locking correctly
    if (newValueExists) {
      printf("\n\nERROR - Producer has the lock while a new value still exists\n\n");
      exit(1);
    }
    
    p = produceT();
    printf("@PRODUCED %d\n",p);
    newValueExists = 1;

    printf("P: Signaling consumer thread\n");
    pthread_cond_signal(&cv);
    
    printf("P: Releasng mutex lock\n");
    pthread_mutex_unlock(&lock);
  }

  printf("@P-EXIT\n");
  pthread_exit(NULL);
}


int consumeT() {
  if (pred(pnum)) { 
    printf("%i passes predicate\n", pnum);
    csum += pnum; 
  }
  return pnum;
}

void *Consume(void *a) {
  int p;

  p=1;
  while (p) {
    printf("@C-WORK\n");
    work(50+100*(rand()%3),&tsC); // "work" for 50ms, 150ms, or 250ms
    printf("@C-READY\n");

    printf("C: Acquiring lock\n");
    pthread_mutex_lock(&lock);
    printf("C: Acquired lock\n");
    
    // Ensure there is a new value so we don't consume the same value twice
    while (!newValueExists) {
      printf("C: No new value exists, waiting on CV signal (releasing lock)\n");
      pthread_cond_wait(&cv, &lock);
    }

    // TODO: Probably remove this as it _should_ be an impossibility, provided we have implemented the locking correctly
    if (!newValueExists) {
      printf("\n\nERROR - Consumer has the lock and is about to consume while no new value exists\n\n");
      exit(1);
    }

    printf("C: New value exists\n");
    p = consumeT();
    
    printf("C: Received value %i, new sum %i\n", p, csum);
    printf("@CONSUMED %d\n",csum);

    newValueExists = 0;
    printf("C: Releasing lock and signaling for %i\n", p);
    pthread_cond_signal(&cv);
    pthread_mutex_unlock(&lock);

    printf("C: Released lock and signaled for %i\n", p);

  }
  printf("@C-EXIT\n");
  pthread_exit(NULL);
}


int main (int argc, const char * argv[]) {
  // the current number predicate
  static pthread_t prod,cons;
	long rc;

  // S: set the default predicate to always true for easier debugging
  pred = &cond1;
  if (argc>1) {
    if (!strncmp(argv[1],"2",10)) { 
      printf("Using cond2\n");
      pred = &cond2; 
    }
    else if (!strncmp(argv[1],"3",10)) { 
      printf("Using cond3\n");
      pred = &cond3; 
    }
    
    // S: adding support for always true predicate
    else if (!strncmp(argv[1],"4",10)) { 
      printf("Using alwaysTrue\n");
      pred = &alwaysTrue; 
    } else {
      printf("Using default predicate\n");
    }
  }

  pnum = 999;
  csum=0;
  srand(time(0));

  printf("@P-CREATE\n");
 	rc = pthread_create(&prod,NULL,Produce,(void *)0);
	if (rc) {
			printf("@P-ERROR %ld\n",rc);
			exit(-1);
		}
    
  printf("@C-CREATE\n");
 	rc = pthread_create(&cons,NULL,Consume,(void *)0);
	if (rc) {
			printf("@C-ERROR %ld\n",rc);
			exit(-1);
		}

  printf("@P-JOIN\n");
  pthread_join( prod, NULL);
  printf("@C-JOIN\n");
  pthread_join( cons, NULL);


  // Expected values for 1 to 20:
  // Odd (cond1): 100
  // Even (cond2): 110
  // % 3 (cond3): 63
  // All: 210
  printf("@CSUM=%d.\n",csum);

  // tidy up
  pthread_mutex_destroy(&lock);
  pthread_cond_destroy(&cv);

  return 0;
}
