/****** Object:  StoredProcedure [dbo].[sp_update_SCDTLSHP]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SCDTLSHP]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SCDTLSHP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/*
=================================================================
Program ID	: sp_update_SCDTLSHP
Description	: Update entry to SCDTLSHP
Programmer	: Kenny Chan
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2002-01-14 	Kenny Chan		SP Created
2013-07-15	David Yue		Phase 2 Implementation
2013-10-18	David Yue		Add Remark Field
=================================================================
*/

CREATE procedure [dbo].[sp_update_SCDTLSHP]

@sds_cocde	nvarchar (6),
@sds_ordno	nvarchar  (20),
@sds_seq	int,
@sds_shpseq	int,
@sds_scfrom	datetime,
@sds_scto	datetime,
@sds_pofrom	datetime,
@sds_poto	datetime,
@sds_ordqty	int,
@sds_ctnstr	int,
@sds_ctnend	int,
@sds_ttlctn	int,
@sds_dest	nvarchar (50),
@sds_rmk	nvarchar (100),
@creusr		nvarchar (30)

 
AS

BEGIN

update	SCDTLSHP
set	sds_scfrom = @sds_scfrom,
	sds_scto = @sds_scto,
	sds_pofrom = @sds_pofrom,
	sds_poto = @sds_poto,
	sds_ordqty = @sds_ordqty,
	sds_ctnstr = @sds_ctnstr,
	sds_ctnend = @sds_ctnend,
	sds_ttlctn = @sds_ttlctn,
	sds_dest = @sds_dest,
	sds_rmk = @sds_rmk,
	sds_updusr = @creusr,
	sds_upddat = getdate()
where	sds_cocde = @sds_cocde and
	sds_ordno = @sds_ordno and
	sds_seq = @sds_seq and
	sds_shpseq = @sds_shpseq

END








GO
GRANT EXECUTE ON [dbo].[sp_update_SCDTLSHP] TO [ERPUSER] AS [dbo]
GO
