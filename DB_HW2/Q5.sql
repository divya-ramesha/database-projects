
/* 
PostgreSQL 11.2 
psql -U <user-name> -d <db> -a -f Q5.sql

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

SELECT Chef FROM CHEF_DISH WHERE Dish IN (SELECT Dish FROM REQ_DISH) GROUP BY Chef HAVING COUNT(DISTINCT Dish) = (SELECT COUNT(*) FROM REQ_DISH);

/* 

Lets break our query into 3 small parts:

1. "SELECT Chef FROM CHEF_DISH WHERE Dish IN (SELECT Dish FROM REQ_DISH);"

So the above SELECT query first selects all those Chef's who can prepare any(one or more) of the required dishes present in REQ_DISH table. 
This includes other Chef's too like 'B' who just prepares 'Creme brulee'. It gives intermediate table like this

'B' : 'Creme brulee'
'C' : 'Creme brulee'
'C' : 'Upside down pineapple cake'
'D' : 'Creme brulee'
'D' : 'Upside down pineapple cake' 
'D' : 'Apple pie'
'E' : 'Creme brulee'
'E' : 'Upside down pineapple cake' 
'E' : 'Apple pie'

2. "SELECT Chef FROM CHEF_DISH WHERE Dish IN (SELECT Dish FROM REQ_DISH) GROUP BY Chef;"

After this it is grouped/categorized by Chef which gives intermediate table something like 

'B' : ['Creme brulee']
'C' : ['Creme brulee', 'Upside down pineapple cake']
'D' : ['Creme brulee', 'Upside down pineapple cake', 'Apple pie']
'E' : ['Creme brulee', 'Upside down pineapple cake', 'Apple pie']

3. "SELECT Chef FROM CHEF_DISH WHERE Dish IN (SELECT Dish FROM REQ_DISH) GROUP BY Chef HAVING COUNT(DISTINCT Dish) = (SELECT COUNT(*) FROM REQ_DISH);""

After this I'm applying a condition to check the count of dishes prepared by this Chef is equal to the total number of required dishes we want.

SELECT COUNT(*) FROM REQ_DISH : gives us the total number of required dishes which is 3 in our case

HAVING COUNT(DISTINCT Dish) = 3 : condition to filter those rows from step 2 where the length of dishes is 3.

*/
