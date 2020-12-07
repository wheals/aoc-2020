let input = `shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.`

interface Bag {
    color: string,
    num: number
}
let bags : Map<string, Array<Bag>> = new Map();
for (let line of input.split("\n")) {
    let splitLine = line.split("contain")
    let match = splitLine[0].match(/([a-z ]*) bags/)
    let container = ""
    if (match)
        container = match[1]
    let contained = []
    for (let bag of splitLine[1].matchAll(/(\d) ([a-z ]*) bags?/g))
        contained.push({ color: bag[2], num: Number.parseInt(bag[1]) })
    bags.set(container, contained)
}
function numWithin(bag: string): number {
    let count = 0
    for (let [container, contained] of bags)
        if (container === bag)
            for (let inner of contained)
                count += inner.num * (1 + numWithin(inner.color))
    return count;
}
console.log(numWithin("shiny gold"))