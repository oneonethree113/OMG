/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_SCDTLCTN_all]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Physical_Delete_SCDTLCTN_all]
GO
/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_SCDTLCTN_all]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 27/07/2003

/************************************************************************
Author:		Kenny Chan
Date:		21th dec, 2001
Description:	Delete data From SCDTLCTN with same Ordseq
Parameter:	1. Company
		2. SC No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_Physical_Delete_SCDTLCTN_all]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@sdc_cocde  nvarchar     (6),
@sdc_ordno  nvarchar     (20),
@sdc_seq  int
---------------------------------------------  
AS

begin
Delete SCDTLCTN
Where 
sdc_cocde = @sdc_cocde  and
sdc_ordno = @sdc_ordno and
sdc_seq =@sdc_seq 


---------------------------------------------------------- 
end





GO
GRANT EXECUTE ON [dbo].[sp_Physical_Delete_SCDTLCTN_all] TO [ERPUSER] AS [dbo]
GO
