USE BI_PWC
DECLARE @Id VARCHAR(10)
SET @Id = '8307025018'
SET @Id = '80819'
--SET @Id = ''
DECLARE @IdList table (Id VARCHAR(100))

 IF ISNUMERIC(@Id) = 1 Or @Id = ''
 BEGIN
		IF		LEN(@Id) = 0
				BEGIN
				INSERT INTO @IdList SELECT DISTINCT [AnstNr] FROM [BI_PWC].[fin].[DimMedarb]
				END

		ELSE IF LEN(@Id) = 5
				BEGIN
				INSERT INTO @IdList SELECT [AnstNr] FROM [BI_PWC].[fin].[DimMedarb] WHERE @Id= [AnstNr]
				END

		ELSE IF LEN(@Id) = 10
				BEGIN
				INSERT INTO @IdList SELECT [AnstNr] FROM [BI_PWC].[fin].[DimMedarb] WHERE @Id= [PersonNr]
				END

		ELSE SELECT 'Var vänligt och mata in rätt anställnings/Personnummer'
END

ELSE
BEGIN
		INSERT INTO @IdList SELECT DISTINCT [AnstNr] FROM [BI_PWC].[fin].[DimMedarb]
END


			SELECT DISTINCT 
				 [Employee number]						= D.[AnstNr]														COLLATE DATABASE_DEFAULT				
				,[Personal Identification Nr]			= COALESCE(P.PersonalIdentificationNr, D.[PersonNr], '-1') 			COLLATE DATABASE_DEFAULT
				,[First Name]							= [FNamn] 										COLLATE DATABASE_DEFAULT
				,[Last Name]							= COALESCE(f.Efternamn, [ENamn]) 										COLLATE DATABASE_DEFAULT						
				,[Mobile Phone]							= COALESCE(D.[MobilePhone], P.[MobilePhone]) 										COLLATE DATABASE_DEFAULT
				,[Office Phone]							= COALESCE(D.[OfficePhone], P.[OfficePhone], P.[LocationPhone]) 										COLLATE DATABASE_DEFAULT
				,[Office Fax]							= COALESCE( P.[OfficeFax], P.[LocationFax]) 										COLLATE DATABASE_DEFAULT
				,[GUID]									= D.[GUID]										COLLATE DATABASE_DEFAULT
				,[Epost i DimMedarb]					= [Epost]												COLLATE DATABASE_DEFAULT				
				,[Email i FIM Person]					= P.[Email]												COLLATE DATABASE_DEFAULT					
				,[INTEmail i FIM Person]				= P.[IntlEmail]												COLLATE DATABASE_DEFAULT			
				,[OfficeLocation]						= COALESCE(P.[OfficeLocation], H.[OfficeLocation])											COLLATE DATABASE_DEFAULT		                                   
				,[PostalAddress]						= P.[PostalAddress]											COLLATE DATABASE_DEFAULT			                                            
				,[Department]							= H.[Department]     										COLLATE DATABASE_DEFAULT                                                                                                              
				,[City]									= H.[City]										COLLATE DATABASE_DEFAULT
				,[Person Status]						= H.[PersonStatus]										COLLATE DATABASE_DEFAULT
				,[Employee Type]						= H.[EmployeeType]    										COLLATE DATABASE_DEFAULT                                                                                                      
				,[Title]								= H.[Title]        										COLLATE DATABASE_DEFAULT                     
				,[Employee Start Date]					= H.[EmployeeStartDate]   										COLLATE DATABASE_DEFAULT    
				,[Employee End Date]					= H.[EmployeeEndDate]  										COLLATE DATABASE_DEFAULT       
				,[Vacation]								= H.[Vacation]				

			FROM [BI_PWC].[fin].[DimMedarb] AS D 
			INNER JOIN [SE-STOSQL010\FIM].[IamDb].[FIM].[Person] AS P
			ON D.[AnstNr] collate database_default = P.[EmployeeId] collate database_default
			INNER JOIN [SE-STOSQL010\FIM].[IamDb].[FIM].[History] AS H
			ON D.[AnstNr] collate database_default = H.[EmployeeId] collate database_default
			WHERE D.Anstnr IN (SELECT * FROM @IdList)

			UNION ALL 

			SELECT 	DISTINCT	
				[Employee number]						= COALESCE(Anstnr, '-1')				
				,[Personal Identification Nr]			= COALESCE(PersonNr, '-1') 
				,[First Name]							= [Förnamn]
				,[Last Name]							= COALESCE(Efternamn, -1)							
				,[Mobile Phone]							= COALESCE(Mobiltelefon, -1)
				,[Office Phone]							= COALESCE(Direkttelefon, -1)
				,[Office Fax]							= ''
				,[GUID]									= ''
				,[Epost i DimMedarb]					= ''						
				,[Email i FIM Person]					= ''							
				,[INTEmail i FIM Person]				= ''					
				,[OfficeLocation]						= ''				                                   
				,[PostalAddress]						= ''			                                            
				,[Department]							= ''                                                                                                                  
				,[City]									= ''
				,[Person Status]						= AnstStatus
				,[Employee Type]						= ''                                                                                                          
				,[Title]								= ''                            
				,[Employee Start Date]					= Anställningsdatum      
				,[Employee End Date]					= ''         
				,[Vacation]								= ''			
										  								               
			FROM [BI_PWC].[fin].[FactMedarbetare_Historik]
			WHERE Anstnr IN (SELECT * FROM @IdList) 	
								 
			--ON F.Anstnr = D.AnstNr
			 
		
		--SELECT
		--*
		--FROM #TMP
		--WHERE Anställningsnumer = '10017'


		--SELECT
		--*--Anstnr, count(distinct Efternamn)
		--	from [BI_PWC].[fin].[FactMedarbetare_Historik] F
		--where Anstnr = '80819'
		--order by 1

		--select
		--h.*

		--FROM [BI_PWC].[fin].[DimMedarb] AS D 
		--	INNER JOIN [SE-STOSQL010\FIM].[IamDb].[FIM].[Person] AS P
		--	ON D.[AnstNr] collate database_default = P.[EmployeeId] collate database_default
		--	INNER JOIN [SE-STOSQL010\FIM].[IamDb].[FIM].[History] AS H
		--	ON D.[AnstNr] collate database_default = H.[EmployeeId] collate database_default
		--	where Anstnr = '80819'
		--	order by h.validfrom