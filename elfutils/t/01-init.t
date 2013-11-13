use v6;
use Test;

use ElfUtils;

plan 4;

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
	dies_ok { ElfUtils.new() },
		"die if no argument is passed to new";
}

{
	my $non-existent-file = "this_file_no_es_here";
	dies_ok { ElfUtils.new(elf-file => $non-existent-file) },
		"throw exception if given file doesn't exist";
}

{
	dies_ok { ElfUtils.new(elf-file => $*PROGRAM_NAME) },
		"throw exception if given file doesn't look like elf";
}

{
	isa_ok ElfUtils.new(elf-file => $elf-for-tests), ElfUtils,
		".new(elf-file => <existing_elf_file>) returns ElfUtils object";
}

# vi: ft=perl6
