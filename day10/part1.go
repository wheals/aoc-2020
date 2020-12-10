package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
)

func main() {
	file, _ := os.Open("input.txt")
	scanner := bufio.NewScanner(file)
	strings := make([]string, 0, 50)
	for scanner.Scan() {
		strings = append(strings, scanner.Text())
	}
	adapters := make([]int, len(strings))
	for i, s := range strings {
		num, _ := strconv.Atoi(s)
		adapters[i] = num
	}
	sort.Ints(adapters)
	prev, oneGaps, threeGaps := 0, 0, 0
	for _, cur := range adapters {
		if cur - prev == 1 {
			oneGaps++
		} else if cur - prev == 3 {
			threeGaps++
		}
		prev = cur
	}
	threeGaps++ // for the built-in
	fmt.Println(oneGaps, threeGaps, oneGaps * threeGaps)
}