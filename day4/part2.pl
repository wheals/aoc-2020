#!/usr/bin/perl
use strict;

my $valid = 0;
$/ = "\n\n";
while (<>) {
    $valid++ if m/byr:(\d+)/ && $1 >= 1920 && $1 <= 2002
                && m/iyr:(\d+)/ && $1 >= 2010 && $1 <= 2020
                && m/eyr:(\d+)/ && $1 >= 2020 && $1 <= 2030
                && m/hcl:#[0-9a-f]{6}\b/
                && m/ecl:(amb|blu|brn|gry|grn|hzl|oth)\b/
                && m/pid:\d{9}\b/
                && (m/hgt:(\d+)cm\b/ && $1 >= 150 && $1 <= 193 || m/hgt:(\d+)in\b/ && $1 >= 59 && $1 <= 76);
}
print $valid,"\n";