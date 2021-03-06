/****** Object:  StoredProcedure [dbo].[sp_select_SCinfo2PRC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCinfo2PRC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCinfo2PRC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


/*
==================================================================================
Program ID	: 	sp_select_SCinfo2PRC
DePOription   	: 	Select released po information to PRC
Programmer  	: 	Allan Yuen
Create Date   	: 	1 March 2006
Last Modified  	: 
Table Read(s) 	:	
Table Write(s) 	:	
==================================================================================
 Modification History                                    
==================================================================================
Modification Date	Modified by	Description
==================================================================================
==================================================================================     
*/



CREATE PROCEDURE [dbo].[sp_select_SCinfo2PRC]  

@sod_cocde nvarchar(6) = '',
@option char(1)

AS

--exec sp_general '㊣SCinfo2PRC※S※※1', '', '', '', ''

if @option = '1' 
	select 
		soh_salrep  + ' - ' +  isnull(ysr_dsc,'')	as 'Sales',
		soh_cus1no + ' - ' + ISNULL(cc.cbi_cussna,'')	as 'Customer',
		poh_venno	+ ' - ' + vbi_vensna 	as 'Vendor',
		soh_ordno  		as 'S/C No.',
		poh_purord		as 'PO No.',
		soh_cuspo			as 'Customer PO',
		pod_jobord			as 'Job Order No.',
		sod_itmno 			as 'UCP Item No.',
		ivi_venitm			as 'Vendor Item No.',
		sod_cusitm			as 'Customer Item',
		sod_cussku		as 'SKU No.',
		sod_itmdsc			as 'Eng Desc.',
		sod_cuscol			as 'Customer Color Code',
		sod_coldsc			as 'Customer Color Code Desc',
		sod_cususd		as 'Customer Retail (USD)',
		sod_cuscad			as 'Customer Retail (CAD)',
		sod_dept			as 'Dept',
		sod_code1			as 'Barcode 1',	
		sod_code2			as 'Barcode 2',	
		sod_code3			as 'Barcode 3',	
		sod_pckunt			as 'UM',
		sod_inrctn			as 'Inner',
		sod_mtrctn			as 'Master',
		sod_ordqty			as 'Order Qty',
		poh_rmk			as 'S/C Remark',
		convert(char(10),pod_shpstr,111) 	as 'Start Ship Date',
		sod_rmk     		as 'Remark',
		sm1.ssm_engdsc		as 'Main Mark English Description',
		sm1.ssm_chndsc		as 'Main Mark Chinese Description',
		sm1.ssm_engrmk		as 'Main Mark English Remark',
		sm1.ssm_chnrmk		as 'Main Mark Chinese Remark'
	 from 
		poordhdr 
		left join vnbasinf on poh_venno = vbi_venno
		left join poorddtl on pod_purord = poh_purord
		left join scorddtl on pod_scno = sod_ordno and pod_scline = sod_ordseq
		left join scshpmrk sm1 on sm1.ssm_ordno = sod_ordno and sm1.ssm_shptyp = 'M'
		left join imbasinf on sod_itmno = ibi_itmno
		left join imveninf on sod_itmno = ivi_itmno
		left join scordhdr on soh_ordno = sod_ordno
		left join SYSALREP on ysr_code1 = soh_salrep
		left join sysetinf on ysi_typ = '04' and soh_paytrm = ysi_cde
		left join cubasinf cc on cc.cbi_cusno = soh_cus1no
	where 
		poh_pursts = 'REL'  and 
		pod_ordqty <> 0 and
		ibi_venno >= 'A'
	order by 
		poh_venno	,
		soh_ordno, 
		poh_purord
else
	select 
		soh_salrep  + ' - ' +  isnull(ysr_dsc,'')	as 'Sales',
		soh_cus1no + ' - ' + ISNULL(cc.cbi_cussna,'')	as 'Customer',
		poh_venno	+ ' - ' + vbi_vensna 	as 'Vendor',
		soh_ordno  		as 'S/C No.',
		poh_purord		as 'PO No.',
		soh_cuspo			as 'Customer PO',
		pod_jobord			as 'Job Order No.',
		sod_itmno 			as 'UCP Item No.',
		ivi_venitm			as 'Vendor Item No.',
		sod_cusitm			as 'Customer Item',
		sod_cussku		as 'SKU No.',
		sod_itmdsc			as 'Eng Desc.',
		sod_cuscol			as 'Customer Color Code',
		sod_coldsc			as 'Customer Color Code Desc',
		sod_cususd		as 'Customer Retail (USD)',
		sod_cuscad			as 'Customer Retail (CAD)',
		sod_dept			as 'Dept',
		sod_code1			as 'Barcode 1',	
		sod_code2			as 'Barcode 2',	
		sod_code3			as 'Barcode 3',	
		sod_pckunt			as 'UM',
		sod_inrctn			as 'Inner',
		sod_mtrctn			as 'Master',
		sod_ordqty			as 'Order Qty',
		poh_rmk			as 'S/C Remark',
		convert(char(10),pod_shpstr,111) 	as 'Start Ship Date',
		sod_rmk     		as 'Remark',
		sm1.ssm_engdsc		as 'Main Mark English Description',
		sm1.ssm_chndsc		as 'Main Mark Chinese Description',
		sm1.ssm_engrmk		as 'Main Mark English Remark',
		sm1.ssm_chnrmk		as 'Main Mark Chinese Remark'
	 from 
		poordhdr 
		left join vnbasinf on poh_venno = vbi_venno
		left join poorddtl on pod_purord = poh_purord
		left join scorddtl on pod_scno = sod_ordno and pod_scline = sod_ordseq
		left join scshpmrk sm1 on sm1.ssm_ordno = sod_ordno and sm1.ssm_shptyp = 'M'
		left join imbasinf on sod_itmno = ibi_itmno
		left join imveninf on sod_itmno = ivi_itmno
		left join scordhdr on soh_ordno = sod_ordno
		left join SYSALREP on ysr_code1 = soh_salrep
		left join sysetinf on ysi_typ = '04' and soh_paytrm = ysi_cde
		left join cubasinf cc on cc.cbi_cusno = soh_cus1no
	where 
		poh_pursts = 'REL'  and 
		pod_ordqty <> 0 and
		ibi_venno < 'A'
	order by 
		poh_venno	,
		soh_ordno, 
		poh_purord






GO
GRANT EXECUTE ON [dbo].[sp_select_SCinfo2PRC] TO [ERPUSER] AS [dbo]
GO
