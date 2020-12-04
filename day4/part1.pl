#!/usr/bin/perl

my $valid = 0;
$/ = "\n\n";
my @regexes = qw{ byr: iyr: eyr: hgt: hcl: ecl: pid: };
while (<>) {
    my $__ = $_;
	$valid++ if scalar grep($__ =~ $_, @regexes) == scalar @regexes;
}
print $valid,"\n";