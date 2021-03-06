/****** Object:  StoredProcedure [dbo].[sp_insert_SYBATRPT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYBATRPT]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYBATRPT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_insert_SYBATRPT]

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

INSERT INTO  SYBATRPT

(
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
yrp_upddat

)
VALUES
(
@cocde,
@rptid,
@rptdsc,
@orgpth,
@schdul,
@schval,
@frmdat,
@todat,
@usrid,
@usrid,
getdate(),
getdate()
)




GO
GRANT EXECUTE ON [dbo].[sp_insert_SYBATRPT] TO [ERPUSER] AS [dbo]
GO
