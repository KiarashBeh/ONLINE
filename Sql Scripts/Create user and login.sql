
--  CREATE LOGIN [BI_Reader] FROM WINDOWS
--GO
--CREATE USER [BI_Reader] FOR LOGIN [BI_Reader]
--GO

   -------------or------------------

--CREATE LOGIN [BI_Reader] WITH PASSWORD=N'jUwcVhO99toJQK5A/CoOhgFhV/YBxu015ug1JJ3tRFM=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
--GO


--  CREATE USER [BI_Reader] FOR LOGIN [BI_Reader]
--GO
---- Database Level Permissions

--GRANT EXECUTE TO [BI_Reader]
--GRANT VIEW DEFINITION TO [BI_Reader]