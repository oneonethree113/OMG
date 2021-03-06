/****** Object:  StoredProcedure [dbo].[sp_select_PKA00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PKA00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PKA00001]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO












/*
=================================================================
Program ID	: sp_select_PKA00001
Description	: Retrieve Data for Packaging Report (By SC)
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2015-05-20 	David Yue		SP Created
=================================================================
*/
--sp_select_PKA00001 '','SC'
CREATE procedure [dbo].[sp_select_PKA00001] 
@cocde		nvarchar(6) , 
@sod_ordno	varchar(1000)

AS    
BEGIN    


create table #TEMP_SC (tmp_ordno nvarchar(20)) on [PRIMARY]
create table #TEMP_TO (tmp_ordno nvarchar(20)) on [PRIMARY]

declare	@fm nvarchar(100), @to nvarchar(100)
declare @strPart nvarchar(1000), @strRemain nvarchar(1000)

set @fm = ''
set @to = ''
set @strPart = ''
set @strRemain = ''

--#TEMP_SC, #TEMP_TO
if ltrim(rtrim(@sod_ordno)) <> ''
begin
	delete from #TEMP_SC
	delete from #TEMP_TO

	set @strRemain = @sod_ordno
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))

		if substring(@strPart,1,1) = 'T'
			insert into #TEMP_TO values (@strPart)
		else
			insert into #TEMP_SC values (@strPart)
	end

	if charindex(',',@strRemain) = 0
	begin
		set @strRemain = ltrim(@strRemain)

		if substring(@strRemain,1,1) = 'T'
			insert into #TEMP_TO values (@strRemain)
		else
			insert into #TEMP_SC values (@strRemain)
	end
end





select	distinct
'TO' as 'rpttype', 
tod_cocde as 'sod_cocde',
isnull(yco_conam, '') as 'yco_conam',
tod_toordno as 'sod_ordno',
tod_toordseq as 'sod_ordseq',
toh_cus1no as 'soh_cus1no',
pri.cbi_cussna as 'pri_cbi_cussna', 
isnull(toh_cus2no,'') as 'soh_cus2no',
isnull(sec.cbi_cussna,'') as 'sec_cbi_cussna',
tod_ftyitmno as'sod_itmno',
sod_pckunt + ' / ' + convert(nvarchar(10),sod_inrctn) + ' / ' + convert(nvarchar(10),sod_mtrctn) as 'packing',
tod_projqty as 'sod_ordqty',
tod_pckunt as 'sod_pckunt',
isnull(tod_toordno,'') as 'tod_toordno',
isnull(tod_toordseq,0) as 'tod_toordseq',
isnull(tod_ftyitmno,'') as 'tod_ftyitmno',
isnull(tod_projqty,0) as 'tod_projqty',
isnull(tod_pckunt,'') as 'tod_pckunt',
isnull(prd_reqno,'') as 'prd_reqno',
isnull(prd_seq,0) as 'prd_seq',
isnull(prd_pkgitm,'') as 'prd_pkgitm',
isnull(prd_engdsc,'') as 'prd_engdsc',
isnull(pod_status,'') as 'prh_status',
isnull(prd_ordqty,0) as 'prd_ordqty',
isnull(prd_pkgven,'') as 'prd_pkgven',
--isnull(req.vbi_vensna,'') as 'vbi_vensna',
isnull(pod_ordno,'') as 'pod_ordno',
isnull(pod_seq,0) as 'pod_seq',
isnull(pod_ordqty,0) as 'pod_ordqty',
isnull(pod_stkqty,0) as 'pod_stkqty',
isnull(pod_wasqty,0) as 'pod_wasper',
isnull(pod_bonqty,0) as 'pod_bonqty',
isnull(pod_ttlordqty,0) as 'pod_ttlordqty',
isnull(pod_qtyum,'') as 'um',
isnull(pod_curcde,'') as 'pod_curcde',
isnull(pod_untprc,0) as 'pod_untprc',
isnull(pod_ttlamtqty,0) as 'pod_ttlamtqty',
isnull(peh_price,0) as 'peh_price',
isnull(peh_curcde,'') as 'peh_curcde',
isnull(pod_pkgven,'') as 'pod_pkgven',
isnull(vbi_vensna,'') as 'pod_vensna',
isnull(pod_status,'') as 'pod_status',
isnull(poh_ver,0) as 'poh_ver' 
from	
#TEMP_TO (nolock)
left join TOORDDTL (nolock) on tmp_ordno = tod_toordno
left join TOORDHDR (nolock) on	toh_toordno = tod_toordno 
left join SCORDDTL (nolock) on	tod_toordno = sod_tordno and tod_toordseq = sod_tordseq and sod_cocde = tod_cocde
left join SYCOMINF (nolock) on 	yco_cocde = tod_cocde
left join SCORDHDR (nolock) on	soh_ordno = sod_ordno
left join CUBASINF pri (nolock) on pri.cbi_cusno = toh_cus1no
left join CUBASINF sec (nolock) on sec.cbi_cusno = toh_cus2no
left join PKREQDTL (nolock) on 	prd_ScToNo = tod_toordno and prd_ScToSeq = tod_toordseq
--left join VNBASINF req (nolock) on prd_pkgven = req.vbi_venno
left join PKREQHDR (nolock) on 	prd_reqno = prh_reqno
left join PKORDDTL (nolock) on 	pod_ordno = prd_ordno and pod_seq = prd_ordseq
left join PKESHDR(nolock) on peh_itemno = prd_itemno and  peh_assitm =prd_assitm and 
				peh_tmpitmno = prd_tmpitmno and  peh_venno = prd_venno and  
				peh_venitm = prd_venitm  and  peh_colcde = prd_colcde 
left join VNBASINF  (nolock) on pod_pkgven =vbi_venno
left join PKORDHDR (nolock) on poh_ordno = pod_ordno 
where tod_latest = 'Y' 

union all
select	distinct
'SC' as 'rpttype', 
sod_cocde,
isnull(yco_conam, '') as 'yco_conam',
sod_ordno,
sod_ordseq,
soh_cus1no,
pri.cbi_cussna as 'pri_cbi_cussna', 
isnull(soh_cus2no,'') as 'soh_cus2no',
isnull(sec.cbi_cussna,'') as 'sec_cbi_cussna',
sod_itmno,
sod_pckunt + ' / ' + convert(nvarchar(10),sod_inrctn) + ' / ' + convert(nvarchar(10),sod_mtrctn) as 'packing',
sod_ordqty,
sod_pckunt,
isnull(tod_toordno,'') as 'tod_toordno',
isnull(tod_toordseq,0) as 'tod_toordseq',
isnull(tod_ftyitmno,'') as 'tod_ftyitmno',
isnull(tod_projqty,0) as 'tod_projqty',
isnull(tod_pckunt,'') as 'tod_pckunt',
isnull(prd_reqno,'') as 'prd_reqno',
isnull(prd_seq,0) as 'prd_seq',
isnull(prd_pkgitm,'') as 'prd_pkgitm',
isnull(prd_engdsc,'') as 'prd_engdsc',
isnull(pod_status,'') as 'prh_status',
isnull(prd_ordqty,0) as 'prd_ordqty',
isnull(prd_pkgven,'') as 'prd_pkgven',
--isnull(req.vbi_vensna,'') as 'vbi_vensna',
isnull(pod_ordno,'') as 'pod_ordno',
isnull(pod_seq,0) as 'pod_seq',
isnull(pod_ordqty,0) as 'pod_ordqty',
isnull(pod_stkqty,0) as 'pod_stkqty',
isnull(pod_wasqty,0) as 'pod_wasper',
isnull(pod_bonqty,0) as 'pod_bonqty',
isnull(pod_ttlordqty,0) as 'pod_ttlordqty',
isnull(pod_qtyum,'') as 'um',
isnull(pod_curcde,'') as 'pod_curcde',
isnull(pod_untprc,0) as 'pod_untprc',
isnull(pod_ttlamtqty,0) as 'pod_ttlamtqty',
isnull(peh_price,0) as 'peh_price',
isnull(peh_curcde,'') as 'peh_curcde',
isnull(pod_pkgven,'') as 'pod_pkgven',
isnull(vbi_vensna,'') as 'pod_vensna',
isnull(pod_status,'') as 'pod_status',
isnull(poh_ver,0) as 'poh_ver' 
from	
#TEMP_SC (nolock)
left join SCORDDTL (nolock) on sod_ordno = tmp_ordno
left join SYCOMINF (nolock) on 	yco_cocde = sod_cocde
left join SCORDHDR (nolock) on	soh_ordno = sod_ordno
left join TOORDDTL (nolock) on	tod_toordno = sod_tordno and 	tod_toordseq = sod_tordseq
left join CUBASINF pri (nolock) on pri.cbi_cusno = soh_cus1no
left join CUBASINF sec (nolock) on sec.cbi_cusno = soh_cus2no
left join PKREQDTL (nolock) on 	prd_ScToNo = sod_ordno and prd_ScToSeq = sod_ordseq
--left join VNBASINF req (nolock) on prd_pkgven = req.vbi_venno
left join PKREQHDR (nolock) on 	prd_reqno = prh_reqno
left join PKORDDTL (nolock) on 	pod_ordno = prd_ordno and pod_seq = prd_ordseq
left join PKESHDR( nolock) on peh_itemno = prd_itemno and  peh_assitm =prd_assitm and 
				peh_tmpitmno = prd_tmpitmno and  peh_venno = prd_venno and 
				 peh_venitm = prd_venitm  and  peh_colcde = prd_colcde 
left join VNBASINF (nolock) on pod_pkgven = vbi_venno
left join PKORDHDR (nolock) on poh_ordno = pod_ordno 
order by sod_ordno, sod_ordseq , pod_ordno , pod_seq
--order by sod_ordno, sod_ordseq, prd_reqno, prd_seq , pod_ordno , pod_seq




drop table #TEMP_SC
drop table #TEMP_TO





END







GO
GRANT EXECUTE ON [dbo].[sp_select_PKA00001] TO [ERPUSER] AS [dbo]
GO
