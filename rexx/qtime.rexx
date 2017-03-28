#!/usr/bin/env rexx

/** -*- REXX -*- *************************************************************
 * Copyright ©1991-2017 Klaus Alexander Seistrup
 *
 * QTime — display time as English sentence.
 *
 * Author  : 1991 Klaus Alexander Seistrup <klaus@seistrup.dk>
 * Created : Sometime back in 1991 on my Amiga 500, using ARexx. :-)
 * @(#) $Id: qtime.rexx,v 1.3 1999/01/29 11:51:57 kas Exp $
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
 *****************************************************************************/

Hr.0	= 'twelve'
Hr.1	= 'one'
Hr.2	= 'two'
Hr.3	= 'three'
Hr.4	= 'four'
Hr.5	= 'five'
Hr.6	= 'six'
Hr.7	= 'seven'
Hr.8	= 'eight'
Hr.9	= 'nine'
Hr.10	= 'ten'
Hr.11	= 'eleven'

Mn.0	= ''
Mn.1	= 'five '
Mn.2	= 'ten '
Mn.3	= 'a quarter '
Mn.4	= 'twenty '
Mn.5	= 'twenty-five '
Mn.6	= 'half '

Ny.0	= 'nearly '
Ny.1	= 'almost '
Ny.2	= ''
Ny.3	= 'just after '
Ny.4	= 'after '

Up.0	= 'to '
Up.1	= ''
Up.2	= 'past '

t = (TIME('S') + 30) % 60 + 27

Hrs	= (t % 60) // 12
Min	= t // 60
Alm	= Min // 5
Div	= (Min % 5) - 5
Upt	= SIGN(Div) + 1

IF Div < 0 THEN Div = -Div
OClock = "It's " || Ny.Alm || Mn.Div || Up.Upt || Hr.Hrs
IF Div == 0 THEN OClock = OClock || " o'clock"

SAY OClock || '.'

/*
**  EOF
*/
