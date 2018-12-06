/****** Script for SelectTopNRows command from SSMS  ******/
Select * From [Test].[dbo].[NewTable]

go


DELETE FROM [Test].[dbo].[NewTable]
WHERE ID =
		(
			SELECT ID
			FROM
			(
				SELECT 
					*,
					ROW_NUMBER() OVER (PARTITION BY  Adress , name, Test, ForingKey
						ORDER BY (SELECT NULL)) AS RowNumber
				FROM
					[Test].[dbo].[NewTable]
			)s
			WHERE RowNumber > 1
		)



		  

	
