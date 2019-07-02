USE mydb;
CREATE TABLE mytable( 
    id INT NOT NULL AUTO_INCREMENT,
    message VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);
INSERT INTO mytable(message) VALUES 
    ('Hello World!'),
    ('foo'),
    ('bar')
;
