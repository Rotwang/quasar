#!/usr/bin/perl

use strict;
use warnings;
use Fcntl ':mode';
use Term::ANSIColor ':constants';
use Getopt::Long;
use Pod::Usage qw(pod2usage);
use Data::Dumper;

use constant FOOTCMP_VERSION => "0.1a";
use constant ROOT => "/";
my $color;

sub conv_to_symbolic {
    my $mode = shift;
    my $symode;
    $symode .= {
            7 => "rwx",
            6 => "rw-",
            5 => "r-x",
            4 => "r--",
            3 => "-wx",
            2 => "-w-",
            1 => "--x",
            0 => "---"
        }->{substr $mode, $_, 1} for (1..3);
    if (my $sticky = substr $mode, 0, 1) {
        if ($sticky % 2) { # sticky bit set
            my $t = (substr($mode, -1) % 2) ? "t" : "T";
            substr $symode, -1, 1, $t;
            $sticky -= 1;
        }
        if ($sticky == 4 or $sticky == 6) { # suid set
            my $s = (substr($mode, 1, 1) %2) ? "s" : "S";
            substr $symode, 2, 1, $s;
            $sticky -= 4;
        }
        if ($sticky == 2) { # sgid set
            my $s = (substr($mode, 2, 1) %2 ) ? "s" : "S";
            substr $symode, 5, 1, $s;
        }
    }
    $symode;
}

sub parse_line {
    # sanity check parsed line
    (m{^[^\t]{10}\t[^/]+/[^/]+\t.+$}) or #/ syntax highlighting
        die "Given footprint is not sane!\n";
    my($perms, $og, $file) = split /\t/, shift;
    $file =~ s/\s+->\s+.*$//;
    my($owner, $group) = split /\//, $og;
    my $type = substr $perms, 0, 1;
    my $operm = substr $perms, 1, 3;
    my $gperm = substr $perms, 4, 3;
    my $wperm = substr $perms, 7, 3;
    my $sticky = 0;
    $sticky += 4 if ((substr $operm, -1) =~ /s/i);
    $sticky += 2 if ((substr $gperm, -1) =~ /s/i);
    $sticky += 1 if ((substr $wperm, -1) =~ /t/i);
    my $octperms = $sticky;
    foreach my $p ($operm, $gperm, $wperm) {
        my $op;
        $op += {
            'r' => 4,
            'w' => 2,
            'x' => 1,
            '-' => 0,
            't' => 1,
            'T' => 0,
            's' => 1,
            'S' => 0
        }->{substr $p, $_, 1} for (0..2);
        $octperms .= $op;
    }
    my $uid = ((getpwnam($owner))[2]);
    my $gid = ((getgrnam($group))[2]);
    {
        "type" => $type,
        "mode" => $octperms,
        "uid" => $uid,
        "gid" => $gid,
        "file" => $file,
        "owner" => $owner,
        "group" => $group
    };
}

sub stat_file {
    my $file = ROOT . shift;
    my (
        $mode,
        $uid,
        $gid,
    ) = (lstat($file))[2,4,5] or return;
    my $octperms = sprintf "%04o", S_IMODE($mode);
    my $type =
        S_ISREG($mode) ? "-" :
        S_ISDIR($mode) ? "d" :
        S_ISLNK($mode) ? "l" :
        S_ISBLK($mode) ? "b" :
        S_ISCHR($mode) ? "c" :
        S_ISFIFO($mode)? "p" :
        S_ISSOCK($mode)? "s" : "?";
    {
        "type" => $type,
        "mode" => $octperms,
        "uid" => $uid,
        "gid" => $gid,
        "file" => $file
    };
}

sub compare {
    my ($foot, $file) = @_;
    my %mismatch;
    if (not $file) {
        $mismatch{'NA'}++;
    } else {
        foreach (keys %{$foot}) {
            next if ($_ eq "file" or $_ eq "owner" or $_ eq "group");
            $mismatch{$_}++ if ($foot->{$_} ne $file->{$_});
        }
    }
    \%mismatch;
}

sub foot_msmtch {
    my ($msmtch, $foot, $file) = @_;
    if (%{$msmtch}) {
        my $nrms;
        $nrms += $msmtch->{$_} foreach (keys %{$msmtch});
        $foot->{"symbolic"} = conv_to_symbolic($foot->{"mode"});
        my $l = ((length($ARGV) > 10) ? length($ARGV) : 10);
        my $format = "%-" . $l ."s: %s%s\t%s/%s\t%s\n";
        my $red_type = RED if ($msmtch->{"type"} and $color);
        my $red_mode = RED if ($msmtch->{"mode"} and $color);
        my $red_owner = RED if ($msmtch->{"uid"} and $color);
        my $red_group = RED if ($msmtch->{"gid"} and $color);
        my $red_na = RED if ($msmtch->{"NA"} and $color);
        my $clear = CLEAR if ($color);
        print $nrms, " mismatch", ($nrms > 1) ? "es " : " ", "found:\n";
        no warnings 'uninitialized';
        printf $format,
            $ARGV,
            $red_type . $foot->{"type"} . $clear,
            $red_mode . $foot->{"symbolic"} . $clear,
            $red_owner . $foot->{"owner"} . $clear,
            $red_group . $foot->{"group"} . $clear,
            $foot->{"file"};
        unless ($msmtch->{"NA"}) {
            $file->{"symbolic"} = conv_to_symbolic($file->{"mode"});
            $file->{"owner"} = ((getpwuid($file->{"uid"}))[0]);
            $file->{"group"} = ((getgrgid($file->{"gid"}))[0]);
            printf $format,
                "filesystem",
                $red_type . $file->{"type"} . $clear,
                $red_mode . $file->{"symbolic"} . $clear,
                $red_owner . $file->{"owner"} . $clear,
                $red_group . $file->{"group"} . $clear,
                $file->{"file"};
        } else {
            printf "%10s: %s\n", "filesystem", $red_na . "File not available." . $clear;
        }
    }
}

GetOptions (
    'help|h' => sub { pod2usage(-verbose => 1, -exitval => 0) },
    'version|v' => sub {print "footcmp version: ".FOOTCMP_VERSION."\n";exit 0;},
    'color|c' => \$color
) or pod2usage();

while (<>) {
    chomp;
    my $foot = parse_line($_);
    my $file = stat_file($foot->{"file"});
    my $mismatch = compare($foot, $file);
    foot_msmtch($mismatch, $foot, $file);
}

__END__

=pod

=head1 NAME

footcmp - compare .footprint with actually installed files

=head1 SYNOPSIS

footcmp [-h|--help|-v|--version]
footcmp [-c|--color] [FILE...]

=head1 DESCRIPTION

footcmp compares entries found in .footprint files (passed as an arguments or from stdin) to actually instaled files found in filesystem.

If mismatch does not occur nothing is printed to stdin.

=head1 OPTIONS

=over 4

=item B<-c>, B<--color>

Highlights type of a mismatch between .footprint entry and actual file.

=item B<-v>, B<--version>

Prints version and exits.

=item B<-h>, B<--help>

Prints help and exits.

=back

=head1 AUTHOR

Written by Bartlomiej Palmowski <rotwang at crux dot org dot pl>

=head1 SEE ALSO

opt/prt-utils - contains many useful scripts

=encoding utf8

=cut
