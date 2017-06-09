#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define NUM_THREADS 5

typedef struct Person {
    int age;
} Person;

void *sayHello(void* param){
    Person* person = (Person*)param;
    printf("Hello I am %d years old\n",person->age);
    pthread_exit(NULL);
}


int main(){
    
    // Create a  person
    Person* person = (Person*)malloc(sizeof(Person));
    person->age = 22;

    // Create an array of People
    Person* people[NUM_THREADS];
    people[0] = person;
    for(int i=1;i<NUM_THREADS;i++){
        people[i] = (Person*)malloc(sizeof(Person));
        people[i]->age = 10*i;
    }

    pthread_t threads[NUM_THREADS];

    for(int i=0;i<NUM_THREADS;i++){
        pthread_create(&threads[i],NULL,sayHello,(void*)people[i]);
        printf("Created thread %i\n",i);
    }

    for(int i=0;i<NUM_THREADS;i++){
        pthread_join(threads[i],NULL);
    }

    return 0;
}