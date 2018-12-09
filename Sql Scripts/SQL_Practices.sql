-- /* Skapa tabeller */
--CREATE TABLE TestTable(
--PrimaryKey	INT				IDENTITY(1,1)		PRIMARY KEY,
--Test		NVARCHAR(59)
--);


--CREATE TABLE Test1 (
--TestId		INT				IDENTITY(1,1)		PRIMARY KEY,
--Name		VARCHAR(50),
--Adress		VARCHAR(50),
--ForingKey	INT				FOREIGN KEY		REFERENCES TestTable(PrimaryKey)
--);

-- /* fylla in i tabeller */
--INSERT INTO TestTable
--VALUES ( 'Test6')

--INSERT INTO Test1 
--VALUES ('Name5', 'ADRESS5' , 3);


-- /* add values to new table */
--SELECT Adress, name,  Test, ForingKey
--INTO NewTable
--From Test1 T
--Inner join TestTable AS Te
--ON T.ForingKey = Te.PrimaryKey
--WHERE TestId = 2

/* add values to existing table */
INSERT INTO NewTable
	SELECT Adress, name,  Test, ForingKey
	From Test1 T
	Inner join TestTable AS Te
	ON T.ForingKey = Te.PrimaryKey
	WHERE TestId = 4

/* Add id */
ALTER TABLE NewTable
ADD ID INT IDENTITY(1,1) PRIMARY KEY ;

-- /* Skapa uniqehet */
ALTER TABLE NewTable
ADD UNIQUE (Adress, name, Test, ForingKey);

