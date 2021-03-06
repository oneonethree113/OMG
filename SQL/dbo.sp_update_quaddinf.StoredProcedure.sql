/****** Object:  StoredProcedure [dbo].[sp_update_quaddinf]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_quaddinf]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_quaddinf]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/************************************************************************
Author:		Lester Wu
Date:		17th September, 2008
Description:	update data to QUADDINF
***********************************************************************
*/

CREATE procedure [dbo].[sp_update_quaddinf]
@qdi_cocde	nvarchar(6),
@qdi_qutno	nvarchar(40),
@qdi_qutseq	int,
@qdi_fldid	nvarchar(40),
@qdi_value	nvarchar(255),
@qdi_updusr	nvarchar(40)



AS

declare @dt as datetime
set @dt = getdate()
/*
BEGIN

update quaddinf

set qdi_value = @qdi_value, qdi_updusr = @qdi_updusr ,qdi_upddat = @dt
where qdi_cocde = @qdi_cocde and qdi_qutno = @qdi_qutno and qdi_qutseq = @qdi_qutseq and qdi_fldid = @qdi_fldid



END
*/


GO
GRANT EXECUTE ON [dbo].[sp_update_quaddinf] TO [ERPUSER] AS [dbo]
GO
