/****** Object:  StoredProcedure [dbo].[sp_physical_delete_VNCATREL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_VNCATREL]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_VNCATREL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 28/07/2003



/************************************************************************
Author:		Johnson Lai
Date:		20th September, 2001
Description:	Physical Delete VNCATREL data
Parameter:	1. Company Code range    
		2. Vendor no.
		2. Category Seq.
************************************************************************/

CREATE PROCEDURE [dbo].[sp_physical_delete_VNCATREL] 

@vcr_cocde nvarchar(6),
@vcr_venno nvarchar(6),
@vcr_catseq int

AS

delete from VNCATREL
where 	
	--vcr_cocde 	= @vcr_cocde and
 	vcr_venno 	= @vcr_venno
and 	vcr_catseq 	= @vcr_catseq








GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_VNCATREL] TO [ERPUSER] AS [dbo]
GO
