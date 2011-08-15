#!/usr/bin/env perl
# quickly test c programm

use strict;
use warnings;

use constant TEMPLATE => "testXXXXX";

use File::Temp 'tempfile';
use Getopt::Long;

my $head_source = "#include <stdio.h>

int main(void) {
";

my $tail_source = "
}";

my $analyzer = "scan-build";
my $compiler = "gcc";

my $source;
my @addflags;
GetOptions (
	'help|h' => sub { ...; },
	'version|v' => sub { ...; },
	'x|exec=s' => \$source,
	'f|flags=s' => \@addflags
);

my @cflags = qw/-ggdb3 -Wall -Wextra -std=c99 -pedantic/;

my ($fh, $filename) = tempfile(TEMPLATE, SUFFIX=>".c", TMPDIR=>1, UNLINK=>1);
my ($fhout, $fnameout) = tempfile(TEMPLATE, TMPDIR=>1, UNLINK=>1);

unless (defined($source)) {
	local $/;
	$source = (<>);
}

$source = $head_source . $source . $tail_source;

print $fh $source;

my @command = ($analyzer,$compiler,@cflags,@addflags,"-o",$fnameout,$filename);
print "@command\n";

my $ret = system(@command);
close($fhout);
close($fh);
if ($ret == 0) {
	print "executing ...\n";
	print "[exit status " . (system($fnameout) >> 8) . "]\n";
} else {
	print "[exit status " . ($ret >> 8) . "]\n";
}
