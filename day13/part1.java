import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.regex.Pattern;

class Part1 {
    public static void main(String[] args) throws FileNotFoundException {
        Scanner scanner = new Scanner(new File("input.txt"));
        int start = scanner.nextInt();
        scanner.useDelimiter(Pattern.compile("[ ,]"));
        ArrayList<Integer> starts = new ArrayList<Integer>();
        while (scanner.hasNext()) {
            if (scanner.hasNextInt()) {
                starts.add(scanner.nextInt());
            }
            else {
                scanner.next();
            }
        }
        int min = start;
        int bestid = 0;
        for (Integer id : starts) {
            int x = id * ((start / id) + 1);
            if (x - start < min) {
                bestid = id;
                min = x - start;
            }
        }
        System.out.println(min * bestid);
    }
}