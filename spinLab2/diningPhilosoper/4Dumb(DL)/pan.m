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
	case 3: // STATE 1 - diningPhil.pml:85 - [(run P(0))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		if (!(addproc(II, 1, 0, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 2 - diningPhil.pml:86 - [(run P(1))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][2] = 1;
		if (!(addproc(II, 1, 0, 1)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 3 - diningPhil.pml:87 - [(run P(2))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][3] = 1;
		if (!(addproc(II, 1, 0, 2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 4 - diningPhil.pml:88 - [(run P(3))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][4] = 1;
		if (!(addproc(II, 1, 0, 3)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 6 - diningPhil.pml:90 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][6] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC P */
	case 8: // STATE 1 - diningPhil.pml:28 - [eating[i] = 0] (0:6:2 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)eating[ Index(((P0 *)this)->i, 4) ]);
		eating[ Index(((P0 *)this)->i, 4) ] = 0;
#ifdef VAR_RANGES
		logval("eating[P:i]", ((int)eating[ Index(((P0 *)this)->i, 4) ]));
#endif
		;
		/* merge: thinking[i] = 1(6, 2, 6) */
		reached[0][2] = 1;
		(trpt+1)->bup.ovals[1] = ((int)thinking[ Index(((P0 *)this)->i, 4) ]);
		thinking[ Index(((P0 *)this)->i, 4) ] = 1;
#ifdef VAR_RANGES
		logval("thinking[P:i]", ((int)thinking[ Index(((P0 *)this)->i, 4) ]));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 9: // STATE 4 - diningPhil.pml:34 - [thinking[i] = 0] (0:29:2 - 1)
		IfNotBlocked
		reached[0][4] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)thinking[ Index(((P0 *)this)->i, 4) ]);
		thinking[ Index(((P0 *)this)->i, 4) ] = 0;
#ifdef VAR_RANGES
		logval("thinking[P:i]", ((int)thinking[ Index(((P0 *)this)->i, 4) ]));
#endif
		;
		/* merge: hungry[i] = 1(29, 5, 29) */
		reached[0][5] = 1;
		(trpt+1)->bup.ovals[1] = ((int)hungry[ Index(((P0 *)this)->i, 4) ]);
		hungry[ Index(((P0 *)this)->i, 4) ] = 1;
#ifdef VAR_RANGES
		logval("hungry[P:i]", ((int)hungry[ Index(((P0 *)this)->i, 4) ]));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 10: // STATE 8 - diningPhil.pml:43 - [((forks[left]==-(1)))] (17:0:1 - 1)
		IfNotBlocked
		reached[0][8] = 1;
		if (!((now.forks[ Index(((P0 *)this)->left, 4) ]== -(1))))
			continue;
		/* merge: forks[left] = i(17, 9, 17) */
		reached[0][9] = 1;
		(trpt+1)->bup.oval = now.forks[ Index(((P0 *)this)->left, 4) ];
		now.forks[ Index(((P0 *)this)->left, 4) ] = ((P0 *)this)->i;
#ifdef VAR_RANGES
		logval("forks[P:left]", now.forks[ Index(((P0 *)this)->left, 4) ]);
#endif
		;
		/* merge: .(goto)(17, 11, 17) */
		reached[0][11] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 11: // STATE 13 - diningPhil.pml:49 - [((forks[right]==-(1)))] (33:0:1 - 1)
		IfNotBlocked
		reached[0][13] = 1;
		if (!((now.forks[ Index(((P0 *)this)->right, 4) ]== -(1))))
			continue;
		/* merge: forks[right] = i(33, 14, 33) */
		reached[0][14] = 1;
		(trpt+1)->bup.oval = now.forks[ Index(((P0 *)this)->right, 4) ];
		now.forks[ Index(((P0 *)this)->right, 4) ] = ((P0 *)this)->i;
#ifdef VAR_RANGES
		logval("forks[P:right]", now.forks[ Index(((P0 *)this)->right, 4) ]);
#endif
		;
		/* merge: .(goto)(33, 16, 33) */
		reached[0][16] = 1;
		;
		/* merge: .(goto)(0, 30, 33) */
		reached[0][30] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 12: // STATE 19 - diningPhil.pml:58 - [((forks[right]==-(1)))] (28:0:1 - 1)
		IfNotBlocked
		reached[0][19] = 1;
		if (!((now.forks[ Index(((P0 *)this)->right, 4) ]== -(1))))
			continue;
		/* merge: forks[right] = i(28, 20, 28) */
		reached[0][20] = 1;
		(trpt+1)->bup.oval = now.forks[ Index(((P0 *)this)->right, 4) ];
		now.forks[ Index(((P0 *)this)->right, 4) ] = ((P0 *)this)->i;
#ifdef VAR_RANGES
		logval("forks[P:right]", now.forks[ Index(((P0 *)this)->right, 4) ]);
#endif
		;
		/* merge: .(goto)(28, 22, 28) */
		reached[0][22] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 13: // STATE 24 - diningPhil.pml:64 - [((forks[left]==-(1)))] (33:0:1 - 1)
		IfNotBlocked
		reached[0][24] = 1;
		if (!((now.forks[ Index(((P0 *)this)->left, 4) ]== -(1))))
			continue;
		/* merge: forks[left] = i(33, 25, 33) */
		reached[0][25] = 1;
		(trpt+1)->bup.oval = now.forks[ Index(((P0 *)this)->left, 4) ];
		now.forks[ Index(((P0 *)this)->left, 4) ] = ((P0 *)this)->i;
#ifdef VAR_RANGES
		logval("forks[P:left]", now.forks[ Index(((P0 *)this)->left, 4) ]);
#endif
		;
		/* merge: .(goto)(33, 27, 33) */
		reached[0][27] = 1;
		;
		/* merge: .(goto)(0, 30, 33) */
		reached[0][30] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 14: // STATE 31 - diningPhil.pml:72 - [hungry[i] = 0] (0:34:2 - 1)
		IfNotBlocked
		reached[0][31] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)hungry[ Index(((P0 *)this)->i, 4) ]);
		hungry[ Index(((P0 *)this)->i, 4) ] = 0;
#ifdef VAR_RANGES
		logval("hungry[P:i]", ((int)hungry[ Index(((P0 *)this)->i, 4) ]));
#endif
		;
		/* merge: eating[i] = 1(34, 32, 34) */
		reached[0][32] = 1;
		(trpt+1)->bup.ovals[1] = ((int)eating[ Index(((P0 *)this)->i, 4) ]);
		eating[ Index(((P0 *)this)->i, 4) ] = 1;
#ifdef VAR_RANGES
		logval("eating[P:i]", ((int)eating[ Index(((P0 *)this)->i, 4) ]));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 15: // STATE 34 - diningPhil.pml:77 - [forks[right] = -(1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][34] = 1;
		(trpt+1)->bup.oval = now.forks[ Index(((P0 *)this)->right, 4) ];
		now.forks[ Index(((P0 *)this)->right, 4) ] =  -(1);
#ifdef VAR_RANGES
		logval("forks[P:right]", now.forks[ Index(((P0 *)this)->right, 4) ]);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 35 - diningPhil.pml:78 - [forks[left] = -(1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][35] = 1;
		(trpt+1)->bup.oval = now.forks[ Index(((P0 *)this)->left, 4) ];
		now.forks[ Index(((P0 *)this)->left, 4) ] =  -(1);
#ifdef VAR_RANGES
		logval("forks[P:left]", now.forks[ Index(((P0 *)this)->left, 4) ]);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

