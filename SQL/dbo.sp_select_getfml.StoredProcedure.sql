/****** Object:  StoredProcedure [dbo].[sp_select_getfml]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_getfml]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_getfml]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_select_getfml] 

@cocde	nvarchar(10),
@fmlopt	nvarchar(10)

AS

BEGIN

	select 
		yfi_fml 
	from syfmlinf
	where yfi_fmlopt = @fmlopt

END


GO
GRANT EXECUTE ON [dbo].[sp_select_getfml] TO [ERPUSER] AS [dbo]
GO
