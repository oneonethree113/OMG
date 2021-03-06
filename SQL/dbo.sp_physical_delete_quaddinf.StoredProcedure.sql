/****** Object:  StoredProcedure [dbo].[sp_physical_delete_quaddinf]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_quaddinf]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_quaddinf]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/************************************************************************
Author:		Lester Wu
Date:		17th September, 2008
Description:	Delete data from QUADDINF
***********************************************************************
*/



CREATE PROCEDURE [dbo].[sp_physical_delete_quaddinf] 

@qdi_cocde 	nvarchar(6),
@qdi_qutno 	nvarchar(20),
@qdi_qutseq 	int


AS

delete from QUADDINF
where 	qdi_cocde = @qdi_cocde
and 	qdi_qutno = @qdi_qutno
and 	qdi_qutseq = @qdi_qutseq


GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_quaddinf] TO [ERPUSER] AS [dbo]
GO
