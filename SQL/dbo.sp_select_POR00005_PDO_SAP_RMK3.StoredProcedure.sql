/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_PDO_SAP_RMK3]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POR00005_PDO_SAP_RMK3]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POR00005_PDO_SAP_RMK3]    Script Date: 09/29/2017 15:29:10 ******/
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
    
CREATE PROCEDURE [dbo].[sp_select_POR00005_PDO_SAP_RMK3]      
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
      
      
DECLARE cur_batno2 CURSOR        
FOR        
SELECT pjd_jobord        
FROM POJBBDTL  (nolock)      
WHERE pjd_cocde = @cocde        
AND pjd_batno = @batno        
AND pjd_batseq = @batseq        
AND  PJd_confrm = 'Y'        
        
OPEN cur_batno2        
FETCH NEXT FROM cur_batno2 INTO        
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
         
/*         
  DECLARE cur_SHPDTL cursor        
  FOR         
  SELECT         
   Case pds_from when pds_to         
   then         
    replace(convert(char(10), pds_from, 121),'-','') +right( '                    ' +  ysi_dsc,20) + str(pds_ttlctn,7,0)        
   Else         
    replace(convert(char(10), pds_from, 121),'-','') + ' - ' + convert(char(10), pds_to, 101) +right( '        ' + ysi_dsc,7) + str(pds_ttlctn,7,0)         
   end,        
         
   Case pds_from when pds_to         
   then         
    '<SubShpDtl>' +         
    '<pod_shpstr>' + replace(convert(char(10), pds_from, 121),'-','') + '</pod_shpstr>'  +         
    '<ysi_dsc>' + ysi_dsc + '</ysi_dsc>' +        
    '<pod_ordqty>' +  ltrim(rtrim(str(pds_ttlctn,7,0))) + '</pod_ordqty>' +        
    '</SubShpDtl>'          
   Else         
    '<SubShpDtl>' +         
    '<pod_shpstr>' + replace(convert(char(10), pds_from, 121),'-','') + '</pod_shpstr>' +         
    '<ysi_dsc>' +  ysi_dsc + '</ysi_dsc>' +         
    '<pod_ordqty>' + ltrim(rtrim(str(pds_ttlctn,7,0))) + '</pod_ordqty>' +        
    '</SubShpDtl>'          
   end        
         
  FROM PODTLSHP, POORDDTL, SYSETINF        
  WHERE          
   pod_untcde = ysi_cde and ysi_typ = '05'        
  AND pds_purord = pod_purord and pds_seq = pod_purseq        
  AND  pds_cocde = @cocde and pod_jobord = @pjd_jobord        
  ORDER BY        
   replace(convert(char(10), pds_from, 121),'-','')        
         
         
  -------------------------------------------------------------------------------------------------------------------------        
  OPEN cur_SHPDTL        
  FETCH NEXT FROM cur_SHPDTL INTO        
  @StrDetail, @StrDetail2        
         
  SET @StrShpDtl = ''        SET @StrShpDtl2 = ''        
         
  WHILE @@fetch_status = 0        
  BEGIN        
   SET @StrShpDtl = @StrShpDtl + @StrDetail + char(10)        
   SET @StrShpDtl2 = @StrShpDtl2 + @StrDetail2        
   FETCH NEXT FROM cur_SHPDTL INTO        
   @StrDetail, @StrDetail2        
  END        
  CLOSE cur_SHPDTL        
  DEALLOCATE cur_SHPDTL        
 ------------------------------------------------------------------------------------------------------------------------------------        
         
  IF @StrShpDtl = ''        
   BEGIN        
    Select @StrShpDtl = Case pod_shpstr when pod_shpend         
       then         
        replace(convert(char(10), pod_shpstr, 121),'-','')  + right('                    ' +  ysi_dsc,20) +  str(pod_ordqty,7,0)        
       Else         
        --AY 2005-08-19        
        --replace(convert(char(10), pod_shpstr, 121),'-','') + ' - ' +  convert(char(10), pod_shpend, 101) + right('       ' + ysi_dsc,7) + str(pod_ordqty,7,0)         
        replace(convert(char(10), pod_shpstr, 121),'-','')  + right('                    ' +  ysi_dsc,20) +  str(pod_ordqty,7,0)        
       End,        
          
     @StrShpDtl2 = Case pod_shpstr when pod_shpend         
       then         
        '<SubShpDtl>' +         
        '<pod_shpstr>' + replace(convert(char(10), pod_shpstr, 121),'-','')  + '</pod_shpstr>' +         
        '<ysi_dsc>' + ysi_dsc + '</ysi_dsc>' +         
        '<pod_ordqty>' + ltrim(rtrim( str(pod_ordqty,7,0))) + '</pod_ordqty>' +        
        '</SubShpDtl>'          
       Else         
        '<SubShpDtl>' +         
        '<pod_shpstr>' + replace(convert(char(10), pod_shpstr, 121),'-','') + '</pod_shpstr>' +         
        --AY 2005-08-19        
        --'<pod_shpend>' +  convert(char(10), pod_shpend, 101)  + '</pod_shpend>' +         
        '<ysi_dsc>' +  ysi_dsc + '</ysi_dsc>' +         
        '<pod_ordqty>' + ltrim(rtrim(str(pod_ordqty,7,0)))  + '</pod_ordqty>' +         
        '</SubShpDtl>'          
       end        
          
    FROM POORDDTL, SYSETINF        
    --WHERE pod_cocde = ysi_cocde and pod_untcde = ysi_cde and ysi_typ = '05'        
    WHERE pod_untcde = ysi_cde and ysi_typ = '05'        
    AND pod_cocde = @cocde and pod_jobord = @pjd_jobord        
    --AND pod_cocde = 'UCPP' AND pod_jobord = 'US0200006-J001'        
    ORDER BY         
     replace(convert(char(10), pod_shpstr, 121),'-','')        
   END        
  ELSE        
   BEGIN        
    SET @StrShpDtl = LEFT(@StrShpDtl, LEN(@StrShpDtl) - 1)        
   END        
*/         
  INSERT INTO         
   #tmpjob         
    (tmp_cocde, tmp_jobord, tmp_shpdtl, tmp_ctndtl, tmp_shpdtl2, tmp_ctndtl2)        
   values         
    (@cocde, @pjd_jobord, @strShpDtl, '', @strShpDtl2, '' )        
         
 --//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
  
   
     
      
         
  -- Cursor to get Carton Detail        
         
  SET @StrDetail = ''        
  SET @StrDetail2 = ''        
/*         
  DECLARE cur_CTNDTL cursor        
  FOR         
  SELECT         
   str(pdc_from,6,0) + ' - ' + str(pdc_to,6,0) + ' (' + ltrim(str(pdc_ttlctn,5,0)) + ')',        
   -- Generate XML ---        
   '<SubCtnNo>' +         
   '<pod_ctnstr>' + ltrim(rtrim(str(pdc_from,6,0))) + '</pod_ctnstr>' +        
   '<pod_ctnend>' +  ltrim(rtrim(str(pdc_to,6,0))) + '</pod_ctnend>' +        
   '<pod_subttlctn>' + '(' + rtrim(ltrim(str(pdc_ttlctn,5,0))) + ')' + '</pod_subttlctn>' +        
   '</SubCtnNo>'         
   ------------------------        
         
  FROM  PODTLCTN, POORDDTL        
  WHERE  pod_cocde = pdc_cocde and pod_purord = pdc_purord and pod_purseq = pdc_seq        
  AND pdc_cocde = @cocde and pod_jobord = @pjd_jobord        
  ORDER BY        
   str(pdc_from,7,0)        
         
         
  OPEN cur_CTNDTL        
  FETCH NEXT FROM cur_CTNDTL INTO        
  @StrDetail,  @StrDetail2        
         
  SET @StrCtnDtl = ''        
  SET @StrCtnDtl2 = ''        
         
  WHILE @@fetch_status = 0        
  BEGIN        
  SET @StrCtnDtl = @StrCtnDtl + @StrDetail + char(10)        
   SET @StrCtnDtl2 = @StrCtnDtl2 + @StrDetail2        
   FETCH NEXT FROM cur_CTNDTL INTO        
   @StrDetail,  @StrDetail2        
  END        
  CLOSE cur_CTNDTL        
  DEALLOCATE cur_CTNDTL        
         
  IF @StrCtnDtl = ''        
  BEGIN        
   SELECT         
    @StrCtnDtl = str(pod_ctnstr,6,0) + ' - ' + str(pod_ctnend,6,0)+ ' (' + ltrim(str(pod_ttlctn,5,0)) + ')',        
    --- Generate XML ---        
    @StrCtnDtl2 =         
     '<SubCtnNo>' +         
     '<pod_ctnstr>' + ltrim(rtrim(str(pod_ctnstr,6,0)))  + '</pod_ctnstr>' +        
     '<pod_ctnend>' + ltrim(rtrim(str(pod_ctnend,6,0)))  + '</pod_ctnend>' +        
     '<pod_subttlctn>' + '(' + rtrim(ltrim(str(pod_ttlctn,5,0))) + ')' + '</pod_subttlctn>' +        
     '</SubCtnNo>'         
    --------------------------        
         
   FROM POORDDTL        
   WHERE pod_cocde = @cocde and pod_jobord = @pjd_jobord        
   ORDER BY        
    str(pod_ctnstr,7,0)        
  END        
  ELSE        
  BEGIN        
   SET @StrCtnDtl = LEFT(@StrCtnDtl, LEN(@StrCtnDtl) - 1)        
  END        
*/         
  UPDATE         
   #tmpjob         
  SET         
   tmp_ctndtl = @StrCtnDtl,        
   tmp_ctndtl2 = @StrCtnDtl2        
  WHERE         
   tmp_cocde = @cocde        
  AND tmp_jobord = @pjd_jobord        
         
 FETCH NEXT FROM cur_batno2 INTO        
 @pjd_jobord        
END        
CLOSE cur_batno2        
DEALLOCATE cur_batno2        
        
Declare @nCountAss int        
Select @nCountAss = count(*) from PODTLASS (nolock), POORDDTL (nolock), #tmpjob  (nolock)      
Where  pod_cocde = pda_cocde and pod_purord = pda_purord and pod_purseq = pda_seq        
and pod_jobord = tmp_jobord  and pod_cocde = tmp_cocde        
        
Set @nCountAss = @nCountAss * 4 + 3        
    
select         
      
 @batch as '@batch',        
 --poh_rmk,          
 poh_rmk =    'X' ,     
/*    
 case @cocde         
         when 'EW' then poh_rmk         
 else         
         case aa.vbi_bvennam          
                when 'NO'  then poh_rmk         
                else ltrim(rtrim('This production note is issued on behalf of ' + aa.vbi_bvennam + '. ' + char(10) + char(13) + '此張生產單乃代表 「' +aa.vbi_bvennamc + '」發出。' + char(10) + char(13)+ poh_rmk  ))        
         end        
 end,        
*/      
 poh_rmk_Memo =  'X' ,       
--Lester Wu 2007-05-08      
 pod_engdsc = 'X', pod_engdsc_Memo = 'X' , --pod_engdsc,        
 pod_chndsc = 'X', pod_chndsc_Memo = 'X' , --pod_chndsc,        
      
 'X' as 'pod_rmk',       
-- Lester Wu 2007-05-08      
 pod_rmk_memo = 'X',     
-- case isnull(sod_pjobno,'') when '' then pod_rmk else '取代 Job # ' + sod_pjobno + case isnull(pod_rmk,'') when '' then '' else  char(10) +char(13) + pod_rmk end end as 'pod_rmk_Memo',          
      
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
 pod_jobord,       
--- ctn        
 
 -- POSHPMRK        
-- Lester Wu 2007-05-08      
 MainMrk = isNull(mrk1.psm_imgpth,''), InnerMrk = isNull(mrk2.psm_imgpth,''), SideMrk = isNull(mrk3.psm_imgpth,''),        
 MainEng = 'X' , -- Case isNull(mrk1.psm_engdsc, '') When '' then '' Else 'ξ' + replace(mrk1.psm_engdsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end,        
 InnerEng = 'X' , --  Case isNull(mrk2.psm_engdsc, '') When '' then '' Else 'ξ' + replace(mrk2.psm_engdsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end,        
 SideEng = 'X' , --  Case isNull(mrk3.psm_engdsc, '') When '' then '' Else  'ξ' + replace(mrk3.psm_engdsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end,        
    
-- Lester Wu 2007-05-08        
-- MainEng_Memo = Case isNull(mrk1.psm_engdsc, '') When '' then '' Else 'ξ' + replace(mrk1.psm_engdsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end,        
-- InnerEng_Memo = Case isNull(mrk2.psm_engdsc, '') When '' then '' Else 'ξ' + replace(mrk2.psm_engdsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end,        
-- SideEng_Memo = Case isNull(mrk3.psm_engdsc, '') When '' then '' Else  'ξ' + replace(mrk3.psm_engdsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end,        
--Lester Wu 2007-07-09    
/* MainEng_Memo = Case isNull(mrk1.psm_engdsc, '') When '' then '' Else 'ξ' + replace(mrk1.psm_engdsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end,        
 InnerEng_Memo = Case isNull(mrk2.psm_engdsc, '') When '' then '' Else 'ξ' + replace(mrk2.psm_engdsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end,        
 SideEng_Memo = Case isNull(mrk3.psm_engdsc, '') When '' then '' Else  'ξ' + replace(mrk3.psm_engdsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end,        
*/    
 MainEng_Memo = 'X', -- Case isNull(mrk1.psm_engdsc, '') When '' then '' Else 'ξ' + replace(mrk1.psm_engdsc, char(13)+char(10), char(13)+char(10)+ '') end,        
 InnerEng_Memo = 'X', -- Case isNull(mrk2.psm_engdsc, '') When '' then '' Else 'ξ' + replace(mrk2.psm_engdsc, char(13)+char(10), char(13)+char(10)+ '') end,        
 SideEng_Memo = 'X', -- Case isNull(mrk3.psm_engdsc, '') When '' then '' Else  'ξ' + replace(mrk3.psm_engdsc, char(13)+char(10), char(13)+char(10)+ '') end,        
        
 MainChn = 'X' , --  Case isNull(mrk1.psm_chndsc, '') When '' then '' Else 'ξ' + replace(mrk1.psm_chndsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end,        
 InnerChn = 'X' , --  Case isNull(mrk2.psm_chndsc, '') When '' then '' Else 'ξ' + replace(mrk2.psm_chndsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end,        
 SideChn = 'X' , --  Case isNull(mrk3.psm_chndsc, '') When '' then '' Else  'ξ' + replace(mrk3.psm_chndsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end,        
        
-- Lester Wu 2007-05-08      
-- MainChn_Memo = Case isNull(mrk1.psm_chndsc, '') When '' then '' Else 'ξ' + replace(mrk1.psm_chndsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end,        
-- Lester Wu 2007-07-09    
/* MainChn_Memo = Case isNull(mrk1.psm_chndsc, '') When '' then '' Else 'ξ' + replace(mrk1.psm_chndsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end,        
 InnerChn_Memo = Case isNull(mrk2.psm_chndsc, '') When '' then '' Else 'ξ' + replace(mrk2.psm_chndsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end,        
 SideChn_Memo = Case isNull(mrk3.psm_chndsc, '') When '' then '' Else  'ξ' + replace(mrk3.psm_chndsc, char(13)+char(10), char(13)+char(10)+ 'ξ') end,        
*/    
 MainChn_Memo = 'X', -- Case isNull(mrk1.psm_chndsc, '') When '' then '' Else 'ξ' + replace(mrk1.psm_chndsc, char(13)+char(10), char(13)+char(10)+ '') end,        
 InnerChn_Memo = 'X', -- Case isNull(mrk2.psm_chndsc, '') When '' then '' Else 'ξ' + replace(mrk2.psm_chndsc, char(13)+char(10), char(13)+char(10)+ '') end,        
 SideChn_Memo = 'X', -- Case isNull(mrk3.psm_chndsc, '') When '' then '' Else  'ξ' + replace(mrk3.psm_chndsc, char(13)+char(10), char(13)+char(10)+ '') end,        
    
        
-- Lester Wu 2007-05-08         
 MainChnRmk = 'X' , --isNull(mrk1.psm_chnrmk,''),   
 InnerChnRmk = 'X' , -- isNull(mrk2.psm_chnrmk,''),   
 SideChnRmk = 'X' , --isNull(mrk3.psm_chnrmk,''),        

 MainEngRmk = 'X' , -- isNull(mrk1.psm_engrmk,''),   
 InnerEngRmk = 'X' , --isNull(mrk2.psm_engrmk,''),   
 SideEngRmk = 'X' --isNull(mrk3.psm_engrmk,'')      
      
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
GRANT EXECUTE ON [dbo].[sp_select_POR00005_PDO_SAP_RMK3] TO [ERPUSER] AS [dbo]
GO
