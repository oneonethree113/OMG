/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_FYJOBSMK]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Physical_Delete_FYJOBSMK]
GO
/****** Object:  StoredProcedure [dbo].[sp_Physical_Delete_FYJOBSMK]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 28/03/2003



/************************************************************************
Author:		Johnson Lai
Date:		Mar 05, 2002
Description:	Delete data From FYJOBSMK
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_Physical_Delete_FYJOBSMK]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@fsm_cocde  nvarchar     (6),
@fsm_creusr  nvarchar     (30)
----------------------------------------------  

AS

begin

Delete FYJOBSMK
Where 
fsm_cocde = @fsm_cocde  and
fsm_creusr = @fsm_creusr

---------------------------------------------------------- 
end





GO
GRANT EXECUTE ON [dbo].[sp_Physical_Delete_FYJOBSMK] TO [ERPUSER] AS [dbo]
GO
