/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_carton]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00005_carton]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_carton]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[sp_select_POR00005_carton]
@cocde		nvarchar(6),
@JP		nvarchar(1),
@from		nvarchar(20),
@to		nvarchar(20)

AS

select	pod_purord as 'pdc_purord',
	pod_purseq as 'pdc_seq',
	99 as 'pdc_ctnseq',
	str(pod_ctnstr) as 'pdc_from',
	str(pod_ctnend) as 'pdc_to',
	str(pod_ttlctn) as 'pdc_ttlctn'
from	POORDDTL (nolock)
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
	  pod_runno <= @to))

union

select	
	pdc_purord as 'pdc_purord',
	pdc_seq as 'pdc_seq',
	pdc_ctnseq as 'pdc_ctnseq',
	str(pdc_from) as 'pdc_from',
	str(pdc_to) as 'pdc_to',
	str(pdc_ttlctn) as 'pdc_ttlctn'
from 	PODTLCTN (nolock), POORDDTL (nolock)
where 	pod_cocde = pdc_cocde			and
	pod_purord = pdc_purord			and
	pod_purseq = pdc_seq				and
	pdc_cocde = @cocde				and
	(
	 (@JP = 'J'			and
	  pod_jobord >= @from	and
	  pod_jobord <= @to)			or
	 (@JP = 'P'			and
	  pod_purord >= @from	and
	  pod_purord <= @to))

order by 1, 2, 3




GO
GRANT EXECUTE ON [dbo].[sp_select_POR00005_carton] TO [ERPUSER] AS [dbo]
GO
