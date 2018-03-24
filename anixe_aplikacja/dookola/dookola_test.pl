#!/usr/bin/env perl

use strict;
use warnings;
use IO::Socket;

my $socket = IO::Socket::INET->new(
    'PeerAddr' => "127.0.0.1",
    'PeerPort' => "7070",
    'Proto' => 'tcp'
) or die "Can't create socket ($!)\n";

print $socket shift . "\r\n";
my $data;
$socket->recv($data, 64);
print $data;

close $socket or die "Can't close socket ($!)\n";
