use v6;
use Test;

use Revdep6::ElfUtils;

plan 4;

#TODO: do it better
my Str $perl_exec = qqx<which $*EXECUTABLE_NAME>.chomp;

{
	dies_ok { Revdep6::ElfUtils.new(elf-file => "no_es_file_not_here") },
		"throw exception if elf-file doesn't exist";
}

{
	lives_ok { Revdep6::ElfUtils.new(elf-file => $perl_exec) },
		"don't throw exception if elf-file exists";
}

{
	my $path_save = %*ENV<PATH>;
	%*ENV<PATH> = "";
	dies_ok { Revdep6::ElfUtils.new(elf-file => $perl_exec) },
		"throw exception if readelf not available in PATH";
	%*ENV<PATH> = $path_save;
}

{
	dies_ok { Revdep6::ElfUtils.new(elf-file => $*PROGRAM_NAME) },
		"throw exception if elf-file is not proper elf"
}

# vi: ft=perl6
