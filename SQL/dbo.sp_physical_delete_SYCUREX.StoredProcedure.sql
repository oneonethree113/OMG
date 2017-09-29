/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCUREX]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYCUREX]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCUREX]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE PROCEDURE [dbo].[sp_physical_delete_SYCUREX]
@yce_cocde NVARCHAR(6),
@yce_frmcur	nvarchar(6),
@yce_tocur nvarchar(6),
@yce_effdat datetime,
@yce_updusr nvarchar(30)
AS

Begin

delete sycurex
where
yce_frmcur = @yce_frmcur and
yce_tocur = @yce_tocur and
yce_effdat = @yce_effdat

END



GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYCUREX] TO [ERPUSER] AS [dbo]
GO
