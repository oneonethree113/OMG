/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCUREX_ACC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYCUREX_ACC]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCUREX_ACC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







create PROCEDURE [dbo].[sp_physical_delete_SYCUREX_ACC]
@yce_cocde NVARCHAR(6),
@yce_frmcur	nvarchar(6),
@yce_tocur nvarchar(6),
@yce_effdat datetime,
@yce_expdat datetime,
@yce_updusr nvarchar(30)
AS

Begin

delete SYCUREX_ACC
where
yce_frmcur = @yce_frmcur and
yce_tocur = @yce_tocur and
yce_effdat = @yce_effdat and
yce_expdat =@yce_expdat
END



GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYCUREX_ACC] TO [ERPUSER] AS [dbo]
GO
