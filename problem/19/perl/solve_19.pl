#!/usr/bin/env perl

#You are given the following information, but you may prefer to do some research for yourself.
#
#    1 Jan 1900 was a Monday.
#    Thirty days has September,
#    April, June and November.
#    All the rest have thirty-one,
#    Saving February alone,
#    Which has twenty-eight, rain or shine.
#    And on leap years, twenty-nine.
#    A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.

#How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

use strict;
use warnings;

use Data::Dumper;

my @months = qw/
        January
        February
        March
        April
        May
        June
        July
        August
        September
        October
        November
        December
/;

my @how_many_days = (
        31,
        -1,
        31,
        30,
        31,
        30,
        31,
        31,
        30,
        31,
        30,
        31
);

my @days = qw/
        Monday
        Tuesday
        Wednesday
        Thursday
        Friday
        Saturday
        Sunday
/;

sub how_many_days_february_has {
        my $y = shift;
        my $days = -1;
        if ($y % 4 == 0) {
                if ($y % 100 == 0) {
                        if ($y % 400 == 0) { # leap year
                                $days = 29;
                        } else {
                                $days = 28;
                        }
                } else { # leap year
                        $days = 29;
                }
        } else { # not a leap year
                $days = 28;
        }
        return $days;
}

my %result = ( 1900 => { January => [  ] } );

my $day_of_a_week = 0;
my $sunday_count  = 0;
for (my $y = 1900; $y <= 2000; $y++) {
        foreach my $m_idx (0..$#months) {
                if ($months[$m_idx] eq "February") {
                        $how_many_days[1] = how_many_days_february_has($y);
                }
                for (my $d = 0; $d < $how_many_days[$m_idx]; $d++) {
                        push @{$result{$y}{$months[$m_idx]}}, $days[$day_of_a_week];
                        if ($d == 0 and $days[$day_of_a_week] eq "Sunday" and $y != 1900) {
                                $sunday_count++;
                        }
                        $day_of_a_week = ++$day_of_a_week % 7;
                }
        }
}

#print Dumper \%result;
print $sunday_count, "\n";