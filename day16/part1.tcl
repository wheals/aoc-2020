set infile [open input.txt r]
while { [gets $infile line] >= 0 } {
    if {[regexp {(\d+)-(\d+) or (\d+)-(\d+)} $line match num1 num2 num3 num4]} {
        lappend rules [list $num1 $num2 $num3 $num4]
    } else { break }
}
gets $infile line ;# "your ticket:"
gets $infile line ;# your ticket
gets $infile line ;# blank line
gets $infile line ;# "nearby tickets:"

set sum 0
while { [gets $infile line] >= 0 } {
    foreach num [split $line ,] {
        set valid False
        foreach list $rules {
            set valid [expr { $valid || ($num >= [lindex $list 0] && $num <= [lindex $list 1]
                                         || $num >= [lindex $list 2] && $num <= [lindex $list 3])} ]
        }
        if {!$valid} {set sum [expr {$sum + $num}]}
    }
}
puts $sum
close $infile