use BI_PWC_Log;
--insert into msdb.dbo.TC_tGenerated_DB_USer_Permissions(dbName,step,tSQLcmd)
SELECT db_name() dbName,
1 step, 
'IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = ' + REPLACE(QuoteName(dp.name, char(39)),'Prod','DEV') + 
') CREATE USER ' + REPLACE(QuoteName(dp.name),'Prod','DEV') + 
IsNull(' FOR LOGIN ' + REPLACE(QuoteName(sp.name),'Prod','DEV'),'') +
IsNull(' WITH DEFAULT_SCHEMA = ' + QuoteName(dp.default_schema_name),'') + ';' as tSQLcmd
FROM BI_PWC_Log.sys.database_principals dp
LEFT JOIN BI_PWC_Log.sys.server_principals sp
ON sp.sid = dp.sid
WHERE dp.type like '[GUS]';

-- List rolemember
--insert into msdb.dbo.TC_tGenerated_DB_USer_Permissions(dbName,step,tSQLcmd)
SELECT db_name() dbName,
2 step ,
'exec BI_PWC_Log..sp_addrolemember ' + '''' + (r3.name) + '''' + ',' + '''' + (r2.name) + '''' + ';'
FROM BI_PWC_Log.sys.database_role_members r1
inner join BI_PWC_Log.sys.database_principals r2
on r1.member_principal_id = r2.principal_id
inner join BI_PWC_Log.sys.database_principals r3
on r1.role_principal_id = r3.principal_id 
WHERE r2.name <> 'dbo';


--Script för lista alla rättighter satta med GRANT:

--insert into msdb.dbo.TC_tGenerated_DB_USer_Permissions(dbName,step,tSQLcmd)
SELECT  db_name() dbName,
3 step,
   CASE dp.state_desc
     WHEN 'GRANT_WITH_GRANT_OPTION' THEN 'GRANT'
     ELSE dp.state_desc 
   END 
     + ' ' + dp.permission_name + ' ON ' +
   CASE dp.class
     WHEN 0 THEN 'DATABASE::[' + DB_NAME() + ']'
     WHEN 1 THEN 'OBJECT::[' + SCHEMA_NAME(o.schema_id) + '].[' + o.[name] + ']'
     WHEN 3 THEN 'SCHEMA::[' + SCHEMA_NAME(dp.major_id) + ']'
   END 
     + ' TO [' + USER_NAME(grantee_principal_id) + ']' +
   CASE dp.state_desc
     WHEN 'GRANT_WITH_GRANT_OPTION' THEN ' WITH GRANT OPTION;'
     ELSE ';' 
   END  
   COLLATE DATABASE_DEFAULT  
FROM BI_PWC_Log.sys.database_permissions dp
  LEFT JOIN sys.all_objects o
    ON dp.major_id = o.OBJECT_ID
WHERE dp.class < 4
  AND major_id >= 0
  AND grantee_principal_id <> 1 ;
  


