use msdb;
go
-------------- steg ---------------  1 -------------------

exec msdb.dbo.TC_pGenerate_DB_User_Permissions_v4 'BI_PWC_Forecast';

if exists(select 1 from sys.sysprocesses where  DB_NAME(dbid) = 'BI_PWC_Forecast')
BEGIN
exec msdb..TC_pKill_DB_Sessions  @databaseName=  'BI_PWC_Forecast'
END

-------------- steg ---------------  2 -------------------


exec msdb.dbo.pTC_Restore_Database_From_Prod_v4  @database_name = N'BI_PWC_Forecast' 


-------------- steg ---------------  3 -------------------
use [BI_PWC_Forecast];   
GO
----1----- restore exported  permissions --------

--DROP USER [SEPWC\23360];
--go
DROP USER [SEPWC\25068];
--go
--DROP USER [SEPWC\admin.23360];

/******     Script Date: 2018-11-21 15:18:48   (Ursprung: Object:  StoredProcedure [dbo].[TC_pRestore_DB_USer_Permissions_v4]) ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DECLARE @dbName nvarchar(250) = 'BI_PWC_Forecast'
set nocount on;
declare @sql nvarchar(max)
declare @step int = 1
if exists (select 1 from  msdb.dbo.TC_tGenerated_DB_USer_Permissions where dbName = @dbName )
begin
DECLARE  PermCur cursor for
select step,tSQLcmd from msdb.dbo.TC_tGenerated_DB_USer_Permissions 
where dbName = @dbName
order by step 
open PermCur
fetch next from PermCur into @step, @sql
while @@FETCH_STATUS = 0
	begin
	print @sql
	exec(@sql)
	fetch next from PermCur into @step, @sql
	end
close PermCur
deallocate PermCur
end 


----- save the current permissions in the _copy-table --------

insert  msdb.dbo.TC_tGenerated_DB_USer_Permissions_Copy ([dbName], [step],[tSQLcmd])
select [dbName], [step],[tSQLcmd]  
from  msdb.dbo.TC_tGenerated_DB_USer_Permissions 
where dbName =  'BI_PWC_Forecast' ; 



---- clear the permission table -----
truncate table msdb.dbo.TC_tGenerated_DB_USer_Permissions;

---2 ---- Orphaned_Users skript ------------
use  [BI_PWC_Forecast] ;  

	DECLARE @username VARCHAR(25)
	DECLARE GetOrphanUsers CURSOR
		FOR
			SELECT UserName = name
			FROM sysusers
			WHERE 
				issqluser = 1
				AND (sid IS NOT NULL
				AND sid <> 0x0)
				AND SUSER_SNAME(sid) IS NULL
			ORDER BY name
		OPEN GetOrphanUsers
		FETCH NEXT
		FROM GetOrphanUsers
		INTO @username
		WHILE @@FETCH_STATUS = 0
		BEGIN
		SET @username = REPLACE(REPLACE(@username,'Prod','DEV'),'forecast_DEV','forecast');  -- byter prod user till Dev user
		PRINT @username;
			IF @username='dbo'
				EXEC sp_changedbowner 'sa'
			ELSE IF  @username = 'ReportUser'
				 PRINT 'No login for This user'
			ELSE
				EXEC sp_change_users_login 'update_one', @username, @username
			FETCH NEXT
			FROM GetOrphanUsers
			INTO @username
		END
	 CLOSE GetOrphanUsers
	 DEALLOCATE GetOrphanUsers

	--Tar bort Users som kommer med från Produktions backup som inte har ett Login
 	declare @tmpOrphanUsers as table(UserName sysname, UserSID varbinary(85))
	declare @sql2 varchar(200)

	insert into @tmpOrphanUsers
	exec sp_change_users_login 'report'
	
	while (select count(1) from @tmpOrphanUsers) > 0
	begin
		select top 1 @UserName = UserName from @tmpOrphanUsers
		set @sql2 = 'DROP USER ' + @UserName
		exec (@sql2)
		delete @tmpOrphanUsers where UserName = @UserName
	END

