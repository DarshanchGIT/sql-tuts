
FOR MORE NOTES : https://drive.google.com/drive/folders/1OeHQaGTxgvBakJIbQ1QC9grO7WqDkPDg

-- Creating database if not exists
CREATE DATABASE IF NOT EXISTS college;
USE college;

-- Creating table and schema
CREATE TABLE student (
    -- first-> attribute, second-> datatype, third-> constraint (e.g: NOT NULL)
    id INT PRIMARY KEY,
    -- CHAR and VARCHAR same but CHAR stores static memory and VARCHAR dynamic.
    name VARCHAR(50),
    age INT NOT NULL
);

-- Inserting data into table
INSERT INTO student VALUES (1, 'Darshan', 21);
INSERT INTO student VALUES (2, 'Rahul', 20);
INSERT INTO student (id, name, age) VALUES
(3, 'Gaurav', 20);


-- Print the whole ( using asterik -> "*" } table
SELECT * FROM student;

-- Print selected column out of table
SELECT name, age FROM student;

-- DISTINCT ouputs distinct value out of that column 

-- Where is basically a clause - Means a specific condition/rule has been set
UPDATE student
SET name = 'Madhav', age = 22
WHERE id = 4;

-- updating my surname 
UPDATE student 
SET name = "Darshan"
WHERE id = 1;

-- Inserting some new data into existing table student
INSERT into student (id,name,age) VALUES
(5,"Ashu",23),
(6,"Anant", 24);

SELECT DISTINCT age FROM student;

-- OR and AND operator in clauses 
SELECT * FROM student WHERE age > 22 OR name = "Ashu";
--  just put AND in place of OR

-- Between operator - beech ka jo jo hota( Ranges are Inclusive ) 
 SELECT * FROM student WHERE age BETWEEN 20 and 22; 
 
 -- In( Matches values in the list )
 SELECT * FROM student WHERE age IN ( 22, 23);

-- NOT In - basically inko chodke sabka 
SELECT * FROM student WHERE name NOT IN ("Madhav","Anant");

-- LIMIT -> Limits the number of rows basically
SELECT * FROM student LIMIT 3;

-- ORDER BY - 1. ASC = Ascending 2. DESC = Descending
-- NOTE : By default it gives data in Ascending
--  1. ASC
SELECT * FROM student ORDER BY name ASC;
--  2. DSC
SELECT * FROM student ORDER BY age DESC LIMIT 3;  

-- AGGREGATION => Perform an operation on given arguments passed and return a single result 
-- For e.g : max(), min(), avg(), sum() etc.
SELECT  MAX(age) FROM student;
-- sum of ages of all student in DB
SELECT  SUM(age) FROM student;

-- GROUP BY clause - Groups rows NOTE: Generally aggregate fn() used along side Group BY clause
SELECT name, count(age) FROM student GROUP BY name;
SELECT name FROM student GROUP BY name;
-- Here's what it does:

-- SELECT name, COUNT(age): This selects the name column and the count of age values for each name.
-- FROM student: This specifies that the data is being fetched from the student table.
-- GROUP BY name: This groups the rows in the table by the name column.
-- What the Query Does:
-- The query groups all rows in the student table by the name column and then counts the number of age values for each distinct name.

-- Example:
-- Assume you have the following data in the student table:

-- name	age
-- Alice	20
-- Alice	21
-- Bob	22
-- Bob	22
-- Bob	23
-- The query will produce the following result:

-- name	COUNT(age)
-- Alice	2
-- Bob	3
-- Explanation:

-- For Alice, there are 2 records, so COUNT(age) is 2.
-- For Bob, there are 3 records, so COUNT(age) is 3.


    

-- HAVING CLAUSE
-- this gives us names of students and and age count of those who are older than or equal to 22
SELECT name, count(age) FROM student GROUP BY name HAVING max(age) >= 22;

-- turning off the safe mode in MYSQL workbench
SET sql_safe_updates = 0;

-- UPDATE Age BY ONE
UPDATE student SET age = age + 1;
SELECT age FROM student;

-- DELETION
INSERT INTO student VALUES ( 7, "Akash",31), ( 8, "Riya",34);
--            below one is good practise                   --
INSERT INTO student (id,name,age) VALUES ( 7, "Akash",31), ( 8, "Riya",34);
--      Now lets delete these above two
DELETE FROM student Where name = "Akash" OR name = "Riya";
--   SEE if they are deleted or not - HOGYA !!
SELECT * FROM student;

-- Foreign key concept -- let's create two table to demonstrate that 
 CREATE TABLE department(
 id INT PRIMARY KEY,
 name VARCHAR(50)
 );
 
 CREATE TABLE teacher(
 id INT PRIMARY KEY,
 name VARCHAR(50),
 dept_id INT NOT NULL,
 -- syntax for creating a foreign key
 FOREIGN KEY (dept_id) REFERENCES department(id)
 );
 
 -- ALTER FUNCTIONALITIES
 -- 1. ADD column 
 ALTER TABLE student ADD COLUMN marks INT NOT NULL;
 SELECT * FROM student;
 
 -- 2. DROP(delete kardeta us attribute ko) column 
 ALTER TABLE student DROP marks;
 SELECT * FROM student;
 
 -- 3. RENAME table too
 ALTER TABLE student RENAME students_table;
 SELECT * FROM students_table;
 -- convert back to earlier one
  ALTER TABLE students_table RENAME student;
 
 -- 4. TRUNCATE - Delete entire table data not the table
-- example table to delete
CREATE TABLE customer_table(
id INT NOT NULL,
name VARCHAR(50),
age INT 
);
 SELECT * FROM customer_table;
 TRUNCATE TABLE customer_table;
 SELECT * FROM customer_table;

 -- JOINS - Combine rows from mltiple table based on the related coulmn
 
 -- Class table
 
  CREATE TABLE class(
  id INT PRIMARY KEY,
  name VARCHAR(50)
  );
  INSERT INTO class (id,name) VALUES (101,"adam"),(102,"bob"),(103,"caesy");
  
  SELECT * FROM class;

  -- Course table
  
  CREATE TABLE course(
  id INT PRIMARY KEY,
  name VARCHAR(50)
  );
  INSERT INTO course (id,name) VALUES 
  (102,"English"),(105,"Math"),(103,"Science"),(107,"Computer Science");
  
  SELECT * FROM course;
  
-- NOW let's create a join of both of them (*) -> ALL

 -- INNER JOIN --
SELECT * FROM class INNER JOIN course ON class.id = course.id;

-- LEFT JOIN  ===> which one is written first complete part uska and matching part of the second table                     --
SELECT * FROM class as cl LEFT JOIN course AS co ON cl.id = co.id;

-- RIGHT JOIN  ===> which one is written first uska matching part and complete part of the second table                       --
SELECT * FROM class as cl RIGHT JOIN course AS co ON cl.id = co.id;

-- FULL JOIN ==> No full join query exist in mysql but its done indirectly
-- HOW ? ( We do the UNION of left and right join of both table )

-- UNION gives us only unique data

SELECT * FROM class as cl LEFT JOIN course as co ON cl.id = co.id
-- as => alias
UNION
SELECT * FROM class as cl RIGHT JOIN course as co ON cl.id = co.id;

-- SELF JOIN => Basically done on table merges its data to itself

-- SQL subqueries - IMPORTANT nester queries 
-- mostly used in WHERE CLAUSE

UPDATE student SET marks = 78 WHERE name = "Madhav";
UPDATE student SET marks = 98 WHERE name = "Ashu";
UPDATE student SET marks = 75 WHERE name = "Darshan";
UPDATE student SET marks = 95 WHERE name = "Anant";
UPDATE student SET marks = 89 WHERE name = "Gaurav";
UPDATE student SET marks = 90 WHERE name = "Rahul";

-- upar waalon ko is trh bhi likh sakte using case and then 

-- UPDATE student
-- SET marks = CASE 
     -- WHEN name = 'Madhav' THEN 78
    -- WHEN name = 'Ashu' THEN 98
    -- WHEN name = 'Darshan' THEN 75
    -- WHEN name = 'Anant' THEN 95
    -- WHEN name = 'Gaurav' THEN 89
    -- WHEN name = 'Rahul' THEN 90
    -- ELSE marks
-- END
-- WHERE name IN ('Madhav', 'Ashu', 'Darshan', 'Anant', 'Gaurav', 'Rahul');

SELECT * FROM student;
-- NOW subqueries example
-- take out all students marks who has more than the Avg
SELECT AVG(marks) FROM student;
SELECT * From student WHERE marks > ( SELECT AVG(marks) FROM student);

-- Take out students having even ids
-- Can use "=" place of IN
SELECT name, id From student WHERE id IN (SELECT id WHERE id % 2 = 0);


-- LIKE in Where clause 
The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.
There are two wildcards often used in conjunction with the LIKE operator:
- The percent sign (%) represents zero, one, or multiple characters
- The underscore sign (_) represents one, single character

Example: SELECT * FROM employees WHERE first_name LIKE 'J%';
WHERE CustomerName LIKE 'a%'
- Finds any values that start with "a"
WHERE CustomerName LIKE '%a'
- Finds any values that end with "a"
WHERE CustomerName LIKE '%or%'
- Finds any values that have "or" in any position
WHERE CustomerName LIKE '_r%'
- Finds any values that have "r" in the second position

WHERE CustomerName LIKE 'a_%'
- Finds any values that start with "a" and are at least 2 characters in length
WHERE CustomerName LIKE 'a__%'
- Finds any values that start with "a" and are at least 3 characters in length
WHERE ContactName LIKE 'a%o'
- Finds any values that start with "a" and ends with "o"

