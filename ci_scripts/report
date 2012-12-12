#!/usr/bin/env perl

use strict;
use warnings;

(@ARGV > 0) or die "Not enough input arguments\n";

my $report_file = "/tmp/report.html";

my ($pkgfile,$dir,$name,$version,$release,$url,$who);

open(my $fh, ">", $report_file) or die;

print $fh <<'HTML';
<!DOCTYPE HTML>
<html>
<head>
	<title>Port list.</title>
	<meta charset="utf-8">
</head>
<body>
HTML

foreach (@ARGV) {
	open(my $ph, '<', $_) or die "Could not open '$_'\n";
	local $/ = undef;
	$pkgfile = <$ph>;
	
	chomp($who = ($pkgfile =~ /^\s*#\sMaintainer\s*:\s*(.+)\n/m)[0]);

 	if (defined($who) and $who =~ /rotwang/) {
		$dir = ($_ =~ m|^([^/]+)|)[0];
		$name = $1 if ($pkgfile =~ /^\s*name=(\S+)\s*\n/m);
		$version = $1 if ($pkgfile =~ /^\s*version=(\S+)\s*\n/m);
		$release = $1 if ($pkgfile =~ /^\s*release=(\S+)\s*\n/m);
		$url = $1 if ($pkgfile =~ /^\s*#\s*URL\s*:\s*(\S+)\s*\n/m);
		print $fh "<h3>" . $name . "</h3>\n";
		print $fh "<ul>\n";
		print $fh "<li>version: " . $version . "</li>";
		print $fh "<li>release: " . $release . "</li>";
		print $fh "<li>url: " . "<a href=$url>" . $url . "</a>"."</li>";
		print $fh "<li>dir: " . "<a href=file://$ENV{'PWD'}/$dir>" .
			$ENV{'PWD'} . "/" . $dir . "</a>"."</li>";
		print $fh "</ul>\n";
		
	}
	close($ph);
}

print $fh <<'HTML';
</body></html>
HTML

close($fh);

exec "firefox" . " " . $report_file;
