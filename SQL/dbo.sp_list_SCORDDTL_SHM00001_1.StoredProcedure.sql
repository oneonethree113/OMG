/****** Object:  StoredProcedure [dbo].[sp_list_SCORDDTL_SHM00001_1]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SCORDDTL_SHM00001_1]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SCORDDTL_SHM00001_1]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





















-- Checked by Allan Yuen at 27/07/2003


/*
=========================================================
Program ID	: sp_list_SCORDDTL_SHM00001_1
Description   	: Select data From SCORDDTL (Cross check with shipping)
Programmer  	: Johnson Lai
ALTER  Date   	: 10th Jan, 2002
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
Parameter:	1. Company
		2. Pri Customer
		3. Sec Customer 
		4.  SC No.	
=========================================================
 Modification History                                    
=========================================================
 Date      	Initial  	Description          
2003-06-17	Allan Yuen		Fix Deadlock error.               
2004-01-28	Marco Chan	Add for getting netuntprc from SC
2005-09-12	Lester Wu		Show vendor short name of PV and CV
=========================================================     
*/

CREATE             procedure [dbo].[sp_list_SCORDDTL_SHM00001_1]
@sod_cocde	nvarchar(6),
@sod_ordno	nvarchar(20)
AS

DECLARE @CUSPO AS nvarchar(50)
select 
	@CUSPO = sod_cuspo 
from 
	SCORDDTL (nolock) 
	inner join SCORDHDR (nolock) on 
		sod_cocde = soh_cocde and 
		sod_ordno = soh_ordno

-------------------------------
Create table  #tlt_cov_qty(tlt_covseq int , hid_cocde nvarchar(20), hid_ordno nvarchar(20), hid_ordseq nvarchar(20))


	--michael 20170421 
	
	INSERT INTO #tlt_cov_qty 
	SELECT sum(hid_shpqty),sod_cocde,sod_ordno,sod_ordseq
	FROM SCORDDTL
	left join SHIPGDTL_COV (nolock) on
		sod_cocde = hid_cocde and
		sod_ordno = hid_ordno and
		sod_ordseq = hid_ordseq
	group by sod_cocde,sod_ordno,sod_ordseq
------------------------------


if @CUSPO is null or @CUSPO = ''  

BEGIN

Select 

sod_ordno, 
sod_ordseq, 
case isnull(sod_cuspo,'') when '' then soh_cuspo else sod_cuspo end  as 'sod_cuspo',
Rtrim(Ltrim(sod_itmno)) as 'sod_itmno', 
sod_itmtyp,
sod_itmdsc,
sod_cusitm,
sod_colcde,
sod_cuscol,
sod_coldsc,
sod_pckunt,
sod_inrctn,
sod_mtrctn,
sod_mtrdcm,
sod_mtrwcm,
sod_mtrhcm,
sod_cbm,
--sod_ordqty - sod_shpqty as 'sod_shpqty',
0 as 'sod_shpqty',
sod_ordqty - sod_shpqty - ISNULL(#tlt_cov_qty.tlt_covseq,0) as 'sod_outqty',
--sod_ordqty  as 'sod_outqty',
-- Lester Wu 2005-09-12, Show vendor short name of PV and CV
--sod_venno,
--sod_cusven,
sod_venno + case isnull(pv.vbi_vensna,'') when '' then '' else ' - ' + pv.vbi_vensna end as 'sod_venno' , 
sod_cusven + case isnull(cv.vbi_vensna,'') when '' then '' else ' - ' + cv.vbi_vensna end as 'sod_cusven' , 
--------------------------------------------------------------------------------------------------------------------------------
cast(sod_colcde as nvarchar(30)) + ' / ' + 
cast(sod_pckunt as nvarchar(6)) + ' / ' + 
cast(sod_inrctn as nvarchar(10)) + ' / ' + 
cast(sod_mtrctn as nvarchar(10)) + ' / ' + 
cast(sod_cft as nvarchar(10)) + ' / ' + 
cast(sod_cbm as nvarchar(10)) + ' / ' + 
cast(sod_ftyprctrm as nvarchar(10)) + ' / ' + 
cast(sod_hkprctrm as nvarchar(10)) + ' / ' + 
cast(sod_trantrm as nvarchar(10)) as 'sod_colpck',
isnull(soh_cus1no,'') as 'soh_cus1no',
isnull(soh_cus2no,'') as 'soh_cus2no',
isnull(soh_prctrm,'') as 'soh_prctrm',
isnull(soh_paytrm,'') as 'soh_paytrm',
isnull(pod_jobord,'') as 'pod_jobord',
isnull(pod_purord,'') as 'pod_purord',
isnull(pod_purseq,0) as 'pod_purseq',
isnull(pv.vbi_vennam,'') as 'vbi_vennam',
sod_untprc,
sod_netuntprc,
isnull(soh_ordsts,'') as 'soh_ordsts',
isnull(poh_pursts,'') as 'poh_pursts',
--Added by Mark Lau 20060929
isnull(sod_alsitmno,'') as 'sod_alsitmno',
isnull(sod_alscolcde,'') as 'sod_alscolcde' , 
isnull(sod_conftr,1) as 'sod_conftr' , 
isnull(sod_contopc,'') as 'sod_contopc' ,
isnull(sod_pcprc,0) as 'sod_pcprc' ,
--Added by Mark Lau 20080611
isnull(sod_custum,'') as 'sod_custum',
-- Added by Mark Lau 20090515
isnull(sod_cusstyno,'') as 'sod_cusstyno',

case sod_resppo when '' then soh_resppo else sod_resppo end as 'sod_resppo',
--isnull(sod_resppo,'') as 'sod_resppo',

isnull(sod_cussku,'') as 'sod_cussku',
soh_rplmnt as 'soh_rplmnt',
isnull(ssm_engdsc,'') as 'ssm_engdsc',
isnull(sod_examven,'') +' - '+ isnull(cv.vbi_vennam,'')  as 'sod_examven',
		isnull(sod_covqty,'0') as 'sod_covqty',
		isnull(sod_name_f1,'') as 'sod_name_f1',
		isnull(sod_dsc_f1,'') as 'sod_dsc_f1',
		isnull(sod_name_f2,'') as 'sod_name_f2',
		isnull(sod_dsc_f2,'') as 'sod_dsc_f2',
		isnull(sod_name_f3,'') as 'sod_name_f3',
		isnull(sod_dsc_f3,'') as 'sod_dsc_f3'


from SCORDDTL (nolock)

inner join SCORDHDR (nolock) on sod_cocde = soh_cocde and sod_ordno = soh_ordno
left join SCSHPMRK  (nolock) on  soh_cocde = ssm_cocde and soh_ordno=ssm_ordno and ssm_shptyp = 'M'



LEFT join POORDDTL (nolock) on sod_cocde = pod_cocde and sod_ordno=pod_scno and sod_ordseq = pod_scline

left join POORDHDR (nolock) on sod_cocde = poh_cocde and pod_purord = poh_purord 

--LEFT join VNBASINF (nolock) on sod_cocde = vbi_cocde and sod_venno = vbi_venno
-- Lester Wu 2005-09-12, show vendor short name of PV and CV
--LEFT join VNBASINF (nolock) on 
--	--sod_cocde = vbi_cocde and 
--	sod_venno = vbi_venno
LEFT join VNBASINF pv (nolock) on sod_examven = pv.vbi_venno
Left join VNBASINF   cv (nolock) on sod_examven = cv.vbi_venno
--LEFT join VNBASINF pv (nolock) on sod_venno = pv.vbi_venno

	--michael 20170421 
	left join #tlt_cov_qty (nolock) on
		sod_cocde = hid_cocde and
		sod_ordno = hid_ordno and
		sod_ordseq = hid_ordseq


where 
sod_cocde = @sod_cocde and
sod_ordno = @sod_ordno 
and sod_ordqty > 0

order by 
sod_cocde, sod_ordno, sod_itmno, sod_colcde ,sod_pckunt,sod_inrctn,sod_mtrctn,sod_cbm

END


ELSE

BEGIN

Select
sod_ordno, 
sod_ordseq, 
sod_cuspo,
Rtrim(Ltrim(sod_itmno)) as 'sod_itmno', 
sod_itmtyp,
sod_itmdsc,
sod_cusitm,
sod_colcde,
sod_cuscol,
sod_coldsc,
sod_pckunt,
sod_inrctn,
sod_mtrctn,
sod_mtrdcm,
sod_mtrwcm,
sod_mtrhcm,
sod_cbm,
--sod_ordqty - sod_shpqty as 'sod_shpqty',
0 as 'sod_shpqty',
sod_ordqty - sod_shpqty - ISNULL(#tlt_cov_qty.tlt_covseq,0) as 'sod_outqty',
--sod_ordqty  as 'sod_outqty',
-- Lester Wu 2005-09-12, Show vendor short name of PV and CV
--sod_venno,
--sod_cusven,
sod_venno + case isnull(pv.vbi_vensna,'') when '' then '' else ' - ' + pv.vbi_vensna end as 'sod_venno' , 
sod_cusven + case isnull(cv.vbi_vensna,'') when '' then '' else ' - ' + cv.vbi_vensna end as 'sod_cusven' , 
--------------------------------------------------------------------------------------------------------------------------------

cast(sod_colcde as nvarchar(30)) + ' / ' + 
cast(sod_pckunt as nvarchar(6)) + ' / ' + 
cast(sod_inrctn as nvarchar(10)) + ' / ' + 
cast(sod_mtrctn as nvarchar(10)) + ' / ' + 
cast(sod_cft as nvarchar(10)) + ' / ' + 
cast(sod_cbm as nvarchar(10)) + ' / ' + 
cast(sod_ftyprctrm as nvarchar(10)) + ' / ' + 
cast(sod_hkprctrm as nvarchar(10)) + ' / ' + 
cast(sod_trantrm as nvarchar(10)) as 'sod_colpck',
isnull(soh_cus1no,'') as 'soh_cus1no',
isnull(soh_cus2no,'') as 'soh_cus2no',
isnull(soh_prctrm,'') as 'soh_prctrm',
isnull(soh_paytrm,'') as 'soh_paytrm',
isnull(pod_jobord,'') as 'pod_jobord',
isnull(pod_purord,'') as 'pod_purord',
isnull(pod_purseq,0) as 'pod_purseq',
isnull(pv.vbi_vennam,'') as 'vbi_vennam',
sod_untprc,
sod_netuntprc,
isnull(soh_ordsts,'') as 'soh_ordsts',
isnull(poh_pursts,'') as 'poh_pursts',
--Added by Mark Lau 20060929
isnull(sod_alsitmno,'') as 'sod_alsitmno',
isnull(sod_alscolcde,'') as 'sod_alscolcde',
isnull(sod_conftr,1) as 'sod_conftr' , 
isnull(sod_contopc,'') as 'sod_contopc' ,
isnull(sod_pcprc,0) as 'sod_pcprc' ,
--Added by Mark Lau 20080611
isnull(sod_custum,'') as 'sod_custum',
-- Added by Mark Lau 20090515
isnull(sod_cusstyno,'') as 'sod_cusstyno',
case sod_resppo when '' then soh_resppo else sod_resppo end as 'sod_resppo',
--isnull(sod_resppo,'') as 'sod_resppo',

isnull(sod_cussku,'') as 'sod_cussku',
soh_rplmnt as 'soh_rplmnt',
isnull(ssm_engdsc,'') as 'ssm_engdsc',
isnull(sod_examven,'') +' - '+ isnull(cv.vbi_vennam,'')  as 'sod_examven',
		isnull(sod_covqty,'0') as 'sod_covqty',
		isnull(sod_name_f1,'') as 'sod_name_f1',
		isnull(sod_dsc_f1,'') as 'sod_dsc_f1',
		isnull(sod_name_f2,'') as 'sod_name_f2',
		isnull(sod_dsc_f2,'') as 'sod_dsc_f2',
		isnull(sod_name_f3,'') as 'sod_name_f3',
		isnull(sod_dsc_f3,'') as 'sod_dsc_f3'

from SCORDDTL (nolock)

inner join SCORDHDR (nolock) on sod_cocde = soh_cocde and sod_ordno = soh_ordno

left join SCSHPMRK   (nolock) on  soh_cocde = ssm_cocde and soh_ordno=ssm_ordno and ssm_shptyp = 'M'

LEFT join POORDDTL (nolock) on sod_cocde = pod_cocde and sod_ordno=pod_scno and sod_ordseq = pod_scline

left join POORDHDR (nolock) on sod_cocde = poh_cocde and pod_purord = poh_purord 

--LEFT join VNBASINF (nolock) on sod_cocde = vbi_cocde and sod_venno = vbi_venno
-- Lester Wu 2005-09-12, show vendor short name of PV and CV
--LEFT join VNBASINF (nolock) on sod_venno = vbi_venno
LEFT join VNBASINF pv (nolock) on sod_examven = pv.vbi_venno
--LEFT join VNBASINF pv (nolock) on sod_venno = pv.vbi_venno
LEFT join VNBASINF cv (nolock) on sod_cusven = cv.vbi_venno
	--michael 20170421 
	left join #tlt_cov_qty (nolock) on
		sod_cocde = hid_cocde and
		sod_ordno = hid_ordno and
		sod_ordseq = hid_ordseq
where 
sod_cocde = @sod_cocde and
sod_ordno = @sod_ordno 

and sod_ordqty > 0 

order by 
sod_cocde, sod_ordno, sod_itmno, sod_colcde ,sod_pckunt,sod_inrctn,sod_mtrctn,sod_cbm

END






GO
GRANT EXECUTE ON [dbo].[sp_list_SCORDDTL_SHM00001_1] TO [ERPUSER] AS [dbo]
GO
