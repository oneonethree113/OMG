/****** Object:  StoredProcedure [dbo].[sp_physical_delete_CUBASINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_CUBASINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_CUBASINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 28/07/2003


/************************************************************************
Author:		Kath Ng     
Date:		13th September, 2001
Description:	Physical Delete CUBASINF data
Parameter:	1. Company Code range    
		2. Customer Code range    
************************************************************************/

CREATE PROCEDURE [dbo].[sp_physical_delete_CUBASINF] 

@cbi_cocde nvarchar(6),
@cbi_cusno nvarchar(6)

AS

delete from CUBASINF
where 	
--	cbi_cocde = @cbi_cocde and 
	cbi_cusno = @cbi_cusno







GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_CUBASINF] TO [ERPUSER] AS [dbo]
GO
