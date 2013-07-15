#!/usr/bin/perl -w
#scientist_carga.pl
use strict;

my @keys = ();
while (my $line = <>) {
    chomp $line;

    if ($line =~ /^scientist_id/)  {
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
    print "INSERT INTO scientist ($keys) VALUES ($data);\n";
}

