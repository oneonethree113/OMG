/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCLMTYP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYCLMTYP]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCLMTYP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/************************************************************************
Description:	delete data From SYCLMTYP
***********************************************************************
*/

CREATE procedure [dbo].[sp_physical_delete_SYCLMTYP]

@yct_cocde nvarchar(6),
@yct_cde nvarchar(20)

AS

BEGIN

delete from SYCLMTYP where yct_cocde = @yct_cocde and yct_cde = @yct_cde


END







GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYCLMTYP] TO [ERPUSER] AS [dbo]
GO
