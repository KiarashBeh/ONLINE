USE [BI_PWC_Raw]
--USE msdb
GO
/****** Object:  StoredProcedure [dbo].[TC_pRestore_DB_USer_Permissions_v4]    Script Date: 2018-11-21 15:18:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--ALTER proc [dbo].[TC_pRestore_DB_USer_Permissions_v4] 
DECLARE @dbName nvarchar(250) = 'BI_PWC_Raw'
--as
set nocount on;
declare @sql nvarchar(max)
declare @step int = 1
if exists (select 1 from  msdb.dbo.TC_tGenerated_DB_USer_Permissions where dbName = @dbName )
begin
declare  PermCur cursor for
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
