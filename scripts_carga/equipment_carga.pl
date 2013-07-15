#!/usr/bin/perl -w
#transgene_subida.pl
use DBI;
use DBD::mysql;
use strict;

my @keys = ();
while (my $line = <>) {
    chomp $line;

    if ($line =~ /^eq_id/)  {
	@keys = split (" ", $line);
	
next;
}

    my @data = split ("\t", $line);

   
    my $keys = join (", ",@keys);
    my $eq_name = $data[1];#separo los datos tomados en @data en cada uno de los campos de la tabla. 
    my $eq_model = $data[2];
    my $eq_serial = $data[3];
    my $provider = $data[4];
   
 
 
 print "INSERT INTO equipment ($keys) VALUES ('$data[0]', '$eq_name', '$eq_model', '$eq_serial', '$provider');\n";
}
