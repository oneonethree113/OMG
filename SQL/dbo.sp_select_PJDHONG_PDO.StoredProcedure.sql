/****** Object:  StoredProcedure [dbo].[sp_select_PJDHONG_PDO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PJDHONG_PDO]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PJDHONG_PDO]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- Checked by Allan Yuen at 27/07/2003            
--sp_select_PJDHONG_PDO 'UCPP','UB0700012','X'          
          
      
      
-- sp_select_PJDHONG_PDO 'UCP','TJ0700283','X'    
      
CREATE  PROCEDURE [dbo].[sp_select_PJDHONG_PDO]             
            
@cocde   nvarchar(6),            
@batno    nvarchar(20)  ,          
@isSAP char(1) = ''          
AS            
            
create table #tmpitm(          
  pod_scno nvarchar(40),            
  pod_itmno nvarchar(40),            
  pjd_batseq nvarchar(8),          
  vencde varchar(20),          
  pod_prdven varchar(20)          
)          
          
IF @cocde <> 'UCP'            
BEGIN            
            
insert into #tmpitm          
 SELECT             
  DISTINCT            
  pod_scno,            
  pod_itmno,            
  pjd_batseq,            
  poh_venno as vencde  ,          
  pod_prdven          
 FROM      
  POJBBDTL (nolock),             
  POORDDTL (nolock),             
  POORDHDR (nolock)            
 WHERE             
  pjd_cocde = @cocde AND            
  pjd_batno = @batno AND            
  pjd_jobord = pod_jobord AND            
  pod_purord = poh_purord AND            
  poh_cocde = pjd_cocde AND            
  pjd_confrm = 'Y'           
          
          
END            
ELSE            
BEGIN            
            
 select             
  *             
 into             
  #Temp1            
 FROM            
  (SELECT             
   DISTINCT            
   pod_scno,             
   pod_itmno,            
   pjd_batseq,            
   isnull(sod_subcde, '') as vencde  ,          
   pod_prdven          
  FROM              
  POJBBDTL (nolock),             
   POORDDTL (nolock)
   left join SCORDDTL (nolock) on sod_cocde = pod_cocde and sod_ordno = pod_scno and sod_ordseq = pod_scline
  WHERE             
   pjd_cocde = @cocde AND            
   pjd_batno = @batno AND            
   pjd_jobord = pod_jobord AND            
   pjd_confrm = 'Y'
  UNION            
             
  SELECT             
   DISTINCT            
   pod_scno,            
   pod_itmno,            
   pjd_batseq,            
   ltrim(rtrim(poh_venno)) + '3a' as vencde  ,          
   pod_prdven          
  FROM             
   POJBBDTL (nolock),             
   POORDDTL (nolock),             
   POORDHDR (nolock)            
  WHERE             
   pjd_cocde = @cocde AND            
   pjd_batno = @batno AND            
   pjd_jobord = pod_jobord AND            
   pod_purord = poh_purord AND            
   poh_cocde = pjd_cocde AND            
   pjd_confrm = 'Y' and            
   poh_venno <> '0005' and poh_venno <> '0006'  and poh_venno <> '0007'  and poh_venno <> '0008'  and poh_venno <> '0009'             
  ) AS TABLE_AA            
            
insert into #tmpitm          
 SELECT             
  *            
 FROM             
  #TEMP1 (nolock)          
 WHERE            
  LTRIM(RTRIM(VENCDE)) <> ''            
      
      
-- ORDER BY             
--  pjd_batseq            
            
END          
          
      
      
      
      
          
if @isSAP = 'X'          
begin          
      
--select * from #tmpitm      
-- 取消倍化檢查流程 20140704 
/*
delete tmp      
from      
#tmpitm as tmp, POJBBDTL as pjd, POORDDTL as pod, SYCONFTR      
where       
   tmp.pjd_batseq = pjd.pjd_batseq and      
   pjd.pjd_batno = @batno and      
   pjd.pjd_cocde = @cocde and      
   pjd.pjd_jobord = pod_jobord and      
   pod.pod_cocde = @cocde and      
   pod.pod_itmno = tmp.pod_itmno and      
   pod.pod_untcde = ycf_code1 and      
   pod.pod_untcde <> 'DZ' and      
   ycf_code2 = 'PC' and      
   ycf_value > 1 and      
   pod_jobord not in (      
 select jobord from vw_SAPSOITM      
   )      
   and pod.pod_ordqty > 0      
   and pjd_zutyp = ''      
*/

-- Delete 3041 EDI records that create before 2007-10-27      
delete tmp      
from      
#tmpitm as tmp, POJBBDTL as pjd, IMPNTINF      
where       
   tmp.pjd_batseq = pjd.pjd_batseq and      
   pjd.pjd_batno = @batno and      
   pjd.pjd_cocde = @cocde and      
   tmp.pod_itmno = ipt_itmno and      
   ipt_plant = '3041' and      
   pjd.pjd_credat < '2007-10-27'       
and pjd.pjd_jobord not in (      
'US0701281-J005',      
'US0700503-J039',      
'US0700913-J081',      
'US0701099-J009',      
'US0701099-J010',      
'US0701418-J008',      
'US0701418-J010',      
'US0701434-J003',      
'US0701581-J002',    'US0701583-J001',      
'US0701584-J001',      
'US0701650-J004',      
'US0701730-J001'      
)      
      
      
      
         
      
      
      
      
--select * from #tmpitm       
      
 select           
  #tmpItm.pod_scno,          
  #tmpItm.pod_itmno,          
    #tmpItm.pjd_batseq,          
  #tmpItm.vencde          
  from           
  #tmpItm (nolock)          
  left join IMPNTINF (nolock) on #tmpItm.pod_itmno = ipt_itmno          
  left join SCUPLDTL (nolock) on ipt_plant = sud_plant and sud_valdat <= getdate()          
 where           
  sud_plant is not null          
/* Lester Wu 2007-11-29  
  and (          
   (pod_prdven in ('B','U','W') and ipt_plant not in ('3043'))           
   or  (pod_prdven in ('A') and ipt_plant not in ('3041','3042'))          
   or  (pod_prdven not in ('A','B','U','W'))        
  )          
 */         
 order by           
  pjd_batseq            
      
      
      
end          
else          
begin          
 select            
  #tmpItm.pod_scno,          
  #tmpItm.pod_itmno,          
    #tmpItm.pjd_batseq,          
  #tmpItm.vencde          
 from           
  #tmpItm  (nolock)          
 order by           
  pjd_batseq            
end          
          
          
          
          
        
      
      
      
    
  








GO
GRANT EXECUTE ON [dbo].[sp_select_PJDHONG_PDO] TO [ERPUSER] AS [dbo]
GO
