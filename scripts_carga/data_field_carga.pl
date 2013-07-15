#!/usr/bin/perl -w
#data_field_carga.pl
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

    my $line_key = $keys[0];
    my $control_key = $keys[1];
    my $scientist_key = $keys[2];
    my $date_key = $keys[3];
    my $value_key = $keys[4];
    my $c_value_key = $keys[5];
    my $h_value_key = $keys[6];
    my $l_value_key = $keys[7];
    my $a_value_key = $keys[8];
    my $b_value_key = $keys[9];
    my $assay_key = $keys[10];
    my $length_key = $keys[11];
    my $width_key = $keys[12];
    


my @data = split ("\t", $line);

   
   # my $keys = join (", ",@keys);
    my $line = $data[0];
    my $control = $data[1];
    my $scientist = $data[2];
    my $date = $data[3];
    my $weight_value = $data[4];
     my $c_value = $data[5];#separo los datos tomados en @data en cada uno de los campos de la tabla. 
    my $h_value = $data[6];
    my $l_value = $data[7];
    my $a_value = $data[8];
    my $b_value = $data[9];
    my $assay_color = $data[10];
    my $length_value = $data[11];
    my $width_value = $data[12];
    my $firmness_value = $data[13];
    my $assay_firmness = $data[14];
    my $solids_value = $data[15];
    my $assay_solids = $data[16];

my @assay_id = ();
my @scientist_id = ();
my @line_id = ();
my @control_id = ();
my @firmness_assay_id = ();
my @color_assay_id = ();
my @solids_assay_id = ();
my $ds = "DBI:mysql:proyecto_fresas:localhost";
my $user_sql = "hugo";
my $passwd = "532anion++";
my $dbh = DBI->connect($ds,$user_sql,$passwd) || die "Can't connect!"; 
my $sth_scient = $dbh->prepare("SELECT scientist_id FROM scientist WHERE mail LIKE ?");
my $sth_line_id = $dbh->prepare("SELECT line_id FROM germplasm WHERE name LIKE ?");
my $sth_line_control_id = $dbh->prepare("SELECT line_id FROM germplasm WHERE name LIKE ?");
my $sth_color_assay_id = $dbh->prepare("SELECT assay_id FROM assay WHERE protocol LIKE ?"); 
my $sth_firmness_assay_id = $dbh->prepare("SELECT assay_id FROM assay WHERE protocol LIKE ?"); 
my $sth_solids_assay_id = $dbh->prepare("SELECT assay_id FROM assay WHERE protocol LIKE ?");
$sth_line_id->execute ($line);
$sth_line_control_id->execute ($control);
$sth_color_assay_id->execute ($assay_color);
$sth_solids_assay_id->execute ($assay_solids);
$sth_firmness_assay_id->execute ($assay_firmness);
$sth_scient->execute ($scientist);
@line_id = $sth_line_id->fetchrow_array;
@control_id = $sth_line_control_id->fetchrow_array;  
@scientist_id = $sth_scient->fetchrow_array;
@color_assay_id = $sth_color_assay_id->fetchrow_array;
@solids_assay_id = $sth_solids_assay_id->fetchrow_array; 
@firmness_assay_id = $sth_firmness_assay_id->fetchrow_array;


 print "INSERT INTO color (color_id, $c_value_key, $h_value_key, $l_value_key, $a_value_key, $b_value_key, $scientist_key, $assay_key,  $control_key, $line_key, $date_key) VALUES ('', '$c_value', '$h_value', '$l_value', '$a_value', '$b_value', '@scientist_id', '@color_assay_id', '@control_id', '@line_id', '$date');\n";

print "INSERT INTO shape (shape_id, $length_key, $width_key, $scientist_key, $line_key,$control_key, $date_key) VALUES ('', '$length_value', '$width_value', '@scientist_id', '@line_id', '@control_id', '$date');\n";

print "INSERT INTO fruit_weight (weight_id, $value_key, $scientist_key, $line_key, $control_key, $date_key) VALUES ('', '$weight_value', '@scientist_id', '@line_id', '@control_id', '$date');\n";

 print "INSERT INTO firmness (firmness_id, $value_key, $scientist_key, $assay_key, $line_key, $control_key, $date_key) VALUES ('', '$firmness_value', '@scientist_id', '@firmness_assay_id', '@line_id', '@control_id', '$date');\n";


    print "INSERT INTO s_solids (ss_id, $value_key, $scientist_key, $assay_key, $line_key, $control_key, $date_key) VALUES ('', '$solids_value', '@scientist_id', '@solids_assay_id', '@line_id', '@control_id', '$date');\n";



}
