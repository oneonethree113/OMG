/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_SCDTLSHP_all]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Physical_Delete_SCDTLSHP_all]
GO
/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_SCDTLSHP_all]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 27/07/2003

/************************************************************************
Author:		Kenny Chan
Date:		21th dec, 2001
Description:	Delete data From SCDTLSHP with same Ordseq
Parameter:	1. Company
		2. SC No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_Physical_Delete_SCDTLSHP_all]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@sds_cocde  nvarchar     (6),
@sds_ordno  nvarchar     (20),
@sds_seq  int

----------------------------------------------  
AS

begin
Delete SCDTLSHP
Where 
sds_cocde = @sds_cocde  and
sds_ordno = @sds_ordno and
sds_seq =@sds_seq


---------------------------------------------------------- 
end





GO
GRANT EXECUTE ON [dbo].[sp_Physical_Delete_SCDTLSHP_all] TO [ERPUSER] AS [dbo]
GO
