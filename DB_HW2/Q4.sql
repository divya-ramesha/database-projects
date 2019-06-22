
/* 
PostgreSQL 11.2 
psql -U <user-name> -d <db> -a -f Q4.sql

Name: Divya Ramesha
USC ID: 5228569441
*/

/* 
If you don't want to see creation or insertion errors then make sure you drop your previous tables first if it already exists using
DROP TABLE JUNKMAIL;
*/

CREATE TABLE JUNKMAIL
(
	Name CHAR(30) NOT NULL, 
	Address CHAR(10) NOT NULL, 
	ID INTEGER NOT NULL, 
	SameFam INTEGER REFERENCES JUNKMAIL(ID) ON DELETE SET NULL, 
	PRIMARY KEY (ID)
);

/* I'm deleting older family members along with updating existing ones with NULL. If its not required then you can remove 'ON DELETE SET NULL' from SameFam column in table definition */

INSERT INTO JUNKMAIL(Name, Address, ID) VALUES ('Alice', 'A', 10);
INSERT INTO JUNKMAIL(Name, Address, ID) VALUES ('Bob', 'B', 15);
INSERT INTO JUNKMAIL(Name, Address, ID) VALUES ('Carmen', 'C', 22);
INSERT INTO JUNKMAIL(Name, Address, ID) VALUES ('Farkhad', 'D', 11);
INSERT INTO JUNKMAIL(Name, Address, ID, SameFam) VALUES ('Diego', 'A', 9, 10);
INSERT INTO JUNKMAIL(Name, Address, ID, SameFam) VALUES ('Ella', 'B', 3, 15);

/* check insertions */
SELECT * FROM JUNKMAIL;

DELETE FROM JUNKMAIL WHERE SameFam IS NULL AND ID IN (SELECT DISTINCT(SameFam) FROM JUNKMAIL WHERE SameFam IS NOT NULL);

/* check deletions and updations made after deletion */
SELECT * FROM JUNKMAIL;
