// http://spinroot.com/spin/Doc/Exercises.html
// Peterson's algorithm, 1981

bool flag[4];
int turn;
int numProcsInCrit = 0;
int count = 0;

active [2] proctype p()
{
	flag[_pid] = true;
	turn = _pid;
	((flag[0] == false && flag[1] == false && flag[2] == false && flag[3] == false) || turn == 1-_pid);

	numProcsInCrit++;
	assert(numProcsInCrit==1);
crit:	count++;
	printf("New Count = %d",count);
	numProcsInCrit--;


	flag[_pid] = false;
}


active [2] proctype q()
{
	flag[_pid] = true;
	turn = _pid;
	((flag[0] == false && flag[1] == false && flag[2] == false && flag[3] == false) || turn == 1-_pid);

	numProcsInCrit++;
	assert(numProcsInCrit==1);
crit:	skip;	// critical section
	numProcsInCrit--;


	flag[_pid] = false;
}
