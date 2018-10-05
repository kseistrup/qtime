#!/usr/bin/env fish

##############################################################################
# Copyright ©1997-2018 Klaus Alexander Seistrup <klaus@seistrup.dk>          #
#                                                                            #
# Version: 2018.10.05-1                                                      #
#                                                                            #
# This program is free software; you can redistribute it and/or modify it    #
# under the terms of the GNU General Public License as published by the Free #
# Software Foundation; either version 3 of the License, or (at your option)  #
# any later version.                                                         #
#                                                                            #
# This program is distributed in the hope that it will be useful, but with-  #
# out any warranty; without even the implied warranty of merchantability or  #
# fitness for a particular purpose. See the GNU General Public License for   #
# more details. <http://gplv3.fsf.org/>                                      #
##############################################################################

function qtime_fish
   set now (date '+%T' | string split ':')
   set seconds   (math "($now[1] * 60 + $now[2]) * 60 + $now[3]")
   set minutes   (math "($seconds + 30) / 60 + 27")
   set hours     (math "$minutes / 60")
   set minutes   (math "$minutes % 60")
   set divisions (math "$minutes / 5 - 5")
   set nearly 'nearly ' 'almost ' '' 'just after ' 'after '
   set elms $nearly[(math "$minutes % 5 + 1")]
   if test $divisions -ne 0
      set fives 'five' 'ten' 'a quarter' 'twenty' 'twenty-five' 'half'
      if test $divisions -lt 0    # there's no abs(), but …
         set fives $fives[-1..1]  # … we can reverse the list
	 set top ' to '
      else
         set top ' past '
      end
      set elms $elms $fives[$divisions] $top
   end
   set the_hours twelve one two three four five six seven eight nine ten eleven
   set elms $elms $the_hours[(math "$hours % 12 + 1")]
   test $divisions -eq 0
      and set elms $elms " o'clock"
   string join '' $elms
end

function main
   # Do you have the time?
   echo "It's" (qtime_fish).
end

main $argv

# eof
