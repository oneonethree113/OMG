/****** Object:  StoredProcedure [dbo].[sp_insert_QUELC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_QUELC]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_QUELC]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/************************************************************************
Author:		Lester Wu
Date:		28th September, 2008
Description:	insert data into QUELC
***********************************************************************
*/

CREATE procedure [dbo].[sp_insert_QUELC]
@qec_cocde	nvarchar(6),
@qec_qutno	nvarchar(20),
@qec_qutseq	int,
@qec_grpcde	nvarchar(6),
@qec_curcde	nvarchar(6),
@qec_amt	numeric(13,4),
@qec_creusr	nvarchar(30)



AS

declare @dt as datetime
set @dt = getdate()

BEGIN

insert into quelc
(
qec_cocde,
qec_qutno,
qec_qutseq,
qec_grpcde,
qec_curcde,
qec_amt,
qec_creusr,
qec_updusr,
qec_credat,
qec_upddat

)
values
(
@qec_cocde,
@qec_qutno,
@qec_qutseq,
@qec_grpcde,
@qec_curcde,
@qec_amt,
@qec_creusr,
@qec_creusr,
@dt,
@dt
)

END



GO
GRANT EXECUTE ON [dbo].[sp_insert_QUELC] TO [ERPUSER] AS [dbo]
GO
