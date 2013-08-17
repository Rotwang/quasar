#!/usr/bin/env perl
# a bit of dynamic programming

use strict;
use warnings;

use feature qw/say/;

use Data::Dumper;

my @dag;

my $stage = 0;
while (<>) {
        chomp;
        next if (/^\s*$/);
        my $node = 0;
        foreach my $v (split) {
                $dag[$stage][$node++] = { int($v) => 0 };
        }
        $stage++;
}

# $stage-1 is the last stage index
# $stage is the number of stages
foreach (@{$dag[$stage - 1]}) {
        my $key = (keys %{$_})[0];
        $_->{$key} = 0;
}

#print Dumper \@dag;

# last stage already done
# lets start from before the last index of $stage
foreach my $stage_idx (reverse 0 .. ($stage - 2)) {
        foreach my $pnode_idx (0..$#{$dag[$stage_idx]}) {
                my $pkey = (keys %{$dag[$stage_idx][$pnode_idx]})[0];
                my $first_chld_idx = $pnode_idx;
                my $last_chld_idx  = $pnode_idx + 1;
                foreach my $cnode_idx ($first_chld_idx .. $last_chld_idx) {
                        my $ckey = (keys %{$dag[$stage_idx + 1][$cnode_idx]})[0];
                        my $possibly_new_value = $dag[$stage_idx + 1][$cnode_idx]->{$ckey} + $ckey;
                        if ($dag[$stage_idx][$pnode_idx]->{$pkey} < $possibly_new_value) {
                                #say "$pkey : $ckey";
                                $dag[$stage_idx][$pnode_idx]->{$pkey} = $possibly_new_value;
                        }
                }
        }
}

#print Dumper \@dag;

my $uber_key = (keys %{$dag[0][0]})[0];
say $uber_key + $dag[0][0]{$uber_key};
