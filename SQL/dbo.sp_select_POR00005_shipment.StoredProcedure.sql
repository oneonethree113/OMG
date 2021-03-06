/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_shipment]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00005_shipment]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_shipment]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[sp_select_POR00005_shipment]
@cocde		nvarchar(6),
@JP		nvarchar(1),
@from		nvarchar(20),
@to		nvarchar(20)

AS

select	
	pod_purord as 'pds_purord',
	pod_purseq as 'pds_seq',
	99 as 'pds_shpseq', 
	convert(char(10), pod_shpstr, 101) as 'pds_from',
	convert(char(10), pod_shpstr, 101) as 'pds_to',
	--pod_ordqty as 'pds_ttlctn',
	pod_ordqty as 'pds_ordqty',
	str(pod_ordqty) as 'qty',
 	pod_mtrctn as 'pod_mtrctn',
	ltrim(rtrim(str(pod_ctnstr))) as 'pod_ctnstr',
	ltrim(rtrim(str(pod_ctnend))) as 'pod_ctnend',
	ltrim(rtrim(str(pod_ttlctn))) as 'pod_ttlctn',
	ysi_dsc as 'ysi_dsc',
	'' as 'pds_dest',
	'' as 'pds_rmk'
from	POORDDTL (nolock), SYSETINF (nolock)
where	pod_cocde = @cocde				and
 	(
	 (@JP = 'J'			and
	  pod_jobord >= @from	and
	  pod_jobord <= @to)			or
	 (@JP = 'P'			and
	  pod_purord >= @from	and
	  pod_purord <= @to)			or
	 (@JP = 'R'			and
	  pod_runno >= @from	and
	  pod_runno <= @to))				and
	pod_untcde = ysi_cde				and
	ysi_typ = '05'

union

select
	pds_purord as 'pds_purord',
 	pds_seq as 'pds_seq',
	pds_shpseq as 'pds_shpseq',
	convert(char(10), pds_from, 101) as 'pds_from',
	convert(char(10), pds_from, 101) as 'pds_to',
	--pds_ttlctn as 'pds_ttlctn',
	pds_ordqty as 'pds_ordqty',
	str(pds_ordqty) as 'qty',
	pod_mtrctn as 'pod_mtrctn',
	ltrim(rtrim(str(pds_ctnstr))) as 'pod_ctnstr',
	ltrim(rtrim(str(pds_ctnend))) as 'pod_ctnend',
	ltrim(rtrim(str(pds_ttlctn))) as 'pod_ttlctn',
	ysi_dsc as 'ysi_dsc',
	pds_dest,
	'' as 'pds_rmk'
From 	PODTLSHP (nolock), POORDDTL (nolock), SYSETINF (nolock)
where 	pds_cocde = @cocde				and
	pds_purord = pod_purord			and
	pds_seq = pod_purseq				and
	pod_untcde = ysi_cde				and
	ysi_typ = '05'				and
	(
	 (@JP = 'J'			and
	  pod_jobord >= @from	and
	  pod_jobord <= @to)			or
	 (@JP = 'P'			and
	  pod_purord >= @from	and
	  pod_purord <= @to))

order by 1, 2, 3






GO
GRANT EXECUTE ON [dbo].[sp_select_POR00005_shipment] TO [ERPUSER] AS [dbo]
GO
