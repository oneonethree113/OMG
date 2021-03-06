/****** Object:  StoredProcedure [dbo].[sp_select_SCR00001_disprm]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCR00001_disprm]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCR00001_disprm]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 27/07/2003




/*=========================================================
Program ID	: 	sp_select_SCR00001_disprm
Description   	: 	
Programmer  	: 	PIC
ALTER  Date   	: 	
Last Modified  	: 
Table Read(s) 	:	
Table Write(s) 	:	
Parameter	:	
		:	
=========================================================
 Modification History                                    
=========================================================
2003-09-10	Allan Yuen	Change the sdp_pct from 1 decimal point to 2.
=========================================================     
*/


CREATE PROCEDURE [dbo].[sp_select_SCR00001_disprm]
@cocde		nvarchar(6),	
@SCfrom		nvarchar(20),	@SCto		nvarchar(20)

AS


Select	distinct
	--SCORDHDR
	hdr.soh_curcde,		hdr.soh_ttlamt,

	--SCDISPRM
	sdp_ordno,			sdp_type,	
--	sdp_type,			sdp.sdp_dsc,
	sdp.sdp_amt,		sdp.sdp_pctamt,		sdp_pct = str(sdp.sdp_pct,10,2),
--	hdr.soh_paytrm,		hdr.soh_prctrm

	-- SYDISPRM
--	syd.ydp_cocde,		syd.ydp_type,	
--	syd.ydp_dsc,		syd.ydp_cde	--	Go back to get Description of Dis/Prm from SC D/P Table 
	sdp.sdp_dsc as 'ydp_dsc',		sdp.sdp_cde as 'ydp_cde'

From 	SCORDHDR hdr, SCDISPRM sdp, SYDISPRM syd
WHERE 
	hdr.soh_cocde = sdp.sdp_cocde and hdr.soh_ordno = sdp.sdp_ordno
/*
--and 	sdp.sdp_cocde = syd.ydp_cocde  and sdp.sdp_type= syd.ydp_type and sdp.sdp_cde = syd.ydp_cde
*/

--and 	hdr.soh_ordno >= @SCfrom and hdr.soh_ordno <= @SCto and hdr.soh_cocde = @cocde
and 	hdr.soh_ordno >= @SCfrom and hdr.soh_ordno <= @SCto 
order by sdp_type desc




GO
GRANT EXECUTE ON [dbo].[sp_select_SCR00001_disprm] TO [ERPUSER] AS [dbo]
GO
