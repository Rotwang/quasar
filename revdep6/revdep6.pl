#!/usr/bin/env perl6

use v6;

use lib './lib';

use Revdep6::ElfUtils;

sub MAIN($dynamic-elf) {
	my $elfutil = Revdep6::ElfUtils.new(elf-file => $dynamic-elf);
	CATCH {
		when X::Revdep6::ElfUtils::NotFound {
			note $_.message;
			exit 1;
		}
		when X::Revdep6::ElfUtils::ReadElf {
			note $_.message;
			exit 1
		}
#		default {
#			note $!;
#		}
	}
}

# vi: ft=perl6

