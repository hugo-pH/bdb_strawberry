#!/usr/bin/perl -w
#shape.pl
use strict;

schema();


sub schema {

    print <<END;
    DROP TABLE IF EXISTS shape;
    CREATE TABLE shape(
	shape_id INT NOT NULL AUTO_INCREMENT,
	length_value FLOAT,
	width_value  FLOAT,
	ratio	     FLOAT,
	scientist_id INT,
	line_id      INT NOT NULL,
	control_id   INT NOT NULL,
	date         DATE,
	PRIMARY KEY (shape_id),
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
