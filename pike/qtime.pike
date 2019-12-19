#!/usr/bin/env pike
// -*- c -*-

int get_secs()
{
    int sys_time = time();
    mapping(string:int) sys_date = localtime(sys_time);

    return ((sys_date["hour"] * 60) + sys_date["min"]) * 60 + sys_date["sec"];
}

void qt()
{
    array(string) hr = ({
	"twelve", "one", "two", "three", "four", "five",
	"six", "seven", "eight", "nine", "ten", "eleven"
    });
    array(string) mn = ({
	"", "five ", "ten ", "a quarter ",
	"twenty ", "twenty-five ", "half "
    });
    array(string) ny = ({
	"nearly ", "almost ", "", "just after ", "after "
    });
    array(string) up = ({
	"to ", "", "past "
    });

    int adj_mins = (get_secs() + 30) / 60 + 27;
    int hours = (adj_mins / 60) % 12;
    int minutes = adj_mins % 60;
    int almost = minutes % 5;
    int divisions = (minutes / 5) - 5;
    int to_past_idx = divisions > 0 ? 1 : 0;

    if (divisions < 0) {
	  divisions = -divisions;
	  to_past_idx = -1;
      }
    ++to_past_idx;

    write(sprintf("It's %s%s%s%s", ny[almost], mn[divisions], up[to_past_idx], hr[hours]));

    if (divisions == 0)
	write(" o'clock.\n");
    else
	write(".\n");
}

int main()
{
    qt();
    return 0;
}

// eof
