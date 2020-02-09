#define N_PHILOSOPHERS 5
#define AMMOUNT_TO_EAT 150

/*--- PROVES DEADLOCK DOES OCCUR --- */


bit mutex[N_PHILOSOPHERS];
bit havelock[N_PHILOSOPHERS];
int ammount_eaten[N_PHILOSOPHERS];
int philosiphers_finished = 0;

int sum;
int sume;


proctype philosipher(byte me){
	int i,a;
	
	do
	:: ammount_eaten[me] >= 0 ->
	     
	     /* -- TRY LOCK THE LEFT FORK-- */
	   	if
	   	:: mutex[me] == 0 ->
	   		atomic{	
	   			mutex[me] =1
				printf("%d Left Lock acquired... \n", me);
			}
			havelock[me] = 1;
			/* -- TRY LOCK THE RIGHT FORK-- */
			if
			:: mutex[(me +1)%N_PHILOSOPHERS] == 0 ->
				atomic{
					mutex[(me +1)%N_PHILOSOPHERS] =1
					printf("%d RIGHT Lock acquired... \n", me);
					
				}
				/* -- Acquired the RIGHT LOCK --*/
				havelock[me] = 2;
				/* -- USE THE FORKS...... ---- */
				

				

				/* -- UNLOCK THE FORKS --- */
				atomic{
					mutex[me] = 0;
					mutex[(me +1)%N_PHILOSOPHERS] = 0;
					havelock[me] = 0;
					ammount_eaten[me] = ammount_eaten[me] + 1;
					printf("%d Both Locks Released: %d  \n", me, ammount_eaten[me]);
				}

			:: else -> 
				/*-- Release the Left Lock -- */
				/*-- Couldn't get the right Lock -- */
				mutex[me] =0
				havelock[me] = 0;
				printf("%d --> LEFT Lock Released... \n", me);
				/* -- Wait a Little Bit ...... ---- */
				
				skip
			fi
		:: else -> 
			/* -- Wait a Little Bit ...... ---- */
			printf("%d --> Couldn't get either LOCK \n", me);

			
			skip
		fi

	:: else ->
		/*--- Finished Eating -- */
		philosiphers_finished = philosiphers_finished + 1;
  	break
	od
	
}
/*
active proctype mostPhilosophersFinished(){
	
	philosiphers_finished==3;
	printf("\n\n\n------> Majority Philosiphers Finished \n");

	/* --- Check if it's greater than 2 -- 
	assert(ammount_eaten[0] > (AMMOUNT_TO_EAT/10));
	assert(ammount_eaten[1] > (AMMOUNT_TO_EAT/10));
	assert(ammount_eaten[2] > (AMMOUNT_TO_EAT/10));
	assert(ammount_eaten[3] > (AMMOUNT_TO_EAT/10));
	assert(ammount_eaten[4] > (AMMOUNT_TO_EAT/10));

}
*/


#define totalEaten ((ammount_eaten[0]+ammount_eaten[1]+ammount_eaten[2]+ammount_eaten[3]+ammount_eaten[4]) > 0)
#define starving ((ammount_eaten[0] != 0) || (ammount_eaten[1] != 0) || (ammount_eaten[2] != 0) || (ammount_eaten[3] != 0) || (ammount_eaten[4] == 0) )
/*ltl livelock { (<>totalEaten)}  */
ltl starvation { (<>starving)} 



init {
   int i = 0;
   int j;
 
 end:  do 
   :: i < N_PHILOSOPHERS ->
   	    havelock[i] = 0;			/*Nobody has the lock in the beggining */
   		mutex[i] = 0;
   		ammount_eaten[i] = 0;
     run philosipher(i);
     i++
   :: i >= N_PHILOSOPHERS ->
     sum = 0;
     j = 0;
     atomic {
       do
       :: j < N_PHILOSOPHERS ->
         sum = sum + mutex[j];
         j = j + 1
       :: j >= N_PHILOSOPHERS ->
         break
       od
     }
     /*assert(sum <= 3); */ 
    
     /*--assert(mutex[0] == 1 && mutex[2] == 1 && mutex[3] == 1 && mutex[4] == 1 ) --*/
     
     break
   od
}
