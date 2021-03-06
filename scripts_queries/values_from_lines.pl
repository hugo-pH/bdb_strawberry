#!/usr/bin/perl -w
#retrieving.pl
#This script retrieve the data for each table and for each line creating a file that cointain this data named by the table name and the line name.
use DBI;
use DBD::mysql;
use strict;
use DBIx::Dump;

my @name = ();
my $line = ();
my $format = 'csv';
my $ds = "DBI:mysql:proyecto_fresas:localhost";
my $user_sql = "user";
my $passwd = "password";
my $dbh = DBI->connect($ds,$user_sql,$passwd) || die "Can't connect!"; 
my $sth_name = $dbh->prepare("SELECT DISTINCT name FROM germplasm"); # this extract the name of the lines from the database. 
$sth_name->execute();
while (@name = $sth_name->fetchrow_array){ #this store the names in an array. 

foreach $line (@name){ #this loop retrieves the values for each line. There is a query for each table (shape, weight, color, firmness, a s_solids) where the name of the line and the value are selected. To create files the DBIx::Dump module is used. 
	my $sth_firm = $dbh->prepare("SELECT name, firmness.value FROM firmness JOIN 		germplasm ON germplasm.line_id = firmness.line_id WHERE germplasm.name 		LIKE ?");
	$sth_firm->execute($line); #execute the query replacing the ? symbol in the sentece by the $line value (a line name).
	my $file_firm = "firmness_$line.csv";
	my $out_firm = DBIx::Dump->new();
	$out_firm->dump('format' => 'csv', 'output' => $file_firm, 'sth' => $sth_firm);
	
	my $sth_solids = $dbh->prepare("SELECT name, s_solids.value FROM s_solids 	  JOIN germplasm ON germplasm.line_id = s_solids.line_id WHERE 		  germplasm.name LIKE ?");
	$sth_solids->execute($line);
	my $file_sol = "solids_$line.csv";
	my $out_sol = DBIx::Dump->new();
	$out_sol->dump('format' => 'csv', 'output' => $file_sol, 'sth' => 		$sth_solids);

	my $sth_weight = $dbh->prepare("SELECT name, fruit_weight.value FROM fruit_weight	  JOIN germplasm ON germplasm.line_id = fruit_weight.line_id WHERE 		       germplasm.name LIKE ?");
	$sth_weight->execute($line);
	my $file_wei = "weight_$line.csv";
	my $out_wei = DBIx::Dump->new();
	$out_sol->dump('format' => 'csv', 'output' => $file_wei, 'sth' => 		$sth_weight);

	my $sth_color = $dbh->prepare("SELECT name, c_value, h_value, l_value, 	a_value, b_value FROM color	  JOIN germplasm ON germplasm.line_id =  color.line_id WHERE 		       germplasm.name LIKE ?");
	$sth_color->execute($line);
	my $file_col = "color_$line.csv";
	my $out_col = DBIx::Dump->new();
	$out_col->dump('format' => 'csv', 'output' => $file_col, 'sth' => 		$sth_color);

		my $sth_shape = $dbh->prepare("SELECT name, width_value, length_value, ratio FROM shape	  JOIN germplasm ON germplasm.line_id =  shape.line_id WHERE 		       germplasm.name LIKE ?");
	$sth_shape->execute($line);
	my $file_shape = "shape_$line.csv";
	my $out_shape = DBIx::Dump->new();
	$out_shape->dump('format' => 'csv', 'output' => $file_shape, 'sth' => 		$sth_shape);


}

}
$dbh->disconnect;


