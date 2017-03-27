#!/usr/bin/env slsh
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Copyright ©1997-2017 Klaus Alexander Seistrup <klaus@seistrup.dk>
%%
%% Version: 0.1.4 (2017-03-27)
%%
%% This program is free software; you can redistribute it and/or modify it
%% under the terms of the GNU General Public License as published by the Free
%% Software Foundation; either version 3 of the License, or (at your option)
%% any later version.
%%
%% This program is distributed in the hope that it will be useful, but with-
%% out any warranty; without even the implied warranty of merchantability or
%% fitness for a particular purpose. See the GNU General Public License for
%% more details.  <http://gplv3.fsf.org/>
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Returns current local time as an English sentence
define qtime()
{
   variable TP = "to ::past ";
   variable NY = "nearly :almost ::just after :after ";
   variable MN = ":five :ten :a quarter :twenty :twenty-five :half ";
   variable HR = "midnight:one:two:three:four:five:six:seven:eight:nine:ten:eleven:noon";

   variable now = extract_element(strcompress(time(), " "), 3, ' ');
   variable hh = integer(extract_element(now, 0, ':'));
   variable mm = integer(extract_element(now, 1, ':'));
   variable ss = integer(extract_element(now, 2, ':'));

   variable adjust = int(((hh * 60 + mm) * 60 + ss + 30) / 60 + 27);
   variable hours = int(adjust / 60);
   variable hours12 = hours mod 12;
   variable minutes = adjust mod 60;
   variable divisions = int(minutes / 5) - 5;

   variable tiktok = strcat(
     extract_element(NY, minutes mod 5, ':'),
     extract_element(MN, abs(divisions), ':'),
     extract_element(TP, sign(divisions) + 1, ':'),
     extract_element(HR, hours12 ? hours12 : hours, ':')
   );

   if (hours12 and not divisions)
     return strcat(tiktok, " o'clock");

   return tiktok;
}

% Do you have the time?
message(sprintf("It's %s.", qtime()));

%% eof
