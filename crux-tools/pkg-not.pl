#!/usr/bin/perl

use warnings;
use strict;
use Data::Dumper;
use File::Find;

my @mapped_db;
{
    my $db_file = q|/var/lib/pkg/db|;
    open(my $fh, '<', $db_file);
    my @db = <$fh>;
    close($fh);
    chomp(@db);
    @mapped_db = map { s|^|/|;s|/$||;$_ } @db;
}

my @dirs = qw|
    /sbin
    /bin
    /lib
    /usr/bin
    /usr/sbin
    /usr/lib
    /usr/include
    /usr/share
    /var/lib
|;

my @blck_dirs = qw|
    /lib/modules
    /lib/firmware
    /usr/lib/locale
    /usr/lib/perl5
    /usr/share/mime
    /usr/share/icons
    /usr/share/themes
|;

my @blck_files = qw|
    .*\.scale$
    .*\.dir$
    .*\.pyo$
    .*\.pyc$
|;

find(\&wanted, @dirs);

sub wanted {
    foreach my $blck_dir (@blck_dirs) {
        return if ($File::Find::dir =~ m|^$blck_dir|)
    }
    foreach my $blck_file (@blck_files) {
        return if (m|$blck_file|)
    } 
    if (not scalar(grep {$File::Find::name eq $_} @mapped_db)) {
        print $File::Find::name . "\n";
    }
}
