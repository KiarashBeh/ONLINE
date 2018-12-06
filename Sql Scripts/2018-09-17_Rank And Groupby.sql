WITH
MintabellCTE ( UtfallRanking, konto, kontoGrupp, Utfall, R�kneskaps�r)
AS
(SELECT DISTINCT DENSE_RANK() over(PARTITION BY FR.R�kenskaps�r order by fr.TotUtfall desc), DK.KontoNamn, DK.KontoGruppIT_Name, FR.TotUtfall, FR.R�kenskaps�r
FROM   (SELECT 
KontoNr, R�kenskaps�r, Sum(utfall*-1) As 'TotUtfall' 
FROM Qlik.vu_FAB_FactResultat 
Group by KontoNr, R�kenskaps�r) AS FR  LEFT OUTER JOIN
             Qlik.vu_FAB_DimKonto AS DK LEFT OUTER JOIN
             Qlik.vu_FAB_DimOrganisation AS DO ON DK.F�retagNr = DO.F�retagNr ON FR.KontoNr = DK.KontoNr)


SELECT UtfallRanking, konto, kontoGrupp, Utfall, R�kneskaps�r
FROM MintabellCTE
WHERE UtfallRanking < 6 AND R�kneskaps�r > '2014'
Order by  R�kneskaps�r desc, UtfallRanking asc


go
With
MintabellCTE2 (  konto, kontoGrupp, Utfall, R�kneskaps�r)
AS
(SELECT distinct DK.KontoNamn, DK.KontoGruppIT_Name, FR.TotUtfall, FR.R�kenskaps�r
FROM   (SELECT 
KontoNr, R�kenskaps�r, SUM(utfall*-1) As 'TotUtfall' 
FROM Qlik.vu_FAB_FactResultat 
Group by KontoNr, R�kenskaps�r
) AS FR  LEFT OUTER JOIN
             Qlik.vu_FAB_DimKonto AS DK LEFT OUTER JOIN
             Qlik.vu_FAB_DimOrganisation AS DO ON DK.F�retagNr = DO.F�retagNr ON FR.KontoNr = DK.KontoNr
)

SELECT  konto, kontoGrupp, SUM(Utfall) AS Utfall, R�kneskaps�r
FROM MintabellCTE2
WHERE  R�kneskaps�r > '2014'
GROUP BY  konto, kontoGrupp, R�kneskaps�r
Order by  R�kneskaps�r desc, Utfall desc


