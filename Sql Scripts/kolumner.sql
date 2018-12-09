--select
--*
--from audit.rpa_Stat

	

/*
SELECT
	AnstNr
	,FNamn                          
	,ENamn                        
	,Modified AS 'LastUpdated'                           
	,BirthDate                                                      
	,Epost                                                         
	,DomainEmployeeNr				                  
	,GUID             
	,NotesFullName                                                                         
	,L_Roll2Namn                                        
	,L_Roll3Namn                                        
	,L_Roll4Namn                                        
	,L_Roll5Namn                                        
	,K_Roll2Namn                                        
	,K_Roll3Namn                                        
	,K_Roll4Namn                                            -- MobilePhone      OfficePhone      OfficeFax        AnstStatus      
FROM [BI_PWC].[fin].[DimMedarb] 
Where AnstNr='29038'  
*/

/*

SELECT DISTINCT 
	EmployeeId 
	,GUID                         
	,FirstName                      
	,MiddleName                     
	,LastName                       
	,DisplayName                                                                                                  
	,NotesFullName                                                  -- MobilePhone      OfficePhone      OfficeFax                
	,Email                                                            
	,IntlEmail                                                         --LocationPhone    LocationFax      
	,Company
	,Manager 
	,NotesCertificateName 
FROM [SE-STOSQL010\FIM].[IamDb].[FIM].[Person] 
Where EmployeeId='29038'

*/


/*

SELECT DISTINCT 
	EmployeeID   
	,DisplayName                                    
	,FirstName                                                        
	,LastName                                                                             
	,NotesCA                     
	,City
FROM [SE-STOSQL010\FIM].[IamDb].[FIM].[History] 
Where EmployeeId='29038'

*/
                                 


/*

SELECT DISTINCT 
	Anstnr
	,Förnamn                        
	,Efternamn  
FROM [BI_PWC].[fin].[FactMedarbetare_Historik] 
Where AnstNr='29038'

*/

          