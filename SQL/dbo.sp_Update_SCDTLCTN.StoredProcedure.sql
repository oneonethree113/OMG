/****** Object:  StoredProcedure [dbo].[sp_Update_SCDTLCTN]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_Update_SCDTLCTN]
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_SCDTLCTN]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 27/07/2003


/************************************************************************
Author:		Kenny Chan
Date:		14th Jan, 2002
Description:	Update data From SCDTLCTN
Parameter:	1. Company
		2. SC No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_Update_SCDTLCTN]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@sdc_cocde  nvarchar  ( 6),
@sdc_ordno  nvarchar  (20),
@sdc_seq  int,
@sdc_ctnseq  int  ,
@sdc_from  int  ,
@sdc_to  int  ,
@sdc_ttlctn  int,
@sdc_updusr  nvarchar  (30)

---------------------------------------------- 
 
AS
begin
Update SCDTLCTN SET
sdc_from = @sdc_from,
sdc_to = @sdc_to,
sdc_ttlctn = @sdc_ttlctn,
sdc_updusr = @sdc_updusr,
sdc_upddat = GETDATE()


--------------------------------- 
Where                                                                                                                                                                                                                           
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
sdc_cocde = @sdc_cocde and
sdc_ordno = @sdc_ordno and
sdc_seq  = @sdc_seq and 
sdc_ctnseq =@sdc_ctnseq
---------------------------------------------------------- 
end






GO
GRANT EXECUTE ON [dbo].[sp_Update_SCDTLCTN] TO [ERPUSER] AS [dbo]
GO
