/****** Object:  StoredProcedure [dbo].[sp_physical_delete_quelcdtl]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_quelcdtl]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_quelcdtl]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/************************************************************************
Author:		Lester Wu
Date:		28th September, 2008
Description:	Delete data from QUELCDTL
***********************************************************************
*/



CREATE PROCEDURE [dbo].[sp_physical_delete_quelcdtl] 

@qed_cocde 	nvarchar(6),
@qed_qutno 	nvarchar(20),
@qed_qutseq 	int,
@qed_grpcde	nvarchar(6),
@qed_seq	int


AS

delete from QUELCDTL
where 	qed_cocde = @qed_cocde
and 	qed_qutno = @qed_qutno
and 	qed_qutseq = @qed_qutseq
and 	qed_grpcde = @qed_grpcde
and 	qed_seq = @qed_seq


GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_quelcdtl] TO [ERPUSER] AS [dbo]
GO
