/****** Object:  StoredProcedure [dbo].[sp_select_BJMONSET]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_BJMONSET]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_BJMONSET]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_select_BJMONSET]
@bst_jobid nvarchar(20),
@bst_pgid nvarchar(20),
@bst_pgstepid nvarchar(20)
AS
BEGIN

select bst_jobid,
bst_jobname,
bst_pgid,
bst_pgname,
bst_pgstepid,
bst_pgstepname,
bst_creusr,
bst_updusr,
bst_credat,
bst_upddat,
bst_timstp
from BJMONSET
where
bst_jobid = @bst_jobid and
bst_pgid = @bst_pgid and
bst_pgstepid = @bst_pgstepid
END

GO
GRANT EXECUTE ON [dbo].[sp_select_BJMONSET] TO [ERPUSER] AS [dbo]
GO
