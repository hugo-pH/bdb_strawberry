#!/usr/bin/perl -w
#taxonomy_carga.pl
use strict;



my @keys = ();
while (my $line = <>) {
    chomp $line;

    if ($line =~ /^tax_id/)  {
	@keys = split (" ", $line);
	    
next;
}

    my @data = split ("\t", $line);
    for my $datum (@data){
	$datum = "'$datum'";
        $datum =~ s/ /_/g; } #esto cambia los espacios en blanco por _.
    my $keys = join (", ",@keys);
    my $data = join (", ", @data);
    $data =~ s/_/ /g;
    print "INSERT INTO taxonomy ($keys) VALUES ($data);\n";
}
