	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC :init: */

	case 3: // STATE 1
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 4: // STATE 2
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 5: // STATE 3
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 6: // STATE 4
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 7: // STATE 6
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC P */

	case 8: // STATE 2
		;
		thinking[ Index(((P0 *)this)->i, 4) ] = trpt->bup.ovals[1];
		eating[ Index(((P0 *)this)->i, 4) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 9: // STATE 5
		;
		hungry[ Index(((P0 *)this)->i, 4) ] = trpt->bup.ovals[1];
		thinking[ Index(((P0 *)this)->i, 4) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 10: // STATE 9
		;
		now.forks[ Index(((P0 *)this)->left, 4) ] = trpt->bup.oval;
		;
		goto R999;

	case 11: // STATE 14
		;
		now.forks[ Index(((P0 *)this)->right, 4) ] = trpt->bup.oval;
		;
		goto R999;

	case 12: // STATE 20
		;
		now.forks[ Index(((P0 *)this)->right, 4) ] = trpt->bup.oval;
		;
		goto R999;

	case 13: // STATE 25
		;
		now.forks[ Index(((P0 *)this)->left, 4) ] = trpt->bup.oval;
		;
		goto R999;

	case 14: // STATE 32
		;
		eating[ Index(((P0 *)this)->i, 4) ] = trpt->bup.ovals[1];
		hungry[ Index(((P0 *)this)->i, 4) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 15: // STATE 34
		;
		now.forks[ Index(((P0 *)this)->right, 4) ] = trpt->bup.oval;
		;
		goto R999;

	case 16: // STATE 35
		;
		now.forks[ Index(((P0 *)this)->left, 4) ] = trpt->bup.oval;
		;
		goto R999;
	}

