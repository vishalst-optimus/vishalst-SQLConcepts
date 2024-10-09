--SET OPERATIONS

CREATE TABLE t1(c1 char(1), c2 int);
CREATE TABLE t2(c1 char(1), c2 int);

INSERT INTO t1 values
	('A', 1),('B', 1), ('C', 2);

INSERT INTO t2 values
	('A', 1), ('B', 2), ('D', 3);

--1. UNION
SELECT * FROM t1 
UNION
SELECT * FROM t2;

--2. INTERSECTION
SELECT * FROM t1 INNER JOIN t2 ON t1.c1 = t2.c1;

--3 MINUS
SELECT t1.* FROM t1 LEFT JOIN t2 ON t1.c1 = t2.c1 WHERE t2.c1 IS NULL;

--ADD Default value to a column
ALTER TABLE t2 ADD CONSTRAINT df_c2 DEFAULT 10 FOR c2;

INSERT INTO t2 (c1) values ('X');

SELECT * FROM t2;
