#!/usr/bin/perl -w
#transgene_subida.pl
use DBI;
use DBD::mysql;
use strict;

my @keys = ();
while (my $line = <>) {
    chomp $line;

    if ($line =~ /^gene_id/)  {
	@keys = split (" ", $line);
	
next;
}

    my @data = split ("\t", $line);

   
    my $keys = join (", ",@keys);
    my $name = $data[1];
    my $sequence = $data[2];#separo los datos tomados en @data en cada uno de los campos de la tabla. 
    my $modif = $data[3];
    my $symbol = $data[4];
    my $EC = $data[5];
    my $scient = $data[6];
 

my @scientist_id = ();
my $ds = "DBI:mysql:proyecto_fresas:localhost";
my $user_sql = "hugo";
my $passwd = "532anion++";
my $dbh = DBI->connect($ds,$user_sql,$passwd) || die "Can't connect!"; 
my $sth_scient = $dbh->prepare("SELECT scientist_id FROM scientist WHERE mail LIKE ?");
$sth_scient->execute ($scient);
@scientist_id = $sth_scient->fetchrow_array;
   
 print "INSERT INTO transgene ($keys) VALUES ('$data[0]', '$name', '$sequence', '$modif', '$symbol', '$EC', '@scientist_id');\n";
}



