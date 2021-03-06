/****** Object:  StoredProcedure [dbo].[sp_update_SYBATRPT]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYBATRPT]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYBATRPT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_update_SYBATRPT]

@cocde	nvarchar(6),
@rptid	nvarchar(10),
@rptdsc	nvarchar(200),
@orgpth	nvarchar(500),
@schdul	nvarchar(1),
@schval	nvarchar(50),
@frmdat	nvarchar(10),
@todat	nvarchar(10),
@usrid	nvarchar(30)

AS

UPDATE   SYBATRPT SET

yrp_rptdsc	= @rptdsc,
yrp_orgpth	= @orgpth,
yrp_schdul	= @schdul,
yrp_schval	= @schval,
yrp_frmdat	= @frmdat,
yrp_todat 	= @todat,
yrp_updusr 	= @usrid,
yrp_upddat 	= getdate()

WHERE

yrp_cocde	= @cocde and
yrp_rptid 		= @rptid




GO
GRANT EXECUTE ON [dbo].[sp_update_SYBATRPT] TO [ERPUSER] AS [dbo]
GO
