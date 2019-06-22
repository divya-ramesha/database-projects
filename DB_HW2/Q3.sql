
/* 
PostgreSQL 11.2 
psql -U <user-name> -d <db> -a -f Q3.sql

Name: Divya Ramesha
USC ID: 5228569441
*/

/* 
If you don't want to see creation or insertion errors then make sure you drop your previous tables first if it already exists using
DROP TABLE PROJECT;
*/

CREATE TABLE PROJECT
(
	ProjectID CHAR(5) NOT NULL, 
	Step INTEGER NOT NULL, 
	Status CHAR(1) NOT NULL, 
	PRIMARY KEY (ProjectID, Step)
);

INSERT INTO PROJECT(ProjectID, Step, Status) VALUES ('P100', 0, 'C');
INSERT INTO PROJECT(ProjectID, Step, Status) VALUES ('P100', 1, 'W');
INSERT INTO PROJECT(ProjectID, Step, Status) VALUES ('P100', 2, 'W');
INSERT INTO PROJECT(ProjectID, Step, Status) VALUES ('P201', 0, 'C');
INSERT INTO PROJECT(ProjectID, Step, Status) VALUES ('P201', 1, 'C');
INSERT INTO PROJECT(ProjectID, Step, Status) VALUES ('P333', 0, 'W');
INSERT INTO PROJECT(ProjectID, Step, Status) VALUES ('P333', 1, 'W');
INSERT INTO PROJECT(ProjectID, Step, Status) VALUES ('P333', 2, 'W');
INSERT INTO PROJECT(ProjectID, Step, Status) VALUES ('P333', 3, 'W');

SELECT ProjectID FROM PROJECT AS P1 WHERE Step = 0 AND Status = 'C' AND 'W' = ALL(SELECT Status FROM PROJECT AS P2 WHERE Step != 0 AND P1.ProjectID = P2.ProjectID);
