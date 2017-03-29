#!/usr/bin/gawk -f
## -*- mode: awk; coding: utf-8 -*-
##############################################################################
## Copyright ©1999-2017 Klaus Alexander Seistrup <klaus@seistrup.dk>
##
## QTime -- display time as English sentence.
##
## Author  : Klaus Alexander Seistrup <klaus@seistrup.dk>
## Created : Friday, 29th January 1999
## @(#) $Id: qtime.awk,v 1.2 1999/01/29 12:02:32 kas Exp $
##
## My first program in AWK. :-)
##
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by the Free
## Software Foundation; either version 2 of the License, or (at your option)
## any later version.
##
## This program is distributed in the hope that it will be useful, but with-
## out any warranty; without even the implied warranty of merchantability or
## fitness for a particular purpose.  See the GNU General Public License for
## more details.
##
## You should have received a copy of the GNU General Public License along
## with this program; if not, write to the Free Software Foundation, Inc.,
## 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
##############################################################################

BEGIN {
  # The hours
  Hr[0] = "twelve";
  Hr[1] = "one";
  Hr[2] = "two";
  Hr[3] = "three";
  Hr[4] = "four";
  Hr[5] = "five";
  Hr[6] = "six";
  Hr[7] = "seven";
  Hr[8] = "eight";
  Hr[9] = "nine";
  Hr[10]= "ten";
  Hr[11]= "eleven";
  # 5-minute divisions
  Mn[0] = "";
  Mn[1] = "five ";
  Mn[2] = "ten ";
  Mn[3] = "a quarter ";
  Mn[4] = "twenty ";
  Mn[5] = "twenty-five ";
  Mn[6] = "half ";
  # Almost...
  Ny[0] = "nearly ";
  Ny[1] = "almost ";
  Ny[2] = "";
  Ny[3] = "just after ";
  Ny[4] = "after ";
  # To or past
  Up[0] = "to ";
  Up[1] = "";
  Up[2] = "past ";
  now   = systime();
  hh    = strftime("%H", now) + 0;
  mm    = strftime("%M", now) + 0;
  ss    = strftime("%S", now) + 0;
  adjm  = int(((hh * 60 + mm) * 60 + ss + 30) / 60) + 27;
  hours = int(adjm / 60) % 12;
  mins  = adjm % 60;
  alm   = mins % 5;
  divs  = int(mins / 5) - 5;
  tpi   = (divs > 0) ? 2 : (divs == 0 ? 1 : 0);
  if (divs < 0)
    divs = -divs;
  printf "It's " Ny[alm] Mn[divs] Up[tpi] Hr[hours];
  if (divs == 0)
    printf " o'clock";
  printf ".\n";
}
#
##############################################################################
