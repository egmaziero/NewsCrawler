/* * Compile-in this chunk of code unless we've turned it off specifically * or in general (id=_iso_8859_7). */#ifndef INCL_CHARSET_iso_8859_7#define INCL_CHARSET_iso_8859_7 1/*ifdef NO_CHARSET*/#ifdef  NO_CHARSET#undef  NO_CHARSET#endif#define NO_CHARSET 0 /* force default to always be active *//*ifndef NO_CHARSET_iso_8859_7*/#ifndef NO_CHARSET_iso_8859_7#if    ALL_CHARSETS#define NO_CHARSET_iso_8859_7 0#else#define NO_CHARSET_iso_8859_7 1#endif#endif /* ndef(NO_CHARSET_iso_8859_7) */#if NO_CHARSET_iso_8859_7#define UC_CHARSET_SETUP_iso_8859_7 /*nothing*/#else/* *  uni_hash.tbl * *  Do not edit this file; it was automatically generated by * *  ./makeuctb ./iso07_uni.tbl * */static const u8 dfont_unicount_iso_8859_7[256] = {	  0,   0,   0,   0,   0,   0,   0,   0,	  0,   0,   0,   0,   0,   0,   0,   0,	  0,   0,   0,   0,   0,   0,   0,   0,	  0,   0,   0,   0,   0,   0,   0,   0,	  1,   1,   1,   1,   1,   1,   1,   1,	  1,   1,   1,   1,   1,   1,   1,   1,	  1,   1,   1,   1,   1,   1,   1,   1,	  1,   1,   1,   1,   1,   1,   1,   1,	  1,   1,   1,   1,   1,   1,   1,   1,	  1,   1,   1,   1,   1,   1,   1,   1,	  1,   1,   1,   1,   1,   1,   1,   1,	  1,   1,   1,   1,   1,   1,   1,   1,	  1,   1,   1,   1,   1,   1,   1,   1,	  1,   1,   1,   1,   1,   1,   1,   1,	  1,   1,   1,   1,   1,   1,   1,   1,	  1,   1,   1,   1,   1,   1,   1,   0,	  0,   0,   0,   0,   0,   0,   0,   0,	  0,   0,   0,   0,   0,   0,   0,   0,	  0,   0,   0,   0,   0,   0,   0,   0,	  0,   0,   0,   0,   0,   0,   0,   0,	  1,   3,   3,   1,   1,   1,   1,   1,	  1,   1,   1,   1,   1,   1,   0,   1,	  1,   1,   1,   1,   1,   1,   2,   4,	  2,   2,   2,   1,   2,   1,   2,   2,	  1,   1,   1,   2,   1,   1,   1,   1,	  1,   1,   1,   2,   1,   1,   1,   1,	  2,   1,   0,   1,   1,   1,   2,   2,	  1,   1,   1,   1,   2,   2,   2,   2,	  1,   1,   1,   2,   2,   1,   1,   1,	  1,   2,   1,   1,   2,   1,   1,   1,	  1,   1,   1,   1,   1,   2,   1,   1,	  1,   1,   1,   2,   2,   2,   2,   0};static const u16 dfont_unitable_iso_8859_7[220] = {	0x0020, 0x0021, 0x0022, 0x0023, 0x0024, 0x0025, 0x0026, 0x0027,	0x0028, 0x0029, 0x002a, 0x002b, 0x002c, 0x002d, 0x002e, 0x002f,	0x0030, 0x0031, 0x0032, 0x0033, 0x0034, 0x0035, 0x0036, 0x0037,	0x0038, 0x0039, 0x003a, 0x003b, 0x003c, 0x003d, 0x003e, 0x003f,	0x0040, 0x0041, 0x0042, 0x0043, 0x0044, 0x0045, 0x0046, 0x0047,	0x0048, 0x0049, 0x004a, 0x004b, 0x004c, 0x004d, 0x004e, 0x004f,	0x0050, 0x0051, 0x0052, 0x0053, 0x0054, 0x0055, 0x0056, 0x0057,	0x0058, 0x0059, 0x005a, 0x005b, 0x005c, 0x005d, 0x005e, 0x005f,	0x0060, 0x0061, 0x0062, 0x0063, 0x0064, 0x0065, 0x0066, 0x0067,	0x0068, 0x0069, 0x006a, 0x006b, 0x006c, 0x006d, 0x006e, 0x006f,	0x0070, 0x0071, 0x0072, 0x0073, 0x0074, 0x0075, 0x0076, 0x0077,	0x0078, 0x0079, 0x007a, 0x007b, 0x007c, 0x007d, 0x007e, 0x00a0,	0x02bd, 0x2018, 0x0371, 0x02bc, 0x2019, 0x0372, 0x00a3, 0x20ac,	0x20af, 0x00a6, 0x00a7, 0x00a8, 0x00a9, 0x037a, 0x00ab, 0x00ac,	0x00ad, 0x2015, 0x00b0, 0x00b1, 0x00b2, 0x00b3, 0x0384, 0x0385,	0x0386, 0x1fbb, 0x00b7, 0x0307, 0x0387, 0x2027, 0x0388, 0x1fc9,	0x0389, 0x1fcb, 0x038a, 0x1fdb, 0x00bb, 0x038c, 0x1ff9, 0x00bd,	0x038e, 0x1feb, 0x038f, 0x1ffb, 0x0390, 0x0391, 0x0392, 0x0393,	0x0413, 0x0394, 0x0395, 0x0396, 0x0397, 0x0398, 0x0399, 0x039a,	0x039b, 0x041b, 0x039c, 0x039d, 0x039e, 0x039f, 0x03a0, 0x041f,	0x03a1, 0x03a3, 0x03a4, 0x03a5, 0x03a6, 0x0424, 0x03a7, 0x0425,	0x03a8, 0x03a9, 0x03aa, 0x03ab, 0x03ac, 0x1f71, 0x03ad, 0x1f73,	0x03ae, 0x1f75, 0x03af, 0x1f77, 0x03b0, 0x03b1, 0x03b2, 0x03b3,	0x0263, 0x03b4, 0x00f0, 0x03b5, 0x03b6, 0x03b7, 0x03b8, 0x03b9,	0x0131, 0x03ba, 0x03bb, 0x03bc, 0x00b5, 0x03bd, 0x03be, 0x03bf,	0x03c0, 0x03c1, 0x03c2, 0x03c3, 0x03c4, 0x03c5, 0x028a, 0x03c6,	0x03c7, 0x03c8, 0x03c9, 0x03ca, 0x03cb, 0x00fc, 0x03cc, 0x1f79,	0x03cd, 0x1f7b, 0x03ce, 0x1f7d};static struct unipair_str repl_map_iso_8859_7[6] = {	{0x2218," \260 "}, {0x2209," !\345 "}, {0x221b," ROOT\263 "}, {0x229a,"(\260)"},	{0x2a4,"d\346"}, {0x20af,"\304\361\367"}};static const struct unimapdesc_str dfont_replacedesc_iso_8859_7 = {6,repl_map_iso_8859_7,0,1};#define UC_CHARSET_SETUP_iso_8859_7 UC_Charset_Setup("iso-8859-7",\"Greek (ISO-8859-7)",\dfont_unicount_iso_8859_7,dfont_unitable_iso_8859_7,220,\dfont_replacedesc_iso_8859_7,160,2,813)#endif /* NO_CHARSET_iso_8859_7 */#endif /* INCL_CHARSET_iso_8859_7 */