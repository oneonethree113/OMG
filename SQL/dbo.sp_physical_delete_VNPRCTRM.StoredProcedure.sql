/****** Object:  StoredProcedure [dbo].[sp_physical_delete_VNPRCTRM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_VNPRCTRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_VNPRCTRM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/************************************************************************
Author:		Frankie Cheung
Date:		01st June, 2009
Description:	Physical Delete VNPRCTRM data
Parameter:	1. Company Code range    
		2. Vendor no.
		3. Item Nature Seq.
************************************************************************/


CREATE PROCEDURE [dbo].[sp_physical_delete_VNPRCTRM] 

@vpt_cocde nvarchar(6),
@vpt_venno nvarchar(6),
@vpt_prctrm nvarchar(6)
 

AS

BEGIN

Delete from VNPRCTRM
where 	
 	vpt_venno = @vpt_venno
and 	vpt_prctrm = @vpt_prctrm

END



GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_VNPRCTRM] TO [ERPUSER] AS [dbo]
GO
