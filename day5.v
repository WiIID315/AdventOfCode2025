import os

struct Range {
    mut:
        start i64
        end i64
}

fn part1() {
    file_path := 'input.txt'
    lines := os.read_lines(file_path) or {panic (err)}

    mut pre_ranges := []Range{}
    mut queries := []i64{}
    mut ans := i64(0)
    for line in lines {
        l := line.trim_space();
        if l == '' {
            continue
        }
        idx := l.index('-') or { -1 }
        if idx != -1 {
            left := l[0..idx].i64()
            right := l[(idx + 1)..].i64()
            pre_ranges << Range {
                start: left
                end: right
            }
        } else {
            val := l.i64()
            queries << val
        }
    }

    for q in queries {
        for range in pre_ranges {
            if range.start <= q && range.end >= q {
                ans++;
                break
            }
        }
    }
    // mut curr := pre_ranges[0]
    // mut ranges := []Range{}
    // for range in pre_ranges {
    //     if range.start > curr.end + 1 {
    //         ranges << curr
    //         curr = range
    //     } else {
    //         if range.end > curr.end {
    //             curr.end = range.end
    //         }
    //     }
    // }

    // queries.sort()
    // mut ptr := 0
    // for range in ranges {
    //     if ptr >= queries.len {
    //         break
    //     }

    //     for ptr < queries.len && queries[ptr] < range.start && queries[ptr] <= range.end{
    //         ptr++;
    //     }

    //     for ptr < queries.len && queries[ptr] >= range.start && queries[ptr] <= range.end {

    //         ptr++;
    //         ans++;
    //     }
    // }
    println(ans)
}

fn part2() {
    file_path := 'input.txt'
    lines := os.read_lines(file_path) or {panic (err)}

    mut pre_ranges := []Range{}
    mut ans := i64(0)
    for line in lines {
        l := line.trim_space();
        if l == '' {
            continue
        }
        idx := l.index('-') or { -1 }
        if idx == -1 {
            break
        }
        left := l[0..idx].i64()
        right := l[(idx + 1)..].i64()
        pre_ranges << Range {
            start: left
            end: right
        }
    }
    pre_ranges.sort(a.start < b.start)

    mut curr := pre_ranges[0]
    mut ranges := []Range{}
    for range in pre_ranges {
        if range.start > curr.end + 1 {
            ranges << curr
            curr = range
        } else {
            if range.end > curr.end {
                curr.end = range.end
            }
        }
    }
    ranges << curr
    for r in ranges {
        ans += i64(r.end - r.start + 1)
    }
    println(ans)
}

fn main() {
    part1()
}
