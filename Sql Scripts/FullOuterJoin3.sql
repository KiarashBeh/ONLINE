
USE [BI_PWC]
GO
DECLARE @Id VARCHAR(10)
--SET @Id = '8307025018'
SET @Id = '34958'
--SET @Id = ''
--SET @Id = '10017'
--SET @Id = '80819' --Lindmark Halldén



DECLARE @IdList table (Id VARCHAR(100))

 IF ISNUMERIC(@Id) = 1 
	 BEGIN
			IF LEN(@Id) = 5
					BEGIN
					INSERT INTO @IdList SELECT [AnstNr] FROM [BI_PWC].[fin].[DimMedarb] WHERE @Id= [AnstNr]
					END

			ELSE IF LEN(@Id) = 10
					BEGIN
					INSERT INTO @IdList SELECT [AnstNr] FROM [BI_PWC].[fin].[DimMedarb] WHERE @Id= [PersonNr]
					END
	END

ELSE
	BEGIN
			INSERT INTO @IdList SELECT DISTINCT [AnstNr] FROM [BI_PWC].[fin].[DimMedarb]
	END



	SELECT DISTINCT 
		[Employee number]									= D.[AnstNr]				
		,[Personal Identification Nr in DimMedarb]			= D.[PersonNr]
		,[Personal Identification Nr in FIM]				= P.[PersonalIdentificationNr]
		,[Personal Identification Nr in Medarbetare Historik]	= F.[PersonNr]	
		,[First Name]										= [FNamn]
		,[Last Name In DimMedarb]							= [ENamn]
		,[Last Name In Medarbetare Historik]				= f.Efternamn
		,[Mobile Phone in DimMedarb]						= D.[MobilePhone]
		,[Mobile Phone in FIM]								= P.[MobilePhone]
		,[Mobile Phone in Medarbetare Historik]				= F.[Mobiltelefon]
		,[Office Phone in DimMedarb]						= D.[OfficePhone]
		,[Office Phone in FIM]								= P.[OfficePhone]
		,[Location Phone in FIM]							= P.[LocationPhone]
		,[Location Phone in Medarbetare Historik]			= F.[Direkttelefon]
		,[GUID  in FIM]										= D.[GUID]							
		,[Epost i DimMedarb]								= D.[Epost]	
		,[Email i FIM Person]								= P.[Email]							
		,[INTEmail i FIM Person]							= P.[IntlEmail]      
		,[Office Fax]										= P.[OfficeFax]
		,[Location Fax]										= P.[LocationFax]
		,[Office Location]									= P.[OfficeLocation]                                                   
		,[Postal Address]									= P.[PostalAddress]                
		--,[Person Status]									= H.[PersonStatus]
		,[Employee Type]									= H.[EmployeeType]                                                                                          
		,[Department] 										= H.[Department]
		,[Office Location]									= H.[OfficeLocation] 
 
	FROM [BI_PWC].[fin].[DimMedarb] AS D 
	INNER JOIN [SE-STOSQL010\FIM].[IamDb].[FIM].[Person] AS P
	ON D.[AnstNr] collate database_default = P.[EmployeeId] collate database_default
	INNER JOIN [SE-STOSQL010\FIM].[IamDb].[FIM].[History] AS H
	ON D.[AnstNr] collate database_default = H.[EmployeeId] collate database_default
			

	FULL OUTER JOIN (
						SELECT 	DISTINCT			
							Anstnr     
							,Förnamn                        
							,Efternamn                      
							,PersonNr 
							,Plats       
							,Direkttelefon        
							,Mobiltelefon                 
						FROM [BI_PWC].[fin].[FactMedarbetare_Historik]
						WHERE Anstnr IN (SELECT * FROM @IdList)  ) AS F
	ON F.Anstnr = D.AnstNr
	WHERE D.Anstnr IN (SELECT * FROM @IdList) 

