DECLARE @Id VARCHAR(10)
--SET @Id = '8307025018'
--SET @Id = '34958'
SET @Id = ''
DECLARE @IdList table (Id VARCHAR(100))


IF		LEN(@Id) = 0
		INSERT INTO @IdList SELECT [AnstNr] FROM [BI_PWC].[fin].[DimMedarb]

ELSE IF LEN(@Id) = 5
		BEGIN
		INSERT INTO @IdList SELECT [AnstNr] FROM [BI_PWC].[fin].[DimMedarb] WHERE @Id= [AnstNr]
		END

ELSE IF LEN(@Id) = 10
		BEGIN
		INSERT INTO @IdList SELECT [AnstNr] FROM [BI_PWC].[fin].[DimMedarb] WHERE @Id= [PersonNr]
		END

ELSE SELECT 'Var vänligt och mata in rätt anställnings/Personnummer'


--Select * FROM @IdList

			SELECT DISTINCT D.[AnstNr]				AS 'Anställningsnumer'
				,D.[PersonNr]						AS 'Personnumer'
				,P.PersonalIdentificationNr			AS 'Personnumer'
				,[FNamn]							AS 'Förnamn'
				,[ENamn]							AS 'Efternamn'
				,D.[MobilePhone]
				,D.[OfficePhone]
				,D.[GUID]							AS 'GUID'
				,[Epost]							AS 'Epost i DimMedarb'
				,P.[Email]							AS 'Email i FIM Person '
				,P.[IntlEmail]						AS 'INTEmail i FIM Person '
				,P.[MobilePhone]      
				,P.[OfficePhone]      
				,P.[OfficeFax]
				,P.[OfficeLocation]                                                   
				,P.[PostalAddress]                                                    
				,P.[LocationPhone]    
				,P.[LocationFax]
				,H.[PersonStatus]
				,H.[EmployeeType]                                                                                                          
				,H.[Title]                                            
				,H.[Department]
				,H.[OfficeLocation]                                                                                                                   
				,H.[City]                             
				,H.[EmployeeStartDate]       
				,H.[EmployeeEndDate]         
				,H.[Vacation]  
				--,F.Anstnr     
				--,F.Förnamn                        
				--,F.Efternamn                      
				--,F.PersonNr 
				--,F.Plats            
				--,F.Företagsnummer 
				--,F.Gender        
				--,F.Direkttelefon        
				--,F.Mobiltelefon                
				--,F.lägenhetsnummer 
 
			FROM [BI_PWC].[fin].[DimMedarb] AS D 
			INNER JOIN [SE-STOSQL010\FIM].[IamDb].[FIM].[Person] AS P
			ON D.[AnstNr] collate database_default = P.[EmployeeId] collate database_default
			INNER JOIN [SE-STOSQL010\FIM].[IamDb].[FIM].[History] AS H
			ON D.[AnstNr] collate database_default = H.[EmployeeId] collate database_default
			--full OUTER JOIN [BI_PWC].[fin].[FactMedarbetare_Historik] AS F 
			--ON D.[AnstNr]  = F.Anstnr 
			WHERE D.Anstnr IN (SELECT * FROM @IdList) 
				

