#!/usr/bin/env python
# -*- mode: python; coding: utf-8 -*-
"""
QTime — Display time as an English sentence
"""
##############################################################################
# Copyright ©2005-2017 Klaus Alexander Seistrup <klaus@seistrup.dk>
#
# Version: 0.2.3 (2017-03-28)
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation; either version 3 of the License, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but with-
# out any warranty; without even the implied warranty of merchantability or
# fitness for a particular purpose. See the GNU General Public License for
# more details.  <http://gplv3.fsf.org/>
##############################################################################

from time import (time, localtime, gmtime)


def qtime(utc=False):
    """Returns current time as an English sentence"""
    the_hours = {
        0: 'twelve', 1: 'one', 2: 'two', 3: 'three', 4: 'four', 5: 'five',
        6: 'six', 7: 'seven', 8: 'eight', 9: 'nine', 10: 'ten', 11: 'eleven'
    }
    now = gmtime(time()) if utc else localtime(time())
    seconds = (now.tm_hour * 60 + now.tm_min) * 60 + now.tm_sec
    minutes = (seconds + 30) // 60 + 27
    (hours, minutes) = divmod(minutes, 60)
    divisions = minutes // 5 - 5
    elms = [
        ('nearly ', 'almost ', '', 'just after ', 'after ')[minutes % 5]
    ]

    if divisions:
        elms.append(
            ('', 'five ', 'ten ', 'a quarter ',
             'twenty ', 'twenty-five ', 'half ')[abs(divisions)]
        )
        elms.append('to ' if divisions < 0 else 'past ')

    elms.append(the_hours[hours % 12])

    if not divisions:
        elms.append(" o'clock")

    return ''.join(elms)


if __name__ == '__main__':
    print("It's {}.".format(qtime()))

# eof
