
bool flag[2];
bool turn;
int numProcsInCrit = 0;

active  proctype p()
{
	flag[_pid] = true;
	turn = _pid;
	(flag[1-_pid] == false || turn == 1-_pid);

	numProcsInCrit++;
	assert(numProcsInCrit==1);
crit:	skip;	// critical section
	numProcsInCrit--;


	flag[_pid] = false;
}


active proctype q()
{
	flag[_pid] = true;
	turn = _pid;
	(flag[1-_pid] == false || turn == 1-_pid);

	numProcsInCrit++;
	assert(numProcsInCrit==1);
crit:	skip;	// critical section
	numProcsInCrit--;


	flag[_pid] = false;
}
