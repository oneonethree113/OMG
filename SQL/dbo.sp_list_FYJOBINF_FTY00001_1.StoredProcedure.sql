/****** Object:  StoredProcedure [dbo].[sp_list_FYJOBINF_FTY00001_1]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_FYJOBINF_FTY00001_1]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_FYJOBINF_FTY00001_1]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 28/07/2003

/************************************************************************
Author:		Johnson Lai	
Date:		Mar 03, 2002
Description:	Select data From FYJOBINF & FYJOBSMK
************************************************************************/

CREATE procedure [dbo].[sp_list_FYJOBINF_FTY00001_1]
                                                                                                                                                                                                                                                               
@fji_cocde nvarchar(6),
@ffi_creusr nvarchar(30)
 
AS
begin


SELECT a.fsm_smkno, b.fji_ftycde, b.fji_jobno 

FROM FYJOBSMK a                          

INNER JOIN FYJOBINF b ON a.fsm_jobno = b.fji_jobno
                         
WHERE 

a.fsm_cocde = @fji_cocde and
a.fsm_creusr = @ffi_creusr

ORDER BY a.fsm_smkno, b.fji_jobno

end





GO
GRANT EXECUTE ON [dbo].[sp_list_FYJOBINF_FTY00001_1] TO [ERPUSER] AS [dbo]
GO
