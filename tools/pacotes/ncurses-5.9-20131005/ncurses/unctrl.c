/* generated by MKunctrl.awk */#include <curses.priv.h>#include <ctype.h>#undef unctrlNCURSES_EXPORT(NCURSES_CONST char *) safe_unctrl(SCREEN *sp, chtype ch){static const short unctrl_table[] = {       0,   3,   6,   9,  12,  15,  18,  21,      24,  27,  30,  33,  36,  39,  42,  45,      48,  51,  54,  57,  60,  63,  66,  69,      72,  75,  78,  81,  84,  87,  90,  93,      96,  98, 100, 102, 104, 106, 108, 110,     112, 114, 116, 118, 120, 122, 124, 126,     128, 130, 132, 134, 136, 138, 140, 142,     144, 146, 148, 150, 152, 154, 156, 158,     160, 162, 164, 166, 168, 170, 172, 174,     176, 178, 180, 182, 184, 186, 188, 190,     192, 194, 196, 198, 200, 202, 204, 206,     208, 210, 212, 214, 216, 218, 220, 222,     224, 226, 228, 230, 232, 234, 236, 238,     240, 242, 244, 246, 248, 250, 252, 254,     256, 258, 260, 262, 264, 266, 268, 270,     272, 274, 276, 278, 280, 282, 284, 286,     289, 292, 295, 298, 301, 304, 307, 310,     313, 316, 319, 322, 325, 328, 331, 334,     337, 340, 343, 346, 349, 352, 355, 358,     361, 364, 367, 370, 373, 376, 379, 382,     385, 389, 393, 397, 401, 405, 409, 413,     417, 421, 425, 429, 433, 437, 441, 445,     449, 453, 457, 461, 465, 469, 473, 477,     481, 485, 489, 493, 497, 501, 505, 509,     513, 517, 521, 525, 529, 533, 537, 541,     545, 549, 553, 557, 561, 565, 569, 573,     577, 581, 585, 589, 593, 597, 601, 605,     609, 613, 617, 621, 625, 629, 633, 637,     641, 645, 649, 653, 657, 661, 665, 669,     673, 677, 681, 685, 689, 693, 697, 701,     705, 709, 713, 717, 721, 725, 729, 733,     737, 741, 745, 749, 753, 757, 761, 765,};#if NCURSES_EXT_FUNCSstatic const short unctrl_c1[] = {     768, 770, 772, 774, 776, 778, 780, 782,     784, 786, 788, 790, 792, 794, 796, 798,     800, 802, 804, 806, 808, 810, 812, 814,     816, 818, 820, 822, 824, 826, 828, 830,     832, 834, 836, 838, 840, 842, 844, 846,     848, 850, 852, 854, 856, 858, 860, 862,     864, 866, 868, 870, 872, 874, 876, 878,     880, 882, 884, 886, 888, 890, 892, 894,     896, 898, 900, 902, 904, 906, 908, 910,     912, 914, 916, 918, 920, 922, 924, 926,     928, 930, 932, 934, 936, 938, 940, 942,     944, 946, 948, 950, 952, 954, 956, 958,     960, 962, 964, 966, 968, 970, 972, 974,     976, 978, 980, 982, 984, 986, 988, 990,     992, 994, 996, 998,1000,1002,1004,1006,    1008,1010,1012,1014,1016,1018,1020,1022,};#endif /* NCURSES_EXT_FUNCS */static const char unctrl_blob[] =     "^\100\0^\101\0^\102\0^\103\0^\104\0^\105\0^\106\0^\107\0"    "^\110\0^\111\0^\112\0^\113\0^\114\0^\115\0^\116\0^\117\0"    "^\120\0^\121\0^\122\0^\123\0^\124\0^\125\0^\126\0^\127\0"    "^\130\0^\131\0^\132\0^\133\0^\134\0^\135\0^\136\0^\137\0"    "\040\0\041\0\042\0\043\0\044\0\045\0\046\0\047\0"    "\050\0\051\0\052\0\053\0\054\0\055\0\056\0\057\0"    "\060\0\061\0\062\0\063\0\064\0\065\0\066\0\067\0"    "\070\0\071\0\072\0\073\0\074\0\075\0\076\0\077\0"    "\100\0\101\0\102\0\103\0\104\0\105\0\106\0\107\0"    "\110\0\111\0\112\0\113\0\114\0\115\0\116\0\117\0"    "\120\0\121\0\122\0\123\0\124\0\125\0\126\0\127\0"    "\130\0\131\0\132\0\133\0\134\0\135\0\136\0\137\0"    "\140\0\141\0\142\0\143\0\144\0\145\0\146\0\147\0"    "\150\0\151\0\152\0\153\0\154\0\155\0\156\0\157\0"    "\160\0\161\0\162\0\163\0\164\0\165\0\166\0\167\0"    "\170\0\171\0\172\0\173\0\174\0\175\0\176\0^?\0"    "~\100\0~\101\0~\102\0~\103\0~\104\0~\105\0~\106\0~\107\0"    "~\110\0~\111\0~\112\0~\113\0~\114\0~\115\0~\116\0~\117\0"    "~\120\0~\121\0~\122\0~\123\0~\124\0~\125\0~\126\0~\127\0"    "~\130\0~\131\0~\132\0~\133\0~\134\0~\135\0~\136\0~\137\0"    "M-\040\0M-\041\0M-\042\0M-\043\0M-\044\0M-\045\0M-\046\0M-\047\0"    "M-\050\0M-\051\0M-\052\0M-\053\0M-\054\0M-\055\0M-\056\0M-\057\0"    "M-\060\0M-\061\0M-\062\0M-\063\0M-\064\0M-\065\0M-\066\0M-\067\0"    "M-\070\0M-\071\0M-\072\0M-\073\0M-\074\0M-\075\0M-\076\0M-\077\0"    "M-\100\0M-\101\0M-\102\0M-\103\0M-\104\0M-\105\0M-\106\0M-\107\0"    "M-\110\0M-\111\0M-\112\0M-\113\0M-\114\0M-\115\0M-\116\0M-\117\0"    "M-\120\0M-\121\0M-\122\0M-\123\0M-\124\0M-\125\0M-\126\0M-\127\0"    "M-\130\0M-\131\0M-\132\0M-\133\0M-\134\0M-\135\0M-\136\0M-\137\0"    "M-\140\0M-\141\0M-\142\0M-\143\0M-\144\0M-\145\0M-\146\0M-\147\0"    "M-\150\0M-\151\0M-\152\0M-\153\0M-\154\0M-\155\0M-\156\0M-\157\0"    "M-\160\0M-\161\0M-\162\0M-\163\0M-\164\0M-\165\0M-\166\0M-\167\0"    "M-\170\0M-\171\0M-\172\0M-\173\0M-\174\0M-\175\0M-\176\0~?\0"/* printable values in 128-255 range */    "\200\0\201\0\202\0\203\0\204\0\205\0\206\0\207\0"    "\210\0\211\0\212\0\213\0\214\0\215\0\216\0\217\0"    "\220\0\221\0\222\0\223\0\224\0\225\0\226\0\227\0"    "\230\0\231\0\232\0\233\0\234\0\235\0\236\0\237\0"    "\240\0\241\0\242\0\243\0\244\0\245\0\246\0\247\0"    "\250\0\251\0\252\0\253\0\254\0\255\0\256\0\257\0"    "\260\0\261\0\262\0\263\0\264\0\265\0\266\0\267\0"    "\270\0\271\0\272\0\273\0\274\0\275\0\276\0\277\0"    "\300\0\301\0\302\0\303\0\304\0\305\0\306\0\307\0"    "\310\0\311\0\312\0\313\0\314\0\315\0\316\0\317\0"    "\320\0\321\0\322\0\323\0\324\0\325\0\326\0\327\0"    "\330\0\331\0\332\0\333\0\334\0\335\0\336\0\337\0"    "\340\0\341\0\342\0\343\0\344\0\345\0\346\0\347\0"    "\350\0\351\0\352\0\353\0\354\0\355\0\356\0\357\0"    "\360\0\361\0\362\0\363\0\364\0\365\0\366\0\367\0"    "\370\0\371\0\372\0\373\0\374\0\375\0\376\0\377\0";	int check = (int) ChCharOf(ch);	const char *result;	if (check >= 0 && check < (int)SIZEOF(unctrl_table)) {#if NCURSES_EXT_FUNCS		if ((sp != 0)		 && (sp->_legacy_coding > 1)		 && (check >= 128)		 && (check < 160))			result = unctrl_blob + unctrl_c1[check - 128];		else		if ((check >= 160)		 && (check < 256)		 && ((sp != 0)		  && ((sp->_legacy_coding > 0)		   || (sp->_legacy_coding == 0		       && isprint(check)))))			result = unctrl_blob + unctrl_c1[check - 128];		else#endif /* NCURSES_EXT_FUNCS */			result = unctrl_blob + unctrl_table[check];	} else {		result = 0;	}	return (NCURSES_CONST char *)result;}NCURSES_EXPORT(NCURSES_CONST char *) unctrl (chtype ch){	return safe_unctrl(CURRENT_SCREEN, ch);}