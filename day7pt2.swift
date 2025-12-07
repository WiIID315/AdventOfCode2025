import Swift
import Foundation

let path = "input.txt"
var lines:[[Character]] = []
var dp:[[Int]] = []

let file = freopen(path, "r", stdin)

while let line=readLine() {
    lines.append(Array(line))
    dp.append(Array(repeating: 0, count:lines[0].count))
}

for i in 0...lines[0].count - 1 {
    if lines[0][i] == "S" {
        dp[0][i] = 1
    }
}
var ans = 0

for r in 1...lines.count - 1 {
    for c in 0...lines[r].count - 1 {
        if lines[r][c] == "^" {
            dp[r][c - 1] += dp[r - 1][c]
            dp[r][c + 1] += dp[r - 1][c]
        } else if dp[r - 1][c] != 0{
            dp[r][c] += dp[r - 1][c]
        }
    }
}

for c in 0...lines[0].count - 1 {
    ans += dp[lines.count - 1][c]
}

print(ans)
