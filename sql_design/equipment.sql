    DROP TABLE IF EXISTS equipment;
    CREATE TABLE equipment(
	eq_id INT NOT NULL AUTO_INCREMENT,
	eq_name  TEXT,
	eq_model VARCHAR(80),
	eq_serial VARCHAR(80),
	provider  TEXT,
	PRIMARY KEY (eq_id)
	)ENGINE=InnoDB;

