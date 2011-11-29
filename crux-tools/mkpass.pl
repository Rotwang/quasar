#!/usr/bin/env perl

use strict;
use warnings;
use Getopt::Std;
use constant VERSION => 0.02;
use constant PASSLEN => 8;
$Getopt::Std::STANDARD_HELP_VERSION++;

sub VERSION_MESSAGE {
    print "mkpass " . VERSION . "\n";
}

sub HELP_MESSAGE {
    print "Usage:\n" .
    "mkpass [OPTIONS]\n" .
    "-b\tblacklist characters (exclude them from pool of available characters)\n" .
    "-w\twhitelist, specify pool of available characters (default is whole printable ascii set)\n" .
    "-n\tlenght of a string to generate (default 8)\n" .
    "-r\tuse /dev/random\n" .
    "-u\tuse /dev/urandom (default)\n";
}

my %opts;
getopts('b:w:n:ru', \%opts);
my $lngth = PASSLEN;
$lngth = $opts{'n'} if ((exists $opts{'n'}) and ($opts{'n'} =~ /^\d+$/));
my @chars;
if (defined $opts{'w'}) {
    @chars = split //, $opts{'w'};
} else {
    push(@chars, chr($_)) foreach (33..126);
    if (defined $opts{'b'}) {
        @chars = grep {
            my $h = 1;
            foreach my $e (split //, $opts{'b'}) {
                $h = 0 if /$e/;
            }
            $h;
        } @chars;
    }
}

die "No characters to choose from!\n" if (@chars == 0);
my $file = (exists $opts{'r'}) ? "/dev/random" : "/dev/urandom";
my $fh;
open($fh, "<", $file) or die $!;
print $chars[ord(getc($fh)) % @chars] foreach (1..$lngth);
print "\n";
close($fh);
