#!/usr/bin/perl -w
#germplasm_subida.pl
use DBI;
use DBD::mysql;
use strict;

my @keys = ();
while (my $line = <>) {
    chomp $line;

    if ($line =~ /^line_id/)  {
	@keys = split (" ", $line);
	
next;
}

    my @data = split ("\t", $line);

   
    my $keys = join (", ",@keys);
    my $name = $data[1];#separo los datos tomados en @data en cada uno de los campos de la tabla. 
    my $tax = $data[2];
    my $gene = $data[3];
    my $gene_2 = $data[4];
    my $gene_3 = $data[5];
    my $scientist = $data[6];
    my $date = $data[7];
    $name =~ s/_/ /g;#esto le quita las _ a cada una de las variables.
    $tax =~ s/_/ /g;
    $gene =~ s/_/ /g;
    $scientist =~ s/_/ /g;
    $date =~ s/_/ /g;;
  
 
my @tax_id = ();
my @gene_id = ();
my @gene_2_id = ();
my @gene_3_id = ();
my @scientist_id = ();
my $ds = "DBI:mysql:proyecto_fresas:localhost";
my $user_sql = "user";
my $passwd = "password";
my $dbh = DBI->connect($ds,$user_sql,$passwd) || die "Can't connect!"; 

my $sth_tax = $dbh->prepare("SELECT tax_id FROM taxonomy WHERE specie LIKE ?");
my $sth_gene = $dbh->prepare("SELECT gene_id FROM transgene WHERE symbol LIKE ?");
my $sth_gene_2 = $dbh->prepare("SELECT gene_id FROM transgene WHERE symbol LIKE ?");
my $sth_gene_3 = $dbh->prepare("SELECT gene_id FROM transgene WHERE symbol LIKE ?");
my $sth_scient = $dbh->prepare("SELECT scientist_id FROM scientist WHERE mail LIKE ?");
$sth_tax->execute ($tax);
$sth_gene->execute ($gene);
$sth_gene_2->execute ($gene_2);
$sth_gene_3->execute ($gene_3); 
$sth_scient->execute ($scientist);
@tax_id = $sth_tax->fetchrow_array;
@gene_id = $sth_gene->fetchrow_array;
@gene_2_id = $sth_gene_2->fetchrow_array;
@gene_3_id = $sth_gene_3->fetchrow_array;
@scientist_id = $sth_scient->fetchrow_array;

   
 print "INSERT INTO germplasm ($keys) VALUES ('$data[0]', '$name', '@tax_id', '@gene_id', '@gene_2_id', '@gene_3_id', '@scientist_id', '$date');\n";
}



