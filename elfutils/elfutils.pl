#!/usr/bin/env perl6

use v6;

use lib './lib';

use ElfUtils;

sub MAIN($elf) {
	# CATCH from toplevel is broken -- moritz
	{
		my $elfutil = ElfUtils.new(elf-file => $elf);
		say ~$elfutil;
		CATCH { 
			default {
#				note $_.message;
				note $_;
				exit 1
			}
		}
	}
}

# vi: ft=perl6

