/***
*assert.h - define the assert macro
*
*	Copyright (c) 1985-1988, Microsoft Corporation.  All rights reserved.
*
*Purpose:
*	Defines the assert(exp) macro.
*	[ANSI/System V]
*
*Revision History:
*	12-18-87  JCR	Added _FAR_ to declarations
*	01-18-88  JCR	Added fflush(stderr) to go with new stderr buffering scheme
*	02-10-88  JCR	Cleaned up white space
*
*******************************************************************************/


/* Don't use _FAR_ for internal builds */	/* _FAR_DEFINED */
#define _FAR_								/* _FAR_DEFINED */
											/* _FAR_DEFINED */
#ifndef _ASSERT_DEFINED

#ifndef NDEBUG

static char _FAR_ _assertstring[] = "Annahme falsch: %s, Datei %s, Zeile %d\n";

#define assert(exp)	{ \
	if (!(exp)) { \
		fprintf(stderr, _assertstring, #exp, __FILE__, __LINE__); \
		fflush(stderr); \
		abort(); \
		} \
	}

#else

#define assert(exp)

#endif /* NDEBUG */

#define _ASSERT_DEFINED

#endif /* _ASSERT_DEFINED */
