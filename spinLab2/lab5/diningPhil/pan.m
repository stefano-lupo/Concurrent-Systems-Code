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

		 /* CLAIM starvation */
	case 3: // STATE 1 - _spin_nvr.tmp:4 - [(!((((((ammount_eaten[0]!=0)||(ammount_eaten[1]!=0))||(ammount_eaten[2]!=0))||(ammount_eaten[3]!=0))||(ammount_eaten[4]==0))))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[2][1] = 1;
		if (!( !((((((now.ammount_eaten[0]!=0)||(now.ammount_eaten[1]!=0))||(now.ammount_eaten[2]!=0))||(now.ammount_eaten[3]!=0))||(now.ammount_eaten[4]==0)))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 6 - _spin_nvr.tmp:6 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported6 = 0;
			if (verbose && !reported6)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported6 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported6 = 0;
			if (verbose && !reported6)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported6 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[2][6] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC :init: */
	case 5: // STATE 1 - dp.pml:108 - [((i<5))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		if (!((((P1 *)this)->i<5)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 2 - dp.pml:109 - [havelock[i] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][2] = 1;
		(trpt+1)->bup.oval = ((int)havelock[ Index(((P1 *)this)->i, 5) ]);
		havelock[ Index(((P1 *)this)->i, 5) ] = 0;
#ifdef VAR_RANGES
		logval("havelock[:init::i]", ((int)havelock[ Index(((P1 *)this)->i, 5) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 3 - dp.pml:110 - [mutex[i] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][3] = 1;
		(trpt+1)->bup.oval = ((int)now.mutex[ Index(((P1 *)this)->i, 5) ]);
		now.mutex[ Index(((P1 *)this)->i, 5) ] = 0;
#ifdef VAR_RANGES
		logval("mutex[:init::i]", ((int)now.mutex[ Index(((P1 *)this)->i, 5) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 4 - dp.pml:111 - [ammount_eaten[i] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][4] = 1;
		(trpt+1)->bup.oval = now.ammount_eaten[ Index(((P1 *)this)->i, 5) ];
		now.ammount_eaten[ Index(((P1 *)this)->i, 5) ] = 0;
#ifdef VAR_RANGES
		logval("ammount_eaten[:init::i]", now.ammount_eaten[ Index(((P1 *)this)->i, 5) ]);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 5 - dp.pml:112 - [(run philosipher(i))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][5] = 1;
		if (!(addproc(II, 1, 0, ((P1 *)this)->i)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 6 - dp.pml:113 - [i = (i+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][6] = 1;
		(trpt+1)->bup.oval = ((P1 *)this)->i;
		((P1 *)this)->i = (((P1 *)this)->i+1);
#ifdef VAR_RANGES
		logval(":init::i", ((P1 *)this)->i);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 7 - dp.pml:114 - [((i>=5))] (0:0:1 - 1)
		IfNotBlocked
		reached[1][7] = 1;
		if (!((((P1 *)this)->i>=5)))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: i */  (trpt+1)->bup.oval = ((P1 *)this)->i;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)this)->i = 0;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 8 - dp.pml:115 - [sum = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][8] = 1;
		(trpt+1)->bup.oval = now.sum;
		now.sum = 0;
#ifdef VAR_RANGES
		logval("sum", now.sum);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 9 - dp.pml:116 - [j = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][9] = 1;
		(trpt+1)->bup.oval = ((P1 *)this)->j;
		((P1 *)this)->j = 0;
#ifdef VAR_RANGES
		logval(":init::j", ((P1 *)this)->j);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 10 - dp.pml:119 - [((j<5))] (15:0:2 - 1)
		IfNotBlocked
		reached[1][10] = 1;
		if (!((((P1 *)this)->j<5)))
			continue;
		/* merge: sum = (sum+mutex[j])(15, 11, 15) */
		reached[1][11] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.sum;
		now.sum = (now.sum+((int)now.mutex[ Index(((P1 *)this)->j, 5) ]));
#ifdef VAR_RANGES
		logval("sum", now.sum);
#endif
		;
		/* merge: j = (j+1)(15, 12, 15) */
		reached[1][12] = 1;
		(trpt+1)->bup.ovals[1] = ((P1 *)this)->j;
		((P1 *)this)->j = (((P1 *)this)->j+1);
#ifdef VAR_RANGES
		logval(":init::j", ((P1 *)this)->j);
#endif
		;
		/* merge: .(goto)(0, 16, 15) */
		reached[1][16] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 15: // STATE 13 - dp.pml:122 - [((j>=5))] (17:0:1 - 1)
		IfNotBlocked
		reached[1][13] = 1;
		if (!((((P1 *)this)->j>=5)))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: j */  (trpt+1)->bup.oval = ((P1 *)this)->j;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)this)->j = 0;
		/* merge: goto :b2(0, 14, 17) */
		reached[1][14] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 16: // STATE 23 - dp.pml:132 - [-end-] (0:0:0 - 3)
		IfNotBlocked
		reached[1][23] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC philosipher */
	case 17: // STATE 1 - dp.pml:20 - [((ammount_eaten[me]>=0))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		if (!((now.ammount_eaten[ Index(((int)((P0 *)this)->me), 5) ]>=0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 18: // STATE 2 - dp.pml:24 - [((mutex[me]==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][2] = 1;
		if (!((((int)now.mutex[ Index(((int)((P0 *)this)->me), 5) ])==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 19: // STATE 3 - dp.pml:26 - [mutex[me] = 1] (0:6:1 - 1)
		IfNotBlocked
		reached[0][3] = 1;
		(trpt+1)->bup.oval = ((int)now.mutex[ Index(((int)((P0 *)this)->me), 5) ]);
		now.mutex[ Index(((P0 *)this)->me, 5) ] = 1;
#ifdef VAR_RANGES
		logval("mutex[philosipher:me]", ((int)now.mutex[ Index(((int)((P0 *)this)->me), 5) ]));
#endif
		;
		/* merge: printf('%d Left Lock acquired... \\n',me)(6, 4, 6) */
		reached[0][4] = 1;
		Printf("%d Left Lock acquired... \n", ((int)((P0 *)this)->me));
		_m = 3; goto P999; /* 1 */
	case 20: // STATE 6 - dp.pml:29 - [havelock[me] = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[0][6] = 1;
		(trpt+1)->bup.oval = ((int)havelock[ Index(((int)((P0 *)this)->me), 5) ]);
		havelock[ Index(((P0 *)this)->me, 5) ] = 1;
#ifdef VAR_RANGES
		logval("havelock[philosipher:me]", ((int)havelock[ Index(((int)((P0 *)this)->me), 5) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 21: // STATE 7 - dp.pml:32 - [((mutex[((me+1)%5)]==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][7] = 1;
		if (!((((int)now.mutex[ Index(((((int)((P0 *)this)->me)+1)%5), 5) ])==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 22: // STATE 8 - dp.pml:34 - [mutex[((me+1)%5)] = 1] (0:11:1 - 1)
		IfNotBlocked
		reached[0][8] = 1;
		(trpt+1)->bup.oval = ((int)now.mutex[ Index(((((int)((P0 *)this)->me)+1)%5), 5) ]);
		now.mutex[ Index(((((P0 *)this)->me+1)%5), 5) ] = 1;
#ifdef VAR_RANGES
		logval("mutex[((philosipher:me+1)%5)]", ((int)now.mutex[ Index(((((int)((P0 *)this)->me)+1)%5), 5) ]));
#endif
		;
		/* merge: printf('%d RIGHT Lock acquired... \\n',me)(11, 9, 11) */
		reached[0][9] = 1;
		Printf("%d RIGHT Lock acquired... \n", ((int)((P0 *)this)->me));
		_m = 3; goto P999; /* 1 */
	case 23: // STATE 11 - dp.pml:39 - [havelock[me] = 2] (0:0:1 - 1)
		IfNotBlocked
		reached[0][11] = 1;
		(trpt+1)->bup.oval = ((int)havelock[ Index(((int)((P0 *)this)->me), 5) ]);
		havelock[ Index(((P0 *)this)->me, 5) ] = 2;
#ifdef VAR_RANGES
		logval("havelock[philosipher:me]", ((int)havelock[ Index(((int)((P0 *)this)->me), 5) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 24: // STATE 12 - dp.pml:47 - [mutex[me] = 0] (0:33:4 - 1)
		IfNotBlocked
		reached[0][12] = 1;
		(trpt+1)->bup.ovals = grab_ints(4);
		(trpt+1)->bup.ovals[0] = ((int)now.mutex[ Index(((int)((P0 *)this)->me), 5) ]);
		now.mutex[ Index(((P0 *)this)->me, 5) ] = 0;
#ifdef VAR_RANGES
		logval("mutex[philosipher:me]", ((int)now.mutex[ Index(((int)((P0 *)this)->me), 5) ]));
#endif
		;
		/* merge: mutex[((me+1)%5)] = 0(33, 13, 33) */
		reached[0][13] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.mutex[ Index(((((int)((P0 *)this)->me)+1)%5), 5) ]);
		now.mutex[ Index(((((P0 *)this)->me+1)%5), 5) ] = 0;
#ifdef VAR_RANGES
		logval("mutex[((philosipher:me+1)%5)]", ((int)now.mutex[ Index(((((int)((P0 *)this)->me)+1)%5), 5) ]));
#endif
		;
		/* merge: havelock[me] = 0(33, 14, 33) */
		reached[0][14] = 1;
		(trpt+1)->bup.ovals[2] = ((int)havelock[ Index(((int)((P0 *)this)->me), 5) ]);
		havelock[ Index(((P0 *)this)->me, 5) ] = 0;
#ifdef VAR_RANGES
		logval("havelock[philosipher:me]", ((int)havelock[ Index(((int)((P0 *)this)->me), 5) ]));
#endif
		;
		/* merge: ammount_eaten[me] = (ammount_eaten[me]+1)(33, 15, 33) */
		reached[0][15] = 1;
		(trpt+1)->bup.ovals[3] = now.ammount_eaten[ Index(((int)((P0 *)this)->me), 5) ];
		now.ammount_eaten[ Index(((P0 *)this)->me, 5) ] = (now.ammount_eaten[ Index(((int)((P0 *)this)->me), 5) ]+1);
#ifdef VAR_RANGES
		logval("ammount_eaten[philosipher:me]", now.ammount_eaten[ Index(((int)((P0 *)this)->me), 5) ]);
#endif
		;
		/* merge: printf('%d Both Locks Released: %d  \\n',me,ammount_eaten[me])(33, 16, 33) */
		reached[0][16] = 1;
		Printf("%d Both Locks Released: %d  \n", ((int)((P0 *)this)->me), now.ammount_eaten[ Index(((int)((P0 *)this)->me), 5) ]);
		/* merge: .(goto)(0, 24, 33) */
		reached[0][24] = 1;
		;
		/* merge: .(goto)(0, 29, 33) */
		reached[0][29] = 1;
		;
		/* merge: .(goto)(0, 34, 33) */
		reached[0][34] = 1;
		;
		_m = 3; goto P999; /* 7 */
	case 25: // STATE 19 - dp.pml:57 - [mutex[me] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[0][19] = 1;
		(trpt+1)->bup.oval = ((int)now.mutex[ Index(((int)((P0 *)this)->me), 5) ]);
		now.mutex[ Index(((P0 *)this)->me, 5) ] = 0;
#ifdef VAR_RANGES
		logval("mutex[philosipher:me]", ((int)now.mutex[ Index(((int)((P0 *)this)->me), 5) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 26: // STATE 20 - dp.pml:58 - [havelock[me] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[0][20] = 1;
		(trpt+1)->bup.oval = ((int)havelock[ Index(((int)((P0 *)this)->me), 5) ]);
		havelock[ Index(((P0 *)this)->me, 5) ] = 0;
#ifdef VAR_RANGES
		logval("havelock[philosipher:me]", ((int)havelock[ Index(((int)((P0 *)this)->me), 5) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 27: // STATE 21 - dp.pml:59 - [printf('%d --> LEFT Lock Released... \\n',me)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][21] = 1;
		Printf("%d --> LEFT Lock Released... \n", ((int)((P0 *)this)->me));
		_m = 3; goto P999; /* 0 */
	case 28: // STATE 26 - dp.pml:66 - [printf('%d --> Couldn't get either LOCK \\n',me)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][26] = 1;
		Printf("%d --> Couldn't get either LOCK \n", ((int)((P0 *)this)->me));
		_m = 3; goto P999; /* 0 */
	case 29: // STATE 31 - dp.pml:74 - [philosiphers_finished = (philosiphers_finished+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][31] = 1;
		(trpt+1)->bup.oval = now.philosiphers_finished;
		now.philosiphers_finished = (now.philosiphers_finished+1);
#ifdef VAR_RANGES
		logval("philosiphers_finished", now.philosiphers_finished);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 30: // STATE 36 - dp.pml:78 - [-end-] (0:0:0 - 3)
		IfNotBlocked
		reached[0][36] = 1;
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

