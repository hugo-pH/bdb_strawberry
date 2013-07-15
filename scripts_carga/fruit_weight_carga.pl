#!/usr/bin/perl -w
#fruit_weight_carga.pl
use DBI;
use DBD::mysql;
use strict;

my @keys = ();
while (my $line = <>) {
    chomp $line;

    if ($line =~ /^weight_id/)  {
	@keys = split (" ", $line);
	
next;
}

    my @data = split ("\t", $line);

   
    my $keys = join (", ",@keys);
    my $value = $data[1];#separo los datos tomados en @data en cada uno de los campos de la tabla. 
    	$value =~ s/,/./;
    my $scient = $data[2];
    my $line = $data[3];
    my $control = $data[4];
    my $date = $data[5];
 

my @scientist_id = ();
my @line_id = ();
my @control_id = ();
my @control_line_id = ();
my $ds = "DBI:mysql:proyecto_fresas:localhost";
my $user_sql = "hugo";
my $passwd = "532anion++";
my $dbh = DBI->connect($ds,$user_sql,$passwd) || die "Can't connect!"; 
my $sth_scient = $dbh->prepare("SELECT scientist_id FROM scientist WHERE mail LIKE ?");
my $sth_line_id = $dbh->prepare("SELECT line_id FROM germplasm WHERE name LIKE ?");
my $sth_line_control_id = $dbh->prepare("SELECT line_id FROM germplasm WHERE name LIKE ?");
$sth_line_id->execute ($line);
$sth_line_control_id->execute ($control);
$sth_scient->execute ($scient);
@line_id = $sth_line_id->fetchrow_array;
@control_line_id = $sth_line_control_id->fetchrow_array;  
my $sth_control_id = $dbh->prepare("SELECT control_id FROM control WHERE line_id = \'@line_id\' AND control_line_id = \'@control_line_id\'");
$sth_control_id->execute ();
@control_id = $sth_control_id->fetchrow_array;
@scientist_id = $sth_scient->fetchrow_array;
   
 print "INSERT INTO fruit_weight ($keys) VALUES ('$data[0]', '$value', '@scientist_id', '@line_id', '@control_id', '$date');\n";
}

