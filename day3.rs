use std::io;

fn main() {
    part2();
}

#[allow(dead_code)]
fn part1() {
    let mut ans: i64 = 0;
    let stdin = io::stdin();
    for line in stdin.lines() {
        let str = match line {
            Err(_) => break,
            Ok(s) => s,
        };

        let mut first: i32 = -1;
        let mut second: i32 = 0;
        for c in str.chars() {
            let d = c.to_digit(10);
            let digit = d.unwrap() as i32;
            if second > first {
                first = second;
                second = digit;
            } else if digit > second {
                second = digit;
            }
        }
        ans += (first * 10 + second) as i64;
    }
    println!("{ans}");
}

fn part2() {
    let mut ans: i64 = 0;
    let stdin = io::stdin();
    for line in stdin.lines() {
        let str = match line {
            Err(_) => break,
            Ok(s) => s,
        };

        let chars: Vec<char> = str.chars().collect();
        let mut stack: Vec<u32> = Vec::new();
        let mut removable = chars.len() - 12;

        for i in 0.. chars.len() {
            let c = chars[i].to_digit(10).unwrap();
            while !stack.is_empty() && c > stack[stack.len() - 1] && removable > 0 {
                stack.pop();
                removable -= 1;
            }
            if stack.len() < 12 {
                stack.push(c);
            } else {
                removable -= 1;
            }
        }
        let mut add: i64 = 0;
        for i in 0.. 12 {
            let val = stack[i] as i64;
            add *= 10;
            add += val;
        }
        ans += add;
    }
    println!("{ans}");
}
