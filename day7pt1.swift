import Swift
import Foundation

let path = "input.txt"
var lines:[[Character]] = []

let file = freopen(path, "r", stdin)

while let line=readLine() {
    lines.append(Array(line))
}

var curr:[Int] = []
for i in 0...lines[0].count - 1 {
    if lines[0][i] == "S" {
        curr.append(i)
    }
}
var ans = 0

for r in 1...lines.count - 1 {
    //print(curr)
    var splitters:[Int] = []
    var newBeams:[Int] = []
    for i in 0...lines[r].count - 1 {
        if lines[r][i] == "^" {
            splitters.append(i)
        }
    }
    // print(splitters)
    var currIdx = 0
    for pos in splitters {
        if currIdx == curr.count {
            break
        }
        while currIdx < curr.count && curr[currIdx] < pos {
            newBeams.append(curr[currIdx])
            currIdx += 1
        }
        if pos == curr[currIdx] {
            ans += 1
            newBeams.append(pos - 1)
            newBeams.append(pos + 1)
            currIdx += 1;
            // print("Split at \(r), \(pos)")
        }
    }
    while currIdx < curr.count {
        newBeams.append(curr[currIdx])
        currIdx += 1
    }
    //print("\(r), \(newBeams)")
    curr = Array(Set(newBeams))
    curr.sort()
}
//print(curr)

print(ans)
