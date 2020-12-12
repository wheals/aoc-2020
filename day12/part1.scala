var (x, y, direction) = (0, 0, 0)

val instructions =
    for (line <- scala.io.Source.fromFile("input.txt").getLines()) 
        yield (line.head, Integer.parseInt(line.tail))

for (instruction <- instructions.toList) {
    instruction match {
        case ('N', num) => y += num
        case ('S', num) => y -= num
        case ('E', num) => x += num
        case ('W', num) => x -= num
        case ('L', num) => direction += num
        case ('R', num) => direction -= num
        case ('F', num) => direction match {
            case 90 => y += num
            case 270  => y -= num
            case 0  => x += num
            case 180  => x -= num
        }
    }
    if (direction >= 360)
        direction -= 360
    if (direction < 0)
        direction += 360
}

println(Math.abs(x) + Math.abs(y))