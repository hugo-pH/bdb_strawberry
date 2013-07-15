#!/usr/bin/perl -w
#control_carga.pl
use DBI;
use DBD::mysql;
use strict;

my @keys = ();
while (my $line = <>) {
    chomp $line;

    if ($line =~ /^control_id/)  {
	@keys = split (" ", $line);
	
next;
}

    my @data = split ("\t", $line);

   
    my $keys = join (", ",@keys);
    my $line = $data[1];#separo los datos tomados en @data en cada uno de los campos de la tabla. 
    my $control_line = $data[2];
    my $season = $data[3];

 

my @line_id = ();
my @control_line_id = ();
my $ds = "DBI:mysql:proyecto_fresas:localhost";
my $user_sql = "user";
my $passwd = "password";
my $dbh = DBI->connect($ds,$user_sql,$passwd) || die "Can't connect!"; 
my $sth_line_id = $dbh->prepare("SELECT line_id FROM germplasm WHERE name LIKE ?");
my $sth_line_control_id = $dbh->prepare("SELECT line_id FROM germplasm WHERE name LIKE ?");
$sth_line_id->execute ($line);
$sth_line_control_id->execute ($control_line);
@line_id = $sth_line_id->fetchrow_array;
@control_line_id = $sth_line_control_id->fetchrow_array;   
 print "INSERT INTO control ($keys) VALUES ('$data[0]', '@line_id', '@control_line_id', '$season');\n";
}
