
WITH
MintabellCTE ( UtfallRanking, konto, kontoGrupp, Utfall, Räkneskapsår)
AS
(SELECT DISTINCT rank() over(PARTITION BY FR.Räkenskapsår order by fr.utfall desc), DK.KontoNamn, DK.KontoGruppIT_Name, FR.Utfall, FR.Räkenskapsår
FROM   (SELECT TOP (0.1) PERCENT * FROM Qlik.vu_FAB_FactResultat) AS FR  INNER JOIN
             Qlik.vu_FAB_DimKonto AS DK INNER JOIN
             Qlik.vu_FAB_DimOrganisation AS DO ON DK.FöretagNr = DO.FöretagNr ON FR.KontoNr = DK.KontoNr)


SELECT UtfallRanking, konto, kontoGrupp, Utfall, Räkneskapsår
FROM MintabellCTE
Order by UtfallRanking


;