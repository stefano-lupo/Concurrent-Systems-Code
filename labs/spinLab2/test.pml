
int n;
int pc;

proctype p() {
	int temp;
	int i;
	for (i:1 .. 2){
		temp = n;
		temp = temp +1;
		n = temp;

	}
	
	printf("Prcess p is complete wit n :%d \n",n);
	pc++;
}



proctype q() {

	int i;
	for(i : 1 .. 2){
		n = n + 1;
	}	
	printf("Process q is complete with n : %d.\n",n);
	pc ++;
}


init {
	run p();
	run q();
	(pc == 2);
	printf("Finished -%d\n",n);
	//assert(n==4); //not needed for trails 
}
