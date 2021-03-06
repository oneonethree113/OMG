/****** Object:  StoredProcedure [dbo].[sp_select_POR00001_carton]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00001_carton]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00001_carton]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 28/07/2003


CREATE PROCEDURE [dbo].[sp_select_POR00001_carton]
@cocde		nvarchar(6),	
@POfrom		nvarchar(20),	@POto		nvarchar(20)

AS

Select	pod_purord as 'pdc_purord',
	pod_purseq as 'pdc_seq',
	99 as 'pdc_ctnseq',
	pdc_from = str(pod_ctnstr),
	pdc_to = str(pod_ctnend),
	pod_ttlctn as 'pdc_ttlctn',
	pdc_ttlctn_str = str(pod_ttlctn)

From	POORDDTL
where 	pod_cocde = @cocde
and 	pod_purord >= @POfrom and pod_purord <= @POto
--and pod_purord = 'P0200078' and pod_purseq = 2

UNION

Select	
	pdc_purord,
	pdc_seq,
	pdc_ctnseq,
	pdc_from = str(pdc_from),
	pdc_to = str(pdc_to),
	pdc_ttlctn,
	pdc_ttlctn = str(pdc_ttlctn)

From 	PODTLCTN
where 	pdc_cocde = @cocde
and 	pdc_purord >= @POfrom and pdc_purord <= @POto
ORDER BY 1, 2, 3




GO
GRANT EXECUTE ON [dbo].[sp_select_POR00001_carton] TO [ERPUSER] AS [dbo]
GO
