	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC q */

	case 3: // STATE 1
		;
		now.count = trpt->bup.oval;
		;
		goto R999;

	case 4: // STATE 2
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC p */

	case 5: // STATE 1
		;
		((P1 *)this)->temp = trpt->bup.oval;
		;
		goto R999;

	case 6: // STATE 2
		;
		now.count = trpt->bup.oval;
		;
		goto R999;

	case 7: // STATE 3
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC :init: */

	case 8: // STATE 1
		;
		((P0 *)this)->i = trpt->bup.oval;
		;
		goto R999;

	case 9: // STATE 5
		;
		p_restor(II);
		;
		;
		goto R999;
	}

