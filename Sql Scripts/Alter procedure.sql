USE [BI_PWC]
GO
/****** Object:  StoredProcedure [dbo].[Emails]    Script Date: 2018-08-28 13:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [rpa].[usp_GetEmployeeIdentificationData]  @Id VARCHAR(10)  
AS
--DECLARE @Id2 VARCHAR(10) 
--SET @Id = '34958'   
SELECT D.[AnstNr]
      ,[FNamn]
      ,[ENamn]
      ,D.[Active]
      ,[Epost] AS 'Epost i DimMedarb'
	  ,p.[Email] AS 'Email i FIM Person '
      ,p.[IntlEmail] AS 'INTEmail i FIM Person '
      ,[AvgDatum]
      ,[Kundansvarig]
	  ,[DomainEmployeeNr]
      ,[PrimaryAttestNr]
      ,D.[GUID]
	  ,H.[EmployeeID]
      ,H.[DisplayName]
      ,H.[PersonStatus]
      ,H.[FirstName]
      ,H.[LastName]
	  ,F.FactMedarbetareSK 
	  ,F.Prev_FactMedarbetareSK 
	  ,F.RunDateSk   
	  ,F.AnstFormSk  
	  ,F.Prev_AnstFormSk 
	  ,F.FranvaroOrsakSk 
	  ,F.Prev_FranvaroOrsakSk 
	  ,F.AvgangsOrsakSk 
	  ,F.OrganisationSK 
	  ,F.Prev_OrganisationSK 
	  ,F.Prev_LKL_OrganisationSK 
	  ,F.MedarbSK    
	  ,F.GradeSk     
	  ,F.Prev_GradeSk 
	  ,F.BirthDateSk 
	  ,F.AvgangsDateSk 
	  ,F.KoncernAnställningsdateSk 
	  ,F.AktivAnst   
	  ,F.Slutat      
	  ,F.Anstnr     
	  ,F.Förnamn                        
	  ,F.Efternamn                      
	  ,F.PersonNr     
	  ,F.AgeSk       
	  ,F.Balansresultatenhet 
	  ,F.Plats        
	  ,F.Resultatenhet 
	  ,F.Admin_befattning 
	  ,F.KA   
	  ,F.Titel 
	  ,F.Avgångsdatum            
	  ,F.Företagsnummer 
	  ,F.Grade  
	  ,F.Prev_Grade 
	  ,F.Gender 
	  ,F.Avgångsorsak 
	  ,F.Anställningsdatum       
	  ,F.Koncernanställningsdatum 
	  ,F.Befattningskod 
	  ,F.Anställningsform 
	  ,F.AnstStatus 
	  ,F.LongText                                                     
	  ,F.KortText        
	  ,F.Direkttelefon        
	  ,F.Mobiltelefon         
	  ,F.Aktiv 
	  ,F.Avställningskod 
	  ,F.Huvudanställning 
	  ,F.Anställningskategori 
	  ,F.Faxtel               
	  ,F.lägenhetsnummer 
	  ,F.LöneArt 
	  ,F.Created                 
	  ,F.Modified                
	  ,F.RV                 
	  ,F.Active 
	  ,F.Period      
	  ,F.IBPeriod    
	  ,F.L_Roll2Id                                          
	  ,F.L_Roll3Id                                          
	  ,F.L_Roll4Id                                          
	  ,F.L_Roll5Id                                          
	  ,F.K_Roll2Id                                          
	  ,F.K_Roll3Id                                          
	  ,F.K_Roll4Id                                          
	  ,F.L_Roll2Namn                                        
	  ,F.L_Roll3Namn                                        
	  ,F.L_Roll4Namn                                        
	  ,F.L_Roll5Namn                                        
	  ,F.K_Roll2Namn                                        
	  ,F.K_Roll3Namn                                        
	  ,F.K_Roll4Namn                                        
	  ,F.L_Roll2Namn_LKL                                    
	  ,F.L_Roll3Namn_LKL                                    
	  ,F.L_Roll4Namn_LKL                                    
	  ,F.L_Roll5Namn_LKL                                    
	  ,F.K_Roll2Namn_LKL                                    
	  ,F.K_Roll3Namn_LKL                                    
	  ,F.K_Roll4Namn_LKL                                    
	  ,F.FyIb  ChargeableSk
 
  FROM [BI_PWC].[fin].[DimMedarb] AS D
  INNER JOIN [SE-STOSQL010\FIM].[IamDb].[FIM].[Person] AS P
  ON D.[AnstNr] collate database_default = P.[EmployeeId] collate database_default
  INNER JOIN [SE-STOSQL010\FIM].[IamDb].[FIM].[History] AS H
  ON D.[AnstNr] collate database_default = H.[EmployeeId] collate database_default
  LEFT OUTER JOIN [BI_PWC].[fin].[FactMedarbetare_Historik] AS F
  ON D.[AnstNr]  = F.Anstnr 
  WHERE D.[AnstNr] = @Id

 

    
   



  


