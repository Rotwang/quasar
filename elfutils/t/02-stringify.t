use v6;
use Test;

use ElfUtils;

plan 2;

# it seems that IO::Spec.join is not working as per specification in rakudo 2013.10
# https://github.com/perl6/specs/blob/master/S32-setting-library/IO.pod
# so lets use catdir, catpath and hope for the best

my Str $elf-for-tests;
{
	my $dir-with-elf-for-tests = IO::Spec.catdir($*PROGRAM_NAME.IO.path.absolute.directory, "elf_for_tests");
	$elf-for-tests = IO::Spec.catpath("", $dir-with-elf-for-tests, "elf");
}
die ">>> File: '" ~ $elf-for-tests ~ "' doesn't exist (it should be distributed along with this ElfUtils archive)!"
	unless $elf-for-tests.IO ~~ :f;


{
	my $sut = ElfUtils.new(elf-file => $elf-for-tests);
	isa_ok ~$sut, Str,
		"stringifies";
}

{
	my $sut = ElfUtils.new(elf-file => $elf-for-tests);
	isnt ~$sut, "",
		"stringified not empty";
}

# vi: ft=perl6
