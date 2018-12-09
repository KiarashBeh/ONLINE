USE [BI_PWC]
GO
/****** Object:  StoredProcedure [rpa].[usp_GetEmployeeIdentificationData]    Script Date: 2018-08-31 14:36:22 ******/
DECLARE @Id VARCHAR(10)
SET @Id = ''--29038'
  

--drop table audit.rpa_Stat
--create table audit.rpa_Stat (id int identity, StartTime datetime, EndTime datetime, ExecutionTime datetime,[User] nvarchar(20) default SUSER_NAME(), Inserted datetime default getdate(), Updated datetime)
--truncate table audit.rpa_Stat 




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
		[Employee ID]										= D.[AnstNr]				
		,[Personal Identification Nr in DimMedarb]			= D.[PersonNr]	
		,[First Name In DimMedarb]							= D.[FNamn]
		,[Last Name In DimMedarb]							= D.[ENamn]
		,[Last Updated In DimMedarb]						= D.[Modified]
		,[Epost i DimMedarb]								= D.[Epost]
		,[Domain Employee Nr]								= D.DomainEmployeeNr				                  
		,[Medarb GUID]										= D.[GUID]             
		,[Notes Full Name]									= Replace(Replace(Replace(D.NotesFullName,'CN=',''),'OU=',''),'O=','')                                                                        
		,[L_Roll2Namn]										= D.L_Roll2Namn                                        
		,[L_Roll3Namn]										= D.L_Roll3Namn                                        
		,[L_Roll4Namn]										= D.L_Roll4Namn                                        
		,[L_Roll5Namn]										= D.L_Roll5Namn                                        
		,[K_Roll2Namn]										= D.K_Roll2Namn                                        
		,[K_Roll3Namn]										= D.K_Roll3Namn                                        
		,[K_Roll4Namn]										= D.K_Roll4Namn
		,[Office Phone in DimMedarb]						= D.[OfficePhone]
		,[Mobile Phone in DimMedarb]						= D.[MobilePhone]
		 
		 ,[Employee ID in FIM]								= P.[EmployeeId]
		,[GUID in FIM]										= P.[GUID]		
		,[First Name in FIM]								= P.[FirstName]
		,[Middle Name in FIM]								= P.[MiddleName]
		,[Last Name in FIM]									= P.[LastName]
		,[Full Name in FIM]									= P.[DisplayName]
		,[NotesFullName in FIM]								= Replace(Replace(Replace(P.[NotesFullName],'CN=',''),'OU=',''),'O=','')  
		,[Mobile Phone in FIM]								= P.[MobilePhone]
		,[Office Phone in FIM]								= P.[OfficePhone]
		,[Location Phone in FIM]							= P.[LocationPhone]
		,[Email in FIM]										= P.[Email]							
		,[INTEmail in FIM]									= P.[IntlEmail]      
		,[Office Fax in FIM]								= P.[OfficeFax]
		,[Location Fax in FIM]								= P.[LocationFax]
		,[Office Location in FIM]							= P.[OfficeLocation]                                                   
		,[Postal Address in FIM]							= P.[PostalAddress]
		,[Company in FIM]									= P.Company
		,[Manager in FIM]									= P.Manager 
		,[Notes Certificate Name in FIM]					= P.NotesCertificateName 							
			                
		,[Employee ID in FIM History]						= H.[EmployeeID]   
		,[DisplayName in FIM History]						= H.[DisplayName]                                   
		,[FirstName in FIM History]							= H.[FirstName]                                                        
		,[LastName in FIM History]							= H.[LastName]                                                                             
		,[Notes in FIM History]								= H.[NotesCA]                     
		,[City in FIM History]								= H.[City]
		,[Person Status in FIM History]						= H.[PersonStatus]
		,[Employee Type in FIM History]						= H.[EmployeeType]                                                                                          
		,[Department in FIM History] 						= H.[Department]
		,[Office Location in FIM History]					= H.[OfficeLocation]
		--,[Valid to in FIM History]							= H.[ValidTo] 
														
		--,[Last Name In Medarbetare Historik]				= F.Efternamn
		--,[Personal Identification Nr in Medarbetare Historik]	= F.[PersonNr]
		--,[Mobile Phone in Medarbetare Historik]				= F.[Mobiltelefon]
		--,[Location Phone in Medarbetare Historik]			= F.[Direkttelefon]
 
	FROM [BI_PWC].[fin].[DimMedarb] AS D 
	INNER JOIN [SE-STOSQL010\FIM].[IamDb].[FIM].[Person] AS P
	ON D.[AnstNr] collate database_default = P.[EmployeeId] collate database_default
	--INNER JOIN (	SELECT --TOP(1)
	--					*
	--				FROM [SE-STOSQL010\FIM].[IamDb].[FIM].[History] 
	--				Where EmployeeId collate database_default IN (SELECT * FROM @IdList) 
	--				--ORDER BY ValidTo 
	--				) AS H
	--ON D.[AnstNr] collate database_default = H.[EmployeeId] collate database_default
	--LEFT OUTER JOIN (
	--					SELECT 	DISTINCT			
	--						[Anstnr]			=  [Anstnr]
	--						,[Förnamn]			= [Förnamn]
	--						,[Efternamn]		= [Efternamn]                     
	--						,[PersonNr]			= [PersonNr]
	--					--	,[Plats]			= [Plats]      
	--						,[Direkttelefon]	= [Direkttelefon]       
	--						,[Mobiltelefon]		= [Mobiltelefon]                
	--					FROM [BI_PWC].[fin].[FactMedarbetare_Historik]
	--					WHERE Anstnr IN (SELECT * FROM @IdList)  ) AS F
	--ON F.Anstnr = D.AnstNr
	WHERE D.Anstnr IN (SELECT * FROM @IdList) 
	--Order by H.ValidTo DESC
    


/*

select
*
from audit.rpa_Stat

*/

  


