/****** Object:  StoredProcedure [dbo].[sp_select_INR00001SUB_NET]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_INR00001SUB_NET]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_INR00001SUB_NET]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE        procedure [dbo].[sp_select_INR00001SUB_NET]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@cocde nvarchar(6) ,
@from nvarchar(20),
@to nvarchar(20)                                               
---------------------------------------------- 
 
AS
begin

Select	
	hdc_shpno as hdc_shpno,
	cast(hdc_shpseq as nvarchar(20)) as  hdc_shpseq,
	hdc_ctnseq as hdc_ctnseq,
	ltrim(str(hdc_from)) as hdc_from,
	ltrim(str(hdc_to)) as hdc_to,
	'C/NO.  '+ltrim(str(hdc_from))  +' - ' + ltrim(str(hdc_to))  as 'hdc_fromto',
	hid_ctnftr as 	hid_ctnftr,Case isnull(hid_cusitm, '') when '' then hid_itmno else hid_cusitm end as 'hid_cusitm' 
From 	SHDTLCTN  ctn 
	left join SHINVHDR hiv
	on ctn.hdc_cocde = hiv.hiv_cocde
	and  ctn.hdc_shpno = hiv.hiv_shpno
	left join SHIPGDTL  dtl 
	on ctn.hdc_shpno = dtl.hid_shpno
	and ctn.hdc_shpseq = dtl.hid_shpseq -- 20150317
WHERE 	
hiv.hiv_cocde = @cocde AND
hiv.hiv_invno >= @from AND
hiv.hiv_invno <= @to  

UNION
Select	
	hid_shpno as hdc_shpno,
	cast(hid_shpseq as nvarchar(20)) as  hdc_shpseq,
	0 as hdc_ctnseq,
	hid_ctnstr as hdc_from,
	hid_ctnend as hdc_to,
	'C/NO.  '+ltrim(str(hid_ctnstr))  +' - ' + ltrim(str(hid_ctnend))  as 'hdc_fromto',

	hid_ctnftr as 	hid_ctnftr,
	Case isnull(hid_cusitm, '') when '' then hid_itmno else hid_cusitm end as 'hid_cusitm'
	 
From 	SHIPGDTL  dtl 
	left join SHINVHDR  hiv
	on dtl.hid_cocde = hiv.hiv_cocde AND
	dtl.hid_shpno = hiv.hiv_shpno 
WHERE 	
hiv.hiv_cocde = @cocde AND
hiv.hiv_invno >= @from AND
hiv.hiv_invno <= @to AND
dtl.hid_shpno + str(dtl.hid_shpseq,4) not in
(select hdc_shpno + str(hdc_shpseq,4)
From SHDTLCTN, SHINVHDR 
WHERE hiv_cocde = @cocde AND
hiv_invno >= @from AND
hiv_invno <= @to  AND
hdc_cocde = hiv_cocde AND
hdc_shpno = hiv_shpno)
ORDER BY hdc_from

end






GO
GRANT EXECUTE ON [dbo].[sp_select_INR00001SUB_NET] TO [ERPUSER] AS [dbo]
GO
