/****** Object:  StoredProcedure [dbo].[sp_select_DER00005]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_DER00005]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_DER00005]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 27/07/2003


CREATE procedure [dbo].[sp_select_DER00005]
@cocde	 nvarchar(6)

AS

Begin

Select	@cocde,
	sco.soh_ordno,
	sco.soh_issdat,
	sco.soh_rvsdat,
	cus.cbi_cussna,
	cut.cbi_cussna,
	sco.soh_ordsts,
	'1'
From 	SCORDHDR sco, CUBASINF cus, CUBASINF cut 
Where	
--sco.soh_cocde = cus.cbi_cocde and sco.soh_cus1no = cus.cbi_cusno
--and	sco.soh_cocde = cut.cbi_cocde and sco.soh_cus2no = cut.cbi_cusno

sco.soh_cus1no = cus.cbi_cusno
and sco.soh_cus2no = cut.cbi_cusno

and	sco.soh_ordsts = 'HLD'
--and	SUBSTRING(CONVERT(char, sco.soh_upddat, 11), 1, 5) = SUBSTRING(CONVERT(char, getdate(), 11), 1, 5)
and	sco.soh_cocde = @cocde

union

Select	@cocde,
	'(' + hnh_nottyp + ')' + hnh_noteno,
	hnh_credat,
	hnh_issdat,
	pri.cbi_cussna,
	sec.cbi_cussna,
	hnh_notsts,
	'3'
From	SHCBNHDR, CUBASINF pri, CUBASINF sec
Where	
--hnh_cocde = pri.cbi_cocde and hnh_pricus = pri.cbi_cusno
--and	hnh_cocde = sec.cbi_cocde and hnh_pricus = sec.cbi_cusno

hnh_pricus = pri.cbi_cusno
and hnh_pricus = sec.cbi_cusno

--and	SUBSTRING(CONVERT(char, hnh_upddat, 11), 1, 5) = SUBSTRING(CONVERT(char, getdate(), 11), 1, 5)
and	hnh_notsts = 'HLD' and hnh_cocde = @cocde

order by  1, 3               
           
End



GO
GRANT EXECUTE ON [dbo].[sp_select_DER00005] TO [ERPUSER] AS [dbo]
GO
