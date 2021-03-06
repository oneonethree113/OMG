/****** Object:  StoredProcedure [dbo].[sp_select_SAP_OS_SO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SAP_OS_SO]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SAP_OS_SO]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	:  Mark Lau
Create Date   	: 
Last Modified  	: 21 Jan 2008
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
*/


CREATE PROCEDURE [dbo].[sp_select_SAP_OS_SO] 
@cocde	nvarchar(4),
@strType	nvarchar(10),
@Value		nvarchar(20)
AS

begin
if  (  @strType  =  'OS')
begin
select 
isnull(pod_jobord,'') as 'JobOrd',
soh_ordsts as 'OrdSts',
sod_ordno as 'OrdNo',
sod_ordseq as 'OrdSeq.',
sod_itmno as 'ItmNo',
isnull(ibi_lnecde,'') as 'PrdLne',
pod_untcde as 'UntCde.',
pod_inrctn as 'Inr',
pod_mtrctn as 'Mtr',
sod_ordqty as 'OrdQty',
sod_shpqty as 'ShpQty', 
sod_cusven as 'CusVen',
sod_venno as 'VenNo.' ,
cast(pod_shpstr as nvarchar(10)) as 'ShpStr.',
--sod_zorvbeln as 'SONo', sod_zorposnr as 'SOLnNo',
cast(sod_credat as nvarchar(30)) as  'SC CreDat',
cast(sod_upddat  as nvarchar(30)) as  'SC UpdDat',
cast(pod_credat  as nvarchar(30)) as  'PO CreDat',
cast(pod_upddat as nvarchar(30)) as  'PO UpdDat',
'' as 'Reason'
from SCORDHDR (nolock)
left join SCORDDTL  (nolock) on soh_cocde = sod_cocde and soh_ordno = sod_ordno
left join POORDDTL (nolock)  on sod_cocde = pod_cocde and sod_ordno = pod_scno and sod_ordseq = pod_scline
left join IMBASINF  (nolock) on sod_itmno = ibi_itmno
where soh_ordsts in ('REL', 'ACT', 'HLD')
and sod_ordqty > sod_shpqty
--and sod_venno in ('A','B','U','W') 
	-- Changed by Mark Lau 20080228
	and 
	(
	-- Item no. in A, Product Line in 'A9', 'B9' will have no change, Prd Ven should be in ('B','U','W','A')
	( sod_venno in ('B','U','W','A') and  ( substring(sod_itmno,3,1) = 'A' or substring(sod_itmno,3,2) = 'A9'  or substring(sod_itmno,3,2) = 'B9' ) )
	or 
	-- Item no. in B, U, Product Line not in 'B9', Prd Ven not in ('B','U','W','A') 
	(
	 ( substring(sod_itmno,3,1) = 'B' or substring(sod_itmno,3,1) = 'U' ) 
	and substring(sod_itmno,3,2) <> 'B9' and  sod_venno not in ('B','U','W','A')
	and (pod_shpstr >= '2008-01-01' or pod_shpend >= '2008-01-01') 
	)
	or
	-- Item no. in B, U, Product Line not in 'B9', Prd Ven in ('B','U','W','A') 
	( sod_venno in ('B','U','W','A') and ( substring(sod_itmno,3,1) = 'B' or substring(sod_itmno,3,1) = 'U' )  )	
	)
and sod_venno = pod_prdven
and isnull(pod_jobord,'') <> ''
and charindex('-',sod_itmno)<= 0 
and charindex('/',sod_itmno)<= 0 
and len(sod_itmno) = 13
and sod_zorvbeln = ''
--and convert(nvarchar(10),sod_credat,111) <= convert(nvarchar(10),@dtDate,111)
order by pod_jobord,sod_ordno, sod_ordseq,  sod_credat asc
end

if  (@strType  =  'GETJOBORD')
Begin

select * from pojbbsap (nolock)
where
 pjs_batno + '-'+ pjs_batseq = @Value
--and  convert(nvarchar(10),pjs_credat,111) <= convert(nvarchar(10),@dtDate,111)
 order by pjs_credat desc
end



if  (@strType  =  'UMCHECK')
Begin

select '' as cat ,isnull(pod_jobord,'') as 'pod_jobord', sod_zorvbeln,sod_zorposnr, sod_itmno,sod_pckunt,sod_inrctn, sod_mtrctn, sod_venno,sod_ordqty, sod_ordno, sod_ordseq
--,* 
from SCORDDTL(nolock)
left join POORDDTL(nolock) on sod_ordno = pod_scno and sod_ordseq = pod_scline
left join SAPSOITM (nolock) on sod_pckunt = ssi_pckunt and sod_inrctn = ssi_inrqty and sod_mtrctn = ssi_mtrqty  and sod_itmno = ssi_itmno
, IMPNTINF(nolock), SYCONFTR(nolock), SCORDHDR(nolock)
where sod_zorvbeln = ''
and sod_credat > '2006-01-01'
and sod_venno in ('A')
and sod_itmno = ipt_itmno
and sod_pckunt = ycf_code1
and ycf_value > 1
and ipt_plant in ('3043')
and soh_ordno = sod_ordno
and soh_ordsts in ('REL','HLD','ACT')
and sod_ordqty > 0
and sod_pckunt <> 'DZ'
--and isnull(pod_jobord,'') not in (	select jobord from vw_SAPSOITM where isnull(jobord,'') <> '' )
and ssi_itmno is null
union
select '',isnull(pod_jobord,'') as 'pod_jobord', sod_zorvbeln,sod_zorposnr, sod_itmno,sod_pckunt,sod_inrctn, sod_mtrctn, sod_venno,sod_ordqty, sod_ordno, sod_ordseq
--,* 
from SCORDDTL(nolock)
left join POORDDTL(nolock) on sod_ordno = pod_scno and sod_ordseq = pod_scline
left join SAPSOITM (nolock) on sod_pckunt = ssi_pckunt and sod_inrctn = ssi_inrqty and sod_mtrctn = ssi_mtrqty and sod_itmno = ssi_itmno
, IMPNTINF(nolock), SYCONFTR(nolock), SCORDHDR(nolock)
where sod_zorvbeln = ''
and sod_credat > '2006-01-01'
and sod_venno in ('B','U','W')
and sod_itmno = ipt_itmno
and sod_pckunt = ycf_code1
and ycf_value > 1
and ipt_plant in ('3042')
and soh_ordno = sod_ordno
and soh_ordsts in ('REL','HLD','ACT')
and sod_ordqty > 0
and sod_pckunt <> 'DZ'
--and isnull(pod_jobord,'') not in (select jobord from vw_SAPSOITM where isnull(jobord,'') <> '')
and ssi_itmno is null
-- 
union
select '' as cat,isnull(pod_jobord,'') as 'pod_jobord', sod_zorvbeln,sod_zorposnr, sod_itmno,sod_pckunt,sod_inrctn, sod_mtrctn, sod_venno,sod_ordqty, sod_ordno, sod_ordseq
--,* 
from SCORDDTL(nolock)
left join POORDDTL(nolock) on sod_ordno = pod_scno and sod_ordseq = pod_scline
left join SAPSOITM (nolock) on sod_pckunt = ssi_pckunt and sod_inrctn = ssi_inrqty and sod_mtrctn = ssi_mtrqty and sod_itmno = ssi_itmno
, IMPNTINF(nolock), SYCONFTR(nolock), SCORDHDR(nolock)
where sod_zorvbeln = ''
and sod_credat > '2007-01-01'
and sod_venno in ('B','U','W')
and sod_itmno = ipt_itmno
and sod_pckunt = ycf_code1
and ycf_value > 1
and ipt_plant in ('3041')
and soh_ordno = sod_ordno
and soh_ordsts in ('REL','HLD','ACT')
and isnull(pod_jobord,'') not in (
		select distinct pjd_jobord from POJBBDTL where pjd_credat <= '2007-10-27' and isnull(pjd_jobord,'') <> ''
)
and sod_ordqty > 0
and sod_pckunt <> 'DZ'
--and isnull(pod_jobord,'') not in (select jobord from vw_SAPSOITM where isnull(jobord,'') <> '')
and ssi_itmno is null
union
select '',isnull(pod_jobord,'') as 'pod_jobord', sod_zorvbeln,sod_zorposnr, sod_itmno,sod_pckunt,sod_inrctn, sod_mtrctn, sod_venno,sod_ordqty, sod_ordno, sod_ordseq
--,* 
from SCORDDTL(nolock)
left join POORDDTL(nolock) on sod_ordno = pod_scno and sod_ordseq = pod_scline
left join SAPSOITM (nolock) on sod_pckunt = ssi_pckunt and sod_inrctn = ssi_inrqty and sod_mtrctn = ssi_mtrqty and sod_itmno = ssi_itmno
, IMPNTINF(nolock), SYCONFTR(nolock), SCORDHDR(nolock)
where pod_jobord in (
'US0701281-J005',
'US0700503-J039',
'US0700913-J081',
'US0701099-J009',
'US0701099-J010',
'US0701418-J008',
'US0701418-J010',
'US0701434-J003',
'US0701581-J002',
'US0701583-J001',
'US0701584-J001',
'US0701650-J004',
'US0701730-J001'
)
and  sod_zorvbeln = ''
and sod_credat > '2007-01-01'
and sod_venno in ('B','U','W')
and sod_itmno = ipt_itmno
and sod_pckunt = ycf_code1
and ycf_value > 1
and ipt_plant in ('3041')
and soh_ordno = sod_ordno
and soh_ordsts in ('REL','HLD','ACT')
and sod_ordqty > 0
and sod_pckunt <> 'DZ'
--and isnull(pod_jobord,'') not in (select jobord from vw_SAPSOITM where isnull(jobord,'') <> '')
and ssi_itmno is null
--select distinct soh_ordsts from SCORDHDR


end

if  (@strType  =  'IMPNTINF')
Begin
select * from impntinf(nolock) where ipt_itmno = @Value
end

if  (@strType  =  'POJBBSAP')
Begin

select * from pojbbsap(nolock) where pjs_jobord = @Value order by pjs_credat desc
end

if  (@strType  =  'POJBBDTL')
Begin
select * from pojbbdtl(nolock) where pjd_jobord = @Value 
and left(pjd_batno ,2) in ('TJ','UT','GT','ET')
order by pjd_credat desc
end 

if (@strType = 'ERPTOTAL')
begin
select count(*) as 'Total' from scorddtl(nolock) where sod_zorvbeln <> '' and sod_zorposnr <> ''
end

end


GO
GRANT EXECUTE ON [dbo].[sp_select_SAP_OS_SO] TO [ERPUSER] AS [dbo]
GO
