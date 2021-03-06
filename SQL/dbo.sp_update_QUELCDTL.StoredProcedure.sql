/****** Object:  StoredProcedure [dbo].[sp_update_QUELCDTL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_QUELCDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_QUELCDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/************************************************************************
Author:		Lester Wu
Date:		28th September, 2008
Description:	update data into QUELCDTL
***********************************************************************
*/

CREATE procedure [dbo].[sp_update_QUELCDTL]
@qed_cocde	nvarchar(6),
@qed_qutno	nvarchar(20),
@qed_qutseq	int,
@qed_grpcde	nvarchar(6),
@qed_seq	int,
@qed_cecde	nvarchar(6),
@qed_percent	numeric(13,4),
@qed_curcde	nvarchar(6),
@qed_amt	numeric(13,4),
@qed_updusr	nvarchar(30)



AS

declare @dt as datetime
set @dt = getdate()

BEGIN

update quelcdtl
set
qed_percent = @qed_percent,
qed_curcde = @qed_curcde,
qed_amt = @qed_amt,
qed_updusr = @qed_updusr,
qed_upddat = getdate()
where
qed_cocde = @qed_cocde and
qed_qutno = @qed_qutno and
qed_qutseq = @qed_qutseq and
qed_grpcde = @qed_grpcde and 
qed_seq = @qed_seq
--qed_cecde,





END



GO
GRANT EXECUTE ON [dbo].[sp_update_QUELCDTL] TO [ERPUSER] AS [dbo]
GO
