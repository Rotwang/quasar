use v6;

module Revdep6::ElfUtils;

class X::Revdep6::ElfUtils::NotFound is Exception {
	has $.error-message;
	has $.file-name;

	method message {
		"file: '" ~ $.file-name ~ "' " ~ $.error-message;
	}
}

class X::Revdep6::ElfUtils::ReadElf is Exception {
	has $.error-message;
	has $.file-name;

	method message {
		"file: '" ~ $.file-name ~ "' " ~ $.error-message;
	}
}

#class Revdep6::ReadElf {
#	has $!readelf-exec = "readelf";
#
#	method is_elf($myelf) {
#		say $myelf;
#		say $!readelf-exec;
##		my $foo =shell($!readelf-exec ~ " --file-header " ~ $myelf);
#		say "DDUUPPAA";
#		return True;
#	}
#}

class Revdep6::ElfUtils {
	has Str $.elf-file;
	has Str $!readelf-exec;

	submethod BUILD(:$elf-file) {
		$!readelf-exec = "readelf";
		$!elf-file = $elf-file;

		die X::Revdep6::ElfUtils::NotFound.new(
			file-name     => $!elf-file,
			error-message => "doesn't exist!"
		) unless $elf-file.IO ~~ :f;

		die X::Revdep6::ElfUtils::NotFound.new(
			file-name => $!readelf-exec,
			error-message => "not found in PATH ({%*ENV<PATH>}), " ~
				"readelf(1) is part of GNU binutils package " ~
				"and is imperative for {$*PROGRAM_NAME} to work."
		) if shell("which {$!readelf-exec} >/dev/null 2>&1") != 0;

		die X::Revdep6::ElfUtils::ReadElf.new(
			file-name => $!elf-file,
			error-message => "is not an elf file!"
		) if shell($!readelf-exec ~ " --file-header " ~ $!elf-file ~ " >/dev/null 2>&1") != 0;
	}
}

# vi: ft=perl6

