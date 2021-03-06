/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_SHCBNDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Physical_Delete_SHCBNDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_SHCBNDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 27/07/2003



/************************************************************************
Author:		Wong Hong
Date:		4th Jan, 2002
Description:	Delete data From SHCBNDTL
Parameter:	1. Company
		2. PO No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_Physical_Delete_SHCBNDTL]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@hnd_cocde  nvarchar     (6),
@hnd_noteno nvarchar     (20),
@hnd_seq  int
----------------------------------------------  
AS

begin
Delete SHCBNDTL 
Where 
hnd_cocde = @hnd_cocde  and
hnd_noteno = @hnd_noteno and
hnd_seq = @hnd_seq 
---------------------------------------------------------- 
end





GO
GRANT EXECUTE ON [dbo].[sp_Physical_Delete_SHCBNDTL] TO [ERPUSER] AS [dbo]
GO
