/****** Object:  StoredProcedure [dbo].[sp_update_SYCUREX]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYCUREX]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYCUREX]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE PROCEDURE [dbo].[sp_update_SYCUREX]
@yce_cocde NVARCHAR(6),
@yce_frmcur	nvarchar(6),
@yce_tocur nvarchar(6),
@yce_buyrat numeric(16,11),
@yce_selrat numeric(16,11),
@yce_effdat datetime,
@yce_iseff nvarchar(1),
@yce_display nvarchar(1),
@yce_updusr nvarchar(30)
AS

Begin
/*
update sycurex
set 
yce_iseff = 'N',
yce_updusr = @yce_updusr ,
yce_upddat = getdate()
where
yce_frmcur = @yce_frmcur and
yce_tocur = @yce_tocur
*/

update sycurex
set 
yce_buyrat = @yce_buyrat,
yce_selrat = @yce_selrat,
yce_iseff = @yce_iseff,
yce_updusr = @yce_updusr ,
yce_upddat = getdate()
where
yce_frmcur = @yce_frmcur and
yce_tocur = @yce_tocur and
yce_effdat = @yce_effdat

END



GO
GRANT EXECUTE ON [dbo].[sp_update_SYCUREX] TO [ERPUSER] AS [dbo]
GO
