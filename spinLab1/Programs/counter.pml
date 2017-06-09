/*
    Notes




*/

bool flag[2];
bool turn;
byte numProcsInCrit = 0;


int count = 0;
init{
    printf("\nStarting\n");
   // printf("\nThe count is %d\n", count);
}

active proctype p(){
    flag[_pid-1] = true;
	turn = _pid-1;
	(flag[1-(_pid-1)] == false || turn == 1-_pid);


    // critical section
	numProcsInCrit ++;
    crit:	assert(numProcsInCrit ==1);		
    int temp = count;
    temp = temp + 1;
    count = temp;
	numProcsInCrit --;
	flag[_pid -1] = false;

}


active proctype q(){
    flag[_pid-1] = true;
	turn = _pid-1;
	(flag[1-(_pid-1)] == false || turn == 1-_pid);


    // critical section
	numProcsInCrit ++;
    crit:	assert(numProcsInCrit ==1);		
    count ++;
    numProcsInCrit --;
	flag[_pid-1] = false;
}



