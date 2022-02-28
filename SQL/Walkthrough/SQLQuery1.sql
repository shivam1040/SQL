--CREATE DATABASE happy; --creates database
USE happy; --selects database for use, remains default until end of execution or new USE is initiallized
--DROP DATABASE happy; --deletes db happy
-- NOT NULL constraint makes sure that every row of field has some value, DEFAULT constraint puts default value to entry row of filed when no value is specified, UNIQUE makes sure that every entry of a field has unique value, PRIMARY KEY constraint makes sure that all values of entries for a field is not null and unique, a table can't have more than one PRIMARY KEy
CREATE TABLE employee(
id int not null, --field id of type int with not null constraint
name varchar(20), --20 char limit
salary int,
age int,
gender varchar(20),
primary key(id)
);
INSERT INTO employee VALUES(
1,'SHiv',9500,23,'M'
);
INSERT INTO employee VALUES(
2,'Hiv',500,3,'M'
);
INSERT INTO employee VALUES(
3,'iv',300,30,'F'
);
SELECT name,salary FROM employee; --selects a field from table and displays it,  use * instead of field names to get all data
SELECT DISTINCT gender FROM employee; --selects distinct value in gender field
SELECT * FROM employee WHERE gender='F'; --selects only gender with F value
SELECT * FROM employee WHERE gender='M' AND age>20; --selects records in employee whose gender and age are satisfied, Similary OR and NOT can be used
SELECT * FROM employee WHERE name LIKE '%v'; --selects % gives any number of characters while  _ gives on character
SELECT * FROM employee WHERE age BETWEEN 3 AND 23; --returns entries whose age are b/w 23 and 3
SELECT MIN(age) from employee; --selects minimum value from the entries of field age in table employee, similarly max
SELECT COUNT(*) FROM employee WHERE gender='M'; --returns the count of M employees in table, * means entire table
SELECT SUM(salary) FROM employee; --returns sum of numeric value of entries for a column
SELECT AVG(salary) FROM employee; --returns average
SELECT LTRIM('   sh'); --removes spaces from left side, LOWER() and UPPER() to conv character case, REVERSE() reverses all character in string
SELECT SUBSTRING('This is', 5, 3); --returns 2 characters from pos 5 in string 'This...
SELECT * FROM employee ORDER BY salary ASC; --sorts the table in asc order wrt salary, use DESC for descendi
SELECT TOP 2 * FROM employee; --returns top 3 records
SELECT TOP 2 * FROM employee ORDER BY age DESC; --returns top 2 records by sorting age in descending
SELECT AVG(salary), gender FROM employee GROUP BY gender ORDER BY AVG(salary) DESC; --returns average salary of gender by grouping male and female in descending order
SELECT gender, AVG(salary) AS avgs FROM employee GROUP BY gender HAVING avg(salary)>300; --find average of salary and stores under field avgs and groups them by gender whose avg salary is more then 300
UPDATE employee SET age=31 WHERE name='iv'; --sets age to 31 for the name iv, if where is not used then entire age is changed to 31
DELETE FROM employee WHERE age=31; --deletes record of employee whose age is 31
SELECT * FROM employee;
--TRUNCATE TABLE employee --deletes entire records
CREATE TABLE dept(
did int not null, --field id of type int with not null constraint
dname varchar(20), --20 char limit
primary key(did)
);
INSERT INTO dept VALUES(
1,'iv'
);
INSERT INTO dept VALUES(
2,'HHiv'
);
INSERT INTO dept VALUES(
3,'iiv'
);
SELECT * FROM dept;
SELECT employee.name, employee.age, dept.dname FROM employee INNER JOIN dept ON employee.id=dept.did; --joins content from two tables employee and debt on the given condition id=did, joins would have name age and dname
SELECT employee.name, employee.age, dept.dname FROM employee LEFT JOIN dept ON employee.id=dept.did; --returns all the elements from employee tbale while only mathced entries from dept table are returned else null is returned, i.e. name, age of employee all returned and dname is returned only if ON condition true else NULL return, similarly RIGHTJOIN can be used for vice vesra, similarly FULL JOIN can be used to return all requested vales from table 1 and 2 and NULL is return for untrue conditions
SELECT * FROM employee;
UPDATE employee SET salary=salary+10 FROM employee JOIN dept ON employee.id=dept.did WHERE dept.did>1; --updates salary by 10 by temporarily joining two tables where emp id=dep did and dep did is greater than 1
SELECT * FROM employee;
DELETE employee FROM employee JOIN dept ON employee.id=dept.did WHERE dept.did>1; --deletes one row of entries from employee by creating join between employee and dept on the given conditon
SELECT * FROM employee;
-- SELECT * FROM table1 UNION SELECT * FROM table2, returns union of two tables, ensure that both the tables have same number of fields, use UNION ALL to return all the values no matter repeated or not
-- SELECT * FROM table1 EXCEPT SELECT * FROM table2, returns a table wherein elements of table1 aren't present in table2, ensure same number of fields
-- SELECT * FROM table1 INTERSECT SELECT * FROM table2, find intersection b/w two tables
-- CREATE VIEW fema AS SELECT * FROM employee WHERE gender='F'; creates a read only table fema from employee and the read only table has only entries of female gender
-- DROP VIEW fema; deletes fema temporary table
ALTER TABLE employee ADD dob date; --adds column dob of type date to employee
ALTER TABLE employee DROP COLUMN dob; --deletes column dob

/* MERGE Target as T			updates Target table
 USING Source1 as S			    by source table
		ON T.id=S.id			checking a condition of id equal in both table
WHEN MATCHED			
		THEN UPDATE SET	T.a=S.a, T.b=S.b	if matched updated particular values of T using S
WHEN NOT MATCHED BY TARGET
		THEN INSERT(a, b)					When values of source aren't present in target then insert particular (a, b...) column with values from source 
		VALUES(S.a, S.b)
WHEN NOT MATCHED BY SOURCE
		THEN DELETE;						if values aren't present in source, the delete the entire  absent entries/colum
*/

/*CREATE FUNCTION addn(@num AS INT)	--user def  scalar function takes @num parameter of type int
RETURNS int	--returns type int value
AS	
BEGIN
RETURN(@num+5)		
END

SELECT dbo.addn(5); --calls function
*/

SELECT * FROM employee;

/*CREATE FUNCTION gender1(@gender as varchar(20))
RETURNS table
AS						--function which returns tabled from a table based on give condition and parameter
RETURN(
select * FROM employee WHERE gender=@gender
)

SELECT * FROM dbo.gender1('M')
*/

CREATE TABLE #stud( --temporary table 
id int,
names varchar(20)
);

INSERT INTO #stud VALUES(
1, 'RA'
);

select * FROM employee

SELECT *, grade= --case statement returning a new column grade in accordance to the cases below
CASE
WHEN salary<1000 then 'C'
WHEN salary>10000 then 'B'
else 'A'
END
FROM employee
GO

SELECT age, IIF(age>30, 'Old','Young') AS GENERA FROM employee; --returns age and genera column and old/young as value of genera based on condition

/* CREATE PROCEDURE age1  --creates stored procedure(often used statement) age1 
AS
SELECT age FROM employee --returns column age and its values from table employee
GO;

EXEC age1; --statement to call age1 stored procedure
*/

CREATE PROCEDURE emp1 @a varchar(20) --procedure function with parameter implementation
AS --returns table from employee filtered on the conition of parameter given by user 
SELECT * FROM employee
WHERE gender=@a
GO;

DECLARE @a int; --exception handling demo mssql
DECLARE @b int;
begin try
set @a=8;
set @b=@a/0;
end try
begin catch
print error_message()
end catch

begin try --user defined error message exception handling
SELECT salary+gender FROM employee
end try
begin catch
print 'unable'
end catch

SELECT * FROM employee;

/* BEGIN TRY  --showing use of transaction in try catch block, a transaction is used to commit/rollback changes
BEGIN TRANSACTION
UPDATE employee set age=31/0 WHERE name='H'
COMMIT TRANSACTION
Print 'COMP'
END TRY
BEGIN CATCH --this case is useful when there's fail in try block so changes can be rolled back in catch block
ROLLBACK TRANSACTION
PRINT 'FAIL'
END CATCH
*/

SELECT MAX(salary) FROM employee WHERE salary NOT IN(SELECT MAX(salary) FROM employee); --this returns second highest entry from the salary field from employee table
--SELECT gender AVG(age) FROM employee WHERE AVG(age)>30 GROUP BY gender; this will return an error since aggregate func can't be used with WHERE, insted use HAVING and place GROUP BY befor having block
--SELECT('ABC',1,3,'Pyth'); --this replaces abc with Pyth starting at index 1 with max replace char count of 3
--DELETE FROM employee WHERE id=1; --deletes the entire record/row where id is equal to 1
--TRUNCATE TABLE employee; deletes the entire table, doesn't work with foreign key
--INSERT INTO employeecopy SELECT * FROM employee; -- copies all data from employee to employeecopy, provided that employeecopy has same number and name of fields as employee table

CREATE TABLE e(
id int not null, --field id of type int with not null constraint
name varchar(20), --20 char limit
salary int,
primary key(id)
);
INSERT INTO e VALUES(
1,'F',9500
);
INSERT INTO e VALUES(
2,'F',500
);
INSERT INTO e VALUES(
3,'F',300
);

CREATE TABLE f(
id int not null, --field id of type int with not null constraint
name varchar(20), --20 char limit
primary key(id)
);
INSERT INTO f VALUES(
1,'FI'
);
INSERT INTO f VALUES(
2,'FI'
);
INSERT INTO f VALUES(
3,'M'
);

SELECT AVG(salary) FROM e WHERE a=1

SELECT AVG(e.salary) FROM e RIGHT JOIN f ON e.id=f.id WHERE f.name='FI'
