
use msdb
go
-------------- steg ---------------  1 -------------------
exec msdb.dbo.TC_pGenerate_DB_User_Permissions_v4 'BI_PWC_Staging';

if exists(select 1 from sys.sysprocesses where  DB_NAME(dbid) = 'BI_PWC_Staging')
BEGIN
exec msdb..TC_pKill_DB_Sessions  @databaseName=  'BI_PWC_Staging'
END

-------------- steg ---------------  2 ------------------

exec msdb.dbo.pTC_Restore_Database_From_Prod_v4  @database_name = N'BI_PWC_Staging' 



-------------- steg ---------------  3 -------------------
use [BI_PWC_Staging];   
GO   

--DROP USER  [SEPWC\23360] ;
--DROP USER  [SEPWC\25068] ;
--DROP USER  [SEPWC\admin.23360];
-- DROP USER [Forecast_Prod];
-- DROP USER [BI_Reader];

----1----- restore exported  permissions --------


/******     Script Date: 2018-11-21 15:18:48   (Ursprung: Object:  StoredProcedure [dbo].[TC_pRestore_DB_USer_Permissions_v4]) ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DECLARE @dbName nvarchar(250) = 'BI_PWC_Staging'
set nocount on;
declare @sql1 nvarchar(max)
declare @step int = 1
if exists (select 1 from  msdb.dbo.TC_tGenerated_DB_USer_Permissions where dbName = @dbName )
begin
DECLARE  PermCur cursor for
select step,tSQLcmd from msdb.dbo.TC_tGenerated_DB_USer_Permissions 
where dbName = @dbName
order by step 
open PermCur
fetch next from PermCur into @step, @sql1
while @@FETCH_STATUS = 0
	begin
	--print @sql1
	exec(@sql1)
	fetch next from PermCur into @step, @sql1
	end
close PermCur
deallocate PermCur
end 

----- save the current permissions in the _copy-table --------

insert  msdb.dbo.TC_tGenerated_DB_USer_Permissions_Copy ([dbName], [step],[tSQLcmd])
select [dbName], [step],[tSQLcmd]  
from  msdb.dbo.TC_tGenerated_DB_USer_Permissions 
where dbName =  'BI_PWC_Staging' ; 

---- clear the permission table -----
truncate table msdb.dbo.TC_tGenerated_DB_USer_Permissions;



---2 ---- Orphaned_Users skript ------------
use  [BI_PWC_Staging] ;  

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
		SET @username = REPLACE(@username,'Prod','DEV');  --Byter Prod mot Dev
		SET @username = REPLACE(@username,'forecast_DEV','forecast');  --Byter Prod mot Dev
		--PRINT @username;
			IF @username='dbo'
				EXEC sp_changedbowner 'sa'
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
	declare @sql varchar(200)

	insert into @tmpOrphanUsers
	exec sp_change_users_login 'report'
	
	while (select count(1) from @tmpOrphanUsers) > 0
	begin
		select top 1 @UserName = UserName from @tmpOrphanUsers
		set @sql = 'DROP USER ' + @UserName
		exec (@sql)		
		delete @tmpOrphanUsers where UserName = @UserName
	end

-------------------------------- end ------------------------------------------
PRINT 'END'
