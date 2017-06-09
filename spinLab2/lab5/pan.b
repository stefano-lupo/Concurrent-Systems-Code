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
;
		;
		;
		;
		
	case 7: // STATE 5
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC q */

	case 8: // STATE 1
		;
		((P1 *)this)->i = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 10: // STATE 3
		;
		now.n = trpt->bup.oval;
		;
		goto R999;

	case 11: // STATE 4
		;
		((P1 *)this)->i = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 13: // STATE 11
		;
		now.pc = trpt->bup.oval;
		;
		goto R999;

	case 14: // STATE 12
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC p */

	case 15: // STATE 1
		;
		((P0 *)this)->i = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 17: // STATE 3
		;
		((P0 *)this)->temp = trpt->bup.oval;
		;
		goto R999;

	case 18: // STATE 4
		;
		((P0 *)this)->temp = trpt->bup.oval;
		;
		goto R999;

	case 19: // STATE 5
		;
		now.n = trpt->bup.oval;
		;
		goto R999;

	case 20: // STATE 6
		;
		((P0 *)this)->i = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 22: // STATE 13
		;
		now.pc = trpt->bup.oval;
		;
		goto R999;

	case 23: // STATE 14
		;
		p_restor(II);
		;
		;
		goto R999;
	}

