#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>



/*  Using pThreads
        1:  Create a refference to a/the thread(s)
                pthread_t myThread;
                pthread_t myThreads[NUM_THREADS];

        2:  Create an entry point for the threads
            This must be a function that reutrns a void*
            and takes in a single void* as the argument
                void* myThreadedFunction(void* argument){
                    // ...
                }

        3:  Create the thread using pthread_create
            This takes four arguments
                1: A POINTER to pthread_t variable
                2: Extra attributes (NULL usually)
                3: A pointer to the function to call [JUST THE FUNCTION NAME]
                4: A void pointer to the parameter block

        4:  Join everything back to one thread using pthread_join
            This takes two parameters
                1: A reference to our pthread_t thread [NOT A POINTER]
                2: A pointer to the return value pointer [usually NULL] 
*/



// Say hello with structs
typedef struct {
    int age;
} Person;


void* sayHello(void* personParameter){
    // Have been passed a pointer to a Person
    // Can't typecast overwrite person parameter
    // So create a new pointer to a Person
    Person* person = (Person*)personParameter;

    // Use struct as normal
    printf("Hello I hate C strings and I am %i years old \n",person->age);
    pthread_exit(NULL);
}



#define NUM_THREADS 3

int main(){

    // Create an array of 3 pointers to people
    Person* people[3];
    people[0] = (Person*)malloc(sizeof(Person));
    people[0]->age = 10;
    people[1] = (Person*)malloc(sizeof(Person));
    people[1]->age = 20;
    people[2] = (Person*)malloc(sizeof(Person));
    people[2]->age = 30;


    // 1: Declre the threads
    pthread_t threads[NUM_THREADS];
    
    // 2: Create and launch all of the threads
    for(int i=0;i<NUM_THREADS;i++){
        printf("Starting thread %i\n",i);
        int returnCode = pthread_create(&threads[i],NULL,sayHello,(void*)people[i]);

        if(returnCode != 0){
            printf("Error occured on thread %i: %i\n\n",i,returnCode);
            exit(-1);
        }
    }

    // 3: Join all of the threads
    for(int i=0;i<NUM_THREADS;i++){
        pthread_join(threads[i],NULL);
        printf("Joined thread %i\n",i);
    }

    printf("Finished joining threads\n");

    return 0;
}