#!/usr/bin/env perl

use strict;
use warnings;

use feature qw/say/;

use Data::Dumper;

my $i = 0;

my @triangle;
while (<>) {
	$triangle[$i++] = [ split ];
}

my $hurr = 0;
while (1) {
        my $seq = get_sequence($hurr++);
        say "-----";
        #say sum_tree($seq);
}

sub get_sequence {
        my $number = shift;
        foreach (reverse 0 .. ($i - 1)) {
                print $_;
                if ($number > ($i - 1)) {
                        $number--;
                        print $number - ($i - 1);
                } elsif ($number <= 0) {
                        print $number;
                } else {
                
                print "\n";
        }
}

sub sum_tree {
        ...
}