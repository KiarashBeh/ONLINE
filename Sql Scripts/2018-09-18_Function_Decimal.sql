ALTER Function fnMultiplicationTest
(@Para1	AS FLOAT 
, @Para2 AS FLOAT 
)
RETURNS FLOAT
AS
Begin
DECLARE @ret FLOAT
SET @ret = @Para1 * @Para2
Return @ret
END;

SELECT dbo.fnMultiplicationTest(1.8,1.8) AS RESULT