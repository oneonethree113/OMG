/****** Object:  StoredProcedure [dbo].[sp_select_SHRMKTYP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHRMKTYP]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHRMKTYP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/***************************************************************************************************************************
History
***************************************************************************************************************************
Modified on		Modified by		Description
***************************************************************************************************************************
4-Aug-2014		Anthony			Create this stored procedure
****************************************************************************************************************************/

/*
If module is not specifed, all record search
if module is specifed, specific module record search

*/


CREATE PROCEDURE [dbo].[sp_select_SHRMKTYP]
-- Required parameters
@module varchar(20)

AS

DECLARE @statement nvarchar(256)
DECLARE @where_module varchar(256)
DECLARE @orderby varchar(40)

SET @statement = 
'
SELECT 
	[hrt_mod],
	[hrt_rmkcde],
	[hrt_rmkname],
	[hrt_rmklen]
FROM
SHRMKTYP
'
			
SET @orderby = 'ORDER BY [hrt_mod]'

--- WHERE [module] ---
IF (@module <> '')
	BEGIN
		SET @where_module = 'WHERE [hrt_mod] like ''' + @module + ''''
	END
ELSE
	BEGIN
		SET @where_module = ''
	END
--- WHERE [module] ---

SET @statement = @statement + @where_module + @orderby
PRINT 'STATEMENT:' + @statement
EXEC sp_executesql @statement







GO
GRANT EXECUTE ON [dbo].[sp_select_SHRMKTYP] TO [ERPUSER] AS [dbo]
GO
