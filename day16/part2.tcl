set infile [open input.txt r]
while { [gets $infile line] >= 0 } {
    if {[regexp {([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)} $line match name num1 num2 num3 num4]} {
        lappend rules [list $name $num1 $num2 $num3 $num4]
    } else { break }
}
gets $infile line ;# "your ticket:"
set yourTicket [split [gets $infile] ,] ;# your ticket
gets $infile line ;# blank line
gets $infile line ;# "nearby tickets:"


while { [gets $infile line] >= 0 } {
    set ticket [split $line ,]
    set allValid True
    foreach num $ticket {
        set valid False
        foreach list $rules {
            set valid [expr { $valid || ($num >= [lindex $list 1] && $num <= [lindex $list 2]
                                         || $num >= [lindex $list 3] && $num <= [lindex $list 4])} ]
        }
        set allValid [expr {$allValid && $valid}]
    }
    if {$allValid} {lappend tickets $ticket}
}
set initValids [list]
set i 0
foreach _ $rules {
    lappend initValids $i
    incr i
}
foreach rule $rules {
    set valids $initValids
    foreach ticket $tickets {
        set newValids [list]
        foreach valid $valids {
            set num [lindex $ticket $valid]
            if {$num >= [lindex $rule 1] && $num <= [lindex $rule 2]
                || $num >= [lindex $rule 3] && $num <= [lindex $rule 4]} {lappend newValids $valid}
        }
        set valids $newValids
    }
    set positions([lindex $rule 0]) $valids
}
foreach _ [array get positions] {
    foreach {key valids} [array get positions] {
        if {[llength $valids] == 1} {
            foreach {iKey iValids} [array get positions] {
                if {$key != $iKey} {
                    set positions($iKey) [lsearch -inline -all -not -exact $iValids [lindex $valids 0]]
                }
            }
        }
    }
}
set product 1
foreach {field valid} [array get positions] {
    if {[string match departure* $field]} {set product [expr {$product * [lindex $yourTicket [lindex $valid 0]]}]}
}
puts $product
close $infile