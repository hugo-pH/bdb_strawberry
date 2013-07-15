#!/usr/bin/perl -w
#germo_tabla.pl
use strict;

schema();


sub schema {

    print <<END;
    DROP TABLE IF EXISTS germplasm;
    CREATE TABLE germplasm(
	line_id INT NOT NULL AUTO_INCREMENT,
	name    VARCHAR(100) NOT NULL,
	tax_line_id  INT,
	transgene_id INT,
	transgene_2_id INT,
	transgene_3_id INT,
	scientist_id_germ INT,
	date_creation DATE,
	PRIMARY KEY (line_id),
	FOREIGN KEY (tax_line_id)
	 REFERENCES taxonomy(tax_id),
	ON DELETE CASCADE
	ON UPDATE CASCADE,
 	FOREIGN KEY (transgene_id)
	 REFERENCES transgene(gene_id)	
	ON DELETE CASCADE
	ON UPDATE CASCADE,
 	FOREIGN KEY (transgene_2_id)
	 REFERENCES transgene(gene_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
 	FOREIGN KEY (transgene_3_id)
	 REFERENCES transgene(gene_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (scientist_id_germ)
	 REFERENCES scientist(scientist_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	) ENGINE=InnoDB;
	
END
;
}	

