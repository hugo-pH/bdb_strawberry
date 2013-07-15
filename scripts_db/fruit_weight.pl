#!/usr/bin/perl -w
#fruit_weight.pl
use strict;

schema();


sub schema {

    print <<END;
    DROP TABLE IF EXISTS fruit_weight;
    CREATE TABLE fruit_weight(
	weight_id INT NOT NULL AUTO_INCREMENT,
	value FLOAT NOT NULL,
	scientist_id INT,
	line_id      INT NOT NULL,
	control_id   INT NOT NULL,
	date         DATE,
	PRIMARY KEY (weight_id),
	FOREIGN KEY (scientist_id)
	 REFERENCES scientist(scientist_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (line_id)
	 REFERENCES germplasm(line_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (control_id)
	 REFERENCES control(control_id)	
	ON DELETE CASCADE
	ON UPDATE CASCADE   
	) ENGINE=InnoDB;

END
;
}
