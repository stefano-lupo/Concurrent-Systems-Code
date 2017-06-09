#define NUM_PHIL 4


bool thinking[NUM_PHIL], hungry[NUM_PHIL], eating[NUM_PHIL] = false;
//int numEats[NUM_PHIL] = 0;
int forks[NUM_PHIL] = -1;

// P(0) uses forks 0  and 1
// P(1) uses forks 1 and 2 
// ...
// P(4) uses forks 4 and 0


//[] always
//<> eventually

//Starvation
//#define starved (((hungry[0] == true) || (hungry[1] == true) || (hungry[2] == true) || (hungry[3] == true) || (hungry[4]== == true));

//ltl starvating { <> [] (hungry[0]==true || hungry[1]==true || hungry[2]==true || hungry[3]==true)}


//ltl starvation {! [] ((hungry[0] -> <> eating[0]) && (hungry[1] -> <> eating[1]) && (hungry[2] -> <> eating[2]) && (hungry[3] -> <> eating[3]))} // add other phils
ltl starving {! [] (hungry[0] -> <> eating[0])}

proctype P(int i){
    int left = i , right = (i+1)%NUM_PHIL;

Think:
    atomic{
        eating[i] = false;
        thinking[i] = true;
    };

Hungry:
    atomic{
        thinking[i] = false;
        hungry[i] = true;
    };

    // Try grab forks
    if 
    :: left<right;  
        atomic{forks[left] == -1 -> forks[left] = i}
        atomic{forks[right] == -1 -> forks[right] = i}
    :: right < left;
        atomic{forks[right] == -1 -> forks[right] = i}
        atomic{forks[left] == -1 -> forks[left] = i}      
    fi

    
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
        run P(2);
        run P(3);
    }
}