#!/usr/bin/perl -w
#values_from_genes.pl
#This script retrieve the data for each table and for each gene and create a file cointaining this data named by the table name and the line name.
use DBI;
use DBD::mysql;
use strict;
use DBIx::Dump;

my @unique_name = ();
my %hash = ();
my @name = (); # this is an array containing the name of the lines.
my $line = ();#this scalar will be used to pick the values of the @name array.
my $format = 'csv';
my $ds = "DBI:mysql:proyecto_fresas:localhost"; #database connection.
my $user_sql = "user";
my $passwd = "password";
my $dbh = DBI->connect($ds,$user_sql,$passwd) || die "Can't connect!"; 
my $sth_name = $dbh->prepare("SELECT DISTINCT name FROM germplasm"); # this extract the name of the lines from the database. 
$sth_name->execute();
while (@name = $sth_name->fetchrow_array){ # this loop process the name of the line to remove the numbers. 
    foreach $line (@name){
		
 $line =~ s/ \d+//;#remove the numbers after the blank space.
 $line =~ s/ \w\d+//;#remove the characters and numbers after the blank space.
	chomp $line;}

  

#@unique_name = grep { ! $hash{ $_ }++} @name; This remove all the equals names, but it not necessary. 

foreach $line (@name){  #this loop retrieves the values for each line. There is a query for each table (shape, weight, color, firmness, a s_solids) where the name of the line and the value are selected. To create files the DBIx::Dump module is used. 
unless ($line=~/control/){
	my $sth_firm = $dbh->prepare("SELECT name, firmness.value FROM firmness JOIN germplasm ON germplasm.line_id = firmness.line_id WHERE germplasm.name LIKE \'$line %\'");#there is a blank space afer '$line' to avoid problems with the lines names (the case of bgal and bgali)
	$sth_firm->execute();
	my $file_firm = "all_firmness_$line.csv";
	my $out_firm = DBIx::Dump->new();
	$out_firm->dump('format' => 'csv', 'output' => $file_firm, 'sth' => $sth_firm);	

	my $sth_solids = $dbh->prepare("SELECT name, s_solids.value FROM s_solids JOIN germplasm ON germplasm.line_id = s_solids.line_id WHERE germplasm.name LIKE \'$line %\'");
	$sth_solids->execute();
	my $file_sol = "all_solids_$line.csv";
	my $out_sol = DBIx::Dump->new();
	$out_sol->dump('format' => 'csv', 'output' => $file_sol, 'sth' => $sth_solids);

	my $sth_weight = $dbh->prepare("SELECT name, fruit_weight.value FROM fruit_weight JOIN germplasm ON germplasm.line_id = fruit_weight.line_id WHERE germplasm.name LIKE  \'$line %\'");
	$sth_weight->execute();
	my $file_wei = "all_weight_$line.csv";
	my $out_wei = DBIx::Dump->new();
	$out_sol->dump('format' => 'csv', 'output' => $file_wei, 'sth' => $sth_weight);

	my $sth_color = $dbh->prepare("SELECT name, c_value, h_value, l_value, 	a_value, b_value FROM color JOIN germplasm ON germplasm.line_id = color.line_id WHERE germplasm.name LIKE  \'$line %\'");
	$sth_color->execute();
	my $file_col = "all_color_$line.csv";
	my $out_col = DBIx::Dump->new();
	$out_col->dump('format' => 'csv', 'output' => $file_col, 'sth' => $sth_color);

	my $sth_shape = $dbh->prepare("SELECT name, width_value, length_value, ratio FROM shape	  JOIN germplasm ON germplasm.line_id =  shape.line_id WHERE germplasm.name LIKE \'$line %\'");
	$sth_shape->execute();
	my $file_shape = "all_shape_$line.csv";
	my $out_shape = DBIx::Dump->new();
	$out_shape->dump('format' => 'csv', 'output' => $file_shape, 'sth' => $sth_shape);

}
}
}
$dbh->disconnect;



