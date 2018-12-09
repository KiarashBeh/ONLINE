USE [master]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [LinjeChefensVyMember]    Script Date: 2018-11-26 10:54:18 ******/
CREATE LOGIN [LinjeChefensVyMember] WITH PASSWORD=N'UTAx6oYKjICtyheLg8uxQxZVECafcqEiL70tqPA6IIM=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

ALTER LOGIN [LinjeChefensVyMember] DISABLE
GO


CREATE USER [MyBusiness_DEV] FOR LOGIN [MyBusiness_DEV]
GO


IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'TRITONDEV') CREATE USER [TRITONDEV] FOR LOGIN [TRITONDEV] WITH DEFAULT_SCHEMA = [excel];

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Qlik_DEV') CREATE USER [Qlik_DEV] FOR LOGIN [Qlik_DEV] WITH DEFAULT_SCHEMA = [excel];