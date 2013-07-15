    DROP TABLE IF EXISTS firmness;
    CREATE TABLE firmness(
	firmness_id INT NOT NULL AUTO_INCREMENT,
	value FLOAT NOT NULL,
	scientist_id INT,
	assay_id  INT,
	line_id      INT NOT NULL,
	control_id   INT NOT NULL,
	date         DATE,
	PRIMARY KEY (firmness_id),
	FOREIGN KEY (assay_id)
	 REFERENCES assay(assay_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
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

