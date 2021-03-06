/****** Object:  StoredProcedure [dbo].[sp_physical_delete_CUPRCTRM_2]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_CUPRCTRM_2]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_CUPRCTRM_2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/************************************************************************
Author:		Frankie Cheung
Date:		01st June, 2009
Description:	Physical Delete CUPRCTRM data
Parameter:	1. Company Code range    
		2. Vendor no.
		3. Item Nature Seq.
************************************************************************/


CREATE PROCEDURE [dbo].[sp_physical_delete_CUPRCTRM_2] 

@cpt_cocde nvarchar(6),
@cpt_cusno nvarchar(6)
 

AS

BEGIN

Delete from CUPRCTRM
where 	
 	cpt_cusno = @cpt_cusno


END



GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_CUPRCTRM_2] TO [ERPUSER] AS [dbo]
GO
