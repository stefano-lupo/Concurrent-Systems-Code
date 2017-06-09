#define NUM_PHIL 2
#define NUM_FORKS 4

bool thinking[NUM_PHIL], hungry[NUM_PHIL], eating[NUM_PHIL] = false;
int forks[NUM_FORKS] = -1;

//byte numEats[NUM_PHIL] = 0;

// P(0) uses forks 0  and 1
// P(1) uses forks 1 and 2 
// ...
// P(4) uses forks 4 and 0


//[] always
//<> eventually

//Starvation
//#define starved (((hungry[0] == true) || (hungry[1] == true) || (hungry[2] == true) || (hungry[3] == true) || (hungry[4]== == true));
//ltl starvating { <> [] (hungry[0]==true || hungry[1]==true || hungry[2]==true || hungry[3]==true)}


ltl starvation {! [] (((hungry[0] -> <> eating[0]) && (hungry[1] -> <> eating[1])))}

proctype P(int i){
    int left = i , right = (i+1)%NUM_FORKS;

Think:
    atomic{
        eating[i] = false;
        thinking[i] = true;
    };

Hungry:
    atomic{
        thinking[i] = false;
        hungry[i] = true;
    

    // Try grab forks
    if 
    :: skip;  
        atomic{forks[left] == -1 -> forks[left] = i}
        atomic{forks[right] == -1 -> forks[right] = i}     
    fi
    };
    
Eat:
    atomic{
        hungry[i] = false;
        eating[i] = true;
       // numEats[i] = numEats[i] + 1;
    };

Done:
    forks[right] = -1;
    forks[left] = -1;
    goto Think;
}


init{
    atomic {
        run P(0);
        run P(1);
        //run P(2);
        // run P(3);
    }
}