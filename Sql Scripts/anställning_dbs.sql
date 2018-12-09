/*
SELECT CONVERT( sysname, SERVERPROPERTY('Z64TSTSQL004'));  
GO 
USE BI_PWC
*/ 

/*
CREATE PROCEDURE Emails     
AS
DECLARE @Id VARCHAR(10); 
SET @Id = '3495'   
SELECT [AnstNr]
      ,[FNamn]
      ,[ENamn]
      ,[Active]
      ,[Epost] AS 'Epost i DimMedarb'
	  ,p.[Email] AS 'Email i FIM Person '
      ,p.[IntlEmail] AS 'INTEmail i FIM Person '
      --,[AvgDatum]
      --,[Kundansvarig]
	  --,[DomainEmployeeNr]
      --,[PrimaryAttestNr]
      --,D.[GUID]
  FROM [BI_PWC].[fin].[DimMedarb] AS D
  Inner Join [SE-STOSQL010\FIM].[IamDb].[FIM].[Person] AS P
  --ON cast(D.[AnstNr] as varbinary) = cast(P.[EmployeeId] as varbinary)
  ON D.[AnstNr] collate database_default = P.[EmployeeId] collate database_default
  Where D.[AnstNr] = @Id;
*/

 
/*
  SELECT [EmployeeId]
      ,[FirstName]
      --,[MiddleName]
      ,[LastName]
      ,[GUID]
      ,[AccountName]
      ,[Email]
      ,[IntlEmail]
  FROM [SE-STOSQL010\FIM].[IamDb].[FIM].[Person]
  Where [EmployeeId] ='34958'
*/



/*
  SELECT [EmployeeID]
      ,[DisplayName]
      ,[PersonStatus]
      ,[FirstName]
      ,[LastName]
	  ,*
  FROM [SE-STOSQL010\FIM].[IamDb].[FIM].[History]
  Where [EmployeeId] ='34958'


  SELECT [Anstnr]
		,[PersonNr]
		,[Förnamn]
		,[Efternamn]
  FROM [BI_PWC].[fin].[FactMedarbetare_Historik]
  Where [Anstnr] ='34958'
  Or [PersonNr] = '8307025018'
  Or [Förnamn] = 'kiarash'
  Or [Efternamn] = 'behnam'
  */