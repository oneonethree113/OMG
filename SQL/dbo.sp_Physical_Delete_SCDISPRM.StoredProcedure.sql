/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_SCDISPRM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Physical_Delete_SCDISPRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_SCDISPRM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 27/07/2003


/************************************************************************
Author:		Kenny Chan
Date:		21th dec, 2001
Description:	Delete data From SCDISPRM
Parameter:	1. Company
		2. SC No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_Physical_Delete_SCDISPRM]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@sdp_cocde  nvarchar     (6),
@sdp_ordno  nvarchar     (20),
@sdp_type  nvarchar     (15),
@sdp_seqno  int
----------------------------------------------  
AS

begin
Delete SCDISPRM 
Where 
sdp_cocde = @sdp_cocde  and
sdp_ordno = @sdp_ordno and
sdp_type = @sdp_type and
sdp_seqno = @sdp_seqno 

---------------------------------------------------------- 
end





GO
GRANT EXECUTE ON [dbo].[sp_Physical_Delete_SCDISPRM] TO [ERPUSER] AS [dbo]
GO
