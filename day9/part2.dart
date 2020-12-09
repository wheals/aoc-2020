import 'dart:io';

void main() {
  final lines =
      new File('input.txt').readAsLinesSync().map((x) => int.parse(x)).toList();
  const PREAMBLE = 25;
  var invalid = lines.asMap().entries.skip(PREAMBLE).firstWhere((entry) {
    for (var j = entry.key - PREAMBLE; j < entry.key; ++j)
      for (var k = j + 1; k < entry.key; ++k)
        if (lines[j] + lines[k] == entry.value) {
          return false;
        }
    return true;
  }).value;
  for (var i = 0; i < lines.length - 1; ++i) {
    var accum = lines[i];
    for (var j = i + 1; j < lines.length && accum < invalid; ++j) {
      accum += lines[j];
      if (accum == invalid) {
        var contig = lines.sublist(i, j + 1);
        contig.sort();
        print(contig.first + contig.last);
        return;
      }
    }
  }
}
