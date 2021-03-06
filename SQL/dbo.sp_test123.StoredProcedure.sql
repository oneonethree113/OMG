/****** Object:  StoredProcedure [dbo].[sp_test123]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_test123]
GO
/****** Object:  StoredProcedure [dbo].[sp_test123]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



























/******************************************************************************************    
Modification History
******************************************************************************************    
Modified on   Modified by   Description
******************************************************************************************    
17 Mar 2005   Lester Wu   Retrieve Company info from database    
          cater add new company    
2006-07-26 Lester Wu  Allow sorting of report by customer item # in crsystal report  
    -- Origial section of code "Upper Part" is duplicated to form the "Lower Part"  
    -- While "Lower Part" is joined to vw_inr00001_cusitm instead of vw_inr00001  
******************************************************************************************    
*/    

/* exec sp_select_INR00001A_NET 'PG','N','N','N','C','Y','N','N','GI0800295','GI0800295','0','ITM','1','1' */

--Kenny Re-write this SP on 08-10-2002

CREATE                 procedure [dbo].[sp_test123] 
@cocde nvarchar(6) ,    
@opt1 nvarchar(1),    
@opt2 nvarchar(1),    
@opt3 nvarchar(1),    
@laf    nvarchar(1),    
@opt4 nvarchar(1),    
@opt5 nvarchar(1),    
@opt6 nvarchar(1),    
@from nvarchar(20),    
@to nvarchar(20),   
@optTitle char(1) = 0 ,   
@optSort varchar(6) = 'ITM',  
--Added by Mark Lau 20060928  
@printGroup nvarchar(1),  
@printAlias nvarchar(1),
@printAss nvarchar(1)  
AS    
begin    

------------------------------------------------------------------------------------------------------------------------------------------------------    
--Lester Wu 2005/03/03 -- Retrieve Company Name, Short Name, Address, Phone No, Fax No, Email Address, Logo Path    
------------------------------------------------------------------------------------------------------------------------------------------------------    
DECLARE    
@yco_conam varchar(100),    
@yco_addr  varchar(200),    

@yco_phoneno varchar(50),    
@yco_faxno varchar(50),    
@yco_logoimgpth varchar(100),
@yco_venid varchar(7),    

@temp_sumamt decimal(13,4),
@temp_sumamt_distinct decimal(13,4)


select '1' as '1'

create table #temp_table_sum
(
tmp_ordno	nvarchar(30),
tmp_sum	numeric(13,4),
tmp_cusitm	nvarchar(30)
)

create table #temp_table_sum_distinct
(
tmp_ordno	nvarchar(30),
tmp_sum	numeric(13,4)
)


set @yco_conam = ''    
set @yco_addr = ''    

set @yco_phoneno = ''    
set @yco_faxno = ''    

set @yco_logoimgpth = ''    
set @yco_venid = ''





select    
@yco_conam=yco_conam,    
@yco_addr=yco_addr,    
    
@yco_phoneno= yco_phoneno,    
@yco_faxno = yco_faxno,    
@yco_logoimgpth = yco_logoimgpth,
-- Add yco_venid by Frankie 22 Oct 2008
@yco_venid = yco_venid    
    
from     
    
SYCOMINF(NOLOCK)    
    
where
yco_cocde = @cocde    
------------------------------------------------------------------------------------------------------------------------------------------------------    
----*** MAKE SURE UPPER PART AND LOWER PART SHOULD IDENTICAL WHEN MODIFY THIS SP  *** ----  
------------------------------------------------------------------------------------------------------------------------------------------------------    
  -- Upper Part --  
------------------------------------------------------------------------------------------------------------------------------------------------------    
------------------------------------------------------------------------------------------------------------------------------------------------------    

select '2' as '2'

  
if @optSort = 'ITM'   

Begin

select '3' as '3'


--make temp_sumamt
insert into #temp_table_sum
select  DISTINCT   dtl.hid_ordno  as 'dtl.hid_ordno',
 Case case when hiv_aformat = '2' then 'C' else case when hiv_aformat = '1' then 'A' else 'C' end end    
   when 'A' then  vw.sumamtd else vw.sumamt end as vw_sumamt ,
   vw.hid_itmno as 'test_itm'

  From  SHIPGHDR hdr    
  left join CUBASINF cus on  --hdr.hih_cocde = cus.cbi_cocde and     
     hdr.hih_cus1no = cus.cbi_cusno    
  left join SYSETINF cty on --hdr.hih_cocde = cty.ysi_cocde and     
     hdr.hih_bilcty = cty.ysi_cde and     
     cty.ysi_typ = '02'    
      
  ,SHINVHDR inv     
  left join SHIPGDTL dtl on inv.hiv_cocde = @cocde and    
     inv.hiv_shpno = dtl.hid_shpno and     
     inv.hiv_invno = dtl.hid_invno    
      
-- Added by Mark Lau 20080714, Customer Alias
-- Changed by Mark Lau 20090702
--  left join imcusals ca on  dtl.hid_itmno  = ca.ica_itmno  and ca.ica_apvsts = 'Y' 
 left join SHPCUSSTY ca on  dtl.hid_itmno  = ca.ica_itmno  and ca.ica_apvsts = 'Y' and ca.sod_ordno = dtl.hid_ordno 
  left join SHSHPMRK shm on   shm.hsm_cocde = @cocde and     
     shm.hsm_invno = inv.hiv_invno and     
     shm.hsm_shptyp = 'M'     
  left join SYSETINF prc on --prc.ysi_cocde =@cocde and     
     inv.hiv_prctrm = prc.ysi_cde and     
     prc.ysi_typ = '03'    
  left join SYSETINF pay on --pay.ysi_cocde = @cocde and     
     inv.hiv_paytrm = pay.ysi_cde and     
     pay.ysi_typ = '04'    
	--Modified by Mark Lau 20080314, move from low section
  left join SYSETINF cde on inv.hiv_cocde = @cocde and    
--Edited by Mark Lau 20080616 
     case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case when isnull(dtl.hid_contopc,'') = 'Y' then 'PC' else dtl.hid_untcde end end = cde.ysi_cde and     
     cde.ysi_typ = '05'         
  left join SCORDHDR soh on soh.soh_cocde = @cocde and     
     soh.soh_ordno = dtl.hid_ordno     
  left join SCORDDTL sod on  sod.sod_cocde = @cocde and     
     sod.sod_ordno = dtl.hid_ordno and     
     sod.sod_ordseq = dtl.hid_ordseq    
--Modified by Mark Lau 20061231 change from join v_select_inr00001 toselect_inr00001_wNewItmNo   
  left join  v_select_inr00001_wNewItmNo vw on  vw.hid_cocde =@cocde and   --  
--left join v_select_inr00001 vw on  vw.hid_cocde =@cocde and     
-- added by Mark Lau 20061231  
 vw.grp = @printgroup and   
      vw.hid_invno = inv.hiv_invno  and     
 -- AY Fix Grouping Problem in Printing at 31/12/2002    
 --     soh.soh_cuspo = vw.soh_cuspo and     
      dtl.hid_cuspo = vw.hid_cuspo and    
      dtl.hid_ordno = vw.hid_ordno and     
      dtl.hid_mannam = vw.hid_mannam and     
     --dtl.hid_itmno = vw.hid_itmno and     
		--Added by Mark Lau 20080516, Add CDTVX
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
else
case when @printGroup = '1' then  

 -- Changed by Mark Lau 20090402, use function to perform the logic
/*
  case when len(ltrim(rtrim(dtl.hid_itmno))) < 11 or charindex('-',ltrim(rtrim(dtl.hid_itmno))) > 0 or charindex('/',ltrim(rtrim(dtl.hid_itmno))) >0 or (Upper(substring(ltrim(rtrim(dtl.hid_itmno)),3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(dtl.hid_itmno)),7,2) = 'AS' then ltrim(rtrim(dtl.hid_itmno))  
  else   
  case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'A'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)   
   else   
   case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) <= '9' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
    else   
    case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
     else ltrim(rtrim(dtl.hid_itmno))  
     end  

   end  
  end  
  end  
*/
dbo.groupnewitmno(dtl.hid_itmno)
  else  
  ltrim(rtrim(dtl.hid_itmno))  
  end end = vw.hid_itmno and   

      dtl.hid_itmdsc = vw.hid_itmdsc and      
      dtl.hid_inrctn = vw.hid_inrctn and     
      dtl.hid_mtrctn = vw.hid_mtrctn    
 -- AY - Bug Fix SelPrc Grouping Item at 24/12/2002    
      and dtl.hid_selprc = round(vw.hid_selprc,6,1)      
	-- added by Mark Lau 20070427
	--Modified by Mark Lau 20080314, change hid_untcde to ysi_dsc
	     and cde.ysi_dsc = vw.ysi_dsc
 -- Lester Wu 2005-09-30, add group by gw, nw, and measurement,     
 -- ** Rememeber to modify v_select_inr00001 as well in order to match the following codes    
      and     
      ltrim(str(dtl.hid_grswgt,10,2)) = vw.hid_grswgt and     
      ltrim(str(dtl.hid_netwgt,10,2)) = vw.hid_netwgt and      
      ltrim(str(dtl.hid_mtrdcm,10,2)) + ' X ' + ltrim(str( dtl.hid_mtrwcm,10,2)) + ' X ' + ltrim(str(dtl.hid_mtrhcm,10,2)) = vw.MEAS   and  
      vw.hid_invno between @from and @to        
 ---------------------------------------------------------------------------------------------------------------    
     
  left join POORDDTL on  pod_cocde = @cocde and     
     pod_purord =  dtl.hid_purord and     
     pod_purseq = dtl.hid_purseq    

  left join SCASSINF sca on  sca.sai_cocde =@cocde  and     
     sca.sai_ordno = dtl.hid_ordno and     
     sca.sai_ordseq = dtl.hid_ordseq     
  left join  SYSETINF saa on  --saa.ysi_cocde = @cocde and     
     sca.sai_untcde = saa.ysi_cde and     
     saa.ysi_typ = '05'    




 WHERE      
  hdr.hih_shpsts <> 'HLD'    
 and  hdr.hih_cocde = @cocde    
 and hdr.hih_shpno = dtl.hid_shpno    
 and  inv.hiv_invno >= @from and inv.hiv_invno <= @to    
--and ( (hdr.hih_cus1no =  ca.ica_cusno and isnull(ca.ica_cusno,'') <> '') or  isnull(ca.ica_cusno,'') = '')
--ORDER BY dtl.hid_cusitm, dtl.hid_ctnstr
--ORDER BY dtl.hid_itmno, dtl.hid_ctnstr



--end make
insert into #temp_table_sum_distinct
select distinct tmp_ordno,tmp_sum
from #temp_table_sum


SET @temp_sumamt = 
(select sum( tmp_sum) 
from #temp_table_sum
--group by
--tmp_ordno
)
 
select   @temp_sumamt as 'testyyyyyyyyyyyyyyyyyyyy'



SET @temp_sumamt_distinct = 
(select sum( tmp_sum) 
from #temp_table_sum_distinct
--group by
--tmp_ordno
)




 Select     
@temp_sumamt AS 'temp_sum',
@temp_sumamt_distinct AS 'temp_sum_distinct',
  @opt1  as 'opt1',        
  @opt2  as 'opt2',        
  @opt3  as 'opt3',        
  @opt4  as 'opt4',        
  @opt5  as 'opt5',        
  @opt6  as 'opt6',        
  --@laf,    
  --case when hiv_aformat = '2' then 'C' else case when hiv_aformat = '1' then 'A' else 'C' end end as 'hiv_aformat'
@laf  as 'laf',        
  hdr.hih_shpno as 'hdr.hih_shpno',     
  cast(dtl.hid_shpseq as nvarchar(20)) as 'dtl.hid_shpseq',     
  hdr.hih_smpshp as 'hdr.hih_smpshp',     
  inv.hiv_invno as 'inv.hiv_invno', 
  ltrim(inv.hiv_cover)  as 'inv.hiv_cover',        
  ltrim(cus.cbi_cusnam)  as 'cus.cbi_cusnam',           
  ltrim(hdr.hih_bilent)  as 'hdr.hih_bilent',        
  ltrim(hdr.hih_biladr)  as 'hdr.hih_biladr',         
  ltrim(hdr.hih_bilstt)  as 'hdr.hih_bilstt',         
  ltrim(cty.ysi_dsc)  as 'cty.ysi_dsc',         
  ltrim(hdr.hih_bilzip)  as 'hdr.hih_bilzip',        
  ltrim(pay.ysi_dsc)  as 'inv.hiv_paytrm',        
  ltrim(inv.hiv_ftrrmk)  as 'inv.hiv_ftrrmk',        
  ltrim(inv.hiv_doctyp)  as 'inv.hiv_doctyp',        
  ltrim(inv.hiv_doc)  as 'inv.hiv_doc',        
     
  inv.hiv_invdat  as 'inv.hiv_invdat',     
  'FROM ' + hdr.hih_potloa + ' TO ' + hdr.hih_dst
  as 'hdr.hih_potloa_hih_dst',        
  hdr.hih_ves  as 'hdr.hih_ves',    
  hdr.hih_voy  as 'hdr.hih_voy',     
  hdr.hih_slnonb  as 'hdr.hih_slnonb',     
     
 --- For Packing List, Group by Container #    
  ltrim(dtl.hid_pckrmk)  as 'dtl.hid_pckrmk',    
  dtl.hid_ctrcfs  as 'dtl.hid_ctrcfs',  
 --- Total of Cartons for Container    
     
 --- For Invoice, Group by Customer PO# and Sales Confirmation #    
  ltrim(dtl.hid_cuspo)
  as 'dtl.hid_cuspo',        
soh.soh_cpodat  as 'poh.poh_issdat',        
 --- Customer PO Date    
  dtl.hid_ordno  as 'dtl.hid_ordno',
  soh.soh_issdat  as 'soh.soh_issdat',
 --- SC Revise Date    
     
     
 --- Details Shipmark    
  ltrim(dtl.hid_itmshm)  as 'dtl.hid_itmshm',        
 --- Carton Details    

 --- Manufacturers Name & Address    
  ltrim(dtl.hid_mannam)  as 'dtl.hid_mannam',        
  ltrim(dtl.hid_manadr)  as 'dtl.hid_manadr',        

 -- ltrim(rtrim(dtl.hid_itmno)) as 'hid_itmno',    
  
 --Added by Mark Lau 20060927  
		--Added by Mark Lau 20080516, Add CDTVX
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm 
else
 case when @printGroup = '1' then  

-- Changed by Mark Lau 20090402, use function to perform the logic
/*
  case when len(ltrim(rtrim(dtl.hid_itmno))) < 11 or charindex('-',ltrim(rtrim(dtl.hid_itmno))) > 0 or charindex('/',ltrim(rtrim(dtl.hid_itmno))) >0 or (Upper(substring(ltrim(rtrim(dtl.hid_itmno)),3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(dtl.hid_itmno)),7,2) = 'AS' then ltrim(rtrim(dtl.hid_itmno))  
   
  else   
  case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'A'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)   
   else   
   case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) <= '9' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
    else   
    case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
     else ltrim(rtrim(dtl.hid_itmno))  
     end  
   end  
  end  
  end  

*/
dbo.groupnewitmno(dtl.hid_itmno)

  else  
  ltrim(rtrim(dtl.hid_itmno))  
  end end as 'dtl.hid_itmno',  
  case when @printAlias = '0' then '' else isnull(hid_alsitmno,'') end as 'dtl.hid_alsitmno',  
  ltrim(rtrim(dtl.hid_itmdsc)) as 'dtl.hid_itmdsc',      
     
 --- Assortment Details    
 --- Component Breakdown    
      
 --- Packing: change all to string and concat.    
CASE when isnull(dtl.hid_contopc,'') =  'Y' and isnull(dtl.hid_custum,'') <> '' THEN
	 CASE  ltrim(str(dtl.hid_inrctn)) WHEN '0' THEN     

	   ltrim(str(dtl.hid_mtrctn*dtl.hid_conftr)) +  ' ' + cde.ysi_dsc + ' IN MASTER CARTON.'    

	 ELSE     
	 ltrim(str(dtl.hid_inrctn*dtl.hid_conftr)) + ' ' + cde.ysi_dsc +' IN INNER BOX, '  + ltrim(str(dtl.hid_mtrctn*dtl.hid_conftr)) + ' ' + cde.ysi_dsc + ' IN MASTER CARTON.'  END
ELSE
CASE isnull(dtl.hid_contopc,'') when 'Y' Then
	 CASE  ltrim(str(dtl.hid_inrctn)) WHEN '0' THEN     
	   ltrim(str(dtl.hid_mtrctn*dtl.hid_conftr)) + ' PC IN MASTER CARTON.'    
	 ELSE     
	 ltrim(str(dtl.hid_inrctn*dtl.hid_conftr)) + ' PC IN INNER BOX, ' + ltrim(str(dtl.hid_mtrctn*dtl.hid_conftr)) + ' PC IN MASTER CARTON.' END
Else
	 CASE  ltrim(str(dtl.hid_inrctn)) WHEN '0' THEN     
	   ltrim(str(dtl.hid_mtrctn)) + ' ' + cde.ysi_dsc +' IN MASTER CARTON.'    
	 ELSE     
	 ltrim(str(dtl.hid_inrctn)) + ' ' + cde.ysi_dsc +' IN INNER BOX, ' + ltrim(str(dtl.hid_mtrctn)) + ' ' + cde.ysi_dsc +' IN MASTER CARTON.' END
END
END
  as 'dtl.packing',    
    
  ltrim(str(dtl.hid_grswgt,10,2)) + ' KG'
  as 'dtl.hid_grswgt',        
  ltrim(str(dtl.hid_netwgt,10,2)) + ' KG'
  as 'dtl.hid_netwgt',        

 --- Master Dim are concat.    
  ltrim(str(dtl.hid_mtrdcm,10,2)) + ' X ' + ltrim(str( dtl.hid_mtrwcm,10,2)) + ' X ' + ltrim(str(dtl.hid_mtrhcm,10,2)) + ' CM'  
as 'dtl.meas',        
 --- Harmonized Code    
     
  str(dtl.hid_ttlctn)  as 'dtl.hid_ttlctn',        
CASE isnull(dtl.hid_contopc,'') when 'Y' Then
  str(cast(cast(dtl.hid_shpqty*dtl.hid_conftr as int) as int))
Else
  str(dtl.hid_shpqty)
End  as 'dtl.hid_shpqty',        
 
  dtl.hid_untsel  as 'dtl.hid_untsel',    
case isnull(dtl.hid_contopc,'') when 'Y' then  
	str(round(dtl.hid_pcprc,2)) 
else  
	str(round(dtl.hid_selprc,2)) 
end   as 'dtl.hid_selprc',     

  str(round(dtl.hid_ttlamt,2),10,4)  as 'dtl.hid_ttlamt',        
  shm.hsm_imgpth   as 'shm.hsm_imgpth',         
  left(ltrim(shm.hsm_engdsc),1)  as 'shm.hsm_engdsc',        
  @cocde  as 'cocde',        
  ltrim(dtl.hid_cmprmk)  as 'dtl.hid_cmprmk',        
--  sca.sai_assitm,    
  
 --Added by Mark Lau 20060927  
		--Added by Mark Lau 20080516, Add CDTVX
 case when @printGroup = '1'  then  


 -- Changed by Mark Lau 20090402, use function to perform the logic
/*
  case when len(sca.sai_assitm) < 11 or charindex('-',sca.sai_assitm) > 0 or charindex('/',sca.sai_assitm) >0 or (Upper(substring(sca.sai_assitm,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(sca.sai_assitm,7,2) = 'AS' then sca.sai_assitm  
   
  else   
  case when upper(substring(sca.sai_assitm, 3, 1)) = 'A'  or upper(substring(sca.sai_assitm, 3, 1)) = 'C'  or upper(substring(sca.sai_assitm, 3, 1)) = 'D' or upper(substring(sca.sai_assitm, 3, 1)) = 'T' or upper(substring(sca.sai_assitm, 3, 1)) = 'X' or upper(substring(sca.sai_assitm, 3, 1)) = 'V'  then substring(sca.sai_assitm,1,11)--and (substring(sca.sai_assitm, 4, 1) >= '0' And substring(sca.sai_assitm, 4, 1) <= '9' ) And (substring(sca.sai_assitm, 5, 1) >= '0' And substring(sca.sai_assitm, 5, 1) <= '9' ) And  (substring(sca.sai_assitm, 6, 1) >= '0' And substring(sca.sai_assitm, 6, 1) <= '9') then substring(sca.sai_assitm,1,11)   
   else    
   case when upper(substring(sca.sai_assitm, 3, 1)) = 'B' and (substring(sca.sai_assitm, 4, 1) >= '0' And substring(sca.sai_assitm, 4, 1) <= '9' ) And (substring(sca.sai_assitm, 5, 1) >= '0' And substring(sca.sai_assitm, 5, 1) <= '9' ) And  (substring(sca.sai_assitm, 6, 1) >= '0' And substring(sca.sai_assitm, 6, 1) <= '9') then substring(sca.sai_assitm,1,11)  
    else   
    case when upper(substring(sca.sai_assitm, 3, 1)) = 'B' and (upper(substring(sca.sai_assitm, 4, 1)) >= 'A' And upper(substring(sca.sai_assitm, 4, 1)) <= 'Z' ) And (substring(sca.sai_assitm, 5, 1) >= '0' And substring(sca.sai_assitm, 5, 1) <= '9' ) And  (substring(sca.sai_assitm, 6, 1) >= '0' And substring(sca.sai_assitm, 6, 1) <= '9') then substring(sca.sai_assitm,1,11)  
     else sca.sai_assitm  
     end  
   end  
  end  
  end  
*/

dbo.groupnewitmno(sca.sai_assitm)

  else  
  sca.sai_assitm
  end as 'sca.sai_assitm',  
  sca.sai_assdsc as 'sca.sai_assdsc',     
  sca.sai_coldsc as 'sca.sai_coldsc',     
  sca.sai_cussku as 'sca.sai_cussku',     
  sca.sai_upcean as 'sca.sai_upcean',     
  sca.sai_cusrtl as 'sca.sai_cusrtl',     
  ltrim(saa.ysi_dsc)  as 'sca.sai_untcde',        
  cast(  dtl.hid_ordseq  as nvarchar(20)) as 'dtl.hid_ordseq',    
  sca.sai_cusitm as 'sca.sai_cusitm',        
  sca.sai_colcde as 'sca.sai_colcde',        
  ltrim(str(sca.sai_inrqty,10,0))  as 'inner',        
  ltrim(str(sca.sai_mtrqty,10,0))  as 'master',        
  hdr.hih_cus1no as 'hdr.hih_cus1no',    
-- ltrim(cde.ysi_dsc) 
case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case when isnull(dtl.hid_contopc,'')  = 'Y' then 'PC' else ltrim(cde.ysi_dsc) end end
  as 'cde.ysi_dsc',        
  ltrim(dtl.hid_colcde)  as 'dtl.hid_colcde',        
  
 --Added by Mark Lau 20060927  
		--Added by Mark Lau 20080516, Add CDTVX

 case when @printGroup = '1' then  


 -- Changed by Mark Lau 20090402, use function to perform the logic
/*
  case when len(ltrim(rtrim(dtl.hid_itmno)) ) < 11 or charindex('-',ltrim(rtrim(dtl.hid_itmno)) ) > 0 or charindex('/',ltrim(rtrim(dtl.hid_itmno)) ) >0 or (Upper(substring(ltrim(rtrim(dtl.hid_itmno)) ,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(dtl.hid_itmno)) ,7,2) = 'AS' then ''  
  else   
  case when upper(substring(ltrim(rtrim(dtl.hid_itmno)) , 3, 1)) = 'A'   or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then + '(' + substring(ltrim(rtrim(dtl.hid_itmno)) ,12, len(dtl.hid_itmno) - 11) +  ') ' --and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)  
   else   
   case when upper(substring(ltrim(rtrim(dtl.hid_itmno)) , 3, 1)) = 'B' and (substring(ltrim(rtrim(dtl.hid_itmno)) , 4, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)) , 4, 1) <= '9' ) And (substring(ltrim(rtrim(dtl.hid_itmno)) , 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)) , 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)) , 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)) , 6, 1) <= '9') then  '(' +  substring(ltrim(rtrim(dtl.hid_itmno)) ,12,len(ltrim(rtrim(dtl.hid_itmno)) ) - 11) + ') '   
    else   
    case when upper(substring(ltrim(rtrim(dtl.hid_itmno)) , 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(dtl.hid_itmno)) , 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(dtl.hid_itmno)) , 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(dtl.hid_itmno)) , 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)) , 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)) , 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)) , 6, 1) <= '9') then  '(' + substring(ltrim(rtrim(dtl.hid_itmno)) ,12,len(ltrim(rtrim(dtl.hid_itmno)) ) - 11) + ') '   
     else ''  
     end  
   end  
  end  
  end  

*/
case when dbo.groupnewitmcol(dtl.hid_itmno,dtl.hid_colcde,'N') = '' then '' else '(' +  dbo.groupnewitmcol(dtl.hid_itmno,dtl.hid_colcde,'N') + ') ' end
  else  
  ''  
  end   +  
  Case rtrim(ltrim(dtl.hid_coldsc)) + ' ' +rtrim(ltrim(dtl.hid_cuscol)) when ' ' then Case rtrim(ltrim(pod_vencol)) when 'N/A' then '' else rtrim(ltrim(pod_vencol)) end else rtrim(ltrim(dtl.hid_coldsc)) + ' ' +rtrim(ltrim(dtl.hid_cuscol)) end AS 'dtl.hid_coldsc'  
 ,    
  ltrim(sod.sod_hrmcde)  as 'sod.sod_hrmcde',        
  ltrim(inv.hiv_bank)  as 'hiv.hiv_bank',        
  ltrim(inv.hiv_ftrrmk)  as 'hiv.hiv_ftrrmk',        
  ltrim( dtl.hid_cusitm) as 'dtl.hid_cusitm',     -- hid_cusitm??
  sod.sod_typcode as 'sod.sod_typcode',     
  LTRIM(sod.sod_Code1) + LTRIM(sod.sod_Code2) + LTRIM(sod.sod_Code3) AS 'sod.sod_code',    
 --- Additional Field : Duty Rate, Customer Retail & Dept #    
      
  CASE sod.sod_dtyrat when 0 then '' else ltrim(str(sod.sod_dtyrat,10,0)) end AS 'sod.sod_dtyrat',    
  CASE sod.sod_cususd when 0 then '' else ltrim(str(sod.sod_cususd,13,4)) end AS 'sod.sod_cususd',    
  CASE sod.sod_cuscad when 0 then '' else ltrim(str(sod.sod_cuscad,13,4)) end AS 'sod.sod_cuscad',    
  ltrim(sod.sod_dept) as 'sod.sod_dept',    
 -- dtl.hid_ctnstr,    
  ltrim(str(dtl.hid_ctnstr)) + ltrim(str(dtl.hid_ctnend)) as 'dtl.hid_ctnstr',    
case isnull(dtl.hid_contopc,'') when 'Y' then     
  str(round(dtl.hid_pcprc/1.05,2,1))
else
  str(round(dtl.hid_selprc/1.05,2,1))
end  
as 'dtl.hid_Aprc',        

 --- Packing Remarks Details    
 --- To concat. all packing remarks of the invoice    
 -- Total amount of a invoice    
   vw.hid_ttlctn   as 'vw_ttlctn',        
   case isnull(dtl.hid_contopc,'') when 'Y' then cast( vw.hid_shpqty*dtl.hid_conftr as int)  else vw.hid_shpqty end   as 'vw_shpqty',     
  -- case isnull(dtl.hid_contopc,'') when 'Y' then vw.hid_shpqty*dtl.hid_conftr else vw.hid_shpqty end   as 'vw_shpqty',     
  --round(vw.hid_selprc,6,1) as vw_debprc,  -- For debug only    
  --Case @laf when 'A' then round(round(vw.hid_selprc,6,1)/1.05,2) else round(vw.hid_selprc,6,1) end as vw_selprc,    
  --Case @laf when 'A' then  vw.sumamtd else vw.sumamt end as vw_sumamt,    
      
  Case (case when hiv_aformat = '2' then 'C' else ( case when hiv_aformat = '1' then 'A' else 'C' end) end)    
   when 'A' then 
	case isnull(dtl.hid_contopc,'') when 'Y' then 
		cast(cast(round(vw.hid_selprc,6,1)/dtl.hid_conftr/1.05 as decimal (14,3)) as nvarchar(20))
	else
		cast(cast(round(vw.hid_selprc,6,1)/1.05 as decimal (14,3)) as nvarchar(20))
	end
   else 
	case isnull(dtl.hid_contopc,'') when 'Y' then 
		cast(cast(round(vw.hid_selprc,6,1) / dtl.hid_conftr as decimal (14,3)) as nvarchar(20))
	else
		cast(cast(vw.hid_selprc as decimal (14,3)) as nvarchar(20))
	end
   end as vw_selprc,    
     
  Case case when hiv_aformat = '2' then 'C' else case when hiv_aformat = '1' then 'A' else 'C' end end    
   when 'A' then  vw.sumamtd else vw.sumamt end as vw_sumamt,    
---seqsumamt     
-- vw_selprc * dtl.hid_shpqty as 'seqsumamt',
Case (case when hiv_aformat = '2' then 'C' else ( case when hiv_aformat = '1' then 'A' else 'C' end) end)    
   when 'A' then 
	case isnull(dtl.hid_contopc,'') when 'Y' then 
		cast(dtl.hid_shpqty*round(vw.hid_selprc,6,1)/dtl.hid_conftr/1.05 as decimal (9,2)) 
	else
		cast(dtl.hid_shpqty*round(vw.hid_selprc,6,1)/1.05 as decimal (9,2))
	end
   else 
	case isnull(dtl.hid_contopc,'') when 'Y' then 
		cast(dtl.hid_shpqty*round(vw.hid_selprc,6,1) / dtl.hid_conftr as decimal (9,2)) 
	else
		cast(dtl.hid_shpqty*vw.hid_selprc as decimal (9,2)) 
	end
   end as 'seqsumamt',


  Case @opt4 when 'N' then '' else Case ltrim(dtl.hid_jobno) when '' then '' else  ltrim(dtl.hid_jobno) + '(' + ltrim(dtl.hid_venno) + ')' end end
  as 'dtl.hid_jobno',        
  sod.sod_itmdsc as 'sod.sod_itmdsc',       
  isnull(sod_cussku, '')  as 'sod.sod_cussku',        
  'TOTAL ' + upper(isnull(prc.ysi_dsc, hiv_prctrm))   as 'hiv_prctrm',        
   shm.hsm_engdsc as  'hsm_engdscM',    
  --2005/03/17 Lester Wu -- Retrieve Company Name , Short Name , Address, Phone, Fax, Email    
  @yco_conam  as '@yco_conam',    
  @yco_addr  as '@yco_addr',    
      
  @yco_phoneno  as '@yco_phoneno',    
  @yco_faxno  as '@yco_faxno',    
  @yco_logoimgpth  as '@yco_logoimgpth',  
  @yco_logoimgpth  as 'logoimgpth',  
  @yco_venid   as '@yco_venid', -- Frankie Cheung 22 Oct 2008
  @optTitle  as '@optTitle',  -- Lester Wu 2006-07-24   
  ltrim( dtl.hid_cusitm)  as '@optSort' ,-- Lester Wu 2006-07-26  
  --    
  
 @printAlias  as '@printAlias',  



  --Added by Mark Lau 20060928  
		--Added by Mark Lau 20080516, Add CDTVX
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
else
  case when @printGroup = '1' then  

-- Changed by Mark Lau 20090402, use function to perform the logic
/*
  case when len(sca.sai_assitm) < 11 or charindex('-',sca.sai_assitm) > 0 or charindex('/',sca.sai_assitm) >0 or (Upper(substring(sca.sai_assitm,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(sca.sai_assitm,7,2) = 'AS' then ''  
   
  else   
  case when upper(substring(sca.sai_assitm, 3, 1)) = 'A'  or upper(substring(sca.sai_assitm, 3, 1)) = 'C'  or upper(substring(sca.sai_assitm, 3, 1)) = 'D' or upper(substring(sca.sai_assitm, 3, 1)) = 'T' or upper(substring(sca.sai_assitm, 3, 1)) = 'X' or upper(substring(sca.sai_assitm, 3, 1)) = 'V'  then + '(' + substring(sca.sai_assitm,12, len(sca.sai_assitm) - 11) +  ') '    --and (substring(sca.sai_assitm, 4, 1) >= '0' And substring(sca.sai_assitm, 4, 1) <= '9' ) And (substring(sca.sai_assitm, 5, 1) >= '0' And substring(sca.sai_assitm, 5, 1) <= '9' ) And  (substring(sca.sai_assitm, 6, 1) >= '0' And substring(sca.sai_assitm, 6, 1) <= '9') then substring(sca.sai_assitm,1,11)  
   else   
   case when upper(substring(sca.sai_assitm, 3, 1)) = 'B' and (substring(sca.sai_assitm, 4, 1) >= '0' And substring(sca.sai_assitm, 4, 1) <= '9' ) And (substring(sca.sai_assitm, 5, 1) >= '0' And substring(sca.sai_assitm, 5, 1) <= '9' ) And  (substring(sca.sai_assitm, 6, 1) >= '0' And substring(sca.sai_assitm, 6, 1) <= '9') then    '(' +  substring(sca.sai_assitm,12,len(sca.sai_assitm) - 11) + ') '   
    else   
    case when upper(substring(sca.sai_assitm, 3, 1)) = 'B' and (upper(substring(sca.sai_assitm, 4, 1)) >= 'A' And upper(substring(sca.sai_assitm, 4, 1)) <= 'Z' ) And (substring(sca.sai_assitm, 5, 1) >= '0' And substring(sca.sai_assitm, 5, 1) <= '9' ) And  (substring(sca.sai_assitm, 6, 1) >= '0' And substring(sca.sai_assitm, 6, 1) <= '9') then  '(' + substring(sca.sai_assitm,12,len(sca.sai_assitm) - 11) + ') '   
     else ''  
     end  
   end  
  end  
  end  

*/
case when dbo.groupnewitmcol(sca.sai_assitm,'','N') = '' then '' else '(' +  dbo.groupnewitmcol(sca.sai_assitm,'','N') + ') ' end
  else  
  ''
  end end as 'ColSeq',  
  --Added by Mark Lau 20061005  
		--Added by Mark Lau 20080516, Add CDTVX
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
else
  case when @printGroup = '1' then  


-- Changed by Mark Lau 20090402, use function to perform the logic
/*
  case when len(dtl.hid_itmno) < 11 or charindex('-',dtl.hid_itmno) > 0 or charindex('/',dtl.hid_itmno) >0 or (Upper(substring(dtl.hid_itmno,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(dtl.hid_itmno,7,2) = 'AS' then ''  
   
  else   
  case when upper(substring(dtl.hid_itmno, 3, 1)) = 'A'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then + '(' + substring(dtl.hid_itmno,12, len(dtl.hid_itmno) - 11) +  ') '    --and (substring(sca.sai_assitm, 4, 1) >= '0' And substring(sca.sai_assitm, 4, 1) <= '9' ) And (substring(sca.sai_assitm, 5, 1) >= '0' And substring(sca.sai_assitm, 5, 1) <= '9' ) And  (substring(sca.sai_assitm, 6, 1) >= '0' And substring(sca.sai_assitm, 6, 1) <= '9') then substring(sca.sai_assitm,1,11)  
   else   
   case when upper(substring(dtl.hid_itmno, 3, 1)) = 'B' and (substring(dtl.hid_itmno, 4, 1) >= '0' And substring(dtl.hid_itmno, 4, 1) <= '9' ) And (substring(dtl.hid_itmno, 5, 1) >= '0' And substring(dtl.hid_itmno, 5, 1) <= '9' ) And  (substring(dtl.hid_itmno, 6, 1) >= '0' And substring(dtl.hid_itmno, 6, 1) <= '9') then    '(' +  substring(dtl.hid_itmno,12,len(dtl.hid_itmno) - 11) + ') '   
    else   
    case when upper(substring(dtl.hid_itmno, 3, 1)) = 'B' and (upper(substring(dtl.hid_itmno, 4, 1)) >= 'A' And upper(substring(dtl.hid_itmno, 4, 1)) <= 'Z' ) And (substring(dtl.hid_itmno, 5, 1) >= '0' And substring(dtl.hid_itmno, 5, 1) <= '9' ) And  (substring(dtl.hid_itmno, 6, 1) >= '0' And substring(dtl.hid_itmno, 6, 1) <= '9') then  '(' + substring(dtl.hid_itmno,12,len(dtl.hid_itmno) - 11) + ') '   
     else ''  
     end  
   end  
  end  
  end  

*/
case when dbo.groupnewitmcol(dtl.hid_itmno,'','N') = '' then '' else '(' +  dbo.groupnewitmcol(dtl.hid_itmno,'','N') + ') ' end
  else  
  ''  
  end end as 'ItmColSeq'  ,
/*
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm + ' (' + dtl.hid_itmno +  ')'
else
 case when @printGroup = '1' then  
  case when len(ltrim(rtrim(dtl.hid_itmno))) < 11 or charindex('-',ltrim(rtrim(dtl.hid_itmno))) > 0 or charindex('/',ltrim(rtrim(dtl.hid_itmno))) >0 or (Upper(substring(ltrim(rtrim(dtl.hid_itmno)),3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(dtl.hid_itmno)),7,2) = 'AS' then ltrim(rtrim(dtl.hid_itmno))  
   
  else   
  case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'A'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)   
   else   
   case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) <= '9' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
    else   
    case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
     else ltrim(rtrim(dtl.hid_itmno))  
     end  
   end  
  end  
  end  
  else  
  ltrim(rtrim(dtl.hid_itmno))  
 end end as 'DisplayItemNo',
*/
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm + ' (' + dtl.hid_itmno +  ')'
else
 case when @printGroup = '1' then  

-- Changed by Mark Lau 20090402, use function to perform the logic
/*

  case when len(ltrim(rtrim(dtl.hid_itmno))) < 11 or charindex('-',ltrim(rtrim(dtl.hid_itmno))) > 0 or charindex('/',ltrim(rtrim(dtl.hid_itmno))) >0 or (Upper(substring(ltrim(rtrim(dtl.hid_itmno)),3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(dtl.hid_itmno)),7,2) = 'AS' then ltrim(rtrim(dtl.hid_itmno))  
   
  else   
  case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'A'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)   
   else   
   case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) <= '9' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
    else   
    case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
     else ltrim(rtrim(dtl.hid_itmno))  
     end  
   end  
  end  
  end  

*/
dbo.groupnewitmno(dtl.hid_itmno)

  else  
  ltrim(rtrim(dtl.hid_itmno))  
 end end as 'DisplayItemNo',
  ltrim(rtrim(hdr.hih_potloa)) as 'hdr.hih_potloa',
  ltrim(rtrim(hdr.hih_dst)) as 'hdr.hih_dst',
  ltrim(rtrim(hdr.hih_lcno)) as 'hdr.hih_lcno',
  ltrim(rtrim(dtl.hid_cusstyno)) as 'dtl.hid_cusstyno',
  @printAss as '@printAss',

CASE WHEN (MONTH(inv.hiv_invdat) = 1) THEN  'Jan'
WHEN (MONTH(inv.hiv_invdat) = 2) THEN  'Feb'
WHEN (MONTH(inv.hiv_invdat) = 3) THEN  'Mar'
WHEN (MONTH(inv.hiv_invdat) = 4) THEN  'Apr'
WHEN (MONTH(inv.hiv_invdat) = 5) THEN  'May'
WHEN (MONTH(inv.hiv_invdat) = 6) THEN  'Jun'
WHEN (MONTH(inv.hiv_invdat) = 7) THEN  'Jul'
WHEN (MONTH(inv.hiv_invdat) = 8) THEN  'Aug'
WHEN (MONTH(inv.hiv_invdat) = 9) THEN  'Sep'
WHEN (MONTH(inv.hiv_invdat) = 10) THEN  'Oct'
WHEN (MONTH(inv.hiv_invdat) = 11) THEN  'Nov'
WHEN (MONTH(inv.hiv_invdat) = 12) THEN  'Dec'
END 
+ '/' +
right('0' +ltrim(rtrim(str(day(inv.hiv_invdat)))),2) + '/' + 
ltrim(rtrim(str(year(inv.hiv_invdat)))) as 'inv.hiv_invdat_text',

CASE WHEN (MONTH(hdr.hih_slnonb) = 1) THEN  'Jan'
WHEN (MONTH(hdr.hih_slnonb) = 2) THEN  'Feb'
WHEN (MONTH(hdr.hih_slnonb) = 3) THEN  'Mar'
WHEN (MONTH(hdr.hih_slnonb) = 4) THEN  'Apr'
WHEN (MONTH(hdr.hih_slnonb) = 5) THEN  'May'
WHEN (MONTH(hdr.hih_slnonb) = 6) THEN  'Jun'
WHEN (MONTH(hdr.hih_slnonb) = 7) THEN  'Jul'
WHEN (MONTH(hdr.hih_slnonb) = 8) THEN  'Aug'
WHEN (MONTH(hdr.hih_slnonb) = 9) THEN  'Sep'
WHEN (MONTH(hdr.hih_slnonb) = 10) THEN  'Oct'
WHEN (MONTH(hdr.hih_slnonb) = 11) THEN  'Nov'
WHEN (MONTH(hdr.hih_slnonb) = 12) THEN  'Dec'
END 
+ '/' +
right('0' +ltrim(rtrim(str(day(hdr.hih_slnonb)))),2) + '/' + 
ltrim(rtrim(str(year(hdr.hih_slnonb)))) as 'hdr.hih_slnonb_text',
cast(pod_purseq as nvarchar(20)) as 'pod_purseq', 	
sod_seccusitm as 'sod_seccusitm'


  	

--------    
  From  SHIPGHDR hdr    
  left join CUBASINF cus on  --hdr.hih_cocde = cus.cbi_cocde and     
     hdr.hih_cus1no = cus.cbi_cusno    
  left join SYSETINF cty on --hdr.hih_cocde = cty.ysi_cocde and     
     hdr.hih_bilcty = cty.ysi_cde and     
     cty.ysi_typ = '02'    
      
  ,SHINVHDR inv     
  left join SHIPGDTL dtl on inv.hiv_cocde = @cocde and    
     inv.hiv_shpno = dtl.hid_shpno and     
     inv.hiv_invno = dtl.hid_invno    
      
-- Added by Mark Lau 20080714, Customer Alias
-- Changed by Mark Lau 20090702
--  left join imcusals ca on  dtl.hid_itmno  = ca.ica_itmno  and ca.ica_apvsts = 'Y' 
 left join SHPCUSSTY ca on  dtl.hid_itmno  = ca.ica_itmno  and ca.ica_apvsts = 'Y' and ca.sod_ordno = dtl.hid_ordno 
  left join SHSHPMRK shm on   shm.hsm_cocde = @cocde and     
     shm.hsm_invno = inv.hiv_invno and     
     shm.hsm_shptyp = 'M'     
  left join SYSETINF prc on --prc.ysi_cocde =@cocde and     
     inv.hiv_prctrm = prc.ysi_cde and     
     prc.ysi_typ = '03'    
  left join SYSETINF pay on --pay.ysi_cocde = @cocde and     
     inv.hiv_paytrm = pay.ysi_cde and     
     pay.ysi_typ = '04'    
	--Modified by Mark Lau 20080314, move from low section
  left join SYSETINF cde on inv.hiv_cocde = @cocde and    
--Edited by Mark Lau 20080616 
     case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case when isnull(dtl.hid_contopc,'') = 'Y' then 'PC' else dtl.hid_untcde end end = cde.ysi_cde and     
     cde.ysi_typ = '05'         
  left join SCORDHDR soh on soh.soh_cocde = @cocde and     
     soh.soh_ordno = dtl.hid_ordno     
  left join SCORDDTL sod on  sod.sod_cocde = @cocde and     
     sod.sod_ordno = dtl.hid_ordno and     
     sod.sod_ordseq = dtl.hid_ordseq    
--Modified by Mark Lau 20061231 change from join v_select_inr00001 toselect_inr00001_wNewItmNo   
  left join  v_select_inr00001_wNewItmNo vw on  vw.hid_cocde =@cocde and   --  
--left join v_select_inr00001 vw on  vw.hid_cocde =@cocde and     
-- added by Mark Lau 20061231  
 vw.grp = @printgroup and   
      vw.hid_invno = inv.hiv_invno  and     
 -- AY Fix Grouping Problem in Printing at 31/12/2002    
 --     soh.soh_cuspo = vw.soh_cuspo and     
      dtl.hid_cuspo = vw.hid_cuspo and    
      dtl.hid_ordno = vw.hid_ordno and     
      dtl.hid_mannam = vw.hid_mannam and     
     --dtl.hid_itmno = vw.hid_itmno and     
		--Added by Mark Lau 20080516, Add CDTVX
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
else
case when @printGroup = '1' then  

 -- Changed by Mark Lau 20090402, use function to perform the logic
/*
  case when len(ltrim(rtrim(dtl.hid_itmno))) < 11 or charindex('-',ltrim(rtrim(dtl.hid_itmno))) > 0 or charindex('/',ltrim(rtrim(dtl.hid_itmno))) >0 or (Upper(substring(ltrim(rtrim(dtl.hid_itmno)),3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(dtl.hid_itmno)),7,2) = 'AS' then ltrim(rtrim(dtl.hid_itmno))  
  else   
  case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'A'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)   
   else   
   case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) <= '9' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
    else   
    case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
     else ltrim(rtrim(dtl.hid_itmno))  
     end  

   end  
  end  
  end  
*/
dbo.groupnewitmno(dtl.hid_itmno)
  else  
  ltrim(rtrim(dtl.hid_itmno))  
  end end = vw.hid_itmno and   

      dtl.hid_itmdsc = vw.hid_itmdsc and      
      dtl.hid_inrctn = vw.hid_inrctn and     
      dtl.hid_mtrctn = vw.hid_mtrctn    
 -- AY - Bug Fix SelPrc Grouping Item at 24/12/2002    
      and dtl.hid_selprc = round(vw.hid_selprc,6,1)      
	-- added by Mark Lau 20070427
	--Modified by Mark Lau 20080314, change hid_untcde to ysi_dsc
	     and cde.ysi_dsc = vw.ysi_dsc
 -- Lester Wu 2005-09-30, add group by gw, nw, and measurement,     
 -- ** Rememeber to modify v_select_inr00001 as well in order to match the following codes    
      and     
      ltrim(str(dtl.hid_grswgt,10,2)) = vw.hid_grswgt and     
      ltrim(str(dtl.hid_netwgt,10,2)) = vw.hid_netwgt and      
      ltrim(str(dtl.hid_mtrdcm,10,2)) + ' X ' + ltrim(str( dtl.hid_mtrwcm,10,2)) + ' X ' + ltrim(str(dtl.hid_mtrhcm,10,2)) = vw.MEAS   and  
      vw.hid_invno between @from and @to        
 ---------------------------------------------------------------------------------------------------------------    
     
  left join POORDDTL on  pod_cocde = @cocde and     
     pod_purord =  dtl.hid_purord and     
     pod_purseq = dtl.hid_purseq    

  left join SCASSINF sca on  sca.sai_cocde =@cocde  and     
     sca.sai_ordno = dtl.hid_ordno and     
     sca.sai_ordseq = dtl.hid_ordseq     
  left join  SYSETINF saa on  --saa.ysi_cocde = @cocde and     
     sca.sai_untcde = saa.ysi_cde and     
     saa.ysi_typ = '05'    




 WHERE      
  hdr.hih_shpsts <> 'HLD'    
 and  hdr.hih_cocde = @cocde    
 and hdr.hih_shpno = dtl.hid_shpno    
 and  inv.hiv_invno >= @from and inv.hiv_invno <= @to    
-- 20140610
order by hdr.hih_shpno,dtl.hid_shpseq

--and ( (hdr.hih_cus1no =  ca.ica_cusno and isnull(ca.ica_cusno,'') <> '') or  isnull(ca.ica_cusno,'') = '')
--ORDER BY dtl.hid_cusitm, dtl.hid_ctnstr
--ORDER BY dtl.hid_itmno, dtl.hid_ctnstr
end  
else  
begin  
------------------------------------------------------------------------------------------------------------------------------------------------------    
----*** MAKE SURE UPPER PART AND LOWER PART SHOULD IDENTICAL WHEN MODIFY THIS SP  *** ----  
------------------------------------------------------------------------------------------------------------------------------------------------------    
  -- Lower Part --  
------------------------------------------------------------------------------------------------------------------------------------------------------    
------------------------------------------------------------------------------------------------------------------------------------------------------     

--test start 2
--make temp_sumamt
select '5' as '5'

insert into #temp_table_sum
select  DISTINCT   dtl.hid_ordno  as 'dtl.hid_ordno',
 Case case when hiv_aformat = '2' then 'C' else case when hiv_aformat = '1' then 'A' else 'C' end end    
   when 'A' then  vw.sumamtd else vw.sumamt end as vw_sumamt,
   vw.hid_itmno as 'test_itm'

  From  SHIPGHDR hdr    
  left join CUBASINF cus on  --hdr.hih_cocde = cus.cbi_cocde and     
     hdr.hih_cus1no = cus.cbi_cusno    
  left join SYSETINF cty on --hdr.hih_cocde = cty.ysi_cocde and     
     hdr.hih_bilcty = cty.ysi_cde and     
     cty.ysi_typ = '02'    
  ,SHINVHDR inv     
  left join SHIPGDTL dtl on inv.hiv_cocde = @cocde and    
     inv.hiv_shpno = dtl.hid_shpno and     
     inv.hiv_invno = dtl.hid_invno    

-- Added by Mark Lau 20080714, Customer Alias
-- Changed by Mark Lau 20090702
--  left join imcusals ca on  dtl.hid_itmno  = ca.ica_itmno  and ca.ica_apvsts = 'Y' 
 left join SHPCUSSTY ca on  dtl.hid_itmno  = ca.ica_itmno  and ca.ica_apvsts = 'Y' and ca.sod_ordno = dtl.hid_ordno 
  left join SHSHPMRK shm on   shm.hsm_cocde = @cocde and     
     shm.hsm_invno = inv.hiv_invno and     
     shm.hsm_shptyp = 'M'     
  left join SYSETINF prc on --prc.ysi_cocde =@cocde and     
     inv.hiv_prctrm = prc.ysi_cde and     
     prc.ysi_typ = '03'    
  left join SYSETINF pay on --pay.ysi_cocde = @cocde and     
     inv.hiv_paytrm = pay.ysi_cde and     
     pay.ysi_typ = '04'    
  left join SCORDHDR soh on soh.soh_cocde = @cocde and     
     soh.soh_ordno = dtl.hid_ordno     
  left join SCORDDTL sod on  sod.sod_cocde = @cocde and     
     sod.sod_ordno = dtl.hid_ordno and     
     sod.sod_ordseq = dtl.hid_ordseq    
	--Modified by Mark Lau 20080314, move from low section
  left join SYSETINF cde on inv.hiv_cocde = @cocde and
--Edited by Mark Lau 20080616 
     case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case when isnull(dtl.hid_contopc,'')  = 'Y' then 'PC' else dtl.hid_untcde end end = cde.ysi_cde and     
     cde.ysi_typ = '05'  
--Modified by Mark Lau 20061231  
--  left join v_select_inr00001_cusitm vw on  vw.hid_cocde =@cocde and     
 left join v_select_inr00001_cusitm_wNewItmNo vw on  vw.hid_cocde =@cocde and  
  vw.grp = @printgroup and  
      vw.hid_invno = inv.hiv_invno  and     
 -- AY Fix Grouping Problem in Printing at 31/12/2002    
 --     soh.soh_cuspo = vw.soh_cuspo and     
      dtl.hid_cuspo = vw.hid_cuspo and    
      dtl.hid_ordno = vw.hid_ordno and     
      dtl.hid_mannam = vw.hid_mannam and     
--      dtl.hid_itmno = vw.hid_itmno and     
		--Added by Mark Lau 20080516, Add CDTVX
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
else
case when @printGroup = '1' then  


-- Changed by Mark Lau 20090402, use function to perform the logic
/*
  case when len(ltrim(rtrim(dtl.hid_itmno))) < 11 or charindex('-',ltrim(rtrim(dtl.hid_itmno))) > 0 or charindex('/',ltrim(rtrim(dtl.hid_itmno))) >0 or (Upper(substring(ltrim(rtrim(dtl.hid_itmno)),3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(dtl.hid_itmno)),7,2) = 'AS' then ltrim(rtrim(dtl.hid_itmno))  
  else
  case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'A'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)   
   else
   case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) <= '9' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
    else
    case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
     else ltrim(rtrim(dtl.hid_itmno))  

     end  
   end  
  end  
  end  


*/
dbo.groupnewitmno(dtl.hid_itmno)
  else  
  ltrim(rtrim(dtl.hid_itmno))  
  end end = vw.hid_itmno and   
      dtl.hid_itmdsc = vw.hid_itmdsc and      
      dtl.hid_inrctn = vw.hid_inrctn and     
      dtl.hid_mtrctn = vw.hid_mtrctn    
 -- AY - Bug Fix SelPrc Grouping Item at 24/12/2002    
      and dtl.hid_selprc = round(vw.hid_selprc,6,1)      
-- added by Mark Lau 20070427  
	--Modified by Mark Lau 20080314, change hid_untcde to ysi_dsc
	     and cde.ysi_dsc = vw.ysi_dsc
 -- Lester Wu 2005-09-30, add group by gw, nw, and measurement,     
 -- ** Rememeber to modify v_select_inr00001 as well in order to match the following codes    
      and     
      ltrim(str(dtl.hid_grswgt,10,2)) = vw.hid_grswgt and     
      ltrim(str(dtl.hid_netwgt,10,2)) = vw.hid_netwgt and      
      ltrim(str(dtl.hid_mtrdcm,10,2)) + ' X ' + ltrim(str( dtl.hid_mtrwcm,10,2)) + ' X ' + ltrim(str(dtl.hid_mtrhcm,10,2)) = vw.MEAS and  
      ltrim( dtl.hid_cusitm) = vw.hid_cusitm and  
      vw.hid_invno between @from and @to        
 ---------------------------------------------------------------------------------------------------------------    
  
  left join POORDDTL on  pod_cocde = @cocde and     
     pod_purord =  dtl.hid_purord and     
     pod_purseq = dtl.hid_purseq    
  
  left join SCASSINF sca on  sca.sai_cocde =@cocde  and     
     sca.sai_ordno = dtl.hid_ordno and     
     sca.sai_ordseq = dtl.hid_ordseq     
  left join  SYSETINF saa on  --saa.ysi_cocde = @cocde and     
     sca.sai_untcde = saa.ysi_cde and     
     saa.ysi_typ = '05'    
 WHERE      
  hdr.hih_shpsts <> 'HLD'    
 and  hdr.hih_cocde = @cocde    
 and hdr.hih_shpno = dtl.hid_shpno    
 and  inv.hiv_invno >= @from and inv.hiv_invno <= @to    
--and ( (hdr.hih_cus1no =  ca.ica_cusno and isnull(ca.ica_cusno,'') <> '') or  isnull(ca.ica_cusno,'') = '')
--ORDER BY dtl.hid_ctnstr

--end make

SET @temp_sumamt = 
(select sum(tmp_sum) 
from #temp_table_sum
--group by
--tmp_ordno
)


--test end  2

select * from #temp_table_sum

--select * from v_select_inr00001_cusitm_wNewItmNo


 Select     
@temp_sumamt as 'temp_sum',
@temp_sumamt_distinct AS 'temp_sum_distinct',
  @opt1  as 'opt1',        
  @opt2  as 'opt2',        
  @opt3  as 'opt3',        
  @opt4  as 'opt4',        
  @opt5  as 'opt5',        
  @opt6  as 'opt6',        
  --@laf,    
  --case when hiv_aformat = '2' then 'C' else case when hiv_aformat = '1' then 'A' else 'C' end end as 'hiv_aformat'
@laf  as 'laf',        
  hdr.hih_shpno as 'hdr.hih_shpno',     
  cast(dtl.hid_shpseq as nvarchar(20)) as 'dtl.hid_shpseq',     
  hdr.hih_smpshp as 'hdr.hih_smpshp',     
  inv.hiv_invno as 'inv.hiv_invno', 
  ltrim(inv.hiv_cover)  as 'inv.hiv_cover',        
  ltrim(cus.cbi_cusnam)  as 'cus.cbi_cusnam',           
  ltrim(hdr.hih_bilent)  as 'hdr.hih_bilent',        
  ltrim(hdr.hih_biladr)  as 'hdr.hih_biladr',         
  ltrim(hdr.hih_bilstt)  as 'hdr.hih_bilstt',         
  ltrim(cty.ysi_dsc)  as 'cty.ysi_dsc',         
  ltrim(hdr.hih_bilzip)  as 'hdr.hih_bilzip',        
  ltrim(pay.ysi_dsc)  as 'inv.hiv_paytrm',        
  ltrim(inv.hiv_ftrrmk)  as 'inv.hiv_ftrrmk',        
  ltrim(inv.hiv_doctyp)  as 'inv.hiv_doctyp',        
  ltrim(inv.hiv_doc)  as 'inv.hiv_doc',        
     
  inv.hiv_invdat  as 'inv.hiv_invdat',     
  'FROM ' + hdr.hih_potloa + ' TO ' + hdr.hih_dst
  as 'hdr.hih_potloa_hih_dst',        
  hdr.hih_ves  as 'hdr.hih_ves',    
  hdr.hih_voy  as 'hdr.hih_voy',     
  hdr.hih_slnonb  as 'hdr.hih_slnonb',     
     
 --- For Packing List, Group by Container #    
  ltrim(dtl.hid_pckrmk)  as 'dtl.hid_pckrmk',    
  dtl.hid_ctrcfs  as 'dtl.hid_ctrcfs',  
 --- Total of Cartons for Container    
     
 --- For Invoice, Group by Customer PO# and Sales Confirmation #    
  ltrim(dtl.hid_cuspo)
  as 'dtl.hid_cuspo',        
soh.soh_cpodat  as 'poh.poh_issdat',        
 --- Customer PO Date    
  dtl.hid_ordno  as 'dtl.hid_ordno',
  soh.soh_issdat  as 'soh.soh_issdat',
 --- SC Revise Date    
     
     
 --- Details Shipmark    
  ltrim(dtl.hid_itmshm)  as 'dtl.hid_itmshm',        
 --- Carton Details    

 --- Manufacturers Name & Address    
  ltrim(dtl.hid_mannam)  as 'dtl.hid_mannam',        
  ltrim(dtl.hid_manadr)  as 'dtl.hid_manadr',        

 -- ltrim(rtrim(dtl.hid_itmno)) as 'hid_itmno',    
  
 --Added by Mark Lau 20060927  
		--Added by Mark Lau 20080516, Add CDTVX
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm 
else
 case when @printGroup = '1' then  

-- Changed by Mark Lau 20090402, use function to perform the logic
/*
  case when len(ltrim(rtrim(dtl.hid_itmno))) < 11 or charindex('-',ltrim(rtrim(dtl.hid_itmno))) > 0 or charindex('/',ltrim(rtrim(dtl.hid_itmno))) >0 or (Upper(substring(ltrim(rtrim(dtl.hid_itmno)),3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(dtl.hid_itmno)),7,2) = 'AS' then ltrim(rtrim(dtl.hid_itmno))  
   
  else   
  case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'A'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)   
   else   
   case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) <= '9' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
    else   
    case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
     else ltrim(rtrim(dtl.hid_itmno))  
     end  
   end  
  end  
  end  

*/
dbo.groupnewitmno(dtl.hid_itmno)

  else  
  ltrim(rtrim(dtl.hid_itmno))  
  end end as 'dtl.hid_itmno',  
  case when @printAlias = '0' then '' else isnull(hid_alsitmno,'') end as 'dtl.hid_alsitmno',  
  ltrim(rtrim(dtl.hid_itmdsc)) as 'dtl.hid_itmdsc',      
     
 --- Assortment Details    
 --- Component Breakdown    
      
 --- Packing: change all to string and concat.    
CASE when isnull(dtl.hid_contopc,'') =  'Y' and isnull(dtl.hid_custum,'') <> '' THEN
	 CASE  ltrim(str(dtl.hid_inrctn)) WHEN '0' THEN     

	   ltrim(str(dtl.hid_mtrctn*dtl.hid_conftr)) +  ' ' + cde.ysi_dsc + ' IN MASTER CARTON.'    

	 ELSE     
	 ltrim(str(dtl.hid_inrctn*dtl.hid_conftr)) + ' ' + cde.ysi_dsc +' IN INNER BOX, '  + ltrim(str(dtl.hid_mtrctn*dtl.hid_conftr)) + ' ' + cde.ysi_dsc + ' IN MASTER CARTON.'  END
ELSE
CASE isnull(dtl.hid_contopc,'') when 'Y' Then
	 CASE  ltrim(str(dtl.hid_inrctn)) WHEN '0' THEN     
	   ltrim(str(dtl.hid_mtrctn*dtl.hid_conftr)) + ' PC IN MASTER CARTON.'    
	 ELSE     
	 ltrim(str(dtl.hid_inrctn*dtl.hid_conftr)) + ' PC IN INNER BOX, ' + ltrim(str(dtl.hid_mtrctn*dtl.hid_conftr)) + ' PC IN MASTER CARTON.' END
Else
	 CASE  ltrim(str(dtl.hid_inrctn)) WHEN '0' THEN     
	   ltrim(str(dtl.hid_mtrctn)) + ' ' + cde.ysi_dsc +' IN MASTER CARTON.'    
	 ELSE     
	 ltrim(str(dtl.hid_inrctn)) + ' ' + cde.ysi_dsc +' IN INNER BOX, ' + ltrim(str(dtl.hid_mtrctn)) + ' ' + cde.ysi_dsc +' IN MASTER CARTON.' END
END
END
  as 'dtl.packing',    
    
  ltrim(str(dtl.hid_grswgt,10,2)) + ' KG'
  as 'dtl.hid_grswgt',        
  ltrim(str(dtl.hid_netwgt,10,2)) + ' KG'
  as 'dtl.hid_netwgt',        

 --- Master Dim are concat.    
  ltrim(str(dtl.hid_mtrdcm,10,2)) + ' X ' + ltrim(str( dtl.hid_mtrwcm,10,2)) + ' X ' + ltrim(str(dtl.hid_mtrhcm,10,2)) + ' CM'  
as 'dtl.meas',        
 --- Harmonized Code    
     
  str(dtl.hid_ttlctn)  as 'dtl.hid_ttlctn',        
CASE isnull(dtl.hid_contopc,'') when 'Y' Then
  str(cast(cast(dtl.hid_shpqty*dtl.hid_conftr as int) as int))
Else
  str(dtl.hid_shpqty)
End  as 'dtl.hid_shpqty',        
 
  dtl.hid_untsel  as 'dtl.hid_untsel',    
case isnull(dtl.hid_contopc,'') when 'Y' then  
	str(round(dtl.hid_pcprc,2)) 
else  
	str(round(dtl.hid_selprc,2)) 
end   as 'dtl.hid_selprc',     

  str(round(dtl.hid_ttlamt,2),10,4)  as 'dtl.hid_ttlamt',        
  shm.hsm_imgpth   as 'shm.hsm_imgpth',         
  left(ltrim(shm.hsm_engdsc),1)  as 'shm.hsm_engdsc',        
  @cocde  as 'cocde',        
  ltrim(dtl.hid_cmprmk)  as 'dtl.hid_cmprmk',        
--  sca.sai_assitm,    
  
 --Added by Mark Lau 20060927  
		--Added by Mark Lau 20080516, Add CDTVX
 case when @printGroup = '1'  then  


 -- Changed by Mark Lau 20090402, use function to perform the logic
/*
  case when len(sca.sai_assitm) < 11 or charindex('-',sca.sai_assitm) > 0 or charindex('/',sca.sai_assitm) >0 or (Upper(substring(sca.sai_assitm,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(sca.sai_assitm,7,2) = 'AS' then sca.sai_assitm  
   
  else   
  case when upper(substring(sca.sai_assitm, 3, 1)) = 'A'  or upper(substring(sca.sai_assitm, 3, 1)) = 'C'  or upper(substring(sca.sai_assitm, 3, 1)) = 'D' or upper(substring(sca.sai_assitm, 3, 1)) = 'T' or upper(substring(sca.sai_assitm, 3, 1)) = 'X' or upper(substring(sca.sai_assitm, 3, 1)) = 'V'  then substring(sca.sai_assitm,1,11)--and (substring(sca.sai_assitm, 4, 1) >= '0' And substring(sca.sai_assitm, 4, 1) <= '9' ) And (substring(sca.sai_assitm, 5, 1) >= '0' And substring(sca.sai_assitm, 5, 1) <= '9' ) And  (substring(sca.sai_assitm, 6, 1) >= '0' And substring(sca.sai_assitm, 6, 1) <= '9') then substring(sca.sai_assitm,1,11)   
   else    
   case when upper(substring(sca.sai_assitm, 3, 1)) = 'B' and (substring(sca.sai_assitm, 4, 1) >= '0' And substring(sca.sai_assitm, 4, 1) <= '9' ) And (substring(sca.sai_assitm, 5, 1) >= '0' And substring(sca.sai_assitm, 5, 1) <= '9' ) And  (substring(sca.sai_assitm, 6, 1) >= '0' And substring(sca.sai_assitm, 6, 1) <= '9') then substring(sca.sai_assitm,1,11)  
    else   
    case when upper(substring(sca.sai_assitm, 3, 1)) = 'B' and (upper(substring(sca.sai_assitm, 4, 1)) >= 'A' And upper(substring(sca.sai_assitm, 4, 1)) <= 'Z' ) And (substring(sca.sai_assitm, 5, 1) >= '0' And substring(sca.sai_assitm, 5, 1) <= '9' ) And  (substring(sca.sai_assitm, 6, 1) >= '0' And substring(sca.sai_assitm, 6, 1) <= '9') then substring(sca.sai_assitm,1,11)  
     else sca.sai_assitm  
     end  
   end  
  end  
  end  
*/

dbo.groupnewitmno(sca.sai_assitm)

  else  
  sca.sai_assitm
  end as 'sca.sai_assitm',  
  sca.sai_assdsc as 'sca.sai_assdsc',     
  sca.sai_coldsc as 'sca.sai_coldsc',     
  sca.sai_cussku as 'sca.sai_cussku',     
  sca.sai_upcean as 'sca.sai_upcean',     
  sca.sai_cusrtl as 'sca.sai_cusrtl',     
  ltrim(saa.ysi_dsc)  as 'sca.sai_untcde',        
  cast(  dtl.hid_ordseq  as nvarchar(20)) as 'dtl.hid_ordseq',    
  sca.sai_cusitm as 'sca.sai_cusitm',        
  sca.sai_colcde as 'sca.sai_colcde',        
  ltrim(str(sca.sai_inrqty,10,0))  as 'inner',        
  ltrim(str(sca.sai_mtrqty,10,0))  as 'master',        
  hdr.hih_cus1no as 'hdr.hih_cus1no',    
-- ltrim(cde.ysi_dsc) 
case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case when isnull(dtl.hid_contopc,'')  = 'Y' then 'PC' else ltrim(cde.ysi_dsc) end end
  as 'cde.ysi_dsc',        
  ltrim(dtl.hid_colcde)  as 'dtl.hid_colcde',        
  
 --Added by Mark Lau 20060927  
		--Added by Mark Lau 20080516, Add CDTVX

 case when @printGroup = '1' then  


 -- Changed by Mark Lau 20090402, use function to perform the logic
/*
  case when len(ltrim(rtrim(dtl.hid_itmno)) ) < 11 or charindex('-',ltrim(rtrim(dtl.hid_itmno)) ) > 0 or charindex('/',ltrim(rtrim(dtl.hid_itmno)) ) >0 or (Upper(substring(ltrim(rtrim(dtl.hid_itmno)) ,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(dtl.hid_itmno)) ,7,2) = 'AS' then ''  
  else   
  case when upper(substring(ltrim(rtrim(dtl.hid_itmno)) , 3, 1)) = 'A'   or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then + '(' + substring(ltrim(rtrim(dtl.hid_itmno)) ,12, len(dtl.hid_itmno) - 11) +  ') ' --and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)  
   else   
   case when upper(substring(ltrim(rtrim(dtl.hid_itmno)) , 3, 1)) = 'B' and (substring(ltrim(rtrim(dtl.hid_itmno)) , 4, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)) , 4, 1) <= '9' ) And (substring(ltrim(rtrim(dtl.hid_itmno)) , 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)) , 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)) , 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)) , 6, 1) <= '9') then  '(' +  substring(ltrim(rtrim(dtl.hid_itmno)) ,12,len(ltrim(rtrim(dtl.hid_itmno)) ) - 11) + ') '   
    else   
    case when upper(substring(ltrim(rtrim(dtl.hid_itmno)) , 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(dtl.hid_itmno)) , 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(dtl.hid_itmno)) , 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(dtl.hid_itmno)) , 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)) , 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)) , 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)) , 6, 1) <= '9') then  '(' + substring(ltrim(rtrim(dtl.hid_itmno)) ,12,len(ltrim(rtrim(dtl.hid_itmno)) ) - 11) + ') '   
     else ''  
     end  
   end  
  end  
  end  

*/
case when dbo.groupnewitmcol(dtl.hid_itmno,dtl.hid_colcde,'N') = '' then '' else '(' +  dbo.groupnewitmcol(dtl.hid_itmno,dtl.hid_colcde,'N') + ') ' end
  else  
  ''  
  end   +  
  Case rtrim(ltrim(dtl.hid_coldsc)) + ' ' +rtrim(ltrim(dtl.hid_cuscol)) when ' ' then Case rtrim(ltrim(pod_vencol)) when 'N/A' then '' else rtrim(ltrim(pod_vencol)) end else rtrim(ltrim(dtl.hid_coldsc)) + ' ' +rtrim(ltrim(dtl.hid_cuscol)) end AS 'dtl.hid_coldsc'  
 ,    
  ltrim(sod.sod_hrmcde)  as 'sod.sod_hrmcde',        
  ltrim(inv.hiv_bank)  as 'hiv.hiv_bank',        
  ltrim(inv.hiv_ftrrmk)  as 'hiv.hiv_ftrrmk',        
  ltrim( dtl.hid_cusitm) as 'dtl.hid_cusitm',     -- hid_cusitm??
  sod.sod_typcode as 'sod.sod_typcode',     
  LTRIM(sod.sod_Code1) + LTRIM(sod.sod_Code2) + LTRIM(sod.sod_Code3) AS 'sod.sod_code',    
 --- Additional Field : Duty Rate, Customer Retail & Dept #    
      
  CASE sod.sod_dtyrat when 0 then '' else ltrim(str(sod.sod_dtyrat,10,0)) end AS 'sod.sod_dtyrat',    
  CASE sod.sod_cususd when 0 then '' else ltrim(str(sod.sod_cususd,13,4)) end AS 'sod.sod_cususd',    
  CASE sod.sod_cuscad when 0 then '' else ltrim(str(sod.sod_cuscad,13,4)) end AS 'sod.sod_cuscad',    
  ltrim(sod.sod_dept) as 'sod.sod_dept',    
 -- dtl.hid_ctnstr,    
  ltrim(str(dtl.hid_ctnstr)) + ltrim(str(dtl.hid_ctnend)) as 'dtl.hid_ctnstr',    
case isnull(dtl.hid_contopc,'') when 'Y' then     
  str(round(dtl.hid_pcprc/1.05,2,1))
else
  str(round(dtl.hid_selprc/1.05,2,1))
end  
as 'dtl.hid_Aprc',        

 --- Packing Remarks Details    
 --- To concat. all packing remarks of the invoice    
 -- Total amount of a invoice    
   vw.hid_ttlctn   as 'vw_ttlctn',        
   case isnull(dtl.hid_contopc,'') when 'Y' then cast( vw.hid_shpqty*dtl.hid_conftr as int)  else vw.hid_shpqty end   as 'vw_shpqty',     
  --round(vw.hid_selprc,6,1) as vw_debprc,  -- For debug only    
  --Case @laf when 'A' then round(round(vw.hid_selprc,6,1)/1.05,2) else round(vw.hid_selprc,6,1) end as vw_selprc,    
  --Case @laf when 'A' then  vw.sumamtd else vw.sumamt end as vw_sumamt,    
      
  Case (case when hiv_aformat = '2' then 'C' else ( case when hiv_aformat = '1' then 'A' else 'C' end) end)    
   when 'A' then 
	case isnull(dtl.hid_contopc,'') when 'Y' then 
		cast(cast(round(vw.hid_selprc,6,1)/dtl.hid_conftr/1.05 as decimal (14,3)) as nvarchar(20))
	else
		cast(cast(round(vw.hid_selprc,6,1)/1.05 as decimal (14,3)) as nvarchar(20))
	end
   else 
	case isnull(dtl.hid_contopc,'') when 'Y' then 
		cast(cast(round(vw.hid_selprc,6,1) / dtl.hid_conftr as decimal (14,3)) as nvarchar(20))
	else
		cast(cast(vw.hid_selprc as decimal (14,3)) as nvarchar(20))
	end
   end as vw_selprc,    
     
  Case case when hiv_aformat = '2' then 'C' else case when hiv_aformat = '1' then 'A' else 'C' end end    
   when 'A' then  vw.sumamtd else vw.sumamt end as vw_sumamt,    
--
  Case (case when hiv_aformat = '2' then 'C' else ( case when hiv_aformat = '1' then 'A' else 'C' end) end)    
   when 'A' then 
	case isnull(dtl.hid_contopc,'') when 'Y' then 
		cast(dtl.hid_shpqty*round(vw.hid_selprc,6,1)/dtl.hid_conftr/1.05 as decimal (9,2))
	else
		cast(dtl.hid_shpqty*round(vw.hid_selprc,6,1)/1.05 as decimal (9,2)) 
	end
   else 
	case isnull(dtl.hid_contopc,'') when 'Y' then 
		cast(dtl.hid_shpqty*round(vw.hid_selprc,6,1) / dtl.hid_conftr as decimal (9,2)) 
	else
		cast(dtl.hid_shpqty*vw.hid_selprc as decimal (9,2)) 
	end
   end as 'seqsumamt',    

     
  Case @opt4 when 'N' then '' else Case ltrim(dtl.hid_jobno) when '' then '' else  ltrim(dtl.hid_jobno) + '(' + ltrim(dtl.hid_venno) + ')' end end
  as 'dtl.hid_jobno',        
  sod.sod_itmdsc as 'sod.sod_itmdsc',       
  isnull(sod_cussku, '')  as 'sod.sod_cussku',        
  'TOTAL ' + upper(isnull(prc.ysi_dsc, hiv_prctrm))   as 'hiv_prctrm',        
   shm.hsm_engdsc as  'hsm_engdscM',    
  --2005/03/17 Lester Wu -- Retrieve Company Name , Short Name , Address, Phone, Fax, Email    
  @yco_conam  as '@yco_conam',    
  @yco_addr  as '@yco_addr',    
      
  @yco_phoneno  as '@yco_phoneno',    
  @yco_faxno  as '@yco_faxno',    
  @yco_logoimgpth  as '@yco_logoimgpth',  
  @yco_logoimgpth  as 'logoimgpth',  
  @yco_venid   as '@yco_venid', -- Frankie Cheung 22 Oct 2008
  @optTitle  as '@optTitle',  -- Lester Wu 2006-07-24   
  ltrim( dtl.hid_cusitm)  as '@optSort' ,-- Lester Wu 2006-07-26  
  --    
  
 @printAlias  as '@printAlias',  



  --Added by Mark Lau 20060928  
		--Added by Mark Lau 20080516, Add CDTVX
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
else
  case when @printGroup = '1' then  

-- Changed by Mark Lau 20090402, use function to perform the logic
/*
  case when len(sca.sai_assitm) < 11 or charindex('-',sca.sai_assitm) > 0 or charindex('/',sca.sai_assitm) >0 or (Upper(substring(sca.sai_assitm,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(sca.sai_assitm,7,2) = 'AS' then ''  
   
  else   
  case when upper(substring(sca.sai_assitm, 3, 1)) = 'A'  or upper(substring(sca.sai_assitm, 3, 1)) = 'C'  or upper(substring(sca.sai_assitm, 3, 1)) = 'D' or upper(substring(sca.sai_assitm, 3, 1)) = 'T' or upper(substring(sca.sai_assitm, 3, 1)) = 'X' or upper(substring(sca.sai_assitm, 3, 1)) = 'V'  then + '(' + substring(sca.sai_assitm,12, len(sca.sai_assitm) - 11) +  ') '    --and (substring(sca.sai_assitm, 4, 1) >= '0' And substring(sca.sai_assitm, 4, 1) <= '9' ) And (substring(sca.sai_assitm, 5, 1) >= '0' And substring(sca.sai_assitm, 5, 1) <= '9' ) And  (substring(sca.sai_assitm, 6, 1) >= '0' And substring(sca.sai_assitm, 6, 1) <= '9') then substring(sca.sai_assitm,1,11)  
   else   
   case when upper(substring(sca.sai_assitm, 3, 1)) = 'B' and (substring(sca.sai_assitm, 4, 1) >= '0' And substring(sca.sai_assitm, 4, 1) <= '9' ) And (substring(sca.sai_assitm, 5, 1) >= '0' And substring(sca.sai_assitm, 5, 1) <= '9' ) And  (substring(sca.sai_assitm, 6, 1) >= '0' And substring(sca.sai_assitm, 6, 1) <= '9') then    '(' +  substring(sca.sai_assitm,12,len(sca.sai_assitm) - 11) + ') '   
    else   
    case when upper(substring(sca.sai_assitm, 3, 1)) = 'B' and (upper(substring(sca.sai_assitm, 4, 1)) >= 'A' And upper(substring(sca.sai_assitm, 4, 1)) <= 'Z' ) And (substring(sca.sai_assitm, 5, 1) >= '0' And substring(sca.sai_assitm, 5, 1) <= '9' ) And  (substring(sca.sai_assitm, 6, 1) >= '0' And substring(sca.sai_assitm, 6, 1) <= '9') then  '(' + substring(sca.sai_assitm,12,len(sca.sai_assitm) - 11) + ') '   
     else ''  
     end  
   end  
  end  
  end  

*/
case when dbo.groupnewitmcol(sca.sai_assitm,'','N') = '' then '' else '(' +  dbo.groupnewitmcol(sca.sai_assitm,'','N') + ') ' end
  else  
  ''
  end end as 'ColSeq',  
  --Added by Mark Lau 20061005  
		--Added by Mark Lau 20080516, Add CDTVX
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
else
  case when @printGroup = '1' then  


-- Changed by Mark Lau 20090402, use function to perform the logic
/*
  case when len(dtl.hid_itmno) < 11 or charindex('-',dtl.hid_itmno) > 0 or charindex('/',dtl.hid_itmno) >0 or (Upper(substring(dtl.hid_itmno,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(dtl.hid_itmno,7,2) = 'AS' then ''  
   
  else   
  case when upper(substring(dtl.hid_itmno, 3, 1)) = 'A'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then + '(' + substring(dtl.hid_itmno,12, len(dtl.hid_itmno) - 11) +  ') '    --and (substring(sca.sai_assitm, 4, 1) >= '0' And substring(sca.sai_assitm, 4, 1) <= '9' ) And (substring(sca.sai_assitm, 5, 1) >= '0' And substring(sca.sai_assitm, 5, 1) <= '9' ) And  (substring(sca.sai_assitm, 6, 1) >= '0' And substring(sca.sai_assitm, 6, 1) <= '9') then substring(sca.sai_assitm,1,11)  
   else   
   case when upper(substring(dtl.hid_itmno, 3, 1)) = 'B' and (substring(dtl.hid_itmno, 4, 1) >= '0' And substring(dtl.hid_itmno, 4, 1) <= '9' ) And (substring(dtl.hid_itmno, 5, 1) >= '0' And substring(dtl.hid_itmno, 5, 1) <= '9' ) And  (substring(dtl.hid_itmno, 6, 1) >= '0' And substring(dtl.hid_itmno, 6, 1) <= '9') then    '(' +  substring(dtl.hid_itmno,12,len(dtl.hid_itmno) - 11) + ') '   
    else   
    case when upper(substring(dtl.hid_itmno, 3, 1)) = 'B' and (upper(substring(dtl.hid_itmno, 4, 1)) >= 'A' And upper(substring(dtl.hid_itmno, 4, 1)) <= 'Z' ) And (substring(dtl.hid_itmno, 5, 1) >= '0' And substring(dtl.hid_itmno, 5, 1) <= '9' ) And  (substring(dtl.hid_itmno, 6, 1) >= '0' And substring(dtl.hid_itmno, 6, 1) <= '9') then  '(' + substring(dtl.hid_itmno,12,len(dtl.hid_itmno) - 11) + ') '   
     else ''  
     end  
   end  
  end  
  end  

*/
case when dbo.groupnewitmcol(dtl.hid_itmno,'','N') = '' then '' else '(' +  dbo.groupnewitmcol(dtl.hid_itmno,'','N') + ') ' end
  else  
  ''  
  end end as 'ItmColSeq'  ,
/*
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm + ' (' + dtl.hid_itmno +  ')'
else
 case when @printGroup = '1' then  
  case when len(ltrim(rtrim(dtl.hid_itmno))) < 11 or charindex('-',ltrim(rtrim(dtl.hid_itmno))) > 0 or charindex('/',ltrim(rtrim(dtl.hid_itmno))) >0 or (Upper(substring(ltrim(rtrim(dtl.hid_itmno)),3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(dtl.hid_itmno)),7,2) = 'AS' then ltrim(rtrim(dtl.hid_itmno))  
   
  else   
  case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'A'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)   
   else   
   case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) <= '9' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
    else   
    case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
     else ltrim(rtrim(dtl.hid_itmno))  
     end  
   end  
  end  
  end  
  else  
  ltrim(rtrim(dtl.hid_itmno))  
 end end as 'DisplayItemNo',
*/
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm + ' (' + dtl.hid_itmno +  ')'
else
 case when @printGroup = '1' then  

-- Changed by Mark Lau 20090402, use function to perform the logic
/*

  case when len(ltrim(rtrim(dtl.hid_itmno))) < 11 or charindex('-',ltrim(rtrim(dtl.hid_itmno))) > 0 or charindex('/',ltrim(rtrim(dtl.hid_itmno))) >0 or (Upper(substring(ltrim(rtrim(dtl.hid_itmno)),3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(dtl.hid_itmno)),7,2) = 'AS' then ltrim(rtrim(dtl.hid_itmno))  
   
  else   
  case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'A'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)   
   else   
   case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) <= '9' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
    else   
    case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
     else ltrim(rtrim(dtl.hid_itmno))  
     end  
   end  
  end  
  end  

*/
dbo.groupnewitmno(dtl.hid_itmno)

  else  
  ltrim(rtrim(dtl.hid_itmno))  
 end end as 'DisplayItemNo',
  ltrim(rtrim(hdr.hih_potloa)) as 'hdr.hih_potloa',
  ltrim(rtrim(hdr.hih_dst)) as 'hdr.hih_dst',
  ltrim(rtrim(hdr.hih_lcno)) as 'hdr.hih_lcno',
  ltrim(rtrim(dtl.hid_cusstyno)) as 'dtl.hid_cusstyno',
  @printAss as '@printAss',

CASE WHEN (MONTH(inv.hiv_invdat) = 1) THEN  'Jan'
WHEN (MONTH(inv.hiv_invdat) = 2) THEN  'Feb'
WHEN (MONTH(inv.hiv_invdat) = 3) THEN  'Mar'
WHEN (MONTH(inv.hiv_invdat) = 4) THEN  'Apr'
WHEN (MONTH(inv.hiv_invdat) = 5) THEN  'May'
WHEN (MONTH(inv.hiv_invdat) = 6) THEN  'Jun'
WHEN (MONTH(inv.hiv_invdat) = 7) THEN  'Jul'
WHEN (MONTH(inv.hiv_invdat) = 8) THEN  'Aug'
WHEN (MONTH(inv.hiv_invdat) = 9) THEN  'Sep'
WHEN (MONTH(inv.hiv_invdat) = 10) THEN  'Oct'
WHEN (MONTH(inv.hiv_invdat) = 11) THEN  'Nov'
WHEN (MONTH(inv.hiv_invdat) = 12) THEN  'Dec'
END 
+ '/' +
right('0' +ltrim(rtrim(str(day(inv.hiv_invdat)))),2) + '/' + 
ltrim(rtrim(str(year(inv.hiv_invdat)))) as 'inv.hiv_invdat_text',

CASE WHEN (MONTH(hdr.hih_slnonb) = 1) THEN  'Jan'
WHEN (MONTH(hdr.hih_slnonb) = 2) THEN  'Feb'
WHEN (MONTH(hdr.hih_slnonb) = 3) THEN  'Mar'
WHEN (MONTH(hdr.hih_slnonb) = 4) THEN  'Apr'
WHEN (MONTH(hdr.hih_slnonb) = 5) THEN  'May'
WHEN (MONTH(hdr.hih_slnonb) = 6) THEN  'Jun'
WHEN (MONTH(hdr.hih_slnonb) = 7) THEN  'Jul'
WHEN (MONTH(hdr.hih_slnonb) = 8) THEN  'Aug'
WHEN (MONTH(hdr.hih_slnonb) = 9) THEN  'Sep'
WHEN (MONTH(hdr.hih_slnonb) = 10) THEN  'Oct'
WHEN (MONTH(hdr.hih_slnonb) = 11) THEN  'Nov'
WHEN (MONTH(hdr.hih_slnonb) = 12) THEN  'Dec'
END 
+ '/' +
right('0' +ltrim(rtrim(str(day(hdr.hih_slnonb)))),2) + '/' + 
ltrim(rtrim(str(year(hdr.hih_slnonb)))) as 'hdr.hih_slnonb_text',
cast(pod_purseq as nvarchar(20)) as 'pod_purseq', 	
sod_seccusitm as 'sod_seccusitm'

--------    
  From  SHIPGHDR hdr    
  left join CUBASINF cus on  --hdr.hih_cocde = cus.cbi_cocde and     
     hdr.hih_cus1no = cus.cbi_cusno    
  left join SYSETINF cty on --hdr.hih_cocde = cty.ysi_cocde and     
     hdr.hih_bilcty = cty.ysi_cde and     
     cty.ysi_typ = '02'    
  ,SHINVHDR inv     
  left join SHIPGDTL dtl on inv.hiv_cocde = @cocde and    
     inv.hiv_shpno = dtl.hid_shpno and     
     inv.hiv_invno = dtl.hid_invno    

-- Added by Mark Lau 20080714, Customer Alias
-- Changed by Mark Lau 20090702
--  left join imcusals ca on  dtl.hid_itmno  = ca.ica_itmno  and ca.ica_apvsts = 'Y' 
 left join SHPCUSSTY ca on  dtl.hid_itmno  = ca.ica_itmno  and ca.ica_apvsts = 'Y' and ca.sod_ordno = dtl.hid_ordno 
  left join SHSHPMRK shm on   shm.hsm_cocde = @cocde and     
     shm.hsm_invno = inv.hiv_invno and     
     shm.hsm_shptyp = 'M'     
  left join SYSETINF prc on --prc.ysi_cocde =@cocde and     
     inv.hiv_prctrm = prc.ysi_cde and     
     prc.ysi_typ = '03'    
  left join SYSETINF pay on --pay.ysi_cocde = @cocde and     
     inv.hiv_paytrm = pay.ysi_cde and     
     pay.ysi_typ = '04'    
  left join SCORDHDR soh on soh.soh_cocde = @cocde and     
     soh.soh_ordno = dtl.hid_ordno     
  left join SCORDDTL sod on  sod.sod_cocde = @cocde and     
     sod.sod_ordno = dtl.hid_ordno and     
     sod.sod_ordseq = dtl.hid_ordseq    
	--Modified by Mark Lau 20080314, move from low section
  left join SYSETINF cde on inv.hiv_cocde = @cocde and
--Edited by Mark Lau 20080616 
     case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case when isnull(dtl.hid_contopc,'')  = 'Y' then 'PC' else dtl.hid_untcde end end = cde.ysi_cde and     
     cde.ysi_typ = '05'  
--Modified by Mark Lau 20061231  
--  left join v_select_inr00001_cusitm vw on  vw.hid_cocde =@cocde and     
 left join v_select_inr00001_cusitm_wNewItmNo vw on  vw.hid_cocde =@cocde and  
  vw.grp = @printgroup and  
      vw.hid_invno = inv.hiv_invno  and     
 -- AY Fix Grouping Problem in Printing at 31/12/2002    
 --     soh.soh_cuspo = vw.soh_cuspo and     
      dtl.hid_cuspo = vw.hid_cuspo and    
      dtl.hid_ordno = vw.hid_ordno and     
      dtl.hid_mannam = vw.hid_mannam and     
--      dtl.hid_itmno = vw.hid_itmno and     
		--Added by Mark Lau 20080516, Add CDTVX
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
else
case when @printGroup = '1' then  


-- Changed by Mark Lau 20090402, use function to perform the logic
/*
  case when len(ltrim(rtrim(dtl.hid_itmno))) < 11 or charindex('-',ltrim(rtrim(dtl.hid_itmno))) > 0 or charindex('/',ltrim(rtrim(dtl.hid_itmno))) >0 or (Upper(substring(ltrim(rtrim(dtl.hid_itmno)),3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(ltrim(rtrim(dtl.hid_itmno)),7,2) = 'AS' then ltrim(rtrim(dtl.hid_itmno))  
  else
  case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'A'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'C'  or upper(substring(dtl.hid_itmno, 3, 1)) = 'D' or upper(substring(dtl.hid_itmno, 3, 1)) = 'T' or upper(substring(dtl.hid_itmno, 3, 1)) = 'X' or upper(substring(dtl.hid_itmno, 3, 1)) = 'V'  then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)--and (substring(dtl.qud_itmno, 4, 1) >= '0' And substring(dtl.qud_itmno, 4, 1) <= '9' ) And (substring(dtl.qud_itmno, 5, 1) >= '0' And substring(dtl.qud_itmno, 5, 1) <= '9' ) And  (substring(dtl.qud_itmno, 6, 1) >= '0' And substring(dtl.qud_itmno, 6, 1) <= '9') then substring(dtl.qud_itmno,1,11)   
   else
   case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1) <= '9' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
    else
    case when upper(substring(ltrim(rtrim(dtl.hid_itmno)), 3, 1)) = 'B' and (upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) >= 'A' And upper(substring(ltrim(rtrim(dtl.hid_itmno)), 4, 1)) <= 'Z' ) And (substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 5, 1) <= '9' ) And  (substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) >= '0' And substring(ltrim(rtrim(dtl.hid_itmno)), 6, 1) <= '9') then substring(ltrim(rtrim(dtl.hid_itmno)),1,11)  
     else ltrim(rtrim(dtl.hid_itmno))  

     end  
   end  
  end  
  end  


*/
dbo.groupnewitmno(dtl.hid_itmno)
  else  
  ltrim(rtrim(dtl.hid_itmno))  
  end end = vw.hid_itmno and   
      dtl.hid_itmdsc = vw.hid_itmdsc and      
      dtl.hid_inrctn = vw.hid_inrctn and     
      dtl.hid_mtrctn = vw.hid_mtrctn    
 -- AY - Bug Fix SelPrc Grouping Item at 24/12/2002    
      and dtl.hid_selprc = round(vw.hid_selprc,6,1)      
-- added by Mark Lau 20070427  
	--Modified by Mark Lau 20080314, change hid_untcde to ysi_dsc
	     and cde.ysi_dsc = vw.ysi_dsc
 -- Lester Wu 2005-09-30, add group by gw, nw, and measurement,     
 -- ** Rememeber to modify v_select_inr00001 as well in order to match the following codes    
      and     
      ltrim(str(dtl.hid_grswgt,10,2)) = vw.hid_grswgt and     
      ltrim(str(dtl.hid_netwgt,10,2)) = vw.hid_netwgt and      
      ltrim(str(dtl.hid_mtrdcm,10,2)) + ' X ' + ltrim(str( dtl.hid_mtrwcm,10,2)) + ' X ' + ltrim(str(dtl.hid_mtrhcm,10,2)) = vw.MEAS and  
      ltrim( dtl.hid_cusitm) = vw.hid_cusitm and  
      vw.hid_invno between @from and @to        
 ---------------------------------------------------------------------------------------------------------------    
  
  left join POORDDTL on  pod_cocde = @cocde and     
     pod_purord =  dtl.hid_purord and     
     pod_purseq = dtl.hid_purseq    
  
  left join SCASSINF sca on  sca.sai_cocde =@cocde  and     
     sca.sai_ordno = dtl.hid_ordno and     
     sca.sai_ordseq = dtl.hid_ordseq     
  left join  SYSETINF saa on  --saa.ysi_cocde = @cocde and     
     sca.sai_untcde = saa.ysi_cde and     
     saa.ysi_typ = '05'    
 WHERE      
  hdr.hih_shpsts <> 'HLD'    
 and  hdr.hih_cocde = @cocde    
 and hdr.hih_shpno = dtl.hid_shpno    
 and  inv.hiv_invno >= @from and inv.hiv_invno <= @to    
-- 20140610
order by hdr.hih_shpno,dtl.hid_shpseq

--and ( (hdr.hih_cus1no =  ca.ica_cusno and isnull(ca.ica_cusno,'') <> '') or  isnull(ca.ica_cusno,'') = '')
--ORDER BY dtl.hid_ctnstr
end  
    
end


























GO
