const fs = require('fs');

dirs = [[-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1]]

const data = fs.readFileSync('input.txt', 'utf8');
const lines = data.trim().split('\n').map(line => line.split(''));

function part1() {
    var ans = 0;

    for(let i = 0; i < lines.length; i++) {
        for(let j = 0; j < lines[i].length; j++) {
            
            if(lines[i][j] != '@')
                continue;
            var adjRolls = 0;
            for(const dir of dirs) {
                try {
                    if(lines[i + dir[0]][j + dir[1]] == '@') {
                        adjRolls++;
                    }
                } catch(e) { }
            }
            if(adjRolls < 4) {
                ans++;
            }
        }
    }
    console.log(ans);
}

function part2() {
    var queue = [];
    var arr = Array.from({ length: lines.length }, () => new Array(lines[0].length).fill(-1));
    var ans = 0;
    for(let i = 0; i < lines.length; i++) {
        for(let j = 0; j < lines[i].length; j++) {
            if(lines[i][j] != '@') continue;
            var adjRolls = 0;
            for(const dir of dirs) {
                try {
                    if(lines[i + dir[0]][j + dir[1]] == '@') adjRolls++;
                } catch(e) { }
            }
            arr[i][j] = adjRolls;
            if(adjRolls < 4) {
                queue.push([i, j]);
            }
        }
    }

    for(const point of queue) {
        lines[point[0]][point[1]] = '.'
    }

    while(queue.length != 0) {
        let len = queue.length;
        for(let i = 0; i < len; i++) {
            let point = queue.shift();
            ans++;
            for(const dir of dirs) {
                try {
                    const r = point[0] + dir[0];
                    const c = point[1] + dir[1];
                    if(lines[r][c] != '@') continue;

                    if(--arr[r][c] < 4) {
                        queue.push([r, c]);
                        lines[r][c] = '.';
                    }
                } catch(e) { }
            }
        }
    }
    console.log(ans);
}

part2();
