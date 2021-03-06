/****** Object:  StoredProcedure [dbo].[sp_update_SHDTLCTN]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SHDTLCTN]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SHDTLCTN]    Script Date: 09/29/2017 15:29:10 ******/
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


CREATE PROCEDURE [dbo].[sp_update_SHDTLCTN] 
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@hdc_cocde  nvarchar  ( 6),
@hdc_shpno  nvarchar  (20),
@hdc_shpseq  int,
@hdc_ctnseq  int  ,
@hdc_from  int  ,
@hdc_to  int  ,
@hdc_ttlctn  int,
@hdc_updusr  nvarchar  (30)

---------------------------------------------- 
 
AS
begin
Update SHDTLCTN SET
hdc_from = @hdc_from,
hdc_to = @hdc_to,
hdc_ttlctn = @hdc_ttlctn,
hdc_updusr = @hdc_updusr,
hdc_upddat = GETDATE()


--------------------------------- 
Where                                                                                                                                                                                                                           
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
hdc_cocde 	=	@hdc_cocde and
hdc_shpno 	=	@hdc_shpno and
hdc_shpseq 	=	@hdc_shpseq and 
hdc_ctnseq 	=	@hdc_ctnseq
---------------------------------------------------------- 
end









GO
GRANT EXECUTE ON [dbo].[sp_update_SHDTLCTN] TO [ERPUSER] AS [dbo]
GO
