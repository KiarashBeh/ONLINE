USE BI_PWC
GO

Alter proc dbo.sp_Kiarash_test
as

WITH
MintabellCTE ( UtfallRanking, konto, kontoGrupp, Utfall, Räkneskapsår)
AS
(SELECT DISTINCT DENSE_RANK() over(PARTITION BY FR.Räkenskapsår order by fr.TotUtfall desc), DK.KontoNamn, DK.KontoGruppIT_Name, FR.TotUtfall, FR.Räkenskapsår
FROM   (SELECT 
KontoNr, Räkenskapsår, Sum(utfall*-1) As 'TotUtfall' 
FROM Qlik.vu_FAB_FactResultat 
Group by KontoNr, Räkenskapsår) AS FR  INNER JOIN
             Qlik.vu_FAB_DimKonto AS DK INNER JOIN
             Qlik.vu_FAB_DimOrganisation AS DO ON DK.FöretagNr = DO.FöretagNr ON FR.KontoNr = DK.KontoNr)


SELECT UtfallRanking, konto, kontoGrupp, Utfall, Räkneskapsår
FROM MintabellCTE
WHERE UtfallRanking < 6 AND Räkneskapsår > '2014'
Order by  Räkneskapsår desc, UtfallRanking asc



--SELECT 
--KontoNr, Räkenskapsår, Sum(utfall) As 'TotUtfall' 
--FROM Qlik.vu_FAB_FactResultat 
--Group by KontoNr, Räkenskapsår
--Order by KontoNr, Räkenskapsår