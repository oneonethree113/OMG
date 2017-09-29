/****** Object:  StoredProcedure [dbo].[sp_update_SCORDDTL_SHM00001]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SCORDDTL_SHM00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SCORDDTL_SHM00001]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO













CREATE procedure [dbo].[sp_update_SCORDDTL_SHM00001]

@sod_cocde	nvarchar(6),	
@sod_ordno	nvarchar(20),	
@sod_ordseq	int,	
@sod_covqty  int,		
@creusr		nvarchar(30)

AS


BEGIN

update	SCORDDTL
set	sod_covqty = @sod_covqty,
	sod_updusr = @creusr,
	sod_upddat = getdate()
where	sod_cocde = @sod_cocde	and
	sod_ordno = @sod_ordno	and
	sod_ordseq = @sod_ordseq



END














GO
GRANT EXECUTE ON [dbo].[sp_update_SCORDDTL_SHM00001] TO [ERPUSER] AS [dbo]
GO
