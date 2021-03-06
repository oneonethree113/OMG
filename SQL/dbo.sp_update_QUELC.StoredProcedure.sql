/****** Object:  StoredProcedure [dbo].[sp_update_QUELC]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_QUELC]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_QUELC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/************************************************************************
Author:		Lester Wu
Date:		28th September, 2008
Description:	update data to QUELC
***********************************************************************
*/

CREATE procedure [dbo].[sp_update_QUELC]
@qec_cocde	nvarchar(6),
@qec_qutno	nvarchar(20),
@qec_qutseq	int,
@qec_grpcde	nvarchar(6),
@qec_curcde	nvarchar(6),
@qec_amt	numeric(13,4),
@qec_updusr	nvarchar(30)



AS



BEGIN

update quelc
set 
qec_curcde = @qec_curcde,
qec_amt = @qec_amt,
qec_updusr = @qec_updusr,
qec_upddat = getdate()
where
qec_cocde = @qec_cocde and 
qec_qutno = @qec_qutno and
qec_qutseq = @qec_qutseq and 
qec_grpcde = @qec_grpcde




END



GO
GRANT EXECUTE ON [dbo].[sp_update_QUELC] TO [ERPUSER] AS [dbo]
GO
