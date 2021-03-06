/****** Object:  StoredProcedure [dbo].[sp_select_SYBATRPT]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYBATRPT]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYBATRPT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_select_SYBATRPT] 

@cocde	nvarchar(6),
@rptid	nvarchar(10),
@usrid	nvarchar(30)

AS


SELECT 

yrp_cocde,
yrp_rptid,
yrp_rptdsc,
yrp_orgpth,
yrp_schdul,
yrp_schval,
yrp_frmdat,
yrp_todat,
yrp_creusr,
yrp_updusr,
yrp_credat,
yrp_upddat,
cast(yrp_timstp as int) as yrp_timstp
 
FROM SYBATRPT



WHERE

yrp_cocde = @cocde and
yrp_rptid = @rptid




GO
GRANT EXECUTE ON [dbo].[sp_select_SYBATRPT] TO [ERPUSER] AS [dbo]
GO
