#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC :init: */
	case 3: // STATE 1 - test.pml:33 - [(run p())] (0:0:0 - 1)
		IfNotBlocked
		reached[2][1] = 1;
		if (!(addproc(II, 1, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 2 - test.pml:34 - [(run q())] (0:0:0 - 1)
		IfNotBlocked
		reached[2][2] = 1;
		if (!(addproc(II, 1, 1)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 3 - test.pml:35 - [((pc==4))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][3] = 1;
		if (!((now.pc==4)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 4 - test.pml:36 - [printf('Finished -%d\\n',n)] (0:0:0 - 1)
		IfNotBlocked
		reached[2][4] = 1;
		Printf("Finished -%d\n", now.n);
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 5 - test.pml:37 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[2][5] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC q */
	case 8: // STATE 1 - test.pml:24 - [i = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		(trpt+1)->bup.oval = ((P1 *)this)->i;
		((P1 *)this)->i = 1;
#ifdef VAR_RANGES
		logval("q:i", ((P1 *)this)->i);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 2 - test.pml:24 - [((i<=2))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][2] = 1;
		if (!((((P1 *)this)->i<=2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 3 - test.pml:25 - [n = (n+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][3] = 1;
		(trpt+1)->bup.oval = now.n;
		now.n = (now.n+1);
#ifdef VAR_RANGES
		logval("n", now.n);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 4 - test.pml:24 - [i = (i+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][4] = 1;
		(trpt+1)->bup.oval = ((P1 *)this)->i;
		((P1 *)this)->i = (((P1 *)this)->i+1);
#ifdef VAR_RANGES
		logval("q:i", ((P1 *)this)->i);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 10 - test.pml:27 - [printf('Process q is complete with n : %d.\\n',n)] (0:0:0 - 3)
		IfNotBlocked
		reached[1][10] = 1;
		Printf("Process q is complete with n : %d.\n", now.n);
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 11 - test.pml:28 - [pc = (pc+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][11] = 1;
		(trpt+1)->bup.oval = now.pc;
		now.pc = (now.pc+1);
#ifdef VAR_RANGES
		logval("pc", now.pc);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 12 - test.pml:29 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][12] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC p */
	case 15: // STATE 1 - test.pml:8 - [i = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		(trpt+1)->bup.oval = ((P0 *)this)->i;
		((P0 *)this)->i = 1;
#ifdef VAR_RANGES
		logval("p:i", ((P0 *)this)->i);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 2 - test.pml:8 - [((i<=2))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][2] = 1;
		if (!((((P0 *)this)->i<=2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 3 - test.pml:9 - [temp = n] (0:0:1 - 1)
		IfNotBlocked
		reached[0][3] = 1;
		(trpt+1)->bup.oval = ((P0 *)this)->temp;
		((P0 *)this)->temp = now.n;
#ifdef VAR_RANGES
		logval("p:temp", ((P0 *)this)->temp);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 18: // STATE 4 - test.pml:10 - [temp = (temp+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][4] = 1;
		(trpt+1)->bup.oval = ((P0 *)this)->temp;
		((P0 *)this)->temp = (((P0 *)this)->temp+1);
#ifdef VAR_RANGES
		logval("p:temp", ((P0 *)this)->temp);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 19: // STATE 5 - test.pml:11 - [n = temp] (0:0:1 - 1)
		IfNotBlocked
		reached[0][5] = 1;
		(trpt+1)->bup.oval = now.n;
		now.n = ((P0 *)this)->temp;
#ifdef VAR_RANGES
		logval("n", now.n);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 20: // STATE 6 - test.pml:8 - [i = (i+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][6] = 1;
		(trpt+1)->bup.oval = ((P0 *)this)->i;
		((P0 *)this)->i = (((P0 *)this)->i+1);
#ifdef VAR_RANGES
		logval("p:i", ((P0 *)this)->i);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 21: // STATE 12 - test.pml:15 - [printf('Prcess p is complete wit n :%d \\n',n)] (0:0:0 - 3)
		IfNotBlocked
		reached[0][12] = 1;
		Printf("Prcess p is complete wit n :%d \n", now.n);
		_m = 3; goto P999; /* 0 */
	case 22: // STATE 13 - test.pml:16 - [pc = (pc+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][13] = 1;
		(trpt+1)->bup.oval = now.pc;
		now.pc = (now.pc+1);
#ifdef VAR_RANGES
		logval("pc", now.pc);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 23: // STATE 14 - test.pml:17 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][14] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

