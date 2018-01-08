use std::time::UNIX_EPOCH;
use std::time::SystemTime;

fn secs() -> u64 {
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .expect("Cannot calculate secs since UNIX_EPOCH")
        .as_secs()
}

fn main() {
    let hr = ["twelve", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven"];
    let mn = ["", "five ", "ten ", "a quarter ", "twenty ", "twenty-five ", "half "];
    let ny = [ "nearly ", "almost ", "", "just after ", "after "];
    let up = ["to ", "", "past "];

    let adj_mins        = ((secs() + 30) / 60 + 27) as i64;
    let hours           = (adj_mins / 60) % 12;
    let minutes         = adj_mins % 60;
    let almost          = minutes % 5;
    let mut divisions   = (minutes / 5) - 5;
    let mut to_past_idx = if divisions > 0 { 1 } else { 0 };

    if divisions < 0 {
        divisions = -divisions;
        to_past_idx = -1;
    }
    to_past_idx += 1;

    println!("It's {}{}{}{}{}", ny[almost as usize], mn[divisions as usize], up[to_past_idx as usize], hr[hours as usize],
            if divisions == 0 {
                " o'clock"
            } else {
                "."
            });
}
