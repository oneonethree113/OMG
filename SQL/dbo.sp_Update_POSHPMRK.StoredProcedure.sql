/****** Object:  StoredProcedure [dbo].[sp_Update_POSHPMRK]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_Update_POSHPMRK]
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_POSHPMRK]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO




-- Checked by Allan Yuen at 28/07/2003


/************************************************************************
Author:		Wong Hong
Date:		7th Jan, 2002
Description:	Update data From POSHPMRK
Parameter:	1. Company
		2. PO No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_Update_POSHPMRK]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@psm_cocde  nvarchar     (6),
@psm_purord  nvarchar     (20),
@psm_shptyp  nvarchar     (6),
@psm_engdsc  nvarchar     (1600),
@psm_chndsc  nvarchar     (3200),
@psm_engrmk  nvarchar     (1600),
@psm_chnrmk  nvarchar     (3200),
@psm_updusr  nvarchar     (30)

---------------------------------------------- 
 
AS
begin
Update POSHPMRK 
Set
psm_engdsc=@psm_engdsc,
psm_chndsc=@psm_chndsc,
psm_engrmk=@psm_engrmk,
psm_chnrmk=@psm_chnrmk,
psm_updusr=@psm_updusr,
psm_upddat=Getdate()

Where 
psm_cocde = @psm_cocde and
psm_purord = @psm_purord and 
psm_shptyp = @psm_shptyp
---------------------------------------------------------- 
end




GO
GRANT EXECUTE ON [dbo].[sp_Update_POSHPMRK] TO [ERPUSER] AS [dbo]
GO
