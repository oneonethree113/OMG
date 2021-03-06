/****** Object:  StoredProcedure [dbo].[sp_select_POJBBSAP_UPD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POJBBSAP_UPD]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POJBBSAP_UPD]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE   procedure [dbo].[sp_select_POJBBSAP_UPD]      
@cocde varchar(6)      
as      
begin      
declare @date as datetime

--set @date='2017/08/14 00:00:00'
set @date=getdate()

 create table #tmp_PDO(      
  pod_jobord varchar(30),      
  pod_purord varchar(30),      
  pod_purseq int,      
  pod_scno varchar(30),      
  pod_scline int,      
  UPDPOD char(1),      
  UPDPOH char(1),      
  UPDSCD char(1),      
  UPDSCH char(1),      
  UPDCTN char(1),      
  UPDSHP char(1),      
  UPDSM char(1),      
  UPDFTY char(1),      
  UPDQTY char(1),      
  UPDPRC char(1),
  ZUTYPE varchar(20)   
 ) 
      
      
-- 01. Check for Update Order Qty      
 insert into #tmp_PDO (pod_jobord , pod_purord , pod_purseq , pod_scno , pod_scline ,       
  UPDPOD , UPDPOH , UPDSCD , UPDSCH , UPDCTN , UPDSHP , UPDSM , UPDFTY , UPDQTY, UPDPRC       
 )      
 select erp.pod_jobord , erp.pod_purord , erp.pod_purseq ,  erp.pod_scno , erp.pod_scline ,      
   '' as UPDPOD, '' as UPDPOH, '' as UPDSCD, '' as UPDSCH , '' as UPDCTN,       
  '' as UPDSHP , '' as UPDSM, '' as UPDFTY, 'Y' as UPDQTY   , '' as UPDPRC   
 from       
 SAPPODTL sap (nolock) ,       
 POORDDTL erp (nolock) ,      
 SCORDDTL (nolock) , 
 IMPNTINF (nolock) , SCORDHDR (nolock)
 where       
 sap.pod_cocde = @cocde      
 and erp.pod_purord = sap.pod_purord      
 and erp.pod_purseq = sap.pod_purseq      
 and erp.pod_itmno = ipt_itmno      
 and erp.pod_ordqty<>sap.pod_ordqty       
 and erp.pod_jobord <> ''      
 and erp.pod_scno = sod_ordno
 and erp.pod_scline = sod_ordseq
 and sod_zorvbeln <> ''      
 and ( sod_upddat >= '2013-10-01' or erp.pod_upddat >= '2013-10-01' or sod_zorvbeln like 'WT%')
 and soh_ordno = sod_ordno 
 --and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and sod_upddat >= '2099-01-01'))
 and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and convert(varchar(10),sod_upddat,111) = convert(varchar(10),@date,111)))

-- 02. Check for Update Shipment (Date and Qty)
 insert into #tmp_PDO (pod_jobord , pod_purord , pod_purseq , pod_scno , pod_scline ,       
  UPDPOD , UPDPOH , UPDSCD , UPDSCH , UPDCTN , UPDSHP , UPDSM , UPDFTY , UPDQTY , UPDPRC      
 )      
 select erp.pod_jobord , erp.pod_purord , erp.pod_purseq ,  erp.pod_scno , erp.pod_scline ,      
   '' as UPDPOD, '' as UPDPOH, '' as UPDSCD, '' as UPDSCH , '' as UPDCTN,       
  'Y' as UPDSHP , '' as UPDSM, '' as UPDFTY, '' as UPDQTY      , '' as UPDPRC
 from       
 SAPPODTL sap (nolock) ,       
 POORDDTL erp (nolock) ,      
 SCORDDTL (nolock) , 
 IMPNTINF (nolock) , SCORDHDR (nolock)
 where       
 sap.pod_cocde = @cocde      
 and erp.pod_purord = sap.pod_purord      
 and erp.pod_purseq = sap.pod_purseq      
 and erp.pod_itmno = ipt_itmno      
 and erp.pod_jobord <> ''      
 and       
 (   erp.pod_shpstr<>sap.pod_shpstr or  erp.pod_shpend<>sap.pod_shpend
     or erp.pod_candat<>sap.pod_candat or erp.pod_ordqty<>sap.pod_ordqty    
 )      
 and erp.pod_jobord <> ''      
 and erp.pod_scno = sod_ordno 
 and erp.pod_scline = sod_ordseq
 and sod_zorvbeln <> ''
and ( sod_upddat >= '2013-10-01' or erp.pod_upddat >= '2013-10-01' or sod_zorvbeln like 'WT%')
and soh_ordno = sod_ordno 
--and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and sod_upddat >= '2099-01-01'))
 and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and convert(varchar(10),sod_upddat,111) = convert(varchar(10),@date,111)))
      

-- 02. Check for Update Shipment (Ctn)
 insert into #tmp_PDO (pod_jobord , pod_purord , pod_purseq , pod_scno , pod_scline ,       
  UPDPOD , UPDPOH , UPDSCD , UPDSCH , UPDCTN , UPDSHP , UPDSM , UPDFTY , UPDQTY  , UPDPRC     
 )      
 select pod_jobord , pod_purord , pod_purseq ,  pod_scno , pod_scline ,      
   '' as UPDPOD, '' as UPDPOH, '' as UPDSCD, '' as UPDSCH , '' as UPDCTN,       
  'Y' as UPDSHP , '' as UPDSM, '' as UPDFTY, '' as UPDQTY  , '' as UPDPRC    
 from       
 PODTLSHP erp (nolock)       
 left join SAPDTLSHP sap (nolock) on erp.pds_purord = sap.pds_purord and erp.pds_seq = sap.pds_seq and erp.pds_shpseq = sap.pds_shpseq      
 , IMPNTINF (nolock)      
 , POORDDTL (nolock)       
 , SCORDDTL (nolock)
 , SCORDHDR (nolock)
 where       
 erp.pds_cocde = @cocde      
 and pod_itmno = ipt_itmno     
 and (
 erp.pds_from <> isnull(sap.pds_from,'1900-01-01') or      
 erp.pds_to <> isnull(sap.pds_to,'1900-01-01') or      
-- erp.pds_ttlctn <> isnull(sap.pds_ttlctn,-1)      
 erp.pds_ordqty <> isnull(sap.pds_ttlctn,-1)      
 )      
 and erp.pds_purord = pod_purord      
 and erp.pds_seq = pod_purseq      
and  sap.pds_purord is not null  
 and pod_jobord <> ''      
 and pod_scno = sod_ordno 
 and pod_scline = sod_ordseq
 and sod_zorvbeln <> ''
and ( sod_upddat >= '2013-10-01' or pod_upddat >= '2013-10-01' or sod_zorvbeln like 'WT%')     
and soh_ordno = sod_ordno 
--and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and sod_upddat >= '2099-01-01'))
 and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and convert(varchar(10),sod_upddat,111) = convert(varchar(10),@date,111)))

      
-- 03. Check for PO Detail
  insert into #tmp_PDO (pod_jobord , pod_purord , pod_purseq , pod_scno , pod_scline ,       
  UPDPOD , UPDPOH , UPDSCD , UPDSCH , UPDCTN , UPDSHP , UPDSM , UPDFTY , UPDQTY , UPDPRC      
 )      
 select erp.pod_jobord , erp.pod_purord , erp.pod_purseq ,  erp.pod_scno , erp.pod_scline ,      
   'Y' as UPDPOD, '' as UPDPOH, '' as UPDSCD, '' as UPDSCH , '' as UPDCTN,       
  '' as UPDSHP , '' as UPDSM, '' as UPDFTY, '' as UPDQTY , '' as UPDPRC      
 from       
 SAPPODTL sap (nolock) ,       
 POORDDTL erp (nolock) ,      
 IMPNTINF (nolock) , 
 SCORDDTL (nolock) , SCORDHDR (nolock)
 where       
 sap.pod_cocde = @cocde      
 and erp.pod_purord = sap.pod_purord      
 and erp.pod_purseq = sap.pod_purseq      
 and erp.pod_itmno = ipt_itmno      
 and (      
 erp.pod_seccusitm<>sap.pod_seccusitm or       
 erp.pod_cusitm<>sap.pod_cusitm or       
 erp.pod_cussku<>sap.pod_cussku or       
 erp.pod_engdsc<>sap.pod_engdsc or       
 erp.pod_chndsc<>sap.pod_chndsc or       
 erp.pod_vencol<>sap.pod_vencol or       
 erp.pod_cuscol<>sap.pod_cuscol or       
 erp.pod_coldsc<>sap.pod_coldsc or       
 erp.pod_dept<>sap.pod_dept or       
 erp.pod_cuspno<>sap.pod_cuspno or       
 erp.pod_respno<>sap.pod_respno or       
 erp.pod_hrmcde<>sap.pod_hrmcde or       
 erp.pod_lblcde<>sap.pod_lblcde or       
 erp.pod_cususd<>sap.pod_cususd or       
 erp.pod_cuscad<>sap.pod_cuscad or       
 erp.pod_ctnstr<>sap.pod_ctnstr or       
 erp.pod_ctnend<>sap.pod_ctnend or       
 erp.pod_dtyrat<>sap.pod_dtyrat or       
 erp.pod_typcode<>sap.pod_typcode or       
 erp.pod_code1<>sap.pod_code1 or       
 erp.pod_code2<>sap.pod_code2 or       
 erp.pod_code3<>sap.pod_code3 or       
 erp.pod_rmk<>sap.pod_rmk or       
 erp.pod_pckitr<>sap.pod_pckitr 
)      
 and erp.pod_jobord <> ''      
 and erp.pod_scno = sod_ordno 
 and erp.pod_scline = sod_ordseq
 and sod_zorvbeln <> ''
and ( sod_upddat >= '2013-10-01' or erp.pod_upddat >= '2013-10-01' or sod_zorvbeln like 'WT%')   
and soh_ordno = sod_ordno
--and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and sod_upddat >= '2099-01-01'))
 and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and convert(varchar(10),sod_upddat,111) = convert(varchar(10),@date,111)))

-- 04. Check for PO Header
 insert into #tmp_PDO (pod_jobord , pod_purord , pod_purseq , pod_scno , pod_scline ,       
  UPDPOD , UPDPOH , UPDSCD , UPDSCH , UPDCTN , UPDSHP , UPDSM , UPDFTY , UPDQTY , UPDPRC      
 )      
 select pod_jobord , pod_purord , pod_purseq ,  pod_scno , pod_scline ,      
   '' as UPDPOD, 'Y' as UPDPOH, '' as UPDSCD, '' as UPDSCH , '' as UPDCTN,       
  '' as UPDSHP , '' as UPDSM, '' as UPDFTY, '' as UPDQTY , '' as UPDPRC     
 from       
 SAPPOHDR sap (nolock) ,       
 POORDHDR erp (nolock) ,      
 POORDDTL (nolock) ,
 SCORDDTL (nolock) ,        
 IMPNTINF (nolock) , SCORDHDR (nolock)
 where       
 sap.poh_cocde = @cocde      
 and erp.poh_purord = sap.poh_purord      
 and pod_itmno = ipt_itmno      
 and (      
  erp.poh_venno<>sap.poh_venno or       
  erp.poh_prmcus<>sap.poh_prmcus or       
  erp.poh_seccus<>sap.poh_seccus or       
  erp.poh_shpadr<>sap.poh_shpadr or       
  erp.poh_shpstt<>sap.poh_shpstt or       
  erp.poh_shpcty<>sap.poh_shpcty or       
  erp.poh_shppst<>sap.poh_shppst or       
  erp.poh_ttlcbm<>sap.poh_ttlcbm or       
  erp.poh_ttlctn<>sap.poh_ttlctn or       
  erp.poh_cuspno<>sap.poh_cuspno or       
  erp.poh_cpodat<>sap.poh_cpodat or       
  erp.poh_reppno<>sap.poh_reppno or       
  erp.poh_pocdat<>sap.poh_pocdat or       
  erp.poh_lbldue<>sap.poh_lbldue or       
  erp.poh_lblven<>sap.poh_lblven or       
  erp.poh_subcde<>sap.poh_subcde or       
((case erp.poh_cusctn when 0 then '' else 'TOTAL CTN# - ' + ltrim(rtrim(str(erp.poh_cusctn))) + char(10) + char(13) end 
+ case erp.poh_dest when '' then '' else 'DESTINATION: ' + ltrim(rtrim(erp.poh_dest)) + char(10) + char(13) end + erp.poh_rmk) <>  sap.poh_rmk) or
  erp.poh_ordno<>sap.poh_ordno
 )      
 and pod_jobord <> ''      
 and erp.poh_purord = pod_purord      
 and pod_scno = sod_ordno 
 and pod_scline = sod_ordseq
 and sod_zorvbeln <> ''
 and ( sod_upddat >= '2013-10-01' or pod_upddat >= '2013-10-01' or sod_zorvbeln like 'WT%')
 and soh_ordno = sod_ordno 
-- and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and sod_upddat >= '2099-01-01'))
  and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and convert(varchar(10),sod_upddat,111) = convert(varchar(10),@date,111)))
     
-- 05. Check for Carton
 insert into #tmp_PDO (pod_jobord , pod_purord , pod_purseq , pod_scno , pod_scline ,       
  UPDPOD , UPDPOH , UPDSCD , UPDSCH , UPDCTN , UPDSHP , UPDSM , UPDFTY , UPDQTY, UPDPRC       
 )      
 select pod_jobord , pod_purord , pod_purseq ,  pod_scno , pod_scline ,      
   '' as UPDPOD, '' as UPDPOH, '' as UPDSCD, '' as UPDSCH , 'Y' as UPDCTN,       
  '' as UPDSHP , '' as UPDSM, '' as UPDFTY, '' as UPDQTY, '' as UPDPRC      
 from       
 PODTLSHP erp (nolock)       
 left join SAPDTLCTN sap (nolock) on erp.pds_purord = sap.pdc_purord and erp.pds_seq = sap.pdc_seq and erp.pds_shpseq = sap.pdc_ctnseq      
 , IMPNTINF (nolock)      
 , POORDDTL (nolock)       
 , SCORDDTL (nolock)
 , SCORDHDR (nolock)
 where       
 erp.pds_cocde = @cocde      
 and pod_itmno = ipt_itmno      
 and (      
 erp.pds_ctnstr <> isnull(sap.pdc_from,0) or      
 erp.pds_ctnend <> isnull(sap.pdc_to,0) or      
 erp.pds_ttlctn <> isnull(sap.pdc_ttlctn,-1)      
 )      
 and erp.pds_purord = pod_purord      
 and erp.pds_seq = pod_purseq      
 and sap.pdc_purord is not null  
 and pod_jobord <> ''      
 and pod_scno = sod_ordno 
 and pod_scline = sod_ordseq
 and sod_zorvbeln <> ''
 and ( sod_upddat >= '2013-10-01' or pod_upddat >= '2013-10-01' or sod_zorvbeln like 'WT%')
 and soh_ordno = sod_ordno 
-- and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and sod_upddat >= '2099-01-01'))
 and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and convert(varchar(10),sod_upddat,111) = convert(varchar(10),@date,111)))

-- 06. Check for Shipmark
 insert into #tmp_PDO (pod_jobord , pod_purord , pod_purseq , pod_scno , pod_scline ,       
  UPDPOD , UPDPOH , UPDSCD , UPDSCH , UPDCTN , UPDSHP , UPDSM , UPDFTY , UPDQTY, UPDPRC       
 )      
 select pod_jobord , pod_purord , pod_purseq ,  pod_scno , pod_scline ,      
   '' as UPDPOD, '' as UPDPOH, '' as UPDSCD, '' as UPDSCH , '' as UPDCTN,       
  '' as UPDSHP , 'Y' as UPDSM, '' as UPDFTY, '' as UPDQTY   , '' as UPDPRC   
 from       
 POSHPMRK erp (nolock)       
 left join SAPSHPMRK sap (nolock) on erp.psm_purord = sap.psm_purord and erp.psm_shptyp = sap.psm_shptyp  
 , IMPNTINF (nolock)      
 , POORDDTL (nolock)       
 , SCORDDTL (nolock)
 , SCORDHDR (nolock)
 where       
 erp.psm_cocde = @cocde      
 and pod_itmno = ipt_itmno  
 and (      
 erp.psm_engdsc <> isnull(sap.psm_engdsc,'') or   
 erp.psm_chndsc <> isnull(sap.psm_chndsc,'') or   
 erp.psm_engrmk <> isnull(sap.psm_engrmk,'') or   
 erp.psm_chnrmk <> isnull(sap.psm_chnrmk,'') 
 )      
 and erp.psm_purord = pod_purord      
 and sap.psm_purord is not null  
 and pod_jobord <> ''      
 and pod_scno = sod_ordno 
 and pod_scline = sod_ordseq
 and sod_zorvbeln <> ''
 and ( sod_upddat >= '2013-10-01' or pod_upddat >= '2013-10-01' or sod_zorvbeln like 'WT%')
 and soh_ordno = sod_ordno 
-- and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and sod_upddat >= '2099-01-01'))
 and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and convert(varchar(10),sod_upddat,111) = convert(varchar(10),@date,111)))

-- 07. Check for Update Price
 insert into #tmp_PDO (pod_jobord , pod_purord , pod_purseq , pod_scno , pod_scline ,       
  UPDPOD , UPDPOH , UPDSCD , UPDSCH , UPDCTN , UPDSHP , UPDSM , UPDFTY , UPDQTY , UPDPRC      
 )      
 select pod_jobord , pod_purord , pod_purseq ,  pod_scno , pod_scline ,      
   '' as UPDPOD, '' as UPDPOH, '' as UPDSCD, '' as UPDSCH , '' as UPDCTN,       
  '' as UPDSHP , '' as UPDSM, '' as UPDFTY, '' as UPDQTY , 'Y' as UPDPRC      
from 
SAPSCDTL sap (nolock),
SCORDDTL erp (nolock),
POORDDTL (nolock),
IMPNTINF (nolock), SCORDHDR (nolock)
 where       
 sap.sod_cocde = @cocde      
 and erp.sod_ordno = sap.sod_ordno
 and erp.sod_ordseq = sap.sod_ordseq      
 and erp.sod_itmno = ipt_itmno      
 and erp.sod_ordno = pod_scno
 and erp.sod_ordseq = pod_scline
 and pod_jobord <> ''      
and
(
( erp.sod_ftyprc <> sap.sod_ftyprc and erp.sod_dv = '' )
or 
(erp.sod_ftycst <> sap.sod_ftycst  and erp.sod_dv = '' )
or 
(erp.sod_bomcst <> sap.sod_bomcst  and erp.sod_dv = '' )
or
(erp.sod_dvftyprc <> sap.sod_dvftyprc and erp.sod_dv <> '' )
or 
(erp.sod_dvftycst <> sap.sod_dvftycst and erp.sod_dv <> '' )
or 
(erp.sod_dvbomcst <> sap.sod_dvbomcst and erp.sod_dv <> '' )
)
and erp.sod_zorvbeln <> ''
and 
( erp.sod_upddat >= '2008-06-01' or erp.sod_credat >= '2008-06-01')
and erp.sod_ordqty <> 0
and ( erp.sod_upddat >= '2013-10-01' or pod_upddat >= '2013-10-01' or erp.sod_zorvbeln like 'WT%')
and soh_ordno = erp.sod_ordno 
--and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and erp.sod_upddat >= '2099-01-01'))
 and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and convert(varchar(10),erp.sod_upddat,111) = convert(varchar(10),@date,111)))





-- Added by Mark Lau 20090603, for sod_cusven
 insert into #tmp_PDO (pod_jobord , pod_purord , pod_purseq , pod_scno , pod_scline ,       
  UPDPOD , UPDPOH , UPDSCD , UPDSCH , UPDCTN , UPDSHP , UPDSM , UPDFTY , UPDQTY , UPDPRC      
 )      
 select pod_jobord , pod_purord , pod_purseq ,  pod_scno , pod_scline ,      
   'Y' as UPDPOD, '' as UPDPOH, '' as UPDSCD, '' as UPDSCH , '' as UPDCTN,       
  '' as UPDSHP , '' as UPDSM, '' as UPDFTY, '' as UPDQTY , '' as UPDPRC      
from 
SAPSCDTL sap (nolock),
SCORDDTL erp (nolock),
POORDDTL (nolock),
IMPNTINF (nolock)
, SCORDHDR (nolock)
 where       
 sap.sod_cocde = @cocde      
 and erp.sod_ordno = sap.sod_ordno
 and erp.sod_ordseq = sap.sod_ordseq      
 and erp.sod_itmno = ipt_itmno      
and erp.sod_ordno = pod_scno
and erp.sod_ordseq = pod_scline
 and pod_jobord <> ''      
and
erp.sod_cusven <> sap.sod_cusven
 and erp.sod_zorvbeln <> ''
and 
( erp.sod_upddat >= '2008-06-01' or erp.sod_credat >= '2008-06-01')
and erp.sod_ordqty <> 0
and ( erp.sod_upddat >= '2013-10-01' or pod_upddat >= '2013-10-01' or erp.sod_zorvbeln like 'WT%')
and soh_ordno = erp.sod_ordno 
--and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and erp.sod_upddat >= '2099-01-01'))
 and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and convert(varchar(10),erp.sod_upddat,111) = convert(varchar(10),@date,111)))



-- Added by Mark Lau 20090310
 insert into #tmp_PDO (pod_jobord , pod_purord , pod_purseq , pod_scno , pod_scline ,       
  UPDPOD , UPDPOH , UPDSCD , UPDSCH , UPDCTN , UPDSHP , UPDSM , UPDFTY , UPDQTY , UPDPRC      
 )      
 select pod_jobord , pod_purord , pod_purseq ,  pod_scno , pod_scline ,      
   '' as UPDPOD, '' as UPDPOH, 'Y' as UPDSCD, '' as UPDSCH , '' as UPDCTN,       
  '' as UPDSHP , '' as UPDSM, '' as UPDFTY, '' as UPDQTY , '' as UPDPRC      
from 
SAPSCDTL sap (nolock),
SCORDDTL erp (nolock),
POORDDTL (nolock),
IMPNTINF (nolock)
, SCORDHDR (nolock)
 where       
 sap.sod_cocde = @cocde      
 and erp.sod_ordno = sap.sod_ordno
 and erp.sod_ordseq = sap.sod_ordseq      
 and erp.sod_itmno = ipt_itmno      
 and erp.sod_ordno = pod_scno
 and erp.sod_ordseq = pod_scline
 and pod_jobord <> ''      
and
erp.sod_venno<>sap.sod_venno
and erp.sod_zorvbeln <> ''
and 
( erp.sod_upddat >= '2008-06-01' or erp.sod_credat >= '2008-06-01')
and erp.sod_ordqty <> 0
and ( erp.sod_upddat >= '2013-10-01' or pod_upddat >= '2013-10-01' or erp.sod_zorvbeln like 'WT%')
and soh_ordno = erp.sod_ordno 
--and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and erp.sod_upddat >= '2099-01-01'))
 and ((soh_ordsts <> 'CLO') or (soh_ordsts = 'CLO' and convert(varchar(10),erp.sod_upddat,111) = convert(varchar(10),@date,111)))

/*
 delete #tmp_PDO from #tmp_PDO, SCORDHDR (nolock)      
 where pod_scno = soh_ordno and soh_ordsts not in ('REL', 'CLO') and not (soh_ordsts = 'CAN' and UPDQTY = 'Y')
      
 delete #tmp_PDO from #tmp_PDO, POORDHDR (nolock)      
 where pod_purord = poh_purord and poh_pursts not in ('REL', 'CLO') and not (poh_pursts = 'CAN' and UPDQTY = 'Y')

 delete #tmp_PDO from #tmp_PDO ,SCORDDTL      
 where pod_scno = sod_ordno and pod_scline = sod_ordseq       
 and sod_zorvbeln <> '' and sod_shpqty > 0  
*/
      
--  O : Others  
--  S : Ship Date  
--  Q : Quantity  
--  F : Factory  
--  G : Non B/U/W to Non B/U/W  
--  R : Resume  
--  P : Resume for B/U/W
--  C   : Cancel  
--  D : Cancel for B/U/W
--  B : Cost Change

update #tmp_PDO set zutype = ''  
  
 update #tmp_PDO set zutype = zutype + 'O' where pod_jobord in (select pod_jobord from #tmp_PDO(nolock) where UPDPOD = 'Y' ) and charindex('O',zutype) <= 0  
 update #tmp_PDO set zutype = zutype + 'O' where pod_jobord in (select pod_jobord from #tmp_PDO(nolock) where UPDPOH = 'Y' ) and charindex('O',zutype) <= 0  
 update #tmp_PDO set zutype = zutype + 'O' where pod_jobord in (select pod_jobord from #tmp_PDO(nolock) where UPDSCD = 'Y' ) and charindex('O',zutype) <= 0  
 update #tmp_PDO set zutype = zutype + 'O' where pod_jobord in (select pod_jobord from #tmp_PDO(nolock) where UPDSCH = 'Y' ) and charindex('O',zutype) <= 0  
 update #tmp_PDO set zutype = zutype + 'O' where pod_jobord in (select pod_jobord from #tmp_PDO(nolock) where UPDCTN = 'Y' ) and charindex('O',zutype) <= 0  

 update #tmp_PDO set zutype = zutype + 'B' where pod_jobord in (select pod_jobord  from #tmp_PDO(nolock) where UPDPRC = 'Y' ) and charindex('B',zutype) <= 0 
    
 update #tmp_PDO set zutype = zutype + 'M' where pod_jobord in (select pod_jobord from #tmp_PDO(nolock) where UPDSM = 'Y' ) and charindex('M',zutype) <= 0  
 update #tmp_PDO set zutype = zutype + 'S' where pod_jobord in (select pod_jobord from #tmp_PDO(nolock) where UPDSHP = 'Y' ) and charindex('S',zutype) <= 0  
 update #tmp_PDO set zutype = zutype + 'Q' where pod_jobord in (select pod_jobord  from #tmp_PDO(nolock) where UPDQTY = 'Y' ) and charindex('Q',zutype) <= 0  


 update #tmp_PDO set zutype = zutype + 'F' where pod_jobord in (select pod_jobord  from #tmp_PDO(nolock) where UPDFTY = 'F') and charindex('F',zutype) <= 0  
 update #tmp_PDO set zutype = zutype + 'R' where pod_jobord in (select pod_jobord  from #tmp_PDO(nolock) where UPDFTY = 'R') and charindex('R',zutype) <= 0  
 update #tmp_PDO set zutype = zutype + 'C' where pod_jobord in (select pod_jobord  from #tmp_PDO(nolock) where UPDFTY = 'C') and charindex('C',zutype) <= 0

 update #tmp_PDO set zutype = zutype + 'G' where pod_jobord in (select pod_jobord  from #tmp_PDO(nolock) where UPDFTY = 'G') and charindex('G',zutype) <= 0  
 update #tmp_PDO set zutype = zutype + 'P' where pod_jobord in (select pod_jobord  from #tmp_PDO(nolock) where UPDFTY = 'P') and charindex('P',zutype) <= 0  
 update #tmp_PDO set zutype = zutype + 'D' where pod_jobord in (select pod_jobord  from #tmp_PDO(nolock) where UPDFTY = 'D') and charindex('D',zutype) <= 0
  


declare @batch_date datetime
set @batch_date = @date

insert into POJBBSAP_UPD
select distinct
@cocde,pod_jobord,pod_purord,pod_purseq,pod_scno,pod_scline,
UPDPOD,UPDPOH,UPDSCD,UPDSCH,UPDCTN,UPDSHP,UPDSM,UPDFTY,UPDQTY,UPDPRC,ZUTYPE,
@batch_date, '', @batch_date
from #tmp_PDO, POORDHDR
where poh_purord = pod_purord
and poh_signappflg <> 'Y'




delete from #tmp_PDO from #tmp_PDO, POORDHDR
where poh_purord = pod_purord
and poh_signappflg <> 'Y'

insert into #tmp_PDO
select pod_jobord,pod_purord,pod_purseq,pod_scno,pod_scline,
UPDPOD,UPDPOH,UPDSCD,UPDSCH,UPDCTN,UPDSHP,UPDSM,UPDFTY,UPDQTY,UPDPRC,ZUTYPE
from POJBBSAP_UPD, POORDHDR
where poh_purord = pod_purord and ACT = '' and poh_signappflg = 'Y'


update POJBBSAP_UPD set ACT = 'Y', ACTDAT = @batch_date from POJBBSAP_UPD, POORDHDR
where poh_purord = pod_purord and ACT = '' and poh_signappflg = 'Y'

SELECT
distinct       
pod.pod_scno,        
pod.pod_jobord,        
pod.pod_runno,        
pod.pod_itmno,        
vbi_vensna,        
'Y' as 'pjd_confrm',        
'' as 'pjd_batseq',        
'new' as 'pjd_recsts',        
vbi_venno as vencde  ,       
ZUTYPE      ,
'' as 'reason'
FROM      
#tmp_PDO tmp,         
POORDDTL pod (nolock), VNBASINF  (nolock)      
WHERE        
pod.pod_purord = tmp.pod_purord and      
pod.pod_purseq = tmp.pod_purseq and        
pod.pod_prdven = vbi_venno  and
pod.pod_upddat >= @date-180
ORDER BY        
pod.pod_jobord    

      
drop table #tmp_PDO      

      
end

GO
GRANT EXECUTE ON [dbo].[sp_select_POJBBSAP_UPD] TO [ERPUSER] AS [dbo]
GO
