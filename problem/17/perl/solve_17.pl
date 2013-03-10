#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;

my %stuff = (
	1 => "one",
	2 => "two",
	3 => "three",
	4 => "four",
	5 => "five",
	6 => "six",
	7 => "seven",
	8 => "eight",
	9 => "nine",
	10 => "ten",
	11 => "eleven",
	12 => "twelve",
	13 => "thirteen",
	14 => "fourteen",
	15 => "fifteen",
	16 => "sixteen",
	17 => "seventeen",
	18 => "eighteen",
	19 => "nineteen",
	20 => "twenty",
	30 => "thirty",
	40 => "forty",
	50 => "fifty",
	60 => "sixty",
	70 => "seventy",
	80 => "eighty",
	90 => "ninety",
	100 => "hundred",
	1000 => "thousand"
);

$ARGV[0] or die;

sub saynum {
	if (exists $stuff{$_[0]}) {
		print "one" if ($_[0] == 100 or $_[0] == 1000);
    		print $stuff{$_[0]};
	} else {
		my @a = split //, $_[0];
		my $trunc = $a[0] . 0 x (@a - 1);
		my $rest = join("", @a[1..$#a]);


		if (exists $stuff{$trunc}) {
			print "one" if ($trunc == 100);
			print $stuff{$trunc};
		} else {
			my @b = split //, $trunc;
			print $stuff{$b[0]};
			print $stuff{1 . join("", @b[1..$#b])};
		}
		return if ($rest =~ /^0+$/);
		print "and" if ((split //, $trunc) >= 3);
		$rest = sprintf("%d", $rest);
		if (exists $stuff{$rest}) {
			print $stuff{$rest};
		} else {
			saynum($rest)
		}
	#print $trunc, "\n";
	#print $rest, "\n";
	}
}

saynum($_) foreach (1..$ARGV[0]);
#saynum($ARGV[0]);

print "\n";

