var (x, y, dx, dy) = (0L, 0L, 10L, 1L)

val instructions =
    for (line <- scala.io.Source.fromFile("input.txt").getLines())
        yield (line.head, Integer.parseInt(line.tail))

for (instruction <- instructions.toList) {
    instruction match {
        case ('N', num) => dy += num
        case ('S', num) => dy -= num
        case ('E', num) => dx += num
        case ('W', num) => dx -= num
        case ('L', num) => num match {
            case 180 => dx *= -1; dy *= -1
            case 90 => val temp = dx; dx = -dy; dy = temp
            case 270 => val temp = dx; dx = dy; dy = -temp
        }
        case ('R', num) => num match {
            case 180 => dx *= -1; dy *= -1
            case 270 => val temp = dx; dx = -dy; dy = temp
            case 90 => val temp = dx; dx = dy; dy = -temp
        }
        case ('F', num) => x += dx * num; y += dy * num
    }
}

println(Math.abs(x) + Math.abs(y))