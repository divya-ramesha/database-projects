
/* 
PostgreSQL 11.2 + PostGIS

Name: Divya Ramesha
USC ID: 5228569441
*/

/* Question 1 - Convex Hull */
SELECT ST_ASTEXT(ST_CONVEXHULL(ST_GEOMFROMTEXT('MultiPoint(-118.28033 34.02839, -118.28397 34.02226, -118.28842 34.02286, -118.28915 34.02122, -118.28913 34.01946, -118.28603 34.01888, -118.28532 34.02050, -118.28408 34.02030, -118.28290 34.02179, -118.27798 34.02630, -118.28409 34.02535, -118.29119 34.02202)'))) AS CONVEX_HULL;

/* 
Output:

spatialdb=# SELECT ST_ASTEXT(ST_CONVEXHULL(ST_GEOMFROMTEXT('MultiPoint(-118.28033 34.02839, -118.28397 34.02226, -118.28842 34.02286, -118.28915 34.02122, -118.28913 34.01946, -118.28603 34.01888, -118.28532 34.02050, -118.28408 34.02030, -118.28290 34.02179, -118.27798 34.02630, -118.28409 34.02535, -118.29119 34.02202)'))) AS CONVEX_HULL;
                                                                     convex_hull
------------------------------------------------------------------------------------------------------------------------------------------------------
 POLYGON((-118.28603 34.01888,-118.28913 34.01946,-118.29119 34.02202,-118.28033 34.02839,-118.27798 34.0263,-118.28408 34.0203,-118.28603 34.01888))
(1 row)

*/

/* Question 2 - Four Nearest Neighbors */
CREATE TABLE spatial_tbl
(
    id SERIAL PRIMARY KEY,
    name CHAR(15)
);

SELECT AddGeometryColumn ('spatial_tbl','geopoint',4326,'POINT',2);

INSERT INTO spatial_tbl(name, geopoint) VALUES ('Home', ST_GeomFromText('POINT(34.02839 -118.28033)', 4326));
INSERT INTO spatial_tbl(name, geopoint) VALUES ('THH', ST_GeomFromText('POINT(34.02226 -118.28397)', 4326));
INSERT INTO spatial_tbl(name, geopoint) VALUES ('Brittingham', ST_GeomFromText('POINT(34.02286 -118.28842)', 4326));
INSERT INTO spatial_tbl(name, geopoint) VALUES ('SGM', ST_GeomFromText('POINT(34.02122 -118.28915)', 4326));
INSERT INTO spatial_tbl(name, geopoint) VALUES ('SAL', ST_GeomFromText('POINT(34.01946 -118.28913)', 4326));
INSERT INTO spatial_tbl(name, geopoint) VALUES ('Marshall', ST_GeomFromText('POINT(34.01888 -118.28603)', 4326));
INSERT INTO spatial_tbl(name, geopoint) VALUES ('Tommy', ST_GeomFromText('POINT(34.02050 -118.28532)', 4326));
INSERT INTO spatial_tbl(name, geopoint) VALUES ('DML', ST_GeomFromText('POINT(34.02030 -118.28408)', 4326));
INSERT INTO spatial_tbl(name, geopoint) VALUES ('Leavey', ST_GeomFromText('POINT(34.02179 -118.28290)', 4326));
INSERT INTO spatial_tbl(name, geopoint) VALUES ('Dominos', ST_GeomFromText('POINT(34.02630 -118.27798)', 4326));
INSERT INTO spatial_tbl(name, geopoint) VALUES ('Target', ST_GeomFromText('POINT(34.02535 -118.28409)', 4326));
INSERT INTO spatial_tbl(name, geopoint) VALUES ('Downey Way', ST_GeomFromText('POINT(34.02202 -118.29119)', 4326));

SELECT ID, NAME, ST_Y(geopoint) AS LONGITUDE, ST_X(geopoint) AS LATITUDE FROM spatial_tbl WHERE ST_Distance(geopoint, ST_GeomFromText('POINT(34.02839 -118.28033)', 4326)) != 0 ORDER BY ST_Distance(geopoint, ST_GeomFromText('POINT(34.02839 -118.28033)', 4326)) ASC LIMIT 4;

/*
Output:

spatialdb=# SELECT ID, NAME, ST_Y(geopoint) AS LONGITUDE, ST_X(geopoint) AS LATITUDE FROM spatial_tbl WHERE ST_Distance(geopoint, ST_GeomFromText('POINT(34.02839 -118.28033)', 4326)) != 0 ORDER BY ST_Distance(geopoint, ST_GeomFromText('POINT(34.02839 -118.28033)', 4326)) ASC LIMIT 4;
 id |      name       | longitude  | latitude
----+-----------------+------------+----------
 32 | Dominos         | -118.27798 |  34.0263
 33 | Target          | -118.28409 | 34.02535
 31 | Leavey          |  -118.2829 | 34.02179
 24 | THH             | -118.28397 | 34.02226
(4 rows)

*/
