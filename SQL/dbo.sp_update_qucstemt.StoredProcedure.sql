/****** Object:  StoredProcedure [dbo].[sp_update_qucstemt]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_qucstemt]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_qucstemt]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/************************************************************************
Author:		Lester Wu
Date:		17th September, 2008
Description:	Update data into QUCSTEMT
***********************************************************************
*/

CREATE procedure [dbo].[sp_update_qucstemt]
@qce_cocde nvarchar(6) ,
@qce_qutno nvarchar(20) ,
@qce_qutseq int ,
@qce_ceseq int ,
@qce_cecde nvarchar(12) ,
@qce_percent_d numeric(13, 4) ,
@qce_percent numeric(13, 4) ,
@qce_curcde nvarchar(12) ,
@qce_amt_d numeric(13, 4) ,
@qce_amt numeric(13, 4) ,
@qce_updusr nvarchar(30) 

AS

BEGIN

update qucstemt
set qce_percent = @qce_percent, qce_curcde = @qce_curcde, qce_amt = @qce_amt , 
qce_percent_d = @qce_percent_d, qce_amt_d = @qce_amt_d ,
qce_updusr = @qce_updusr, qce_upddat = getdate()
where
qce_cocde = @qce_cocde and qce_qutno = @qce_qutno and qce_qutseq = @qce_qutseq and qce_cecde = @qce_cecde
--and qce_ceseq = @qce_ceseq

END



GO
GRANT EXECUTE ON [dbo].[sp_update_qucstemt] TO [ERPUSER] AS [dbo]
GO
