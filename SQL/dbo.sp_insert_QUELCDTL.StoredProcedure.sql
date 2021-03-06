/****** Object:  StoredProcedure [dbo].[sp_insert_QUELCDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_QUELCDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_QUELCDTL]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/************************************************************************
Author:		Lester Wu
Date:		28th September, 2008
Description:	insert data into QUELCDTL
***********************************************************************
*/

CREATE procedure [dbo].[sp_insert_QUELCDTL]
@qed_cocde	nvarchar(6),
@qed_qutno	nvarchar(20),
@qed_qutseq	int,
@qed_grpcde	nvarchar(6),
@qed_seq	int,
@qed_cecde	nvarchar(6),
@qed_percent	numeric(13,4),
@qed_curcde	nvarchar(6),
@qed_amt	numeric(13,4),
@qed_creusr	nvarchar(30)



AS

declare @dt as datetime
set @dt = getdate()

BEGIN

insert into quelcdtl
(
qed_cocde,
qed_qutno,
qed_qutseq,
qed_grpcde,
qed_seq,
qed_cecde,
qed_percent,
qed_curcde,
qed_amt,
qed_creusr,
qed_updusr,
qed_credat,
qed_upddat

)
values
(
@qed_cocde,
@qed_qutno,
@qed_qutseq,
@qed_grpcde,
@qed_seq,
@qed_cecde,
@qed_percent,
@qed_curcde,
@qed_amt,
@qed_creusr,
@qed_creusr,
@dt,
@dt
)

END



GO
GRANT EXECUTE ON [dbo].[sp_insert_QUELCDTL] TO [ERPUSER] AS [dbo]
GO
