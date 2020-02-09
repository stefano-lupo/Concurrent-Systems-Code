
byte forks[5] = {0,0,0,0,0};
int numEats[5] = {0,0,0,0,0};
byte hungry[5] = {1,1,1,1,1};

// p1 can use forks 0 and 1 etc
// p2 can use forks 1 and 2
// ...
// p5 can use forks 4 and 0 


//ltl livelock {[]<> (numEats[0] != 0 && numEats[1] != 0 && numEats[2] != 0 && numEats[3] != 0 && numEats[4] != 0 ) }

// [] always, <> eventually
// One Philosopher - run p(1)
//ltl starve1 {eventually hungry[0] == 0}

// Two philophers - run p(1); run p(3)
ltl starve1 {[]<> ((hungry[0] == 0) && (hungry[2] == 0))}

proctype p(byte id) {
	int numForks = 0;


    do

	// Try take left fork then right fork
    ::
    	atomic{
            hungry[id-1] = 1;
			printf("Left fork first\n");
            if
            :: forks[id-1] == 0 ->
                printf("P%d grabbed fork %d\n",id,id-1);
                numForks = numForks + 1;
                forks[id-1] = id;
			fi;
        }

        atomic {
            printf("Going for right fork second\n");
            if
            :: forks[id%5]==0 ->
                printf("P%d grabbed fork %d\n",id,id%5);
                numForks = numForks + 1;
                forks[id%5] = id;
            fi;
        }


        atomic{
            if
            :: numForks == 2 ->
                hungry[id-1] = 0;
                printf("P%d eating\n\n",id);
                forks[id-1] = 0;
                forks[id%5] = 0;
                numForks = 0;
                numEats[id-1] = numEats[id-1] + 1;
            fi;
        }
        




    // Try take right first then left
    ::
       atomic{
            printf("Right fork first\n");
            hungry[id-1] = 1;
            if
            :: forks[id%5] == 0 ->
                printf("P%d grabbed fork %d\n",id,id%5);
                numForks = numForks + 1;
                forks[id%5] = id;
            fi;
        }

        atomic {
            printf("Going for left fork second\n");
            if
            :: forks[id-1]==0 ->
                printf("P%d grabbed fork %d\n",id,id-1);
                numForks = numForks + 1;
                forks[id-1] = id;
            fi;
        }

        atomic {
            if
            :: numForks == 2 ->
                hungry[id-1] = 0;
                printf("P%d eating\n\n",id);
                forks[id-1] = 0;
                forks[id%5] = 0;
                numForks = 0;
                numEats[id-1] = numEats[id-1] + 1;
            fi;
        }
    od;
}


init {
    atomic {
        run p(1);
        //run p(2);
        run p(3);
        //run p(4);
        //run p(5);
    }
}
