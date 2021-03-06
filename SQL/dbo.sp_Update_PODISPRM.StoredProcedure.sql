/****** Object:  StoredProcedure [dbo].[sp_Update_PODISPRM]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_Update_PODISPRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_PODISPRM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






-- Checked by Allan Yuen at 28/07/2003

/************************************************************************
Author:		Wong Hong
Date:		4th Jan, 2002
Description:	UPDATE data From PODISPRM
Parameter:	1. Company
		2. PO No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_Update_PODISPRM]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@pdp_cocde  nvarchar		(6),
@pdp_purord  nvarchar     	(20),
@pdp_pdptyp  nvarchar     	(1),
@pdp_seqno  int,
@pdp_dpltyp  nvarchar     	(20),
@pdp_dsc 	      nvarchar	(200),
@pdp_pctamt  nvarchar     	(1),
@pdp_purpct  numeric  	(6, 3),
@pdp_paamt  numeric  	(13, 4),
@pdp_updusr  nvarchar	(30 )

---------------------------------------------- 
 
AS
begin
Update PODISPRM SET
pdp_seqno=@pdp_seqno,
pdp_pdptyp=@pdp_pdptyp,
pdp_dsc = @pdp_dsc,
pdp_pctamt=@pdp_pctamt,
pdp_purpct=@pdp_purpct,
pdp_paamt=@pdp_paamt,
pdp_updusr=@pdp_updusr,
pdp_upddat=GETDATE()

Where
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
pdp_cocde = @pdp_cocde and
pdp_purord = @pdp_purord and
pdp_pdptyp = @pdp_pdptyp and 
pdp_seqno=@pdp_seqno  
---------------------------------------------------------- 
end







GO
GRANT EXECUTE ON [dbo].[sp_Update_PODISPRM] TO [ERPUSER] AS [dbo]
GO
