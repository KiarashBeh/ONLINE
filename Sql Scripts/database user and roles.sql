IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'Qlik_PROD') CREATE USER [Qlik_Dev] WITH DEFAULT_SCHEMA = [aura];

IF NOT EXISTS (SELECT default_schema_name FROM sys.database_principals WHERE name = 'TRITONPROD') CREATE USER [TRITONPROD] WITH DEFAULT_SCHEMA = [aura];

SELECT * FROM sys.database_principals WHERE name IN ('Qlik_DEV','TRITONDEV')


exec BI_PWC_Raw..sp_addrolemember 'db_owner','dbo';

exec BI_PWC_Raw..sp_addrolemember 'db_owner','SalesForceApplication';

SELECT name, database_id, is_read_only, collation_name, compatibility_level  
FROM sys.databases WHERE name = 'BI_PWC_Raw';




SELECT DP1.name AS DatabaseRoleName, 
   isnull (DP2.name, 'No members') AS DatabaseUserName   
 FROM sys.database_role_members AS DRM  
 RIGHT OUTER JOIN sys.database_principals AS DP1  
   ON DRM.role_principal_id = DP1.principal_id  
 LEFT OUTER JOIN sys.database_principals AS DP2  
   ON DRM.member_principal_id = DP2.principal_id  
WHERE DP1.type = 'R'
ORDER BY DP1.name;

SELECT * FROM sys.database_principals WHERE name = 'Qlik_DEV'
SELECT * FROM sys.sql_logins
WHERE name = 'Qlik_DEV' 