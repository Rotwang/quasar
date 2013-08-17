#!/usr/bin/env perl

use strict;
use warnings;

use List::Util qw(first sum min);
use Storable qw(dclone);

use Data::Dumper;

my @triangle;
my @striangle;
my @utriangle;
my %substracts;

my $i = 0;

while (<>) {
	$triangle[$i] = [ split ];
	$striangle[$i++] = [ reverse sort split ];
}

@utriangle = @{ dclone(\@triangle) };
foreach my $f (@utriangle) {
        foreach my $x (0..@{$f} - 1) {
                $f->[$x] = ($x == 0) ? 1 : 0;
        }
}

sub traverse_triangle {
	my $i = 0;
	my $idx = 0;
	my $prev_idx = 0;
	foreach my $num (@{$_[0]}) {
		my $tr_lngth = @{$triangle[$i]} - 1;
		$idx = first { $triangle[$i][$_] == $num } 0..$tr_lngth;
		return 0 unless ($idx == $prev_idx or $idx - 1 == $prev_idx);

		$prev_idx = $idx;
		$i++;
	}
	return 1
}

my @hurr = map { $_->[0] } @striangle;
print sum(@hurr) if traverse_triangle(\@hurr);

while (1) {
        foreach my $t1 (0..$#triangle) {
                #foreach my $t2 (0..@{$triangle[$t1]} - 1) {
                #        print $triangle[$t1][$t2], "\n";
                #}
                my $st_elem = $striangle[$t1][0];
                foreach my $t2 (0..@{$triangle[$t1]} - 1) {
                        if ($utriangle[$t1][$t2] == 1) {
                                next;
                        } else {
                                $substracts{$t1} = $st_elem - $striangle[$t1][$t2];
                                last;
                        }
                }
        }
        my $mins = min(values %substracts);
        my @skeys = grep { $substracts{$_} == $mins } keys %substracts;
        $skeys[0];
        # wziac pierwsza wartosc z lewa w rzedzie $skeys[0] ktora nie jest 1
        # przemyslec to gowno jeszcze raz, bedzie problem przy "dalszych" kombinacjach
}

# ARGOLYTM
# posortuj tablice trojkata
# stworz tablice jednostkowa trojkata
# sprawdzaj ktore elementy z danego wiersza sa najwieksze i tworz kombinacje na ich podstawie
# zly jest ten algorytm
#
