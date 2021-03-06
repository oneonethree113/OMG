/****** Object:  StoredProcedure [dbo].[sp_insert_CLCUREX]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_CLCUREX]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_CLCUREX]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









create  PROCEDURE [dbo].[sp_insert_CLCUREX]
@cce_cocde NVARCHAR(6),
@cce_frmcur	nvarchar(6),
@cce_tocur nvarchar(6),
@cce_buyrat numeric(16,11),
@cce_selrat numeric(16,11),
@cce_effdat datetime,
@cce_iseff nvarchar(1),
@cce_display nvarchar(1),
@cce_tor numeric(16,11),
@cce_creusr nvarchar(30)
AS

Begin

if ( @cce_iseff = 'Y' )
begin
	update CLCUREX
	set cce_iseff = 'N',
	cce_updusr = @cce_creusr ,
	cce_upddat = getdate()
	where cce_frmcur = @cce_frmcur and cce_tocur = @cce_tocur
end 
insert into CLCUREX (cce_cocde,cce_frmcur,cce_tocur,cce_buyrat,cce_selrat,cce_effdat,cce_iseff,cce_tor,cce_creusr,cce_credat,cce_updusr,cce_upddat,cce_display)
values
('',@cce_frmcur,@cce_tocur,@cce_buyrat,@cce_selrat,@cce_effdat,@cce_iseff,@cce_tor,@cce_creusr,getdate(),@cce_creusr,getdate(),@cce_display)

END





GO
GRANT EXECUTE ON [dbo].[sp_insert_CLCUREX] TO [ERPUSER] AS [dbo]
GO
