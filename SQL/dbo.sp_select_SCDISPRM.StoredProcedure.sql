/****** Object:  StoredProcedure [dbo].[sp_select_SCDISPRM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCDISPRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCDISPRM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 27/07/2003

/************************************************************************
Author:		Kenny Chan
Date:		19th dec, 2001
Description:	Select data From SCDISPRM
Parameter:	1. Company
		2. SC No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_SCDISPRM]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@sdp_cocde nvarchar(6) ,
@sdp_ordno nvarchar(20),
@sdp_type nvarchar(1)                                     
---------------------------------------------- 
 
AS
begin
Select 
' ' as 'sdp_status',
sdp_cocde,
sdp_ordno,
sdp_type,
sdp_seqno,
sdp_cde,
sdp_dsc,
sdp_pctamt,
sdp_pct,
sdp_amt,
sdp_creusr,
sdp_updusr,
sdp_credat,
sdp_upddat,
cast(sdp_timstp as int) as sdp_timstp
--------------------------------- 
from SCDISPRM
where                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
sdp_cocde = @sdp_cocde and
sdp_ordno = @sdp_ordno and
sdp_type = @sdp_type
---------------------------------------------------------- 
end





GO
GRANT EXECUTE ON [dbo].[sp_select_SCDISPRM] TO [ERPUSER] AS [dbo]
GO
