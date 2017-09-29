/****** Object:  StoredProcedure [dbo].[sp_update_SHASSINF]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SHASSINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SHASSINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE procedure [dbo].[sp_update_SHASSINF]
@hai_shpno	nvarchar(20),
@hai_shpseq	int,
@hai_assitm	nvarchar(20),
@hai_assdsc	nvarchar(800),
@creusr		nvarchar(30)

as

update	SHASSINF
set	hai_assdsc	= @hai_assdsc,
	hai_updusr = @creusr,
	hai_upddat = getdate()
where	
	hai_shpno = @hai_shpno and
	hai_shpseq = @hai_shpseq and
	hai_assitm = @hai_assitm









GO
GRANT EXECUTE ON [dbo].[sp_update_SHASSINF] TO [ERPUSER] AS [dbo]
GO
