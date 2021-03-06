/****** Object:  StoredProcedure [dbo].[sp_select_SHRMKVAL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SHRMKVAL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHRMKVAL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/***************************************************************************************************************************
History
***************************************************************************************************************************
Modified on		Modified by		Description
***************************************************************************************************************************
5-Aug-2014		Anthony			Create this stored procedure
****************************************************************************************************************************/

/*
*/


CREATE PROCEDURE [dbo].[sp_select_SHRMKVAL]
-- Required parameters
@my_mode varchar(2),
@my_type varchar(2),
@my_pricust varchar(6) = "",
@my_seccust varchar(6) = "",
@my_field varchar(40) = NULL

AS

DECLARE @statement nvarchar(1024)
DECLARE @where_statement varchar(512)
DECLARE @orderby varchar(40)
DECLARE @err_message nvarchar(1024)

SET @statement = 
'
SELECT
	[hrt_typ],
	[hrt_mod],
	[hrt_rmkcde],
	[hrt_rmkid],
	[hrt_rmkval],
	[hrt_rmkdsc],
	[hrt_flgdef],
	[hrt_pricustno],
	[hrt_seccustno],
	[hrt_creusr],
	[hrt_updusr],
	[hrt_credat],
	[hrt_upddat]
FROM
SHRMKVAL
'				
SET @orderby = 'ORDER BY [hrt_typ]'

IF (@my_mode = '')
	BEGIN
	IF (@my_type  = 'P')
		BEGIN
			if (@my_pricust = "")
				BEGIN
					SET @where_statement = "WHERE [hrt_typ] like 'P' "
				END
			ELSE
				BEGIN
					SET @where_statement = 
						"WHERE ([hrt_typ] like 'P' AND [hrt_pricustno] like '" + @my_pricust + "') "
				END
		END
	ELSE IF (@my_type = 'S')
		BEGIN
			IF(@my_seccust = "")
				BEGIN
					SET @where_statement = "WHERE [hrt_typ] like 'S' "
				END
			ELSE
				BEGIN
					SET @where_statement = 
						"WHERE (([hrt_typ] like 'S') AND [hrt_seccustno] like '" + @my_seccust + "') "
				END
		END
	ELSE IF (@my_type = 'G')
		BEGIN
			SET @where_statement = 
				"WHERE ([hrt_typ] like 'G') "
		END
END
ELSE IF (@my_mode = 'f')
	BEGIN
		IF (@my_field = NULL)
			BEGIN
				SET @err_message = "Missing parameters" + "[hrt_rmkdsc]"
				RAISERROR (@err_message, 11,1)
			END
	
		IF (@my_type = 'P')
			BEGIN
				SET @where_statement = 
					" WHERE [hrt_typ] like 'P'" +
					" AND [hrt_pricustno] like '" + @my_pricust +
					"' AND [hrt_rmkcde] like '" + @my_field +
					"'"
			END
		ELSE IF (@my_type = 'S')
			BEGIN
				SET @where_statement = 
				" WHERE [hrt_typ] like 'S'" +
				" AND [hrt_seccustno] like '" + @my_seccust + 
				"' AND [hrt_rmkcde] like '" + @my_field +
				"'"
			END
		ELSE IF (@my_type = 'G')
			BEGIN
				SET @where_statement = 
				" WHERE [hrt_typ] like 'G'" +
				" AND [hrt_rmkcde] like '" + @my_field +
				"'"
			END
	END

SET @statement = @statement + @where_statement + @orderby
--PRINT 'STATEMENT:' + @statement
EXEC sp_executesql @statement






GO
GRANT EXECUTE ON [dbo].[sp_select_SHRMKVAL] TO [ERPUSER] AS [dbo]
GO
