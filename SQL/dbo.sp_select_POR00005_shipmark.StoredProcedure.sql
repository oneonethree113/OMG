/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_shipmark]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00005_shipmark]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_shipmark]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 28/07/2003

CREATE PROCEDURE [dbo].[sp_select_POR00005_shipmark]

@cocde		nvarchar(6)
AS

Select	hdr.poh_purord,
	mrk.psm_shptyp,	mrk.psm_imgpth,	mrk.psm_imgnam,
	mrk.psm_engdsc,	mrk.psm_chndsc,	mrk.psm_engrmk,
	mrk.psm_chnrmk

From	POORDHDR hdr, POSHPMRK mrk
Where 	hdr.poh_cocde = @cocde 
and hdr.poh_cocde = mrk.psm_cocde and hdr.poh_purord = mrk.psm_purord







GO
GRANT EXECUTE ON [dbo].[sp_select_POR00005_shipmark] TO [ERPUSER] AS [dbo]
GO
