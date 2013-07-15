DROP TABLE IF EXISTS transgene;
CREATE TABLE transgene(
    gene_id  INT NOT NULL AUTO_INCREMENT,
    sequence TEXT,
    modification TEXT,
    symbol   VARCHAR(255) NOT NULL,
    ECC      VARCHAR(255),
    scient_gene_id  INT,
    PRIMARY KEY (gene_id),
    FOREIGN KEY (scient_gene_id)
     REFERENCES scientist(scientist_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
    ) ENGINE=InnoDB;

