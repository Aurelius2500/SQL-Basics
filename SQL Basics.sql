-- SQL Basics with SQL Server
-- SQL stands for Structured Query Language, it is a scripting language that can be used to communicate with databases
-- The query below creates the table that we will use during this exercise
-- For now, we will not focus on how to create tables, as most likely, data will be facilitated
CREATE TABLE Houses (
Street VARCHAR(200),
[State] VARCHAR(200),
Price INT,
Price_Date DATE,
Years_since_construction INT
);

-- The query below populates the table by inserting records
-- We have the following columns:
-- Street is the address of the house
-- State is the U.S State in which the house is located
-- Price is the current listed price of the house
-- Price_Date is when the price was retrieved
-- Years_since_construction is how many years have passed since the house was built
INSERT INTO Houses (Street, [State], Price, Price_Date, Years_since_construction)
VALUES ('240 Main Street', 'CA', 1900000, '2019-01-01', 18), 
('140 Maple Street', 'GA', 1300000, '2021-01-01', 5),
('555 New Way', 'TX', 1100000, '2017-01-01', 12),
('14 Paradise Street', 'MO', 700000, '2020-01-01', 30),
('123 School Street', 'MI', 400000, '2019-01-01', 18),
('70 Smith Way', 'VA', 1500000, '2012-07-10', 12),
('230 Valley Way', 'TX', 1200000, '2007-02-08', 2),
('23 King Drive', 'CA', 3300000, '2022-04-08', 5),
('12 Felicity Way', 'RI', 2200000, '2017-04-12', 1),
('34 Hollow Drive', 'FL', 1950000, '2019-05-29', 2);

-- The most basic form of any SQL query is selecting all the rows and records from a given table
SELECT *
FROM test_database.dbo.Houses

-- Our ten records will be returned in the results below
-- We can limit our query to return specific columns, instead of the whole table, for example, we might be interested on retrieving just the prices and years since construction
-- Instead of using the *, that will always return all the columns in the table
SELECT Price, Years_since_construction
FROM test_database.dbo.Houses

-- We have a list of the ten houses again, but just the prices and years since construction
-- One of the biggest advantages of SQL is that it allows us to write scripts that we can reuse later, for example, we can filter houses that are less than 10 years old with the WHERE clause
SELECT Price, Years_since_construction
FROM test_database.dbo.Houses
WHERE Years_since_construction < 10

-- We can also perform aggregations easily using the GROUP BY clause. For example, knowing how many houses we have
SELECT COUNT(*)
FROM test_database.dbo.Houses

-- And even go ahead and create a flag that identifies if the house is less than a decade old with CASE WHEN
SELECT *,
CASE WHEN Years_since_construction > 10
THEN 'Yes'
ELSE 'No'
END AS [New_House?] 
FROM test_database.dbo.Houses

-- We can use this derived field to get the number of houses in each category
SELECT COUNT(Street), [New_House?]
FROM 
	(SELECT *,
	CASE WHEN Years_since_construction > 10
	THEN 'Yes'
	ELSE 'No'
	END AS [New_House?] 
	FROM test_database.dbo.Houses) house_data
GROUP BY [New_House?]

-- These are just small examples of operations that can be achieved with SQL, to finish this, we can also drop the table
DROP TABLE test_database.dbo.Houses