
/* 
PostgreSQL 11.2 
psql -U <user-name> -d <db> -a -f Q1.sql

Name: Divya Ramesha
USC ID: 5228569441
*/

/* 
If you don't want to see creation or insertion errors then make sure you drop your previous tables first if it already exists using
DROP TABLE HotelStays;
*/

CREATE TABLE HotelStays
(
	roomNum INTEGER NOT NULL,
	arrDate DATE NOT NULL,
	depDate DATE NOT NULL,
	guestName CHAR(5) NOT NULL,
	PRIMARY KEY (roomNum, arrDate),
	CONSTRAINT check_earLy_departure CHECK(depDate > arrDate)
);

/*

The 'CONSTRAINT check_earLy_departure CHECK(depDate > arrDate)' makes sure that departure date is always later than arrival date to fix the first problem.

To fix second problem I've created a trigger which gets triggered before insert and checks whether the requested hotel stay is clashing with already reserved entries.

*/

CREATE OR REPLACE FUNCTION checkGuestClash() RETURNS trigger AS $checkGuestClash$
	DECLARE
		rec HotelStays%rowtype;
	BEGIN 
		FOR rec IN SELECT * from HotelStays 
		WHERE roomNum = NEW.roomNum
		LOOP 
			IF (NEW.arrDate BETWEEN rec.arrDate AND rec.depDate) OR (NEW.depDate BETWEEN rec.arrDate AND rec.depDate) OR (NEW.arrDate < rec.arrDate AND NEW.depDate > rec.depDate) THEN
				RAISE EXCEPTION '% is clashing with existing guest %', NEW.guestName, rec.guestName;
				EXIT;
			END IF;
		END LOOP;
		RETURN NEW;
	END;
$checkGuestClash$ LANGUAGE plpgsql;

CREATE TRIGGER checkGuestClash BEFORE INSERT ON HotelStays
    FOR EACH ROW EXECUTE PROCEDURE checkGuestClash();

/* The following queries should succeed */
INSERT INTO HotelStays(roomNum, arrDate, depDate, guestName) VALUES (123, to_date('20160202', 'YYYYMMDD'), to_date('20160206', 'YYYYMMDD'), 'A');
INSERT INTO HotelStays(roomNum, arrDate, depDate, guestName) VALUES (123, to_date('20160102', 'YYYYMMDD'), to_date('20160106', 'YYYYMMDD'), 'B');
INSERT INTO HotelStays(roomNum, arrDate, depDate, guestName) VALUES (123, to_date('20160220', 'YYYYMMDD'), to_date('20160320', 'YYYYMMDD'), 'C');
INSERT INTO HotelStays(roomNum, arrDate, depDate, guestName) VALUES (125, to_date('20160120', 'YYYYMMDD'), to_date('20160205', 'YYYYMMDD'), 'H');

/* The following queries should fail because they violate the constraints specified to fix the problems*/
INSERT INTO HotelStays(roomNum, arrDate, depDate, guestName) VALUES (123, to_date('20160204', 'YYYYMMDD'), to_date('20160208', 'YYYYMMDD'), 'D');
INSERT INTO HotelStays(roomNum, arrDate, depDate, guestName) VALUES (123, to_date('20160125', 'YYYYMMDD'), to_date('20160204', 'YYYYMMDD'), 'E');
INSERT INTO HotelStays(roomNum, arrDate, depDate, guestName) VALUES (123, to_date('20160128', 'YYYYMMDD'), to_date('20160218', 'YYYYMMDD'), 'F');
INSERT INTO HotelStays(roomNum, arrDate, depDate, guestName) VALUES (201, to_date('20160210', 'YYYYMMDD'), to_date('20160206', 'YYYYMMDD'), 'G');

/* Check whether it succedded */
SELECT * FROM HotelStays;
