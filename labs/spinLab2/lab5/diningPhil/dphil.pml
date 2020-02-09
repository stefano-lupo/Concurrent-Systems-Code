
byte forks[5] = {1,1,1,1,1};
int numEats[5] = {0,0,0,0,0};
bool finished = false;

// p1 can use forks 0 and 1 etc
// p2 can use forks 1 and 2
// ...
// p5 can use forks 4 and 0 


proctype p(byte id) {
	int numForks = 0;


	do

	// Check if both forks are free
	:: ((forks[id-1] == 1) && (forks[id % 5] == 1)) ->
		atomic{
			// Got both forks
			numForks = numForks +  2;

			// Set both forks as taken
			forks[id-1] = 0;
			forks[id%5] = 0;

			// Eat..
			numEats[id-1] = numEats[id-1] + 1;
			if
			:: skip;
			:: ((numEats[id-1] % 100000)==0) ->
				printf("P%d got both forks at same time : numEats = %d\n",id,numEats[id-1]);
			fi;
			
		
			// Release both forks
			forks[id-1] = 1;
			forks[id%5] = 1;
			numForks = 0;
		}
			

		// Left fork is free, right fork is taken
	::	((forks[id-1] == 1) && (forks[id%5] == 0)) ->

		printf("Starting");

		atomic{
			
			// Grabbed left fork
			numForks = numForks + 1;
			forks[id-1] = 0;
			printf("P%d grabbed fork %d\n",id,id-1);

			// Check if he now has both forks
			if
			::	numForks == 2
				

				// Eat..
				numEats[id-1] = numEats[id-1] + 1;
				if
				:: skip;
				:: ((numEats[id-1] % 100000)==0) ->
					printf("P%d had right and now got left : numEats = %d\n",id,numEats[id-1]);
				fi;
			

				// Release both forks
				forks[id-1] = 1;
				forks[id%5] = 1;
				numForks = 0;
			fi
		}



	// Right fork is free but left fork is taken
	:: ((forks[id-1] == 0) && (forks[id%5] == 1)) ->
		printf("Starting");
		atomic{
			// Grabbed right fork
			numForks = numForks + 1;
			forks[id%5] = 0;
			printf("P%d grabbed fork %d",id,id%5);

			if
			::	numForks == 2

				// Eat..
				numEats[id-1] = numEats[id-1] + 1;
				if
				:: skip;
				:: ((numEats[id-1] % 100000)==0) ->
					printf("P%d had left and now got right : numEats = %d\n",id,numEats[id-1]);
				fi;

				// Release both forks
				forks[id-1] = 1;
				forks[id%5] = 1;
				numForks = 0;
			fi
		}
	:: else ->
		// Could not grab either fork
		printf("P%d cannot eat..\n ", id);
	od
}


init {
	run p(1);
	run p(2);
	run p(3);
	run p(4);
	
}
