WITH
MintabellCTE ( UtfallRanking, konto, kontoGrupp, Utfall, Räkneskapsår)
AS
(SELECT DISTINCT DENSE_RANK() over(PARTITION BY FR.Räkenskapsår order by fr.TotUtfall desc), DK.KontoNamn, DK.KontoGruppIT_Name, FR.TotUtfall, FR.Räkenskapsår
FROM   (SELECT 
KontoNr, Räkenskapsår, Sum(utfall*-1) As 'TotUtfall' 
FROM Qlik.vu_FAB_FactResultat 
Group by KontoNr, Räkenskapsår) AS FR  LEFT OUTER JOIN
             Qlik.vu_FAB_DimKonto AS DK LEFT OUTER JOIN
             Qlik.vu_FAB_DimOrganisation AS DO ON DK.FöretagNr = DO.FöretagNr ON FR.KontoNr = DK.KontoNr)


SELECT UtfallRanking, konto, kontoGrupp, Utfall, Räkneskapsår
FROM MintabellCTE
WHERE UtfallRanking < 6 AND Räkneskapsår > '2014'
Order by  Räkneskapsår desc, UtfallRanking asc


go
With
MintabellCTE2 (  konto, kontoGrupp, Utfall, Räkneskapsår)
AS
(SELECT distinct DK.KontoNamn, DK.KontoGruppIT_Name, FR.TotUtfall, FR.Räkenskapsår
FROM   (SELECT 
KontoNr, Räkenskapsår, SUM(utfall*-1) As 'TotUtfall' 
FROM Qlik.vu_FAB_FactResultat 
Group by KontoNr, Räkenskapsår
) AS FR  LEFT OUTER JOIN
             Qlik.vu_FAB_DimKonto AS DK LEFT OUTER JOIN
             Qlik.vu_FAB_DimOrganisation AS DO ON DK.FöretagNr = DO.FöretagNr ON FR.KontoNr = DK.KontoNr
)

SELECT  konto, kontoGrupp, SUM(Utfall) AS Utfall, Räkneskapsår
FROM MintabellCTE2
WHERE  Räkneskapsår > '2014'
GROUP BY  konto, kontoGrupp, Räkneskapsår
Order by  Räkneskapsår desc, Utfall desc


