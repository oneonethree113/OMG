/****** Object:  StoredProcedure [dbo].[sp_physical_delete_VNITMNAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_VNITMNAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_VNITMNAT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/************************************************************************
Author:		Frankie Cheung
Date:		01st June, 2009
Description:	Physical Delete VNITMNAT data
Parameter:	1. Company Code range    
		2. Vendor no.
		3. Item Nature Seq.
************************************************************************/

CREATE PROCEDURE [dbo].[sp_physical_delete_VNITMNAT] 

@vin_cocde nvarchar(6),
@vin_venno nvarchar(6),
@vin_natseq int

AS

BEGIN

Delete from VNITMNAT
where 	
 	vin_venno = @vin_venno
and 	vin_natseq = @vin_natseq

END


GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_VNITMNAT] TO [ERPUSER] AS [dbo]
GO
