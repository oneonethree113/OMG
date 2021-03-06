/****** Object:  StoredProcedure [dbo].[sp_select_SCDTLSHP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCDTLSHP]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCDTLSHP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/*
=================================================================
Program ID	: sp_select_SCDTLSHP
Description	: Select data From SCDTLSHP
Programmer	: Kenny Chan
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2002-01-14	Kenny Chan		SP Created
2013-10-17 	David Yue		Add Remark Field
=================================================================
*/


CREATE PROCEDURE [dbo].[sp_select_SCDTLSHP] 

@sds_cocde 	nvarchar(6),
@sds_ordno	nvarchar(20)--,


AS

declare @sds_cbm numeric(11, 4)
set @sds_cbm = 0.0000

select 	'' as 'sds_status',
	sds_cocde,
	sds_ordno,
	sds_seq,
	sds_shpseq,
	convert(varchar(10),sds_scfrom,101) as 'sds_scfrom',
	convert(varchar(10),sds_scto,101) as 'sds_scto',
	case sds_pofrom when '1900-01-01' then '' else convert(varchar(10),sds_pofrom,101) end as 'sds_pofrom',
	case sds_poto when '1900-01-01' then '' else convert(varchar(10),sds_poto,101) end as 'sds_poto',
	sds_ordqty,
	sds_ctnstr,
	sds_ctnend,
	sds_ttlctn,
	sds_dest,
	sds_rmk,
	@sds_cbm as 'sds_cbm',
	sds_creusr,
	sds_updusr,
	sds_credat,
	sds_upddat,
	sds_timstp
from 	SCDTLSHP (nolock) 
where 	sds_cocde = @sds_cocde and 
	sds_ordno= @sds_ordno








GO
GRANT EXECUTE ON [dbo].[sp_select_SCDTLSHP] TO [ERPUSER] AS [dbo]
GO
