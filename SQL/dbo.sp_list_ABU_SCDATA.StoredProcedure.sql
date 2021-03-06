/****** Object:  StoredProcedure [dbo].[sp_list_ABU_SCDATA]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_ABU_SCDATA]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_ABU_SCDATA]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





/*      
      
select * from SCSUBCON(nolock)      
      
delete from SCSUBCON      
      
-- drop table SCSUBCON      
create table SCSUBCON (      
 ssc_cocde  varchar(6) ,       
 ssc_typ   varchar(1) ,       
 ssc_jobord  varchar(30) ,       
 ssc_ordno  varchar(20) ,       
 ssc_ordseq  int ,       
 ssc_cus1no  varchar(10) ,       
 ssc_pricus  varchar(40) ,       
 ssc_cus2no  varchar(10) ,       
 ssc_seccus  varchar(40) ,       
 ssc_itmno  varchar(30) ,       
 ssc_colcde  nvarchar(60) ,       
 ssc_coldsc  nvarchar(600) ,       
 ssc_ordqty  int ,       
 ssc_qtypc  int ,       
 ssc_um  varchar(20) ,       
 ssc_pckunt  varchar(20) ,       
 ssc_inrqty  int ,       
 ssc_mtrqty  int ,       
 ssc_ttlctn  int ,       
 ssc_cbm  numeric(13,4) ,      
 ssc_cusven  varchar(10) ,       
 ssc_venno  varchar(10) ,       
 ssc_credat  datetime      
)      
      
*/      
      
      
--select case when 'A' in ('A','B','U') then 'D' else 'N' end      
      
CREATE procedure [dbo].[sp_list_ABU_SCDATA]      
as      
begin      
      
declare @date as datetime      
set @date = getdate()      
      
------ New for ABU Item
select sod_cocde, 'N' as 'type',pod_jobord, sod_ordno , sod_ordseq, soh_cus1no, pri.cbi_cussna as 'PriCust', soh_cus2no, isnull(sec.cbi_cussna,'') as 'SecCust',  sod_itmno,       
sod_colcde , sod_coldsc ,       
sod_ordqty, sod_ordqty*isnull(ycf_value,1)*isnull(sod_conftr,1) as 'Qty', 'PC' as 'PC' , sod_pckunt, sod_inrctn, sod_mtrctn, sod_ttlctn, sod_cbm, sod_venno, sod_cusven   ,     
isnull(pod_shpstr, '1900-01-01') as pod_shpstr ,    
-- 2007-12-13  
isnull(pod_purord, '') as pod_purord, isnull(pod_cusitm,'') as pod_cusitm  , isnull(pod_ctnstr,0) as pod_ctnstr , isnull(pod_ctnend,0) as pod_ctnend ,  
isnull(pod_chndsc,'') as pod_chndsc ,   
isnull(pod_engdsc,'') as pod_engdsc  ,
-- Added by Mark Lau 20090526
isnull(poh_cuspno,'') as 'poh_cuspno',
isnull(pod_cuspno,'') as 'pod_cuspno',
-- Added by Mark Lau 20090601
isnull(poh_reppno,'') as 'poh_reppno',
isnull(pod_respno,'') as 'pod_respno'

--, *      
into #tmp_Update      
from       
--Select top 10 * from POORDDTL  where pod_shpstr <> pod_shpend    
SCORDHDR (nolock)       
left join SCORDDTL(nolock) on soh_ordno = sod_ordno      
left join POORDDTL (nolock) on sod_ordno = pod_scno and sod_ordseq = pod_scline      
left join CUBASINF pri (nolock) on soh_cus1no = pri.cbi_cusno      
left join CUBASINF sec (nolock) on soh_cus2no = sec.cbi_cusno      
left join SYCONFTR (nolock) on sod_pckunt = ycf_code1  
-- Added by Mark Lau 20081230
left join IMBASINF (nolock) on sod_itmno = ibi_itmno    
-- Added by Mark Lau 20090526
left join poordhdr(nolock) on poh_purord = pod_purord
, IMPNTINF (nolock)      
where       
soh_ordsts = 'REL'      
and sod_itmno = ipt_itmno    
-- Rem by Mark Lau 20082223, for SAP 880, 以設計工廠 A/B/C/D/T/U/V 上單至3041後由華泰分單至其他兄弟廠。
--and sod_venno not in ('A','B','U')      
and ibi_venno not in ('A','B','C','D','T','U','V','W') 


union
-------New for non-ABU Item


select sod_cocde, 'N' as 'type',isnull(pod_jobord,''), sod_ordno , sod_ordseq, soh_cus1no, pri.cbi_cussna as 'PriCust', soh_cus2no, isnull(sec.cbi_cussna,'') as 'SecCust',  sod_itmno,       
sod_colcde , sod_coldsc ,       
sod_ordqty, sod_ordqty*isnull(ycf_value,1)*isnull(sod_conftr,1) as 'Qty', 'PC' as 'PC' , sod_pckunt, sod_inrctn, sod_mtrctn, sod_ttlctn, sod_cbm, sod_venno, sod_cusven   ,     
isnull(pod_shpstr, '1900-01-01') as pod_shpstr ,    
isnull(pod_purord, '') as pod_purord, isnull(pod_cusitm,'') as pod_cusitm  , isnull(pod_ctnstr,0) as pod_ctnstr , isnull(pod_ctnend,0) as pod_ctnend ,  
isnull(pod_chndsc,'') as pod_chndsc ,   
isnull(pod_engdsc,'') as pod_engdsc  ,
-- Added by Mark Lau 20090526
isnull(poh_cuspno,'') as 'poh_cuspno',
isnull(pod_cuspno,'') as 'pod_cuspno'     ,
-- Added by Mark Lau 20090601
isnull(poh_reppno,'') as 'poh_reppno',
isnull(pod_respno,'') as 'pod_respno' 
from       
--Select top 10 * from POORDDTL  where pod_shpstr <> pod_shpend    
SCORDHDR (nolock)       
left join SCORDDTL(nolock) on soh_ordno = sod_ordno      
left join POORDDTL (nolock) on sod_ordno = pod_scno and sod_ordseq = pod_scline      
left join CUBASINF pri (nolock) on soh_cus1no = pri.cbi_cusno      
left join CUBASINF sec (nolock) on soh_cus2no = sec.cbi_cusno      
left join SYCONFTR (nolock) on sod_pckunt = ycf_code1      
-- Added by Mark Lau 20090526
left join poordhdr(nolock) on poh_purord = pod_purord   
where       
soh_ordsts = 'REL'      

and sod_itmno not in ( select ipt_itmno from IMPNTINF(nolock))
--and sod_venno not in ('A','B','U')  
and

-- JV / I
(
pod_jobord in
(
select pjd_jobord from pojbbdtl 
where 
/*
-- For 1st run
pjd_credat >= '2008-08-01' 

and
*/
-- For Daily

 pjd_credat >= convert(nvarchar(10),getdate()-1,121)

and substring(pjd_batno,1,2) not in ( 'UT','TJ','ET','GT') 
--(select ydc_prefix from sydocctl where ydc_docdsc = 'SC Update Data')
)
)




     
---------- For Delete
    
select sod_cocde, 'D' as 'type' , pod_jobord, sod_ordno , sod_ordseq, soh_cus1no, pri.cbi_cussna as 'PriCust', soh_cus2no, isnull(sec.cbi_cussna,'')  as 'SecCust',  sod_itmno,       
sod_colcde , sod_coldsc ,       
sod_ordqty, sod_ordqty*isnull(ycf_value,1)*isnull(sod_conftr,1) as 'Qty', 'PC' as 'PC' , sod_pckunt, sod_inrctn, sod_mtrctn, sod_ttlctn, sod_cbm, sod_venno, sod_cusven  ,    
isnull(pod_shpstr, '1900-01-01') as pod_shpstr  ,  
-- 2007-12-13  
isnull(pod_purord, '') as pod_purord, isnull(pod_cusitm,'') as pod_cusitm  , isnull(pod_ctnstr,0) as pod_ctnstr , isnull(pod_ctnend,0) as pod_ctnend ,  
isnull(pod_chndsc,'') as pod_chndsc ,   
isnull(pod_engdsc,'') as pod_engdsc  ,
-- Added by Mark Lau 20090526
isnull(poh_cuspno,'') as 'poh_cuspno',
isnull(pod_cuspno,'') as 'pod_cuspno'       ,
-- Added by Mark Lau 20090601
isnull(poh_reppno,'') as 'poh_reppno',
isnull(pod_respno,'') as 'pod_respno'
  
--, *      
into #tmp_Delete  
from       
--Select top 10 * from sp_help POORDDTL      
SCORDHDR (nolock)       
left join SCORDDTL(nolock) on soh_ordno = sod_ordno      
left join POORDDTL (nolock) on sod_ordno = pod_scno and sod_ordseq = pod_scline      
left join CUBASINF pri (nolock) on soh_cus1no = pri.cbi_cusno      
left join CUBASINF sec (nolock) on soh_cus2no = sec.cbi_cusno      
left join SYCONFTR (nolock) on sod_pckunt = ycf_code1      
-- Added by Mark Lau 20090526
left join poordhdr(nolock) on poh_purord = pod_purord   
, IMPNTINF (nolock)      
where       
soh_ordsts = 'REL'  
and sod_itmno = ipt_itmno       
and sod_venno  in ('A','B','U')      
and sod_oldven not in ('A','B','U')      
      
select       
tmp.sod_cocde as ssc_cocde ,       
tmp.type as ssc_type ,       
tmp.pod_jobord as ssc_jobord ,      
tmp.sod_ordno as ssc_ordno ,       
tmp.sod_ordseq as ssc_ordseq ,       
tmp.soh_cus1no as ssc_cus1no ,       
tmp.PriCust as ssc_pricus ,       
tmp.soh_cus2no as ssc_cus2no ,      
tmp.SecCust as ssc_seccus ,       
tmp.sod_itmno as ssc_itmno ,       
tmp.sod_colcde as ssc_colcde ,       
tmp.sod_coldsc as ssc_coldsc ,       
tmp.sod_ordqty as ssc_ordqty ,       
tmp.Qty as ssc_qtypc ,       
tmp.PC as ssc_um ,       
tmp.sod_pckunt as ssc_pckunt,      
tmp.sod_inrctn as ssc_inrqty ,      
tmp.sod_mtrctn as ssc_mtrqty,       
tmp.sod_ttlctn as ssc_ttlctn ,       
tmp.sod_cbm as ssc_cbm ,       
tmp.sod_venno as ssc_venno ,       
tmp.sod_cusven as ssc_cusven  ,    
tmp.pod_shpstr as ssc_shpstr  ,  
--  
tmp.pod_purord as ssc_purord ,  
tmp.pod_cusitm as ssc_cusitm,  
tmp.pod_ctnstr as ssc_ctnstr,   
tmp.pod_ctnend as ssc_ctnend,  
tmp.pod_chndsc as ssc_chndsc,  
tmp.pod_engdsc as ssc_engdsc  ,
-- Added by Mark Lau 20090526
tmp.poh_cuspno as ssc_cuspno_h,
tmp.pod_cuspno as ssc_cuspno_d       ,
-- Added by Mark Lau 20090601
tmp.poh_reppno as ssc_resppo_h,
tmp.pod_respno as ssc_resppo_d
  
into #tmp_Result      
from #tmp_Update tmp      
left join SCSUBCON sc  on tmp.pod_jobord = sc.ssc_jobord      
where      
tmp.Qty <> isnull(sc.ssc_qtypc, -1) or       
tmp.sod_pckunt <> isnull(sc.ssc_pckunt,'') or       
tmp.sod_inrctn <> isnull(sc.ssc_inrqty, -1) or      
tmp.sod_mtrctn <> isnull(sc.ssc_mtrqty, -1) or      
tmp.sod_ttlctn <> isnull(sc.ssc_ttlctn, -1) or       
tmp.sod_cbm <> isnull(sc.ssc_cbm, -1) or      
tmp.sod_venno <> isnull(sc.ssc_venno,'') or       
tmp.sod_cusven <> isnull(sc.ssc_cusven, '')  or     
tmp.pod_shpstr <> isnull(sc.ssc_shpstr, '')  or   
--  
tmp.pod_purord <> isnull(ssc_purord , '') or   
tmp.pod_cusitm <> isnull(ssc_cusitm, '') or   
tmp.pod_ctnstr <> isnull(ssc_ctnstr, 0 ) or   
tmp.pod_ctnend <> isnull(ssc_ctnend, 0 ) or   
tmp.pod_chndsc <> isnull(ssc_chndsc, '') or   
tmp.pod_engdsc <> isnull(ssc_engdsc, '')  
  
union      
select       
tmp.sod_cocde as ssc_cocde ,       
tmp.type as ssc_type ,       
tmp.pod_jobord as ssc_jobord ,      
tmp.sod_ordno as ssc_ordno ,       
tmp.sod_ordseq as ssc_ordseq ,       
tmp.soh_cus1no as ssc_cus1no ,       
tmp.PriCust as ssc_pricus ,       
tmp.soh_cus2no as ssc_cus2no ,      
tmp.SecCust as ssc_seccus ,       
tmp.sod_itmno as ssc_itmno ,       
tmp.sod_colcde as ssc_colcde ,       
tmp.sod_coldsc as ssc_coldsc ,       
tmp.sod_ordqty as ssc_ordqty ,       
tmp.Qty as ssc_qtypc ,       
tmp.PC as ssc_um ,       
tmp.sod_pckunt as ssc_pckunt,      
tmp.sod_inrctn as ssc_inrqty ,      
tmp.sod_mtrctn as ssc_mtrqty,       
tmp.sod_ttlctn as ssc_ttlctn ,       
tmp.sod_cbm as ssc_cbm ,       
tmp.sod_venno as ssc_venno ,       
tmp.sod_cusven as ssc_cusven  ,    
tmp.pod_shpstr as ssc_shpstr  ,  
--  
tmp.pod_purord as ssc_purord ,  
tmp.pod_cusitm as ssc_cusitm,  
tmp.pod_ctnstr as ssc_ctnstr,   
tmp.pod_ctnend as ssc_ctnend,  
tmp.pod_chndsc as ssc_chndsc,  
tmp.pod_engdsc as ssc_engdsc  ,
-- Added by Mark Lau 20090526
tmp.poh_cuspno as ssc_cuspno_h,
tmp.pod_cuspno as ssc_cuspno_d     ,
-- Added by Mark Lau 20090601
tmp.poh_reppno as ssc_resppo_h,
tmp.pod_respno as ssc_resppo_d
from #tmp_Delete tmp      
left join SCSUBCON sc on tmp.pod_jobord = sc.ssc_jobord       
where sc.ssc_jobord is not null      
order by tmp.pod_jobord      
      
      
delete from SCSUBCON      
where ssc_jobord in (      
 select ssc_jobord from #tmp_Result      
)      



insert into SCSUBCON (      
ssc_cocde ,       
ssc_typ ,       
ssc_jobord ,       
ssc_ordno ,       
ssc_ordseq ,       
ssc_cus1no ,       
ssc_pricus ,       
ssc_cus2no ,       
ssc_seccus ,       
ssc_itmno ,       
ssc_colcde ,       
ssc_coldsc ,       
ssc_ordqty ,       
ssc_qtypc ,       
ssc_um ,       
ssc_pckunt ,       
ssc_inrqty ,       
ssc_mtrqty ,       
ssc_ttlctn ,       
ssc_cbm ,       
ssc_venno ,       
ssc_cusven ,       
ssc_credat  ,     
ssc_shpstr  ,  
--  
ssc_purord ,   
ssc_cusitm,   
ssc_ctnstr,   
ssc_ctnend,   
ssc_chndsc,   
ssc_engdsc  ,
-- Added by Mark Lau 20090526
ssc_cuspno_h,
ssc_cuspno_d     ,
-- Added by Mark Lau 20090601
ssc_resppo_h,
ssc_resppo_d
)      
select       
ssc_cocde ,       
ssc_type ,       
ssc_jobord ,       
ssc_ordno ,       
ssc_ordseq ,       
ssc_cus1no ,       
ssc_pricus ,       
ssc_cus2no ,       

ssc_seccus ,       
ssc_itmno ,       
ssc_colcde ,       
ssc_coldsc ,       
ssc_ordqty ,       
ssc_qtypc ,       
ssc_um ,       
ssc_pckunt ,       
ssc_inrqty ,       
ssc_mtrqty ,       
ssc_ttlctn ,       
ssc_cbm ,       
ssc_venno ,       
ssc_cusven ,       
@date  ,    
ssc_shpstr  ,  
ssc_purord ,   
ssc_cusitm,   
ssc_ctnstr,   
ssc_ctnend,   
ssc_chndsc,   
ssc_engdsc  ,
-- Added by Mark Lau 20090526
ssc_cuspno_h,
ssc_cuspno_d     ,
-- Added by Mark Lau 20090601
ssc_resppo_h,
ssc_resppo_d
  
from #tmp_Result where ssc_type <> 'D'      
      
select     
ssc_cocde ,       
ssc_type ,       
ssc_jobord ,      
ssc_ordno ,       
ssc_ordseq ,       
ssc_cus1no ,       
ssc_pricus ,       
ssc_cus2no ,      
ssc_seccus ,       
ssc_itmno ,       
ssc_colcde ,       
ssc_coldsc ,       
ssc_ordqty ,       
ssc_qtypc ,       
ssc_um ,       
ssc_pckunt,      
ssc_inrqty ,      
ssc_mtrqty,       
ssc_ttlctn ,       
ssc_cbm ,       
ssc_venno ,       
ssc_cusven  ,    
ltrim(rtrim(replace(convert(varchar(10), ssc_shpstr , 121),'-',''))) as ssc_shpstr ,     
ltrim(rtrim(replace(convert(varchar(10), @date , 121),'-',''))) as ssc_credat  ,  
  ssc_purord ,   
ssc_cusitm,   
ssc_ctnstr,   
ssc_ctnend,   
ssc_chndsc,   
ssc_engdsc  ,
-- Added by Mark Lau 20090526
-- case when ssc_cuspno_d <> '' then ssc_cuspno_d else ssc_cuspno_h end as 'ssc_cuspno'
ssc_cuspno_h,
ssc_cuspno_d,
-- Added by Mark Lau 20090601
ssc_resppo_h,
ssc_resppo_d
from #tmp_Result      


drop table #tmp_Update      
drop table #tmp_Delete      
drop table #tmp_Result      
      
end





GO
GRANT EXECUTE ON [dbo].[sp_list_ABU_SCDATA] TO [ERPUSER] AS [dbo]
GO
