/****** Object:  StoredProcedure [dbo].[sp_physical_delete_PKDISPRM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_PKDISPRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_PKDISPRM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_physical_delete_PKDISPRM] 

@pdp_cocde	nvarchar(6) ,
@pdp_ordno 	nvarchar(20),
@pdp_type	nvarchar(15),
@pdp_seqno	int
 

AS

delete from PKDISPRM

where 	
 pdp_cocde = @pdp_cocde and 
pdp_ordno = @pdp_ordno and 
pdp_type = @pdp_type and 
pdp_seqno = @pdp_seqno





GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_PKDISPRM] TO [ERPUSER] AS [dbo]
GO
