#!/usr/bin/perl -w
#assay_carga.pl
use DBI;
use DBD::mysql;
use strict;

my @keys = ();
while (my $line = <>) {
    chomp $line;

    if ($line =~ /^assay_id/)  {
	@keys = split (" ", $line);
	
next;
}

    my @data = split ("\t", $line);

   
    my $keys = join (", ",@keys);
    my $protocol = $data[1];#separo los datos tomados en @data en cada uno de los campos de la tabla. 
    my $description = $data[2];    
    my $equipment = $data[3];
    my $scientist = $data[4];

 

my @equipment_id = ();
my @scient_id = ();
my $ds = "DBI:mysql:proyecto_fresas:localhost";
my $user_sql = "user";
my $passwd = "password";
my $dbh = DBI->connect($ds,$user_sql,$passwd) || die "Can't connect!"; 
my $sth_equip_id = $dbh->prepare("SELECT eq_id FROM equipment WHERE eq_name LIKE ?");
my $sth_scient_id = $dbh->prepare("SELECT scientist_id FROM scientist WHERE mail LIKE ?");
$sth_scient_id->execute ($scientist);
$sth_equip_id->execute ($equipment);
@scient_id = $sth_scient_id->fetchrow_array;
@equipment_id = $sth_equip_id->fetchrow_array;   
 print "INSERT INTO assay ($keys) VALUES ('$data[0]', '$protocol', '$description', '@equipment_id', '@scient_id');\n";
}
