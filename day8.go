package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"sort"
)

func find(dsu []int, i int) int {
	if dsu[i] < 0 {
		return i
	}
	var root = find(dsu, dsu[i])
	dsu[i] = root
	return dsu[i]
}

func join(dsu []int, i int, j int) bool {
	var r1 = find(dsu, i)
	var r2 = find(dsu, j)
	if r1 == r2 {
		return false
	}
	if r1 > r2 {
		r1, r2 = r2, r1
	}
	dsu[r1] += dsu[r2]
	dsu[r2] = r1
	return true
}

type point struct {
	id int
	x  int
	y  int
	z  int
}

type edge struct {
	a    *point
	b    *point
	dist int64
}

func dist(a point, b point) int64 {
	var dx = a.x - b.x
	var dy = a.y - b.y
	var dz = a.z - b.z
	return int64(dx*dx + dy*dy + dz*dz)
}

func day1() {
	file := "input.txt"
	numIterations := 1000
	f, err := os.Open(file)
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()
	scanner := bufio.NewScanner(f)

	var points = []point{}
	var edges = []edge{}

	id := 0

	for scanner.Scan() {
		var p point
		p.id = id
		id++
		line := scanner.Text()
		_, error := fmt.Sscanf(line, "%d,%d,%d", &p.x, &p.y, &p.z)
		if error != nil {
			println("Fuck")
			continue
		}
		points = append(points, p)
	}

	for i := 0; i < len(points); i++ {
		for j := i + 1; j < len(points); j++ {
			edges = append(edges, edge{&points[i], &points[j], dist(points[i], points[j])})
		}
	}

	var dsu = make([]int, len(points))
	for i := 0; i < len(dsu); i++ {
		dsu[i] = -1
	}

	sort.Slice(edges, func(i, j int) bool {
		return edges[i].dist < edges[j].dist
	})

	for i := 0; i < numIterations; i++ {
		join(dsu, edges[i].a.id, edges[i].b.id)
	}
	sort.Ints(dsu)
	println(int64(dsu[0]) * int64(dsu[1]) * int64(dsu[2]) * -1)
}

func day2() {
	file := "input.txt"
	f, err := os.Open(file)
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()
	scanner := bufio.NewScanner(f)

	var points = []point{}
	var edges = []edge{}

	id := 0

	for scanner.Scan() {
		var p point
		p.id = id
		id++
		line := scanner.Text()
		_, error := fmt.Sscanf(line, "%d,%d,%d", &p.x, &p.y, &p.z)
		if error != nil {
			println("Fuck")
			continue
		}
		points = append(points, p)
	}

	for i := 0; i < len(points); i++ {
		for j := i + 1; j < len(points); j++ {
			edges = append(edges, edge{&points[i], &points[j], dist(points[i], points[j])})
		}
	}

	var dsu = make([]int, len(points))
	for i := 0; i < len(dsu); i++ {
		dsu[i] = -1
	}

	sort.Slice(edges, func(i, j int) bool {
		return edges[i].dist < edges[j].dist
	})

	var ans = int64(0)

	for _, edge := range edges {
		if dsu[0] == -len(dsu) {
			break
		}
		if join(dsu, edge.a.id, edge.b.id) {
			ans = int64(edge.a.x) * int64(edge.b.x)
		}
	}
	println(ans)
}

func main() {
	day2()
}
