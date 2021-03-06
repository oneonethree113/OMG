/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_PDO_Assortment_2_PO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00005_PDO_Assortment_2_PO]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_PDO_Assortment_2_PO]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE   PROCEDURE [dbo].[sp_select_POR00005_PDO_Assortment_2_PO]

@cocde		nvarchar(6),	
@jobno		nvarchar(20),
@batch		nvarchar(23)


AS

select	@cocde as 'cocde',
	--pjd_batno + '-' + pjd_batseq as 'batch',
	@batch as 'batch',
	pod_jobord,
	pod_itmno + ltrim(pod_engdsc) +  ysi_dsc + str(pod_inrctn,10,0) + str(pod_mtrctn,10,0) + str(pod_cubcft,10,2) as 'podKey',
	poh_venno,
	pda_seq,
	pda_itmno,
	pda_assitm,
	ivi_venitm,
	pda_pckunt,
	pda_inrqty,
	pda_mtrqty,
	pda_cusitm,
	pda_assdsc,
	pda_colcde,
	pda_coldsc,
	pda_cussku,
	pod_typcode,
	pda_upcean,
--	case cast(isnull(nullif(pda_cusrtl,0),0) as numeric(13, 2)) when 0 then '' else ltrim(rtrim(str(pda_cusrtl))) end as 'pda_cusrtl',
	case isnull(pda_cusrtl,'') when '0' then '' else ltrim(rtrim(pda_cusrtl)) end as 'pda_cusrtl',
	pda_cusstyno
from	--POJBBDTL (nolock)
	 POORDDTL (nolock) 

	join POORDHDR (nolock) on
		poh_cocde = pod_cocde and
		poh_purord = pod_purord
	join SYSETINF (nolock) on
		ysi_typ = '05' and
		ysi_cde = pod_untcde
	join PODTLASS (nolock) on
		pda_cocde = pod_cocde and
		pda_purord = pod_purord and
		pda_seq = pod_purseq
	join IMBASINF (nolock) on
		ibi_itmno = pda_assitm
	join IMVENINF (nolock) on
		ivi_itmno = pda_assitm and
		ivi_venno = ibi_venno
where	pod_cocde = @cocde and 
	pod_jobord = @jobno
	--pjd_cocde = @cocde and
	--pjd_batno = @batch and
	--pjd_confrm = 'Y'
order by poh_venno, batch, ivi_venitm





GO
GRANT EXECUTE ON [dbo].[sp_select_POR00005_PDO_Assortment_2_PO] TO [ERPUSER] AS [dbo]
GO
