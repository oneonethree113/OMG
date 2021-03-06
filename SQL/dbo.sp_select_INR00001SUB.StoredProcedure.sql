/****** Object:  StoredProcedure [dbo].[sp_select_INR00001SUB]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_INR00001SUB]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_INR00001SUB]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[sp_select_INR00001SUB]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@cocde nvarchar(6) ,
@from nvarchar(20),
@to nvarchar(20)                                               
---------------------------------------------- 
 
AS
begin

Select	
	hdc_shpno as one,
	hdc_shpseq as  two,
	hdc_ctnseq as thr,
	ltrim(str(hdc_from)) as fou,
	ltrim(str(hdc_to)) as fiv
From 	SHDTLCTN, SHINVHDR
WHERE 	
hiv_cocde = @cocde AND
hiv_invno >= @from AND
hiv_invno <= @to AND
hdc_cocde = hiv_cocde AND
hdc_shpno = hiv_shpno 

UNION
Select	
	hid_shpno as one,
	hid_shpseq as two,
	0 as thr,
	hid_ctnstr as fou,
	hid_ctnend as fiv
From 	SHIPGDTL, SHINVHDR
WHERE 	
hiv_cocde = @cocde AND
hiv_invno >= @from AND
hiv_invno <= @to AND
hid_cocde = hiv_cocde AND
hid_shpno = hiv_shpno AND
hid_shpno + str(hid_shpseq,4) not in
(select hdc_shpno + str(hdc_shpseq,4)
From SHDTLCTN, SHINVHDR 
WHERE hiv_cocde = @cocde AND
hiv_invno >= @from AND
hiv_invno <= @to  AND
hdc_cocde = hiv_cocde AND
hdc_shpno = hiv_shpno)
ORDER BY fou



end


GO
GRANT EXECUTE ON [dbo].[sp_select_INR00001SUB] TO [ERPUSER] AS [dbo]
GO
