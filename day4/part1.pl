#!/usr/bin/perl

my $valid = 0;
$/ = "\n\n";
while (<>) {
    my $__ = $_;
	$valid++ unless scalar grep {$__ !~ $_} qw{ byr: iyr: eyr: hgt: hcl: ecl: pid: };
}
print $valid,"\n";