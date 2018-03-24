#!/usr/bin/env perl

use strict;
use warnings;
use IO::Socket;
use Data::Dumper;

my $fsep = "\r\n";
my %data;
{
    # proste parsowanie szczegolnego przypadku pliku xml
    local $/;
    open(my $fh, "<", "./countries.xml") or die $!;
    my $blob = <$fh>;
    close($fh);
    %data = ($blob =~ m/country\s+COC="([A-Z]{2})"\s*>\s*([^<]+)/g);
}

my $sock = IO::Socket::INET->new(
    LocalHost => '0.0.0.0',
    LocalPort => '7070',
    Proto => 'tcp',
    Listen => 1,
    ReuseAddr => 1
) or die "Can't bind : $@\n";

while (my $new_sock = $sock->accept()) {
    # po kazdym nowym polaczeniu forkujemy zeby moglo podlaczyc sie wiele
    # klientow na raz
    if (fork == 0) {
        while(<$new_sock>) {
            local $/ = $fsep;
            if ((chomp == 2) and m/^([A-Z]{2})$/) {
                if (defined($data{$1})) {
                    $new_sock->send($data{$1} . $fsep);
                } else {
                    $new_sock->send("Not found" . $fsep);
                }
            } else {
                $new_sock->send("Invalid query" . $fsep);
            }
        }
        close($sock);
        exit;
    }
}

close($sock);
