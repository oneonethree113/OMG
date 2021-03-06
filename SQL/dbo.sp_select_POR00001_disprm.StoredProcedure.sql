/****** Object:  StoredProcedure [dbo].[sp_select_POR00001_disprm]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00001_disprm]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00001_disprm]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_select_POR00001_disprm]
@cocde		nvarchar(6),	
@POfrom		nvarchar(20),	@POto		nvarchar(20)

AS



Select	

	-- POORDHDR
--	hdr.poh_cocde,	hdr.poh_purord,
--	hdr.poh_ttlcbm,	hdr.poh_prctrm,	hdr.poh_curcde, hdr.poh_ttlamt
	vw.pod_lneamt as 'poh_ttlamt', 	poh_discnt = str(hdr.poh_discnt,10,1), 
--	hdr.poh_discnt, 	hdr.poh_netamt,
--	hdr.poh_paytrm,	hdr.poh_rmk,
	
	-- PODISPRM
--	pdp.pdp_cocde,	
	pdp.pdp_purord,	pdp.pdp_pdptyp,	
	pdp.pdp_paamt,
	pdp.pdp_pctamt,	pdp_purpct = str(pdp.pdp_purpct),

	-- SYDISPRM
--	syd.ydp_cocde,	
--	syd.ydp_type,	

	case pdp.pdp_dsc 
		when '' then syd.ydp_dsc 
		else pdp.pdp_dsc  
	end as 'ydp_dsc',

	syd.ydp_cde




From	POORDHDR hdr, PODISPRM pdp, SYDISPRM syd,
	(select pod_cocde, pod_purord, pod_lneamt = sum(pod_lneamt) from v_select_por00001 group by pod_cocde, pod_purord) vw
Where 	
	hdr.poh_cocde = pdp.pdp_cocde and hdr.poh_purord = pdp.pdp_purord
--and 	syd.ydp_cocde = pdp.pdp_cocde and syd.ydp_type = pdp.pdp_pdptyp and pdp.pdp_dpltyp = syd.ydp_cde
and 	syd.ydp_type = pdp.pdp_pdptyp and pdp.pdp_dpltyp = syd.ydp_cde

and	hdr.poh_cocde = vw.pod_cocde and hdr.poh_purord = vw.pod_purord
and	hdr.poh_purord >= @POfrom and hdr.poh_purord <= @POto and hdr.poh_cocde = @cocde
order by pdp_pdptyp desc





GO
GRANT EXECUTE ON [dbo].[sp_select_POR00001_disprm] TO [ERPUSER] AS [dbo]
GO
