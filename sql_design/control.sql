    DROP TABLE IF EXISTS control;
    CREATE TABLE control(
	control_id INT NOT NULL AUTO_INCREMENT,
	line_id INT NOT NULL,
	control_line_id INT NOT NULL,
	season YEAR,
	PRIMARY KEY (control_id),
	FOREIGN KEY (line_id)
	 REFERENCES germplasm(line_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (control_line_id)
	 REFERENCES germplasm(line_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	) ENGINE=InnoDB;


