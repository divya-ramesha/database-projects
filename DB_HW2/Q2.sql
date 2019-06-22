
/* 
PostgreSQL 11.2 
psql -U <user-name> -d <db> -a -f Q2.sql

Name: Divya Ramesha
USC ID: 5228569441
*/

/* 
If you don't want to see creation or insertion errors then make sure you drop your previous tables first if it already exists using
DROP TABLE ENROLL;
*/

CREATE TABLE ENROLL
(
	SID INTEGER NOT NULL, 
	ClassName CHAR(30) NOT NULL, 
	Grade CHAR(1) NOT NULL, 
	PRIMARY KEY (SID, ClassName)
);

INSERT INTO ENROLL(SID, ClassName, Grade) VALUES (123, 'ART123', 'A');
INSERT INTO ENROLL(SID, ClassName, Grade) VALUES (123, 'BUS456', 'B');
INSERT INTO ENROLL(SID, ClassName, Grade) VALUES (666, 'REL100', 'D');
INSERT INTO ENROLL(SID, ClassName, Grade) VALUES (666, 'ECO966', 'A');
INSERT INTO ENROLL(SID, ClassName, Grade) VALUES (666, 'BUS456', 'B');
INSERT INTO ENROLL(SID, ClassName, Grade) VALUES (345, 'BUS456', 'A');
INSERT INTO ENROLL(SID, ClassName, Grade) VALUES (345, 'ECO966', 'F');

SELECT ClassName, COUNT(distinct SID) AS Total FROM ENROLL GROUP BY ClassName ORDER BY Total, ClassName;
