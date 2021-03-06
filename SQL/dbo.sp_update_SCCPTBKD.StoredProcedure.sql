/****** Object:  StoredProcedure [dbo].[sp_update_SCCPTBKD]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SCCPTBKD]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SCCPTBKD]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
=================================================================
Program ID	: sp_update_SCCPTBKD
Description	: Insert Component Breakdown for SC
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-07-18 	David Yue		SP Created
=================================================================
*/

CREATE procedure [dbo].[sp_update_SCCPTBKD]
@scb_cocde	nvarchar(6),
@scb_ordno	nvarchar(20),
@scb_ordseq	int,
@scb_itmno	nvarchar(20),
@scb_cptseq	int,
@scb_cpt	nvarchar(200),
@scb_curcde	nvarchar(6),
@scb_cst	numeric(13,4),
@scb_cstpct	numeric(13,4),
@scb_pct	numeric(6,3),
@creusr		nvarchar(30)

as

update	SCCPTBKD
set	scb_cpt	= @scb_cpt,
	scb_curcde = @scb_curcde,
	scb_cst = @scb_cst,
	scb_cstpct = @scb_cstpct,
	scb_pct = @scb_pct,
	scb_updusr = @creusr,
	scb_upddat = getdate()
where	scb_cocde = @scb_cocde and
	scb_ordno = @scb_ordno and
	scb_ordseq = @scb_ordseq and
	scb_cptseq = @scb_cptseq




GO
GRANT EXECUTE ON [dbo].[sp_update_SCCPTBKD] TO [ERPUSER] AS [dbo]
GO
