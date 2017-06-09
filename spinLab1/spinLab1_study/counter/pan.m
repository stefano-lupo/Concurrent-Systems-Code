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

		 /* PROC WaitForFinsih */
	case 3: // STATE 1 - counter.pml:17 - [((finish==2))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		if (!((((int)now.finish)==2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 2 - counter.pml:18 - [printf('n = %d\\n',n)] (0:0:0 - 1)
		IfNotBlocked
		reached[1][2] = 1;
		Printf("n = %d\n", ((int)now.n));
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 3 - counter.pml:19 - [assert((n>=10))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][3] = 1;
		spin_assert((((int)now.n)>=10), "(n>=10)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 4 - counter.pml:20 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][4] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC P */
	case 7: // STATE 1 - counter.pml:6 - [((counter==10))] (0:0:1 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		if (!((((int)((P0 *)this)->counter)==10)))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: counter */  (trpt+1)->bup.oval = ((P0 *)this)->counter;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P0 *)this)->counter = 0;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 4 - counter.pml:8 - [reg = n] (0:0:1 - 1)
		IfNotBlocked
		reached[0][4] = 1;
		(trpt+1)->bup.oval = ((int)((P0 *)this)->reg);
		((P0 *)this)->reg = ((int)now.n);
#ifdef VAR_RANGES
		logval("P:reg", ((int)((P0 *)this)->reg));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 5 - counter.pml:9 - [reg = (reg+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][5] = 1;
		(trpt+1)->bup.oval = ((int)((P0 *)this)->reg);
		((P0 *)this)->reg = (((int)((P0 *)this)->reg)+1);
#ifdef VAR_RANGES
		logval("P:reg", ((int)((P0 *)this)->reg));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 6 - counter.pml:10 - [n = reg] (0:0:1 - 1)
		IfNotBlocked
		reached[0][6] = 1;
		(trpt+1)->bup.oval = ((int)now.n);
		now.n = ((int)((P0 *)this)->reg);
#ifdef VAR_RANGES
		logval("n", ((int)now.n));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 7 - counter.pml:11 - [counter = (counter+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][7] = 1;
		(trpt+1)->bup.oval = ((int)((P0 *)this)->counter);
		((P0 *)this)->counter = (((int)((P0 *)this)->counter)+1);
#ifdef VAR_RANGES
		logval("P:counter", ((int)((P0 *)this)->counter));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 11 - counter.pml:13 - [finish = (finish+1)] (0:0:1 - 3)
		IfNotBlocked
		reached[0][11] = 1;
		(trpt+1)->bup.oval = ((int)now.finish);
		now.finish = (((int)now.finish)+1);
#ifdef VAR_RANGES
		logval("finish", ((int)now.finish));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 12 - counter.pml:14 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][12] = 1;
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

