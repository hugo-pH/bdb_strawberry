#!/usr/bin/perl -w
#taxonomy.pl
use strict;

schema();


sub schema {

    print <<END;
    DROP TABLE IF EXISTS taxonomy;
    CREATE TABLE taxonomy(
    	   tax_id  INT NOT NULL AUTO_INCREMENT,
	   specie  TEXT NOT NULL,
	   var	   TEXT NOT NULL,
	   PRIMARY KEY (tax_id)
	   ) ENGINE=InnoDB;
END
;
}
	   
