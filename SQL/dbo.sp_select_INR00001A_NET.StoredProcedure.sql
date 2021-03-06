/****** Object:  StoredProcedure [dbo].[sp_select_INR00001A_NET]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_INR00001A_NET]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_INR00001A_NET]    Script Date: 09/29/2017 15:29:10 ******/
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

CREATE                     procedure [dbo].[sp_select_INR00001A_NET] 
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

create table #temp_table_sum
(
tmp_ordno	nvarchar(30),
tmp_sum	numeric(13,4),
tmp_invno        nvarchar(30)
)
create table #temp_table_sum_byinv
(
tmp_sum	numeric(13,4),
tmp_invno        nvarchar(30)
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
create table #temp_cmp
(
	tmp_shpno  nvarchar(20),
	tmp_shpseq int,
	tmp_cmp      nvarchar(4000),
)
-- For cursor use
declare
@chk_shpno  nvarchar(20),
@chk_shpseq int,
@cmp_str  nvarchar(4000)
declare
@chk_cpt  nvarchar(500),
@chk_pct int

declare c_1 CURSOR FOR
select dtl.hid_shpno,dtl.hid_shpseq
from  shipgdtl dtl 
left join shinvhdr  sih
	on dtl.hid_shpno = sih.hiv_shpno
where 	sih.hiv_invno >= @from	
	and sih.hiv_invno <= @to	

Open c_1
FETCH NEXT FROM c_1 INTO @chk_shpno  ,@chk_shpseq
WHILE @@FETCH_STATUS = 0
BEGIN
   set @cmp_str =''

   Declare c_2 CURSOR FOR
   select 
	scb.shb_cpt,scb.shb_pct
	from SHCPTBKD scb (nolock) 
	where 	scb.shb_ordno = @chk_shpno
		and  scb.shb_ordseq = @chk_shpseq
		order by scb.shb_cptseq
   OPEN c_2
   FETCH NEXT FROM c_2 INTO @chk_cpt,@chk_pct
   WHILE @@FETCH_STATUS = 0
   BEGIN
	set @cmp_str = @cmp_str +@chk_cpt+ ' ' +convert(nvarchar(9),@chk_pct ) +'%  '
         FETCH NEXT FROM c_2 INTO @chk_cpt,@chk_pct
   END
   CLOSE c_2
   DEALLOCATE c_2

      insert into  #temp_cmp
      select @chk_shpno  ,@chk_shpseq, @cmp_str

FETCH NEXT FROM c_1 INTO @chk_shpno  ,@chk_shpseq
END
CLOSE c_1
DEALLOCATE c_1


if @optSort = 'ITM'   

Begin

--make temp_sumamt
insert into #temp_table_sum
select  
DISTINCT   
dtl.hid_ordno + dtl.hid_cusstyno  as 'dtl.hid_ordno',
Case case when hiv_aformat = '2' then 'C' else case 
when hiv_aformat = '1' then 'A' else 'C' end end when 'A' 
then  vw.sumamtd else vw.sumamt end as vw_sumamt,
hiv_invno  as 'hiv_invno'
From  SHIPGHDR hdr    
left join CUBASINF cus on hdr.hih_cus1no = cus.cbi_cusno    
left join SYSETINF cty on hdr.hih_bilcty = cty.ysi_cde and cty.ysi_typ = '02'    
,SHINVHDR inv     
left join SHIPGDTL dtl on inv.hiv_cocde = @cocde and inv.hiv_shpno = dtl.hid_shpno and inv.hiv_invno = dtl.hid_invno    
left join shpckdim pdm on 
	 pdm.hpd_shpno = hid_shpno and pdm.hpd_shpseq = hid_shpseq
		and pdm.hpd_dimtyp = 'Mod'
		and (
			(dtl.hid_ctnftr = 1 and ( pdm.hpd_pdnum = 5 or pdm.hpd_pdnum = 6 )) 
			or (dtl.hid_ctnftr = 2 and ( pdm.hpd_pdnum = 1 or pdm.hpd_pdnum = 2 or pdm.hpd_pdnum = 3 or pdm.hpd_pdnum = 4 ))   
			)
left join SHPCUSSTY ca on dtl.hid_itmno  = ca.ica_itmno  and ca.ica_apvsts = 'Y' and ca.sod_ordno = dtl.hid_ordno 
left join SHSHPMRK shm on shm.hsm_cocde = @cocde and  shm.hsm_invno = inv.hiv_invno and shm.hsm_shptyp = 'M'     
left join SYSETINF prc on inv.hiv_prctrm = prc.ysi_cde and prc.ysi_typ = '03'    
left join SYSETINF pay on inv.hiv_paytrm = pay.ysi_cde and pay.ysi_typ = '04'    
left join SYSETINF cde on inv.hiv_cocde = @cocde and case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case when isnull(dtl.hid_contopc,'') = 'Y' then 'PC' else dtl.hid_untcde end end = cde.ysi_cde and cde.ysi_typ = '05'         
left join SCORDHDR soh on soh.soh_cocde = @cocde and soh.soh_ordno = dtl.hid_ordno     
left join SCORDDTL sod on  sod.sod_cocde = @cocde and sod.sod_ordno = dtl.hid_ordno and sod.sod_ordseq = dtl.hid_ordseq    
left join  v_select_inr00001_wNewItmNo vw on  	
	vw.hid_cocde =@cocde and
	vw.grp = @printgroup and
	vw.hid_invno = inv.hiv_invno and 
	dtl.hid_cuspo = vw.hid_cuspo and    
	dtl.hid_ordno = vw.hid_ordno and     
	dtl.hid_mannam = vw.hid_mannam and     
	case when isnull(ca.ica_itmno,'') <> '' 
	     then ca.ica_cusalsitm 
             else case when @printGroup = '1' 
                       then dbo.groupnewitmno(dtl.hid_itmno)
                       else ltrim(rtrim(dtl.hid_itmno))
                       end 
             end = vw.hid_itmno and   
	dtl.hid_itmdsc = vw.hid_itmdsc and      
	dtl.hid_inrctn = vw.hid_inrctn and     
	dtl.hid_mtrctn = vw.hid_mtrctn and 
	dtl.hid_selprc = round(vw.hid_selprc,6,1) and 
	cde.ysi_dsc = vw.ysi_dsc and     
	ltrim(str(pdm.hpd_gw_kg,10,2)) = vw.hid_grswgt and     
	ltrim(str(pdm.hpd_nw_kg,10,2)) = vw.hid_netwgt and      
	ltrim(str(pdm.hpd_l_cm,10,2)) + ' X ' + ltrim(str(pdm.hpd_w_cm,10,2)) + ' X ' + ltrim(str(pdm.hpd_h_cm,10,2)) = vw.MEAS   and  
	vw.hid_invno between @from and @to        
left join POORDDTL on  pod_cocde = @cocde and pod_purord =  dtl.hid_purord and pod_purseq = dtl.hid_purseq    
left join SCASSINF sca on sca.sai_cocde =@cocde  and sca.sai_ordno = dtl.hid_ordno and sca.sai_ordseq = dtl.hid_ordseq     
left join SYSETINF saa on sca.sai_untcde = saa.ysi_cde and saa.ysi_typ = '05'    
WHERE      
hdr.hih_shpsts <> 'HLD' and  
hdr.hih_cocde = @cocde and 
hdr.hih_shpno = dtl.hid_shpno and 
inv.hiv_invno >= @from and inv.hiv_invno <= @to    

--select * from #temp_table_sum

insert into #temp_table_sum_byinv
select sum(tmp_sum),tmp_invno
from #temp_table_sum
group by tmp_invno


insert into #temp_table_sum_distinct
select distinct tmp_ordno,tmp_sum from #temp_table_sum

--SET @temp_sumamt = 
--(select sum(tmp_sum) 
--from #temp_table_sum

--group by
--tmp_ordno
--)

SET @temp_sumamt_distinct = 
(select sum( tmp_sum) 
from #temp_table_sum_distinct
--group by
--tmp_ordno
)

--goto

Select     
[#temp_table_sum_byinv].tmp_sum  as 'temp_sum',
--@temp_sumamt_distinct AS 'temp_sum_distinct',
1 AS 'temp_sum_distinct',
@opt1  as 'opt1',        
@opt2  as 'opt2',        
@opt3  as 'opt3',        
@opt4  as 'opt4',        
@opt5  as 'opt5',        
@opt6  as 'opt6',        
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
'FROM ' + hdr.hih_potloa + ' TO ' + hdr.hih_dst as 'hdr.hih_potloa_hih_dst',        
hdr.hih_ves  as 'hdr.hih_ves',    
hdr.hih_voy  as 'hdr.hih_voy',     
hdr.hih_slnonb  as 'hdr.hih_slnonb',     

ltrim(dtl.hid_pckrmk)  as 'dtl.hid_pckrmk',    
dtl.hid_ctrcfs  as 'dtl.hid_ctrcfs',  

ltrim(dtl.hid_cuspo) as 'dtl.hid_cuspo',        
soh.soh_cpodat  as 'poh.poh_issdat',        
dtl.hid_ordno  as 'dtl.hid_ordno',
soh.soh_issdat  as 'soh.soh_issdat',

ltrim(dtl.hid_itmshm)  as 'dtl.hid_itmshm',        
ltrim(dtl.hid_mannam)  as 'dtl.hid_mannam',        
ltrim(dtl.hid_manadr)  as 'dtl.hid_manadr',        

case when isnull(ca.ica_itmno,'') <> '' 
     then ca.ica_cusalsitm 
     else case when @printGroup = '1' 
               then dbo.groupnewitmno(dtl.hid_itmno)
               else ltrim(rtrim(dtl.hid_itmno))
               end 
     end as 'dtl.hid_itmno',  

case when @printAlias = '0' then '' else isnull(hid_alsitmno,'') end as 'dtl.hid_alsitmno',  

ltrim(rtrim(dtl.hid_itmdsc)) as 'dtl.hid_itmdsc',      
     
CASE when isnull(dtl.hid_contopc,'') =  'Y' and isnull(dtl.hid_custum,'') <> '' 
     THEN CASE ltrim(str(dtl.hid_inrctn)) WHEN '0' 
                      THEN     
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
    
ltrim(str(pdm.hpd_gw_kg,10,2)) + ' KG'  as 'dtl.hid_grswgt',        
ltrim(str(pdm.hpd_nw_kg,10,2)) + ' KG'  as 'dtl.hid_netwgt',        

ltrim(str(pdm.hpd_l_cm,10,2)) + ' X ' + ltrim(str(pdm.hpd_w_cm,10,2)) + ' X ' + ltrim(str(pdm.hpd_h_cm,10,2)) + ' CM' as 'dtl.meas',        
    
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
--ltrim(dtl.hid_cmprmk)  as 'dtl.hid_cmprmk',        

case when @printGroup = '1'  
     then dbo.groupnewitmno(sca.sai_assitm)
     else sca.sai_assitm end as 'sca.sai_assitm',  
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

case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case when isnull(dtl.hid_contopc,'')  = 'Y' then 'PC' else ltrim(cde.ysi_dsc) end end  as 'cde.ysi_dsc',        
ltrim(dtl.hid_colcde)  as 'dtl.hid_colcde',        
case when @printGroup = '1' then  
case when dbo.groupnewitmcol(dtl.hid_itmno,dtl.hid_colcde,'N') = '' then '' else '(' +  dbo.groupnewitmcol(dtl.hid_itmno,dtl.hid_colcde,'N') + ') ' end
  else  
  ''  
  end   +  
  Case rtrim(ltrim(dtl.hid_coldsc)) + ' ' +rtrim(ltrim(dtl.hid_cuscol)) when ' ' then Case rtrim(ltrim(pod_vencol)) when 'N/A' then '' else rtrim(ltrim(pod_vencol)) end else rtrim(ltrim(dtl.hid_coldsc)) + ' ' +rtrim(ltrim(dtl.hid_cuscol)) end AS 'dtl.hid_coldsc' ,
    
ltrim(sod.sod_hrmcde)  as 'sod.sod_hrmcde',        
ltrim(inv.hiv_bank)  as 'hiv.hiv_bank',        
ltrim(inv.hiv_ftrrmk)  as 'hiv.hiv_ftrrmk',        
ltrim( dtl.hid_cusitm) as 'dtl.hid_cusitm',

sod.sod_typcode as 'sod.sod_typcode',     
LTRIM(sod.sod_Code1) + LTRIM(sod.sod_Code2) + LTRIM(sod.sod_Code3) AS 'sod.sod_code',    
      
CASE sod.sod_dtyrat when 0 then '' else ltrim(str(sod.sod_dtyrat,10,0)) end AS 'sod.sod_dtyrat',    
CASE sod.sod_cususd when 0 then '' else ltrim(str(sod.sod_cususd,13,4)) end AS 'sod.sod_cususd',    
CASE sod.sod_cuscad when 0 then '' else ltrim(str(sod.sod_cuscad,13,4)) end AS 'sod.sod_cuscad',    
ltrim(sod.sod_dept) as 'sod.sod_dept',    

ltrim(str(dtl.hid_ctnstr)) + ltrim(str(dtl.hid_ctnend)) as 'dtl.hid_ctnstr',    
case isnull(dtl.hid_contopc,'') when 'Y' then     
  str(round(dtl.hid_pcprc/1.05,2,1))
else
  str(round(dtl.hid_selprc/1.05,2,1))
end  as 'dtl.hid_Aprc',        

vw.hid_ttlctn   as 'vw_ttlctn',        
case isnull(dtl.hid_contopc,'') when 'Y' then cast( vw.hid_shpqty*dtl.hid_conftr as int)  else vw.hid_shpqty end   as 'vw_shpqty',     
      
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

@yco_conam  as '@yco_conam',    
@yco_addr  as '@yco_addr',    
      
@yco_phoneno  as '@yco_phoneno',    
@yco_faxno  as '@yco_faxno',    
@yco_logoimgpth  as '@yco_logoimgpth',  
@yco_logoimgpth  as 'logoimgpth',  
@yco_venid   as '@yco_venid',
@optTitle  as '@optTitle',
ltrim( dtl.hid_cusitm)  as '@optSort' ,
 
@printAlias  as '@printAlias',  

case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
else
  case when @printGroup = '1' then  
case when dbo.groupnewitmcol(sca.sai_assitm,'','N') = '' then '' else '(' +  dbo.groupnewitmcol(sca.sai_assitm,'','N') + ') ' end
  else  
  ''
  end end as 'ColSeq',  
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
else
  case when @printGroup = '1' then  
case when dbo.groupnewitmcol(dtl.hid_itmno,'','N') = '' then '' else '(' +  dbo.groupnewitmcol(dtl.hid_itmno,'','N') + ') ' end
  else  
  ''  
  end end as 'ItmColSeq'  ,
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm + ' (' + dtl.hid_itmno +  ')'
else
 case when @printGroup = '1' then  

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
sod_seccusitm as 'sod_seccusitm',
tmp_table.tmp_cmp	 as 'dtl.hid_cmprmk',
hiv_lcno as 'hiv_lcno',
hiv_lcbank  as 'hiv_lcbank',
CONVERT(VARCHAR(10),inv.hiv_lcdat,12)   as'hiv_lcdat'         


  	
From  SHIPGHDR hdr    
left join CUBASINF cus on hdr.hih_cus1no = cus.cbi_cusno    
left join SYSETINF cty on hdr.hih_bilcty = cty.ysi_cde and cty.ysi_typ = '02'    
,SHINVHDR inv     
left join SHIPGDTL dtl on inv.hiv_cocde = @cocde and inv.hiv_shpno = dtl.hid_shpno and inv.hiv_invno = dtl.hid_invno    
left join [#temp_table_sum_byinv]
	on [#temp_table_sum_byinv].tmp_invno = inv.hiv_invno
left join shpckdim pdm on 
	 pdm.hpd_shpno = hid_shpno and pdm.hpd_shpseq = hid_shpseq
		and pdm.hpd_dimtyp = 'Mod'
		and (
			(dtl.hid_ctnftr = 1 and ( pdm.hpd_pdnum = 5 or pdm.hpd_pdnum = 6 )) 
			or (dtl.hid_ctnftr = 2 and ( pdm.hpd_pdnum = 1 or pdm.hpd_pdnum = 2 or pdm.hpd_pdnum = 3 or pdm.hpd_pdnum = 4 ))   
			)
left join #temp_cmp tmp_table on
	tmp_table.tmp_shpno =  dtl.hid_shpno
	and tmp_table.tmp_shpseq = dtl.hid_shpseq

left join SHPCUSSTY ca on dtl.hid_itmno  = ca.ica_itmno  and ca.ica_apvsts = 'Y' and ca.sod_ordno = dtl.hid_ordno 
left join SHSHPMRK shm on shm.hsm_cocde = @cocde and shm.hsm_invno = inv.hiv_invno and shm.hsm_shptyp = 'M'     
left join SYSETINF prc on inv.hiv_prctrm = prc.ysi_cde and prc.ysi_typ = '03'    
left join SYSETINF pay on inv.hiv_paytrm = pay.ysi_cde and pay.ysi_typ = '04'    
left join SYSETINF cde on inv.hiv_cocde = @cocde and    
     case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case when isnull(dtl.hid_contopc,'') = 'Y' then 'PC' else dtl.hid_untcde end end = cde.ysi_cde and     
     cde.ysi_typ = '05'         
left join SCORDHDR soh on soh.soh_cocde = @cocde and soh.soh_ordno = dtl.hid_ordno     
left join SCORDDTL sod on  sod.sod_cocde = @cocde and sod.sod_ordno = dtl.hid_ordno and sod.sod_ordseq = dtl.hid_ordseq    
left join  v_select_inr00001_wNewItmNo vw on  vw.hid_cocde =@cocde and   --  
	vw.grp = @printgroup and   
	vw.hid_invno = inv.hiv_invno  and     
      	dtl.hid_cuspo = vw.hid_cuspo and    
      	dtl.hid_ordno = vw.hid_ordno and     
      	dtl.hid_mannam = vw.hid_mannam and     
	case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
else
case when @printGroup = '1' then  
dbo.groupnewitmno(dtl.hid_itmno)
  else  
  ltrim(rtrim(dtl.hid_itmno))  
  end end = vw.hid_itmno and   

      dtl.hid_itmdsc = vw.hid_itmdsc and      
      dtl.hid_inrctn = vw.hid_inrctn and     
      dtl.hid_mtrctn = vw.hid_mtrctn    
      and dtl.hid_selprc = round(vw.hid_selprc,6,1)      
	     and cde.ysi_dsc = vw.ysi_dsc
      and     
      ltrim(str(pdm.hpd_gw_kg,10,2)) = vw.hid_grswgt and     
      ltrim(str(pdm.hpd_nw_kg,10,2)) = vw.hid_netwgt and      
      ltrim(str(pdm.hpd_l_cm,10,2)) + ' X ' + ltrim(str(pdm.hpd_w_cm,10,2)) + ' X ' + ltrim(str(pdm.hpd_h_cm,10,2)) = vw.MEAS   and  
      vw.hid_invno between @from and @to        
     
left join POORDDTL on  pod_cocde = @cocde and     
     pod_purord =  dtl.hid_purord and     
     pod_purseq = dtl.hid_purseq    

left join SCASSINF sca on  sca.sai_cocde =@cocde  and     
     sca.sai_ordno = dtl.hid_ordno and     
     sca.sai_ordseq = dtl.hid_ordseq     
left join  SYSETINF saa on 
     sca.sai_untcde = saa.ysi_cde and     
     saa.ysi_typ = '05'    

WHERE      
hdr.hih_shpsts <> 'HLD'    
and  hdr.hih_cocde = @cocde    
and hdr.hih_shpno = dtl.hid_shpno    
and  inv.hiv_invno >= @from and inv.hiv_invno <= @to    
order by hdr.hih_shpno,dtl.hid_shpseq



end  
else  
begin  
------------------------------------------------------------------------------------------------------------------------------------------------------    
----*** MAKE SURE UPPER PART AND LOWER PART SHOULD IDENTICAL WHEN MODIFY THIS SP  *** ----  
------------------------------------------------------------------------------------------------------------------------------------------------------    
  -- Lower Part --  
------------------------------------------------------------------------------------------------------------------------------------------------------    
------------------------------------------------------------------------------------------------------------------------------------------------------     

--make temp_sumamt
insert into #temp_table_sum
select  DISTINCT   dtl.hid_ordno + dtl.hid_cusstyno  as 'dtl.hid_ordno',
Case case when hiv_aformat = '2' then 'C' else case when hiv_aformat = '1' then 'A' else 'C' end end    
when 'A' then  vw.sumamtd else vw.sumamt end as vw_sumamt    ,
hiv_invno  as 'hiv_invno'
From  SHIPGHDR hdr    
left join CUBASINF cus on hdr.hih_cus1no = cus.cbi_cusno    
left join SYSETINF cty on hdr.hih_bilcty = cty.ysi_cde and cty.ysi_typ = '02'    
,SHINVHDR inv     
left join SHIPGDTL dtl on inv.hiv_cocde = @cocde and inv.hiv_shpno = dtl.hid_shpno and inv.hiv_invno = dtl.hid_invno    
left join shpckdim pdm on 
	 pdm.hpd_shpno = hid_shpno and pdm.hpd_shpseq = hid_shpseq
		and pdm.hpd_dimtyp = 'Mod'
		and (
			(dtl.hid_ctnftr = 1 and ( pdm.hpd_pdnum = 5 or pdm.hpd_pdnum = 6 )) 
			or (dtl.hid_ctnftr = 2 and ( pdm.hpd_pdnum = 1 or pdm.hpd_pdnum = 2 or pdm.hpd_pdnum = 3 or pdm.hpd_pdnum = 4 ))   
			)
left join SHPCUSSTY ca on dtl.hid_itmno  = ca.ica_itmno  and ca.ica_apvsts = 'Y' and ca.sod_ordno = dtl.hid_ordno 
left join SHSHPMRK shm on shm.hsm_cocde = @cocde and shm.hsm_invno = inv.hiv_invno and shm.hsm_shptyp = 'M'     
left join SYSETINF prc on inv.hiv_prctrm = prc.ysi_cde and prc.ysi_typ = '03'    
left join SYSETINF pay on inv.hiv_paytrm = pay.ysi_cde and pay.ysi_typ = '04'    
left join SCORDHDR soh on soh.soh_cocde = @cocde and soh.soh_ordno = dtl.hid_ordno     
left join SCORDDTL sod on  sod.sod_cocde = @cocde and sod.sod_ordno = dtl.hid_ordno and sod.sod_ordseq = dtl.hid_ordseq    
left join SYSETINF cde on inv.hiv_cocde = @cocde and
     case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case when isnull(dtl.hid_contopc,'')  = 'Y' then 'PC' else dtl.hid_untcde end end = cde.ysi_cde and     
     cde.ysi_typ = '05'  
left join v_select_inr00001_cusitm_wNewItmNo vw on  
	vw.hid_cocde =@cocde and  
	vw.grp = @printgroup and  
	vw.hid_invno = inv.hiv_invno  and     
	dtl.hid_cuspo = vw.hid_cuspo and    
	dtl.hid_ordno = vw.hid_ordno and     
	dtl.hid_mannam = vw.hid_mannam and     
	case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
	else
	case when @printGroup = '1' then  
dbo.groupnewitmno(dtl.hid_itmno)
  else  
  ltrim(rtrim(dtl.hid_itmno))  
  end end = vw.hid_itmno and   
      dtl.hid_itmdsc = vw.hid_itmdsc and      
      dtl.hid_inrctn = vw.hid_inrctn and     
      dtl.hid_mtrctn = vw.hid_mtrctn    
      and dtl.hid_selprc = round(vw.hid_selprc,6,1)      
     and cde.ysi_dsc = vw.ysi_dsc
      and     
      ltrim(str(pdm.hpd_gw_kg,10,2)) = vw.hid_grswgt and     
      ltrim(str(pdm.hpd_nw_kg,10,2)) = vw.hid_netwgt and      
      ltrim(str(pdm.hpd_l_cm,10,2)) + ' X ' + ltrim(str(pdm.hpd_w_cm,10,2)) + ' X ' + ltrim(str(pdm.hpd_h_cm,10,2)) = vw.MEAS and  
      ltrim( dtl.hid_cusitm) = vw.hid_cusitm and  
      vw.hid_invno between @from and @to        
  
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

--select * from #temp_table_sum

insert into #temp_table_sum_byinv
select sum(tmp_sum),tmp_invno
from #temp_table_sum
group by tmp_invno

insert into #temp_table_sum_distinct
select distinct tmp_ordno,tmp_sum from #temp_table_sum

--SET @temp_sumamt = 
--(select sum(tmp_sum) 
--from #temp_table_sum
--group by
--tmp_ordno
--)

SET @temp_sumamt_distinct = 
(select sum( tmp_sum) 
from #temp_table_sum_distinct
--group by
--tmp_ordno
)


Select     
[#temp_table_sum_byinv].tmp_sum  as 'temp_sum',
--@temp_sumamt_distinct AS 'temp_sum_distinct',
1 AS 'temp_sum_distinct',
@opt1  as 'opt1',        
@opt2  as 'opt2',        
@opt3  as 'opt3',        
@opt4  as 'opt4',        
@opt5  as 'opt5',        
@opt6  as 'opt6',        
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
     
ltrim(dtl.hid_pckrmk)  as 'dtl.hid_pckrmk',    
dtl.hid_ctrcfs  as 'dtl.hid_ctrcfs',  
     
ltrim(dtl.hid_cuspo) as 'dtl.hid_cuspo',        
soh.soh_cpodat  as 'poh.poh_issdat',        

dtl.hid_ordno  as 'dtl.hid_ordno',
soh.soh_issdat  as 'soh.soh_issdat',

ltrim(dtl.hid_itmshm)  as 'dtl.hid_itmshm',        
ltrim(dtl.hid_mannam)  as 'dtl.hid_mannam',        
ltrim(dtl.hid_manadr)  as 'dtl.hid_manadr',        

case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm 
else
 case when @printGroup = '1' then  
dbo.groupnewitmno(dtl.hid_itmno)

  else  
  ltrim(rtrim(dtl.hid_itmno))  
  end end as 'dtl.hid_itmno',  
  case when @printAlias = '0' then '' else isnull(hid_alsitmno,'') end as 'dtl.hid_alsitmno',  
  ltrim(rtrim(dtl.hid_itmdsc)) as 'dtl.hid_itmdsc',      
     
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
    
ltrim(str(dtl.hid_grswgt,10,2)) + ' KG'  as 'dtl.hid_grswgt',        
ltrim(str(dtl.hid_netwgt,10,2)) + ' KG'  as 'dtl.hid_netwgt',        

ltrim(str(dtl.hid_mtrdcm,10,2)) + ' X ' + ltrim(str( dtl.hid_mtrwcm,10,2)) + ' X ' + ltrim(str(dtl.hid_mtrhcm,10,2)) + ' CM'  as 'dtl.meas',        
     
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
--ltrim(dtl.hid_cmprmk)  as 'dtl.hid_cmprmk',        
  
case when @printGroup = '1'  then  
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

case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case when isnull(dtl.hid_contopc,'')  = 'Y' then 'PC' else ltrim(cde.ysi_dsc) end end
  as 'cde.ysi_dsc',        
ltrim(dtl.hid_colcde)  as 'dtl.hid_colcde',        
  
case when @printGroup = '1' then  
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
  CASE sod.sod_dtyrat when 0 then '' else ltrim(str(sod.sod_dtyrat,10,0)) end AS 'sod.sod_dtyrat',    
  CASE sod.sod_cususd when 0 then '' else ltrim(str(sod.sod_cususd,13,4)) end AS 'sod.sod_cususd',    
  CASE sod.sod_cuscad when 0 then '' else ltrim(str(sod.sod_cuscad,13,4)) end AS 'sod.sod_cuscad',    
  ltrim(sod.sod_dept) as 'sod.sod_dept',    
  ltrim(str(dtl.hid_ctnstr)) + ltrim(str(dtl.hid_ctnend)) as 'dtl.hid_ctnstr',    
case isnull(dtl.hid_contopc,'') when 'Y' then     
  str(round(dtl.hid_pcprc/1.05,2,1))
else
  str(round(dtl.hid_selprc/1.05,2,1))
end  
as 'dtl.hid_Aprc',        
vw.hid_ttlctn   as 'vw_ttlctn',        
case isnull(dtl.hid_contopc,'') when 'Y' then cast( vw.hid_shpqty*dtl.hid_conftr as int)  else vw.hid_shpqty end   as 'vw_shpqty',     
      
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

@yco_conam  as '@yco_conam',    
@yco_addr  as '@yco_addr',    
      
@yco_phoneno  as '@yco_phoneno',    
@yco_faxno  as '@yco_faxno',    
@yco_logoimgpth  as '@yco_logoimgpth',  
@yco_logoimgpth  as 'logoimgpth',  
@yco_venid   as '@yco_venid',
@optTitle  as '@optTitle',
ltrim( dtl.hid_cusitm)  as '@optSort' ,
  
@printAlias  as '@printAlias',  

case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
else
  case when @printGroup = '1' then  
case when dbo.groupnewitmcol(sca.sai_assitm,'','N') = '' then '' else '(' +  dbo.groupnewitmcol(sca.sai_assitm,'','N') + ') ' end
  else  
  ''
  end end as 'ColSeq',  
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
else
  case when @printGroup = '1' then  
case when dbo.groupnewitmcol(dtl.hid_itmno,'','N') = '' then '' else '(' +  dbo.groupnewitmcol(dtl.hid_itmno,'','N') + ') ' end
  else  
  ''  
  end end as 'ItmColSeq'  ,
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm + ' (' + dtl.hid_itmno +  ')'
else
 case when @printGroup = '1' then  
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
sod_seccusitm as 'sod_seccusitm',
tmp_table.tmp_cmp as 'dtl.hid_cmprmk',
hiv_lcno as 'hiv_lcno',
hiv_lcbank  as 'hiv_lcbank',
CONVERT(VARCHAR(10),inv.hiv_lcdat,12)   as'hiv_lcdat'         

From  SHIPGHDR hdr    
left join CUBASINF cus on hdr.hih_cus1no = cus.cbi_cusno    
left join SYSETINF cty on hdr.hih_bilcty = cty.ysi_cde and cty.ysi_typ = '02'    
,SHINVHDR inv     
left join SHIPGDTL dtl on inv.hiv_cocde = @cocde and inv.hiv_shpno = dtl.hid_shpno and inv.hiv_invno = dtl.hid_invno    
left join [#temp_table_sum_byinv]
	on [#temp_table_sum_byinv].tmp_invno = inv.hiv_invno
left join shpckdim pdm on 
	 pdm.hpd_shpno = hid_shpno and pdm.hpd_shpseq = hid_shpseq
		and pdm.hpd_dimtyp = 'Mod'
		and (
			(dtl.hid_ctnftr = 1 and ( pdm.hpd_pdnum = 5 or pdm.hpd_pdnum = 6 )) 
			or (dtl.hid_ctnftr = 2 and ( pdm.hpd_pdnum = 1 or pdm.hpd_pdnum = 2 or pdm.hpd_pdnum = 3 or pdm.hpd_pdnum = 4 ))   
			)
left join #temp_cmp tmp_table on
	tmp_table.tmp_shpno =  dtl.hid_shpno
	and tmp_table.tmp_shpseq = dtl.hid_shpseq

left join SHPCUSSTY ca on dtl.hid_itmno  = ca.ica_itmno  and ca.ica_apvsts = 'Y' and ca.sod_ordno = dtl.hid_ordno 
left join SHSHPMRK shm on shm.hsm_cocde = @cocde and shm.hsm_invno = inv.hiv_invno and shm.hsm_shptyp = 'M'     
left join SYSETINF prc on inv.hiv_prctrm = prc.ysi_cde and prc.ysi_typ = '03'    
left join SYSETINF pay on inv.hiv_paytrm = pay.ysi_cde and pay.ysi_typ = '04'    
left join SCORDHDR soh on soh.soh_cocde = @cocde and soh.soh_ordno = dtl.hid_ordno     
left join SCORDDTL sod on  sod.sod_cocde = @cocde and sod.sod_ordno = dtl.hid_ordno and sod.sod_ordseq = dtl.hid_ordseq    
left join SYSETINF cde on inv.hiv_cocde = @cocde and
     case when isnull(dtl.hid_custum,'') <> '' then dtl.hid_custum else case when isnull(dtl.hid_contopc,'')  = 'Y' then 'PC' else dtl.hid_untcde end end = cde.ysi_cde and     
     cde.ysi_typ = '05'  
left join v_select_inr00001_cusitm_wNewItmNo vw on  vw.hid_cocde =@cocde and  
	vw.grp = @printgroup and  
	vw.hid_invno = inv.hiv_invno  and     
	dtl.hid_cuspo = vw.hid_cuspo and    
	dtl.hid_ordno = vw.hid_ordno and     
	dtl.hid_mannam = vw.hid_mannam and     
case when isnull(ca.ica_itmno,'') <> '' then ca.ica_cusalsitm
else
case when @printGroup = '1' then  

dbo.groupnewitmno(dtl.hid_itmno)
  else  
  ltrim(rtrim(dtl.hid_itmno))  
  end end = vw.hid_itmno and   
      dtl.hid_itmdsc = vw.hid_itmdsc and      
      dtl.hid_inrctn = vw.hid_inrctn and     
      dtl.hid_mtrctn = vw.hid_mtrctn    
      and dtl.hid_selprc = round(vw.hid_selprc,6,1)      
	     and cde.ysi_dsc = vw.ysi_dsc
      and     
      ltrim(str(pdm.hpd_gw_kg,10,2)) = vw.hid_grswgt and     
      ltrim(str(pdm.hpd_nw_kg,10,2)) = vw.hid_netwgt and      
      ltrim(str(pdm.hpd_l_cm,10,2)) + ' X ' + ltrim(str( pdm.hpd_w_cm,10,2)) + ' X ' + ltrim(str(pdm.hpd_h_cm,10,2)) = vw.MEAS and  
      ltrim( dtl.hid_cusitm) = vw.hid_cusitm and  
      vw.hid_invno between @from and @to        
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
order by hdr.hih_shpno,dtl.hid_shpseq

end  
    
end

































GO
GRANT EXECUTE ON [dbo].[sp_select_INR00001A_NET] TO [ERPUSER] AS [dbo]
GO
