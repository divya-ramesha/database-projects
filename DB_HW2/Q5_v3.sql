
/* 
PostgreSQL 11.2 
psql -U <user-name> -d <db> -a -f Q5_v3.sql

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

SELECT DISTINCT CHEF_DISH.Chef FROM CHEF_DISH WHERE NOT EXISTS (SELECT REQ_DISH.Dish FROM REQ_DISH WHERE REQ_DISH.Dish NOT IN (SELECT DISTINCT Chef_Copy.Dish FROM CHEF_DISH Chef_Copy WHERE Chef_Copy.Chef = CHEF_DISH.Chef));

/*

Also, from the another prospective of set theory, 
We can think about it in this way: 
For a valid Chef who can prepare all the REQ_DISH, we shouldn't be able to find a Dish in REQ_DISH that cannot be prepared by this Chef in CHEF_DISH

Lets break our query into following steps:

1. SELECT DISTINCT Chef_Copy.Dish FROM CHEF_DISH Chef_Copy WHERE Chef_Copy.Chef = CHEF_DISH.Chef

This selects all the distinct dishes a Chef can prepare

2. SELECT REQ_DISH.Dish FROM REQ_DISH WHERE REQ_DISH.Dish NOT IN Step 1

This selects all the required dishes which are not prepared by this Chef

3. SELECT DISTINCT CHEF_DISH.Chef FROM CHEF_DISH WHERE NOT EXISTS in Step 2

This selects all the valid Chef's for whom there is no REQ_DISH that he can't prepare

*/