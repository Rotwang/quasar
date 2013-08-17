#!/usr/bin/env perl

use strict;
use warnings;
use feature "say";
use List::Util qw(sum);

use Data::Dumper;

my @names_arr = sort ( do "./names.txt" );
my %names;
my @alphabet_arr = qw/A B C D E F G H I J K L M N O P Q R S T U V W X Y Z/;
my %alphabet;
my $i = 1;
$names{$_} = $i++ foreach (@names_arr);
$i =1;
$alphabet{$_} = $i++ foreach (@alphabet_arr);

foreach my $n (@names_arr) {
        my $val = 0;
        foreach my $l (split //, $n) { $val += $alphabet{$l}; }
        $names{$n} *= $val; 
}

say sum(values %names);