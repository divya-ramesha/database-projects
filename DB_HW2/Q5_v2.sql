
/* 
PostgreSQL 11.2 
psql -U <user-name> -d <db> -a -f Q5_v2.sql

Name: Divya Ramesha
USC ID: 5228569441
*/

/* 
If you don't want to see creation or insertion errors then make sure you drop your previous tables first if it already exists using
DROP TABLE CHEF_DISH;
DROP TABLE REQ_DISH;
*/

CREATE TABLE CHEF_DISH
(
	Chef CHAR(30) NOT NULL, 
	Dish CHAR(50) NOT NULL, 
	PRIMARY KEY (Chef, Dish)
);

INSERT INTO CHEF_DISH(Chef, Dish) VALUES ('A', 'Mint chocolate brownie');
INSERT INTO CHEF_DISH(Chef, Dish) VALUES ('B', 'Creme brulee');
INSERT INTO CHEF_DISH(Chef, Dish) VALUES ('B', 'Mushroom Manchurian');
INSERT INTO CHEF_DISH(Chef, Dish) VALUES ('B', 'Mint chocolate brownie');
INSERT INTO CHEF_DISH(Chef, Dish) VALUES ('C', 'Upside down pineapple cake');
INSERT INTO CHEF_DISH(Chef, Dish) VALUES ('C', 'Creme brulee');
INSERT INTO CHEF_DISH(Chef, Dish) VALUES ('D', 'Apple pie');
INSERT INTO CHEF_DISH(Chef, Dish) VALUES ('D', 'Upside down pineapple cake');
INSERT INTO CHEF_DISH(Chef, Dish) VALUES ('D', 'Creme brulee');
INSERT INTO CHEF_DISH(Chef, Dish) VALUES ('E', 'Apple pie');
INSERT INTO CHEF_DISH(Chef, Dish) VALUES ('E', 'Upside down pineapple cake');
INSERT INTO CHEF_DISH(Chef, Dish) VALUES ('E', 'Creme brulee');
INSERT INTO CHEF_DISH(Chef, Dish) VALUES ('E', 'Bananas Foster');

CREATE TABLE REQ_DISH
(
	Dish CHAR(50) NOT NULL, 
	PRIMARY KEY (Dish)
);

INSERT INTO REQ_DISH(Dish) VALUES ('Creme brulee');
INSERT INTO REQ_DISH(Dish) VALUES ('Upside down pineapple cake');
INSERT INTO REQ_DISH(Dish) VALUES ('Apple pie');

/* I'm hardcoding the values here */
SELECT DISTINCT Chef FROM CHEF_DISH WHERE Dish = 'Creme brulee' INTERSECT SELECT DISTINCT Chef FROM CHEF_DISH WHERE Dish = 'Upside down pineapple cake' INTERSECT SELECT DISTINCT Chef FROM CHEF_DISH WHERE Dish = 'Apple pie';

/* 

First I'm selecting all those Chef's who can prepare 'Creme brulee'. This includes B,C,D,E
Next I'm taking intersection of all those Chef's who can prepare 'Upside down pineapple cake' along with 'Creme brulee'. This includes C,D,E. It doesn't include B because he can't prepare 'Upside down pineapple cake'.
Next I'm taking intersection of above Chef's with those Chef's who can prepare 'Apple pie' along with 'Upside down pineapple cake' and 'Creme brulee'. This includes D,E. It doesn't include C because he can't prepare 'Apple pie'.

*/

/* If hardcoding like above is not accepted only then please consider the below query instead */
SELECT Chef FROM CHEF_DISH INNER JOIN REQ_DISH ON CHEF_DISH.Dish = REQ_DISH.Dish GROUP BY Chef HAVING COUNT(*) = (SELECT COUNT(*) FROM REQ_DISH);

/* 

First I'm selecting(inner join) all those Chef's who can prepare any of the required dishes.

'B' : 'Creme brulee'
'C' : 'Creme brulee'
'C' : 'Upside down pineapple cake'
'D' : 'Creme brulee'
'D' : 'Upside down pineapple cake' 
'D' : 'Apple pie'
'E' : 'Creme brulee'
'E' : 'Upside down pineapple cake' 
'E' : 'Apple pie'

After this it is grouped/categorized by Chef which gives intermediate table something like 

'B' : ['Creme brulee']
'C' : ['Creme brulee', 'Upside down pineapple cake']
'D' : ['Creme brulee', 'Upside down pineapple cake', 'Apple pie']
'E' : ['Creme brulee', 'Upside down pineapple cake', 'Apple pie']

After this I'm applying a condition to check the count of dishes prepared by this Chef is equal to the total number of required dishes we want.

SELECT COUNT(*) FROM REQ_DISH : gives us the total number of required dishes which is 3 in our case

HAVING COUNT(*) = 3 : condition to filter those rows from step 2 where the length of dishes is 3.

*/

