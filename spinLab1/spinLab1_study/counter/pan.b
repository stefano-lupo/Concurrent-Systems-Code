	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC WaitForFinsih */
;
		;
		;
		;
		;
		;
		
	case 6: // STATE 4
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC P */

	case 7: // STATE 1
		;
	/* 0 */	((P0 *)this)->counter = trpt->bup.oval;
		;
		;
		goto R999;

	case 8: // STATE 4
		;
		((P0 *)this)->reg = trpt->bup.oval;
		;
		goto R999;

	case 9: // STATE 5
		;
		((P0 *)this)->reg = trpt->bup.oval;
		;
		goto R999;

	case 10: // STATE 6
		;
		now.n = trpt->bup.oval;
		;
		goto R999;

	case 11: // STATE 7
		;
		((P0 *)this)->counter = trpt->bup.oval;
		;
		goto R999;

	case 12: // STATE 11
		;
		now.finish = trpt->bup.oval;
		;
		goto R999;

	case 13: // STATE 12
		;
		p_restor(II);
		;
		;
		goto R999;
	}

