/****** Object:  StoredProcedure [dbo].[sp_insert_SCDTLSHP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SCDTLSHP]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SCDTLSHP]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/*
=================================================================
Program ID	: sp_insert_SCDTLSHP
Description	: Insert new entry to SCDTLSHP
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-07-09 	David Yue		SP Created
2013-10-13	David Yue		Add Remark Field
=================================================================
*/

CREATE PROCEDURE [dbo].[sp_insert_SCDTLSHP] 

@sds_cocde	nvarchar (6),
@sds_ordno	nvarchar  (20),
@sds_seq	int,
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

declare @sds_shpseq  int
Set @sds_shpseq = (Select isnull(max(sds_shpseq ),0) + 1 from SCDTLSHP Where sds_cocde= @sds_cocde and sds_ordno = @sds_ordno and sds_seq = @sds_seq)

insert into SCDTLSHP
(	sds_cocde,
	sds_ordno,
	sds_seq,
	sds_shpseq,
	sds_scfrom,
	sds_scto,
	sds_pofrom,
	sds_poto,
	sds_ordqty,
	sds_ctnstr,
	sds_ctnend,
	sds_ttlctn,
	sds_dest,
	sds_rmk,
	sds_creusr,
	sds_updusr,
	sds_credat,
	sds_upddat
)
values
(	@sds_cocde,
	@sds_ordno,
	@sds_seq,
	@sds_shpseq,
	@sds_scfrom,
	@sds_scto,
	@sds_pofrom,
	@sds_poto,
	@sds_ordqty,
	@sds_ctnstr,
	@sds_ctnend,
	@sds_ttlctn,
	@sds_dest,
	@sds_rmk,
	@creusr,
	@creusr,
	getdate(),
	getdate()
)








GO
GRANT EXECUTE ON [dbo].[sp_insert_SCDTLSHP] TO [ERPUSER] AS [dbo]
GO
