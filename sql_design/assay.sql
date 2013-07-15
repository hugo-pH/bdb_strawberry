    DROP TABLE IF EXISTS assay;
    CREATE TABLE assay(
	assay_id INT NOT NULL AUTO_INCREMENT,
	protocol TEXT,
	description TEXT,
	equipment_id INT,
	scientist_id INT,
	PRIMARY KEY (assay_id),
	FOREIGN KEY (equipment_id)
	 REFERENCES equipment(eq_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (scientist_id)
	 REFERENCES scientist(scientist_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	) ENGINE=InnoDB;

