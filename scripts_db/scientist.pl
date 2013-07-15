#!/usr/bin/perl -w
#scientist.pl
use strict;

schema();


sub schema {
    print <<END;
    DROP TABLE IF EXISTS scientist;
    CREATE TABLE scientist(
	scientist_id  INT NOT NULL AUTO_INCREMENT,
	mail    VARCHAR(60) NOT NULL,
	first_name VARCHAR (20),
	family_name VARCHAR (20),
	institution VARCHAR (60),
	PRIMARY KEY (scientist_id)
	) ENGINE=InnoDB;

END
;
}
