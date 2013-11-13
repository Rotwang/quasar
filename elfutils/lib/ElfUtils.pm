use v6;

class ElfUtils;

has Int $.elf-class;
has Int $.elf-data;

has IO::Handle $!elf-file-fh;

submethod BUILD(:$elf-file!) {

	$!elf-file-fh = $elf-file.IO.open(chomp => False);

	self!parse-ident;
}

method !parse-ident {
	# size of the elf identification bytes
	my constant $EI-NIDENT = 16;
	my constant $EI-CLASS  = 4;
	my constant $EI-DATA   = 5;

	$!elf-file-fh.seek(0, 0);
	my Buf[uint8] $elf-ident = $!elf-file-fh.read($EI-NIDENT);

	my constant $elf-magic = Buf[uint8].new(0x7f, 0x45, 0x4c, 0x46);
	die "File: '" ~ $!elf-file-fh.Str ~ "' is not an elf file!"
		unless $elf-magic eqv $elf-ident.subbuf(0, $elf-magic.elems);
	
	$!elf-class = $elf-ident[$EI-CLASS];
	$!elf-data  = $elf-ident[$EI-DATA];
}

method Str {
	my constant @elf-class-descr = (
		"Invalid class.",
		"32 bit",
		"64 bit"
	);

	my constant @elf-data-descr = (
		"Invalid data encoding.",
		"LSB (little endian)",
		"MSB (big endian)"
	);

	my Str $descr-string;
	$descr-string  = sprintf("Class:         %-20s (%#x)\n", @elf-class-descr[$!elf-class], $!elf-class.fmt("%#x"));
	$descr-string ~= sprintf("Data encoding: %-20s (%#x)\n", @elf-data-descr[$!elf-data],   $!elf-data.fmt("%#x"));

	return $descr-string;
}

# vi: ft=perl6
