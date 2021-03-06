/****** Object:  StoredProcedure [dbo].[sp_select_INR00001SUBA]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_INR00001SUBA]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_INR00001SUBA]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO











/*** 24 Jul 2003	Lewia To		Ignor Company code for select system file *********/


CREATE procedure [dbo].[sp_select_INR00001SUBA]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@cocde nvarchar(6) ,
@from nvarchar(20),
@to nvarchar(20) ,
--Added by Mark Lau 20060929    
@printGroup	nvarchar(1)                                          
---------------------------------------------- 
 
AS
begin

Select	
	hdc_shpno as one,
	hdc_shpseq as  two,
	hdc_ctnseq as thr,
	ltrim(str(hdc_from)) as fou,
	ltrim(str(hdc_to)) as fiv,
	--hid_itmno,	

	--Added by Mark Lau 20060927
		--Added by Mark Lau 20080516, Add CDTVX
	case when isnull(ica_itmno,'') <> '' then ica_cusalsitm 
	else
	case when @printGroup = '1' then
		 -- Changed by Mark Lau 20090402, use function to perform the logic
		/*
		case when len(ltrim(rtrim(hid_itmno))) < 11 or charindex('-',ltrim(rtrim(hid_itmno))) > 0 or charindex('/',ltrim(rtrim(hid_itmno))) >0 or (Upper(substring(ltrim(rtrim(hid_itmno)),3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(hid_itmno)),7,2) = 'AS' then ltrim(rtrim(hid_itmno))
	
		else 
		case when upper(substring(ltrim(rtrim(hid_itmno)), 3, 1)) = 'A'  or upper(substring(hid_itmno, 3, 1)) = 'C'  or upper(substring(hid_itmno, 3, 1)) = 'D' or upper(substring(hid_itmno, 3, 1)) = 'T' or upper(substring(hid_itmno, 3, 1)) = 'X' or upper(substring(hid_itmno, 3, 1)) = 'V'   then substring(ltrim(rtrim(hid_itmno)),1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)

			else 
			case when upper(substring(ltrim(rtrim(hid_itmno)), 3, 1)) = 'B' and (substring(ltrim(rtrim(hid_itmno)), 4, 1) >= '0' And substring(ltrim(rtrim(hid_itmno)), 4, 1) <= '9' ) And (substring(ltrim(rtrim(hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(hid_itmno)),1,11)
				else 
				case when upper(substring(ltrim(rtrim(hid_itmno)), 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(hid_itmno)), 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(hid_itmno)), 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(hid_itmno)),1,11)
					else ltrim(rtrim(hid_itmno))
				 end
			end
		end
		end
		*/
		dbo.groupnewitmno(hid_itmno)
		else
		ltrim(rtrim(hid_itmno))
		end end as 'hid_itmno',
	
	hid_ctrcfs,	hid_cuspo,	hid_ordno,
	CASE ltrim(str(hid_inrctn)) WHEN '0' THEN
		'                       ' + ltrim( str(hid_mtrctn)) + ' ' + ysi_dsc
	ELSE
		ltrim(str(hid_inrctn)) + ' ' + ysi_dsc +'          ' +ltrim( str(hid_mtrctn)) + ' ' + ysi_dsc
	END as 'Packing',
	hid_invno,
	ltrim(str(hid_mtrdcm,10,2)),
	ltrim(str(hid_mtrwcm,10,2)),
	ltrim(str(hid_mtrhcm,10,2)),
	Case isnull(hid_cusitm, '') when '' then hid_itmno else hid_cusitm end
From 	SHIPGDTL
Left join SYSETINF on --ysi_cocde =@cocde  and 
		--hid_untcde = ysi_cde and ysi_typ = '05'

case when isnull(hid_custum,'') <> '' then hid_custum else hid_untcde end = ysi_cde and ysi_typ = '05'
left join shipghdr on hih_shpno = hid_shpno
-- Changed by Mark Lau 20090702
--left join imcusals on hid_itmno = ica_itmno  and ica_apvsts = 'Y' 
 left join SHPCUSSTY ca on  hid_itmno  = ca.ica_itmno  and ca.ica_apvsts = 'Y' and ca.sod_ordno = hid_ordno 
and ca.sod_ordseq = hid_ordseq
,SHDTLCTN, SHINVHDR
WHERE 	
hiv_cocde = @cocde AND
hiv_invno >= @from AND
hiv_invno <= @to AND
hid_cocde = hiv_cocde AND
hid_shpno = hiv_shpno AND
hdc_cocde = hid_cocde AND
hdc_shpno = hid_shpno AND

hdc_shpseq = hid_shpseq
/*
 AND
(
( isnull(ica_itmno ,'') <> '' and  ica_cusno  =  hih_cus1no )
or 
( isnull(ica_itmno ,'') = '')
)
*/
UNION
Select	
	hid_shpno as one,
	hid_shpseq as two,
	0 as thr,
	hid_ctnstr as fou,
	hid_ctnend as fiv,
	--hid_itmno,	

	--Added by Mark Lau 20060927
		--Added by Mark Lau 20080516, Add CDTVX
	case when isnull(ica_itmno,'') <> '' then ica_cusalsitm 
	else
	case when @printGroup = '1' then
		-- Changed by Mark Lau 20090402, use function to perform the logic
		/*
		case when len(ltrim(rtrim(hid_itmno))) < 11 or charindex('-',ltrim(rtrim(hid_itmno))) > 0 or charindex('/',ltrim(rtrim(hid_itmno))) >0 or (Upper(substring(ltrim(rtrim(hid_itmno)),3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(hid_itmno)),7,2) = 'AS' then ltrim(rtrim(hid_itmno))
	
		else 
		case when upper(substring(ltrim(rtrim(hid_itmno)), 3, 1)) = 'A' or upper(substring(hid_itmno, 3, 1)) = 'C'  or upper(substring(hid_itmno, 3, 1)) = 'D' or upper(substring(hid_itmno, 3, 1)) = 'T' or upper(substring(hid_itmno, 3, 1)) = 'X' or upper(substring(hid_itmno, 3, 1)) = 'V'  then substring(ltrim(rtrim(hid_itmno)),1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)

			else 
			case when upper(substring(ltrim(rtrim(hid_itmno)), 3, 1)) = 'B' and (substring(ltrim(rtrim(hid_itmno)), 4, 1) >= '0' And substring(ltrim(rtrim(hid_itmno)), 4, 1) <= '9' ) And (substring(ltrim(rtrim(hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(hid_itmno)),1,11)
				else 
				case when upper(substring(ltrim(rtrim(hid_itmno)), 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(hid_itmno)), 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(hid_itmno)), 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(hid_itmno)),1,11)
					else ltrim(rtrim(hid_itmno))
				 end
			end
		end
		end
		*/
		dbo.groupnewitmno(hid_itmno)
		else
		ltrim(rtrim(hid_itmno))
		end end as 'hid_itmno',

	hid_ctrcfs,	hid_cuspo,	hid_ordno,
	CASE ltrim(str(hid_inrctn)) WHEN '0' THEN
		'                       ' + ltrim( str(hid_mtrctn)) + ' ' + ysi_dsc
	ELSE
		ltrim(str(hid_inrctn)) + ' ' + ysi_dsc +'          ' +ltrim( str(hid_mtrctn)) + ' ' + ysi_dsc
	END as 'Packing',
	hid_invno,
	ltrim(str(hid_mtrdcm,10,2)),
	ltrim(str(hid_mtrwcm,10,2)),
	ltrim(str(hid_mtrhcm,10,2)),
	Case isnull(hid_cusitm, '') when '' then hid_itmno else hid_cusitm end
From 	SHIPGDTL
Left join SYSETINF on --ysi_cocde =@cocde  and 
		--Edited by Mark Lau 20080616
		case when isnull(hid_custum,'') <> '' then hid_custum else hid_untcde end = ysi_cde and ysi_typ = '05'
left join shipghdr on hih_shpno = hid_shpno
-- Changed by Mark Lau 20090702
--left join imcusals on hid_itmno = ica_itmno  and ica_apvsts = 'Y' 
 left join SHPCUSSTY ca on  hid_itmno  = ca.ica_itmno  and ca.ica_apvsts = 'Y' and ca.sod_ordno = hid_ordno 
and ca.sod_ordseq = hid_ordseq
, SHINVHDR
WHERE 	
hiv_cocde = @cocde AND
hiv_invno >= @from AND
hiv_invno <= @to 
/*
AND
(
( isnull(ica_itmno ,'') <> '' and  ica_cusno  =  hih_cus1no )
or 
( isnull(ica_itmno ,'') = '')
)
*/
 and 
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

ORDER BY  fou



end




GO
GRANT EXECUTE ON [dbo].[sp_select_INR00001SUBA] TO [ERPUSER] AS [dbo]
GO
