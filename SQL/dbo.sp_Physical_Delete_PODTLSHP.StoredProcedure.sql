/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_PODTLSHP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Physical_Delete_PODTLSHP]
GO
/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_PODTLSHP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 28/07/2003


/************************************************************************
Author:		Wong Hong
Date:		21th dec, 2001
Description:	Delete data From PODTLSHP
Parameter:	1. Company
		2. PO No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_Physical_Delete_PODTLSHP]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@pds_cocde  nvarchar     (6),
@pds_purord  nvarchar     (20),
@pds_seq  int,
@pds_shpseq int
----------------------------------------------  
AS

begin
Delete PODTLSHP
Where 
pds_cocde = @pds_cocde  and
pds_purord = @pds_purord and
pds_seq =@pds_seq and
pds_shpseq =@pds_shpseq 

---------------------------------------------------------- 
end




GO
GRANT EXECUTE ON [dbo].[sp_Physical_Delete_PODTLSHP] TO [ERPUSER] AS [dbo]
GO
