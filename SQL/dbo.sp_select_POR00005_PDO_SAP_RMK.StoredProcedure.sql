/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_PDO_SAP_RMK]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00005_PDO_SAP_RMK]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_PDO_SAP_RMK]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







/**************************************************************************************************************    
Modification History    
**************************************************************************************************************    
Modified on Modified by Description    
**************************************************************************************************************    
    
***************************************************************************************************************/    

-- sp_select_POR00005_PDO_SAP_RMK 'UCP','BJ0700025-0012'  
-- sp_select_POR00005_PDO_SAP_RMK 'UCP','BJ0700025-0013'   

CREATE PROCEDURE [dbo].[sp_select_POR00005_PDO_SAP_RMK]  
@cocde  nvarchar(6),     
@batch  nvarchar(23)  
AS    
BEGIN  
  
-- Read Company Information --    
declare     
 @yco_conam varchar(50), @yco_addr nvarchar(200), @yco_logoimgpth varchar(100), @yco_phoneno varchar(50), @yco_faxno varchar(50)    
    
declare     
 @dummy varchar(20)    
    
set @dummy = ''    
    
  
    
DECLARE    
@batno  nvarchar(20),    
@batseq  nvarchar(4)    
    
SET @batno = left(@batch,9)    
SET @batseq = right(@batch,4)    
    
CREATE TABLE #tmpjob (    
tmp_cocde nvarchar(6) not null,    
tmp_jobord nvarchar(20) not null,    
tmp_shpdtl nvarchar(2000) null,    
tmp_ctndtl nvarchar(1000) null,    
tmp_Assort ntext null,    
tmp_shpdtl2 ntext null,    
tmp_ctndtl2 ntext null)  on [PRIMARY]    
    
  
Declare    
@pjd_jobord nvarchar(20)    
  
  
DECLARE cur_batno CURSOR    
FOR    
SELECT pjd_jobord    
FROM POJBBDTL  (nolock)  
WHERE pjd_cocde = @cocde    
AND pjd_batno = @batno    
AND pjd_batseq = @batseq    
AND  PJd_confrm = 'Y'    
    
OPEN cur_batno    
FETCH NEXT FROM cur_batno INTO    
@pjd_jobord    
    
WHILE @@fetch_status = 0    
BEGIN    
    
  Declare    
  @StrDetail  nvarchar(100),     
  @StrDetail2 nvarchar(4000),     
  @StrShpDtl nvarchar(4000),    
  @StrCtnDtl nvarchar(4000),    
  @StrShpDtl2 nvarchar(4000),     
  @StrCtnDtl2 nvarchar(4000)     
     
 ------------------------------------------------------------------------------------------------------------------------------------    
  -- Cursor to get Shipment Detail    
  SET @StrDetail = ''    
  SET @StrDetail2 = ''    

  INSERT INTO     
   #tmpjob     
    (tmp_cocde, tmp_jobord, tmp_shpdtl, tmp_ctndtl, tmp_shpdtl2, tmp_ctndtl2)    
   values     
    (@cocde, @pjd_jobord, @strShpDtl, '', @strShpDtl2, '' )    
     
  SET @StrDetail = ''    
  SET @StrDetail2 = ''    

  UPDATE     
   #tmpjob     
  SET     
   tmp_ctndtl = @StrCtnDtl,    
   tmp_ctndtl2 = @StrCtnDtl2    
  WHERE     
   tmp_cocde = @cocde    
  AND tmp_jobord = @pjd_jobord    
     
 FETCH NEXT FROM cur_batno INTO    
 @pjd_jobord    
END    
CLOSE cur_batno    
DEALLOCATE cur_batno    
    
Declare @nCountAss int    
Select @nCountAss = count(*) from PODTLASS (nolock), POORDDTL (nolock), #tmpjob  (nolock)  
Where  pod_cocde = pda_cocde and pod_purord = pda_purord and pod_purseq = pda_seq    
and pod_jobord = tmp_jobord  and pod_cocde = tmp_cocde    
    
Set @nCountAss = @nCountAss * 4 + 3    
    
select     
  
 @batch as '@batch',    
 --poh_rmk,      
 poh_rmk =   
 case @cocde     
         when 'EW' then poh_rmk     
	when 'TT' then ltrim(rtrim('This P.O. is issued on behalf of NEW LEADER. ' + char(10) + char(13) + '此張採購單乃代表 「聯通」發出。' + char(10) + char(13)+ poh_rmk  ))
	when 'HX' then poh_rmk
 else     
         case aa.vbi_bvennam      
                when 'NO'  then poh_rmk     
                else ltrim(rtrim('This production note is issued on behalf of ' + aa.vbi_bvennam + '. ' + char(13) + char(10) + '此張生產單乃代表 「' +aa.vbi_bvennamc + '」發出。' + char(13) + char(10)+ poh_rmk  ))    
         end    
 end
+ case poh_cusctn when 0 then '' else 'TOTAL CTN# - ' + ltrim(rtrim(str(poh_cusctn))) + char(10) + char(13) end 
+ case poh_dest when '' then '' else 'DESTINATION: ' + ltrim(rtrim(poh_dest)) + char(10) + char(13) end 
,    
  
 --poh_rmk_Memo = poh_rmk,    
 poh_rmk_Memo =  null, -- 'X' ,   
--Lester Wu 2007-05-08  
 pod_engdsc , pod_engdsc_Memo = 'X' , --pod_engdsc,    
 pod_chndsc , pod_chndsc_Memo = 'X' , --pod_chndsc,    
  
 'X' as 'pod_rmk',   
-- Lester Wu 2007-05-08  
 case isnull(sod_pjobno,'') when '' then pod_rmk    
   else '取代 Job # ' + sod_pjobno + case isnull(pod_rmk,'') when '' then '' else  char(13) +char(10) + pod_rmk end end as 'pod_rmk_Memo',      
  
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
 pod_jobord
into #tmp_PDO_SAP    
From     
 POORDHDR (nolock)
left join POSHPMRK mrk1 (nolock) on poh_cocde = mrk1.psm_cocde and poh_purord = mrk1.psm_purord and mrk1.psm_shptyp = 'M'
left join POSHPMRK mrk2 (nolock) on poh_cocde = mrk2.psm_cocde and poh_purord = mrk2.psm_purord and mrk2.psm_shptyp = 'I'
left join POSHPMRK mrk3 (nolock) on poh_cocde = mrk3.psm_cocde and poh_purord = mrk3.psm_purord and mrk3.psm_shptyp = 'S'
,     
 POORDDTL (nolock),     
 VNBASINF aa (nolock),     
 VNBASINF bb (nolock),     
 SCORDDTL (nolock),    
 #tmpjob (nolock) --,    
WHERE     
 poh_cocde = pod_cocde and      
 poh_purord = pod_purord and    
 pod_cocde = sod_cocde and     
 pod_scno = sod_ordno and     
 pod_scline = sod_ordseq    
AND poh_venno = aa.vbi_venno    
AND pod_prdven = bb.vbi_venno    
AND pod_jobord = tmp_jobord  and pod_cocde = tmp_cocde    
  
    
select * from #tmp_PDO_SAP  (nolock)  
    
drop table  #tmp_PDO_SAP    
drop table #tmpjob    
    
END  
  
  












GO
GRANT EXECUTE ON [dbo].[sp_select_POR00005_PDO_SAP_RMK] TO [ERPUSER] AS [dbo]
GO
