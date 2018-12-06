;WITH ChargeCodeRaw
AS (SELECT
        er.RoleName
      , er.Names
      , BusinessUnitName              = bu.Name
      , bu.WBSChargeCode
      , HasWBSChargeCode              = CAST(CASE WHEN bu.WBSChargeCode IS NULL THEN 0 ELSE 1 END AS bit)
      , WBSChargeCodeHasCorrectFormat = CAST(CASE
                                                 WHEN bu.WBSChargeCode LIKE '[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' THEN
                                                 1
                                                 ELSE 0
                                             END AS bit)
    FROM AuraEng_6_0.EngagementRole         AS er
        INNER JOIN AuraEng_6_0.Engagement   AS e
            ON e.EngagementId = er.EngagementId
        INNER JOIN AuraEng_6_0.BusinessUnit AS bu
            ON bu.EngagementId = e.EngagementId
    WHERE er.RoleName = 'Engagement Leader'
          AND bu.Name NOT LIKE 'Testbolag%')
SELECT
    c.RoleName
  , c.Names
  , c.BusinessUnitName
  , c.WBSChargeCode
  , c.HasWBSChargeCode
  , c.WBSChargeCodeHasCorrectFormat
  , WBSChargeCodeHasCorrectControlDigit =	 
											 (CASE
                                               WHEN c.WBSChargeCodeHasCorrectFormat = 0 THEN 0
                                               ELSE
											   (
											   CASE WHEN( 10 - (
                                               
											   CASE WHEN LEN(2 * SUBSTRING(c.WBSChargeCode, 1, 1)) >1 THEN 
											   1 * SUBSTRING(CAST (2 * SUBSTRING(c.WBSChargeCode, 1, 1) AS CHAR(2)), 1, 1) + 1 * SUBSTRING(CAST (2 * SUBSTRING(c.WBSChargeCode, 1, 1) AS CHAR(2)), 2, 1)
											   ELSE 2 * SUBSTRING(c.WBSChargeCode, 1, 1) END + SUBSTRING(c.WBSChargeCode, 2, 1) +

											   CASE WHEN LEN(2 * SUBSTRING(c.WBSChargeCode, 3, 1)) >1 THEN 
											   1 * SUBSTRING(CAST (2 * SUBSTRING(c.WBSChargeCode, 3, 1) AS CHAR(2)), 1, 1) + 1 * SUBSTRING(CAST (2 * SUBSTRING(c.WBSChargeCode, 3, 1) AS CHAR(2)), 2, 1)
											   ELSE 2 * SUBSTRING(c.WBSChargeCode, 3, 1) END + SUBSTRING(c.WBSChargeCode, 4, 1) +

											   CASE WHEN LEN(2 * SUBSTRING(c.WBSChargeCode, 5, 1)) >1 THEN 
											   1 * SUBSTRING(CAST (2 * SUBSTRING(c.WBSChargeCode, 5, 1) AS CHAR(2)), 1, 1) + 1 * SUBSTRING(CAST (2 * SUBSTRING(c.WBSChargeCode, 5, 1) AS CHAR(2)), 2, 1)
											   ELSE 2 * SUBSTRING(c.WBSChargeCode, 5, 1) END + SUBSTRING(c.WBSChargeCode, 6, 1) +

											   CASE WHEN LEN(2 * SUBSTRING(c.WBSChargeCode, 8, 1)) >1 THEN 
											   1 * SUBSTRING(CAST (2 * SUBSTRING(c.WBSChargeCode, 8, 1) AS CHAR(2)), 1, 1) + 1 * SUBSTRING(CAST (2 * SUBSTRING(c.WBSChargeCode, 8, 1) AS CHAR(2)), 2, 1)
											   ELSE 2 * SUBSTRING(c.WBSChargeCode, 8, 1) END + SUBSTRING(c.WBSChargeCode, 9, 1) +

											   CASE WHEN LEN(2 * SUBSTRING(c.WBSChargeCode, 10, 1)) >1 THEN 
											   1 * SUBSTRING(CAST (2 * SUBSTRING(c.WBSChargeCode, 10, 1) AS CHAR(2)), 1, 1) + 1 * SUBSTRING(CAST (2 * SUBSTRING(c.WBSChargeCode, 10, 1) AS CHAR(2)), 2, 1)
											   ELSE 2 * SUBSTRING(c.WBSChargeCode, 10, 1) END

												) % 10) %10

                                           
												 = 1*(SUBSTRING(c.WBSChargeCode, 11, 1)) THEN 1 ELSE 0 END) END )
                                          

FROM ChargeCodeRaw AS c;