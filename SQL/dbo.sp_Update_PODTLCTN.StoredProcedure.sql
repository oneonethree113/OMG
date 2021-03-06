/****** Object:  StoredProcedure [dbo].[sp_Update_PODTLCTN]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_Update_PODTLCTN]
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_PODTLCTN]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 28/07/2003

/************************************************************************
Author:		Wong Hong
Date:		4th dec, 2002
Description:	Update data From PODTLCTN
Parameter:	1. Company
		2. PO No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_Update_PODTLCTN]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@pdc_cocde  nvarchar(6), 	@pdc_purord  nvarchar(20),
@pdc_seq int,		@pdc_ctnseq int,
@pdc_from int,		@pdc_to int,
@pdc_ttlctn int,		@pdc_updusr nvarchar(30)
---------------------------------------------- 
 
AS
begin
Update PODTLCTN SET
pdc_from=@pdc_from,
pdc_to=@pdc_to,
pdc_ttlctn=@pdc_ttlctn,
pdc_updusr=@pdc_updusr,
pdc_upddat=GETDATE()
--------------------------------- 
Where                                                                                                                                                                                                                           
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
pdc_cocde = @pdc_cocde and
pdc_purord = @pdc_purord and
pdc_seq = @pdc_seq and                                                                               
pdc_ctnseq = @pdc_ctnseq                                                                                 
---------------------------------------------------------- 


end






GO
GRANT EXECUTE ON [dbo].[sp_Update_PODTLCTN] TO [ERPUSER] AS [dbo]
GO
