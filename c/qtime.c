/******************************************************************************
 * Copyright ©1991-2017 Klaus Alexander Seistrup @ Magnetic Ink, Copenhagen, DK.
 *
 * QTime -- display time as English sentence.
 *
 * Author  : 1991 Klaus Alexander Seistrup <kseis@magnetic-ink.dk>
 * Created : Sometime back in 1991 on my Amiga 500. :-)
 * @(#) $Id: qtime.c,v 1.3 1999/01/29 11:51:57 kseis Exp $
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2 of the License, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful, but with-
 * out any warranty; without even the implied warranty of merchantability or
 * fitness for a particular purpose.  See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
 ******************************************************************************/

#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <time.h>

static long
get_secs(void)
{
    time_t sys_time = time(NULL);
    struct tm *sys_date = localtime(&sys_time);

    return ((sys_date->tm_hour * 60L) + sys_date->tm_min) * 60L +
	sys_date->tm_sec;
}

static void
qt(void)
{
    static char *const hr[] = {
	"twelve", "one", "two", "three", "four", "five",
	"six", "seven", "eight", "nine", "ten", "eleven"
    };
    static char *const mn[] = {
	"", "five ", "ten ", "a quarter ",
	"twenty ", "twenty-five ", "half "
    };
    static char *const ny[] = {
	"nearly ", "almost ", "", "just after ", "after "
    };
    static char *const up[] = {
	"to ", "", "past "
    };

    long adj_mins = (get_secs() + 30L) / 60L + 27L;
    long hours = (adj_mins / 60L) % 12L;
    long minutes = adj_mins % 60L;
    long almost = minutes % 5L;
    long divisions = (minutes / 5L) - 5L;
    long to_past_idx = divisions > 0L ? 1L : 0L;

    if (divisions < 0L)
      {
	  divisions = -divisions;
	  to_past_idx = -1L;
      }
    ++to_past_idx;

    (void) printf("It's %s%s%s%s",
		  ny[almost], mn[divisions], up[to_past_idx], hr[hours]);

    if (divisions == 0L)
	(void) puts(" o'clock.");
    else
	(void) puts(".");
}

int
main(int argc, char *const *argv)
{
    qt();
    return 0;
}

/*
 * EoF
 */
