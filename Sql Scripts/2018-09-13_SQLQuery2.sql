
WITH
MintabellCTE ( UtfallRanking, konto, kontoGrupp, Utfall, R�kneskaps�r)
AS
(SELECT DISTINCT rank() over(PARTITION BY FR.R�kenskaps�r order by fr.utfall desc), DK.KontoNamn, DK.KontoGruppIT_Name, FR.Utfall, FR.R�kenskaps�r
FROM   (SELECT TOP (0.1) PERCENT * FROM Qlik.vu_FAB_FactResultat) AS FR  INNER JOIN
             Qlik.vu_FAB_DimKonto AS DK INNER JOIN
             Qlik.vu_FAB_DimOrganisation AS DO ON DK.F�retagNr = DO.F�retagNr ON FR.KontoNr = DK.KontoNr)


SELECT UtfallRanking, konto, kontoGrupp, Utfall, R�kneskaps�r
FROM MintabellCTE
Order by UtfallRanking


;