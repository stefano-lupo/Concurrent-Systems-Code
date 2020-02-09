	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* CLAIM starvation */
;
		;
		
	case 4: // STATE 6
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC :init: */
;
		;
		
	case 6: // STATE 2
		;
		havelock[ Index(((P1 *)this)->i, 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 7: // STATE 3
		;
		now.mutex[ Index(((P1 *)this)->i, 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 8: // STATE 4
		;
		now.ammount_eaten[ Index(((P1 *)this)->i, 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 9: // STATE 5
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 10: // STATE 6
		;
		((P1 *)this)->i = trpt->bup.oval;
		;
		goto R999;

	case 11: // STATE 7
		;
	/* 0 */	((P1 *)this)->i = trpt->bup.oval;
		;
		;
		goto R999;

	case 12: // STATE 8
		;
		now.sum = trpt->bup.oval;
		;
		goto R999;

	case 13: // STATE 9
		;
		((P1 *)this)->j = trpt->bup.oval;
		;
		goto R999;

	case 14: // STATE 12
		;
		((P1 *)this)->j = trpt->bup.ovals[1];
		now.sum = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 15: // STATE 13
		;
	/* 0 */	((P1 *)this)->j = trpt->bup.oval;
		;
		;
		goto R999;

	case 16: // STATE 23
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC philosipher */
;
		;
		;
		;
		
	case 19: // STATE 3
		;
		now.mutex[ Index(((P0 *)this)->me, 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 20: // STATE 6
		;
		havelock[ Index(((P0 *)this)->me, 5) ] = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 22: // STATE 8
		;
		now.mutex[ Index(((((P0 *)this)->me+1)%5), 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 23: // STATE 11
		;
		havelock[ Index(((P0 *)this)->me, 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 24: // STATE 15
		;
		now.ammount_eaten[ Index(((P0 *)this)->me, 5) ] = trpt->bup.ovals[3];
		havelock[ Index(((P0 *)this)->me, 5) ] = trpt->bup.ovals[2];
		now.mutex[ Index(((((P0 *)this)->me+1)%5), 5) ] = trpt->bup.ovals[1];
		now.mutex[ Index(((P0 *)this)->me, 5) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 4);
		goto R999;

	case 25: // STATE 19
		;
		now.mutex[ Index(((P0 *)this)->me, 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 26: // STATE 20
		;
		havelock[ Index(((P0 *)this)->me, 5) ] = trpt->bup.oval;
		;
		goto R999;
;
		;
		;
		;
		
	case 29: // STATE 31
		;
		now.philosiphers_finished = trpt->bup.oval;
		;
		goto R999;

	case 30: // STATE 36
		;
		p_restor(II);
		;
		;
		goto R999;
	}

