// _pid is a built in read only variabe which holds the id of the process that requests it
init{
	int lastPID;
	printf("Init Starting with _pid = %d\n",_pid);

	lastPID = run Hello();
	printf("LastPID = \n");
	
	lastPID = run Hello();
	printf("LastPID = %d\n",lastPID);

}
active proctype Hello() {
    	printf("Hello Process, my pid is : %d\n",_pid);
}



