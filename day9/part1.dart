import 'dart:io';

void main() {
  final lines =
      new File('input.txt').readAsLinesSync().map((x) => int.parse(x)).toList();
  const PREAMBLE = 25;
  for (var i = PREAMBLE; i < lines.length; ++i) {
    var found = false;
    for (var j = i - PREAMBLE; j < i; ++j)
      for (var k = j + 1; k < i; ++k)
        if (lines[j] + lines[k] == lines[i]) {
          found = true;
        }
    if (!found) print(lines[i]);
  }
}
