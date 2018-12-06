use BI_PWC
go
Alter proc dbo.sp_Kiarash_test
as
SELECT TOP (5) rank() over(order by fr.utfall desc) as Rn, DO.KostnadsställeNamn, DO.Firma, DK.KontoNamn, DK.KontoGruppIT_Name, FR.Utfall, FR.Räkenskapsår
FROM   Qlik.vu_FAB_FactResultat AS FR INNER JOIN
             Qlik.vu_FAB_DimKonto AS DK INNER JOIN
             Qlik.vu_FAB_DimOrganisation AS DO ON DK.FöretagNr = DO.FöretagNr ON FR.KontoNr = DK.KontoNr
WHERE EXISTS
                 (SELECT TOP (0.1) PERCENT Ftg
                 FROM    Qlik.vu_FAB_FactResultat)

--Labb 1
--		Cte
--och recursive cte
--LAbb2
/*GROUP BY {
      column-expression  
    | ROLLUP ( <group_by_expression> [ ,...n ] )  
    | CUBE ( <group_by_expression> [ ,...n ] )  
    | GROUPING SETS ( <grouping_set> [ ,...n ]  )  
	
	Labb 3
	--Rank
	--Ntile
	--Dense

	Labb 4
	outer/cross Apply
	*/go
	exec dbo.sp_Kiarash_test

	create table #tmp (id int identity(1,1), test varchar(10))
	/* ROW_NUMBER(), RANK(), NTILE() etc. */
	insert into #tmp(test)
	select 'test'

	;with cte
	as
	(
	select test from #tmp
	)
	update c
	set test = 'Ny test2'
	from
	cte c

	select
	*
	from #tmp t1
	join (
	select * from #tmp
	) t2
	on 1=1

	;with cte (ett, lev)
	as
	(
	select 1 as ett, 0 as lev
	union all
	select 2 as ett, lev + 1
	from cte
	where ett <10
	)
	select *
	--from 
	--(
	--select 1 as ett
	--) m
	from cte c
		where ett <10
	--on 1=1 

