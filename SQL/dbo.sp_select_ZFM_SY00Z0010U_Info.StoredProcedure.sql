/****** Object:  StoredProcedure [dbo].[sp_select_ZFM_SY00Z0010U_Info]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_ZFM_SY00Z0010U_Info]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_ZFM_SY00Z0010U_Info]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE   procedure [dbo].[sp_select_ZFM_SY00Z0010U_Info]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

@cocde nvarchar(6) 
             

---------------------------------------------- 
 
AS


begin
/*
Remind
AKONT hardcode '1131010000' as 'AKONT'

*/

select
--PRIMARY CUSTOMER
 cbi_cusno as 'KUNNR', --MANDATORY
 '1010' as 'BUKRS', --MANDATORY
'1010' as 'VKORG', --MANDATORY
'10' as 'VTWEG', --MANDATORY
 '00' as 'SPART', --MANDATORY
 '0001' as 'KTOKD', --MANDATORY
'' AS 'TITLE',
left(cbi_cusnam,35) as 'NAME1', --MANDATORY
case when len(cbi_cusnam) > 35 then right (cbi_cusnam,  len(cbi_cusnam)-35) else '' end  as 'NAME2', 
'' as 'NAME3',
'' as 'NAME4',
cbi_cusno as 'SORT1',
cbi_cussna AS 'SORT2',
'BLOCK C, 6/F., ELDEX INDUSTRIAL BUILDING, 21 MA TAU WAI ROAD' as 'STREET', 
'HUNG HOM' AS 'STR_SUPPL3',
'KOWLOON' AS 'LOCATION',
'' AS 'CITY2',
''  as 'POST_CODE1',
'HONG KONG' as 'CITY1',
cci_cntcty as 'COUNTRY', 
''  as 'REGION',
''  AS 'TAXJURCODE',
 'E' as 'LANGU', 
'' as 'TEL_NUMBER', '' AS 'TEL_EXTENS',
'' AS 'MOB_NUMBER',
'' as 'FAX_NUMBER', '' as 'FAX_EXTENS',
'' as 'SMTP_ADDR',
'1131010000' as 'AKONT', -- cci_sapreconacc AS 'AKONT',
'' AS 'ZTERM',
case cbi_mrkreg
    when 'ASIA PACIFIC' then '001'
    when ' CENTRAL AMERIC' then '002'
     when 'CENTRAL EUROPE' then '003'
     when 'EASTERN EUROPE' then '004'
    when 'NORTH AMERICA' then '005'
      when 'NORTHERN EUROP' then '006'
     when 'OTHER REGIONS' then '007'
     when ' SOUTH AMERICA' then '008'
     when 'WESTERN EUROPE' then '009'
     else '010'
end AS 'BZIRK',

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '001'   
 	 	when 'C' then '001'   	
		when 'D' then '002' 
		when 'E' then '002' 
		when 'F' then '002' 
		when 'G' then '002' 
		when 'H' then '002' 
		when 'I' then '003'
		when 'J' then '003' 
		when 'K' then '003' 
		when 'L' then '001' 
		when 'M' then '001' 
		when 'N' then '003' 
		when 'S' then '001'  -- Which Code should be assigned for Team S
		else ''
end as 'VKBUR', 

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '002'   
 	 	when 'C' then '003'   	
		when 'D' then '004' 
		when 'E' then '005' 
		when 'F' then '006' 
		when 'G' then '007' 
		when 'H' then '008' 
		when 'I' then '009'
		when 'J' then '010' 
		when 'K' then '011' 
		when 'L' then '012' 
		when 'M' then '013' 
		when 'N' then '014' 
		when 'S' then '015' 
		else ''
end as 'VKGRP' ,

case upper(t.ysi_cde) 	when  'CCH' then '01'   
	  	when 'CGR' then '02'   
 	 	when 'DIS' then '03'   	
		when 'DPT' then '04' 
		when 'IMP' then '05' 
		when 'MAL' then '06' 
		when 'MMD' then '07' 
		when 'OTH' then '08' 
		when 'RET' then '09'
		when 'TRD' then '10' 
		when 'WHL' then '11' 
		else ''
 end  as 'KDGRP',
case  when cpi_curcde = '' then '' else cpi_curcde end  as 'WAERS',
'01' AS 'VSBED',
case when cpi_prctrm = '' then '' else substring(cpi_prctrm,1,3) end as 'INCO1',
case when cpi_prctrm = '' then '' else 
 case substring(cpi_prctrm,5,2) 
when  'HK' then 'HONG KONG'  
when  'YT' then 'YANTIAN'  
when  'ZH' then 'ZHONGSHAN'  
when  'JX' then ' JIANG XI'
else substring(cpi_prctrm,5,2) 
end
end as 'INCO2',
isnull(ypm_sappayterm,'') as 'ZTERM_S',
'Z1' AS 'KTGRD',
'3' as 'ACTFLG',
'4' as 'ORDER'

from cubasinf 
left join sysalrep on cbi_salrep = ysr_code1
left join sysetinf t on cbi_mrktyp = t.ysi_cde and t.ysi_typ = '08'
--left join sysetinf p on cbi_mrktyp = p.ysi_cde and p.ysi_typ = '04'
--left join sypaytermmap on ypm_erppayterm = p.ysi_cde
left join cuprcinf on cpi_cusno = cbi_cusno
left join cucntinf on cci_cusno = cbi_cusno and cci_cnttyp = 'M' and cci_cntseq = '1'
left join sysetinf p on cpi_paytrm = p.ysi_cde and p.ysi_typ = '04'
left join sypaytermmap on ypm_erppayterm = p.ysi_cde
where cbi_cusno in 
(select distinct cbi_cusno from ucperpdb_aud..cubasinf_aud 
--where  --(year(cbi_credat) = year(getdate()) and month(cbi_credat) = month(getdate()) and day(cbi_credat) = day(getdate()) )  
--CONVERT(NVARCHAR(10),cbi_credat,111) = CONVERT(NVARCHAR(10),getdate() ,111) 
where cbi_credat > '2014-02-01'
and cbi_actflg_aud = '3' and cbi_cusno like '5%'
)

union 


--SECONDARY CUSTOMERS
select
cbi_cusno as 'KUNNR',
 '1010' as 'BUKRS',
'1010' as 'VKORG',
'10' as 'VTWEG',
 '00' as 'SPART',
 'Z1' as 'KTOKD',
'' AS 'TITLE',
left(cbi_cusnam,35) as 'NAME1', 
case when len(cbi_cusnam) > 35 then right (cbi_cusnam,  len(cbi_cusnam)-35) else '' end  as 'NAME2', 
'' AS ' NAME3',
'' AS 'NAME4',
cbi_cusno as 'SORT1',
cbi_cussna AS 'SORT2',
'BLOCK C, 6/F., ELDEX INDUSTRIAL BUILDING, 21 MA TAU WAI ROAD' as 'STREET', 
'HUNG HOM' AS 'STR_SUPPL3',
'KOWLOON' AS 'LOCATION',
'' AS 'CITY2',
''  as 'POST_CODE1',
'HONG KONG' as 'CITY1',
cci_cntcty as 'COUNTRY', 
''  as 'REGION',
''  AS 'TAXJURCODE',
 'E' as 'LANGU', 
'' as 'TEL_NUMBER', '' AS 'TEL_EXTENS',
'' AS 'MOB_NUMBER',
'' as 'FAX_NUMBER', '' as 'FAX_EXTENS',
'' as 'SMTP_ADDR',
'1131010000' as 'AKONT', -- cci_sapreconacc AS 'AKONT',
'' AS 'ZTERM',
case cbi_mrkreg
    when 'ASIA PACIFIC' then '001'
    when ' CENTRAL AMERIC' then '002'
     when 'CENTRAL EUROPE' then '003'
     when 'EASTERN EUROPE' then '004'
    when 'NORTH AMERICA' then '005'
      when 'NORTHERN EUROP' then '006'
     when 'OTHER REGIONS' then '007'
     when ' SOUTH AMERICA' then '008'
     when 'WESTERN EUROPE' then '009'
     else '010'
end AS 'BZIRK',

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '001'   
 	 	when 'C' then '001'   	
		when 'D' then '002' 
		when 'E' then '002' 
		when 'F' then '002' 
		when 'G' then '002' 
		when 'H' then '002' 
		when 'I' then '003'
		when 'J' then '003' 
		when 'K' then '003' 
		when 'L' then '001' 
		when 'M' then '001' 
		when 'N' then '003' 
		when 'S' then '001' 
		else ''
end as 'VKBUR', 

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '002'   
 	 	when 'C' then '003'   	
		when 'D' then '004' 
		when 'E' then '005' 
		when 'F' then '006' 
		when 'G' then '007' 
		when 'H' then '008' 
		when 'I' then '009'
		when 'J' then '010' 
		when 'K' then '011' 
		when 'L' then '012' 
		when 'M' then '013' 
		when 'N' then '014' 
		when 'S' then '015' 
		else ''
end as 'VKGRP' ,

case upper(t.ysi_cde) 	when  'CCH' then '01'   
	  	when 'CGR' then '02'   
 	 	when 'DIS' then '03'   	
		when 'DPT' then '04' 
		when 'IMP' then '05' 
		when 'MAL' then '06' 
		when 'MMD' then '07' 
		when 'OTH' then '08' 
		when 'RET' then '09'
		when 'TRD' then '10' 
		when 'WHL' then '11' 
		else ''
 end  as 'KDGRP',
case  when cpi_curcde = '' then '' else cpi_curcde end  as 'WAERS',
'01' AS 'VSBED',
case when cpi_prctrm = '' then '' else substring(cpi_prctrm,1,3) end as 'INCO1',
case when cpi_prctrm = '' then '' else 
 case substring(cpi_prctrm,5,2) 
when  'HK' then 'HONG KONG'  
when  'YT' then 'YANTIAN'  
when  'ZH' then 'ZHONGSHAN'  
when  'JX' then ' JIANG XI'
else substring(cpi_prctrm,5,2) 
end
end as 'INCO2',
isnull(ypm_sappayterm,'') as 'ZTERM_S',
'Z1' AS 'KTGRD',
'3' as 'ACTFLG',
'3' as 'ORDER'

 from cubasinf 
left join sysalrep on cbi_salrep = ysr_code1
left join sysetinf t on cbi_mrktyp =t.ysi_cde and t.ysi_typ = '08'
--left join sysetinf p on cbi_mrktyp =p.ysi_cde and p.ysi_typ = '04'
--left join sypaytermmap on ypm_erppayterm = p.ysi_cde
left join cuprcinf on cpi_cusno = cbi_cusno
left join cucntinf on cci_cusno = cbi_cusno and cci_cnttyp = 'M' and cci_cntseq = '1'
left join sysetinf p on cpi_paytrm = p.ysi_cde and p.ysi_typ = '04'
left join sypaytermmap on ypm_erppayterm = p.ysi_cde
where cbi_cusno in 
(select distinct cbi_cusno from ucperpdb_aud..cubasinf_aud 
--where  (
----year(cbi_credat) = year(getdate()) and month(cbi_credat) = month(getdate()) and day(cbi_credat) = day(getdate()) 
--CONVERT(NVARCHAR(10),cbi_credat,111) = CONVERT(NVARCHAR(10),getdate() ,111) 
--)
where cbi_credat > '2014-02-01'
and cbi_actflg_aud = '3' and cbi_cusno like '6%'
)


union 

select
--GOODS RECIPIENT FOR PRIMARY CUSTOMER
cci_sapshcusno as 'KUNNR',
 '1010' as 'BUKRS',
'1010' as 'VKORG',
'10' as 'VTWEG',
 '00' as 'SPART',
 '0002' as 'KTOKD',
'' AS 'TITLE',
left(cbi_cusnam,35) as 'NAME1', 
case when len(cbi_cusnam) > 35 then right (cbi_cusnam,  len(cbi_cusnam)-35) else '' end  as 'NAME2', 
'' AS 'NAME3',
'' AS 'NAME4',
cbi_cusno as 'SORT1',
cbi_cussna AS 'SORT2',
'BLOCK C, 6/F., ELDEX INDUSTRIAL BUILDING, 21 MA TAU WAI ROAD' as 'STREET', 
'HUNG HOM' AS 'STR_SUPPL3',
'KOWLOON' AS 'LOCATION',
'' AS 'CITY2',
''  as 'POST_CODE1',
'HONG KONG' as 'CITY1',
cci_cntcty as 'COUNTRY', 
''  as 'REGION',
''  AS 'TAXJURCODE',
 'E' as 'LANGU', 
'' as 'TEL_NUMBER', '' AS 'TEL_EXTENS',
'' AS 'MOB_NUMBER',
'' as 'FAX_NUMBER', '' as 'FAX_EXTENS',
'' as 'SMTP_ADDR',
'1131010000' as 'AKONT', -- cci_sapreconacc AS 'AKONT',
'' AS 'ZTERM',
case cbi_mrkreg
    when 'ASIA PACIFIC' then '001'
    when ' CENTRAL AMERIC' then '002'
     when 'CENTRAL EUROPE' then '003'
     when 'EASTERN EUROPE' then '004'
    when 'NORTH AMERICA' then '005'
      when 'NORTHERN EUROP' then '006'
     when 'OTHER REGIONS' then '007'
     when ' SOUTH AMERICA' then '008'
     when 'WESTERN EUROPE' then '009'
     else '010'
end AS 'BZIRK',

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '001'   
 	 	when 'C' then '001'   	
		when 'D' then '002' 
		when 'E' then '002' 
		when 'F' then '002' 
		when 'G' then '002' 
		when 'H' then '002' 
		when 'I' then '003'
		when 'J' then '003' 
		when 'K' then '003' 
		when 'L' then '001' 
		when 'M' then '001' 
		when 'N' then '003' 
		when 'S' then '001' 
		else ''
end as 'VKBUR', 

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '002'   
 	 	when 'C' then '003'   	
		when 'D' then '004' 
		when 'E' then '005' 
		when 'F' then '006' 
		when 'G' then '007' 
		when 'H' then '008' 
		when 'I' then '009'
		when 'J' then '010' 
		when 'K' then '011' 
		when 'L' then '012' 
		when 'M' then '013' 
		when 'N' then '014' 
		when 'S' then '015' 
		else ''
end as 'VKGRP' ,

case upper(t.ysi_cde) 	when  'CCH' then '01'   
	  	when 'CGR' then '02'   
 	 	when 'DIS' then '03'   	
		when 'DPT' then '04' 
		when 'IMP' then '05' 
		when 'MAL' then '06' 
		when 'MMD' then '07' 
		when 'OTH' then '08' 
		when 'RET' then '09'
		when 'TRD' then '10' 
		when 'WHL' then '11' 
		else ''
 end  as 'KDGRP',
case  when cpi_curcde = '' then '' else cpi_curcde end  as 'WAERS',
'01' AS 'VSBED',
case when cpi_prctrm = '' then '' else substring(cpi_prctrm,1,3) end as 'INCO1',
case when cpi_prctrm = '' then '' else 
 case substring(cpi_prctrm,5,2) 
when  'HK' then 'HONG KONG'  
when  'YT' then 'YANTIAN'  
when  'ZH' then 'ZHONGSHAN'  
when  'JX' then ' JIANG XI'
else substring(cpi_prctrm,5,2) 
end
end as 'INCO2',
isnull(ypm_sappayterm,'') as 'ZTERM_S',
'Z1' AS 'KTGRD',
'3' as 'ACTFLG',
'1' as 'ORDER'

 from cubasinf 
left join sysalrep on cbi_salrep = ysr_code1
left join sysetinf t on cbi_mrktyp = t.ysi_cde and t.ysi_typ = '08'
--left join sysetinf p on cbi_mrktyp = p.ysi_cde and p.ysi_typ = '04'
--left join sypaytermmap on ypm_erppayterm = p.ysi_cde
left join cuprcinf on cpi_cusno = cbi_cusno
left join cucntinf on cci_cusno = cbi_cusno
left join sysetinf p on cpi_paytrm = p.ysi_cde and p.ysi_typ = '04'
left join sypaytermmap on ypm_erppayterm = p.ysi_cde
where cbi_cusno in 
(select distinct cci_cusno from ucperpdb_aud..cucntinf_aud 
--where  (
----year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate()) 
--CONVERT(NVARCHAR(10),cci_credat,111) = CONVERT(NVARCHAR(10),getdate() ,111) 
--)
where cbi_credat > '2014-02-01'
and cci_actflg_aud = '3' and cbi_cusno like '5%'
)  and CCI_CNTTYP in ('M','S','B') 



union 

select
--GOODS RECIPIENT FOR SECONDARY CUSTOMER
cci_sapshcusno as 'KUNNR',
 '1010' as 'BUKRS',
'1010' as 'VKORG',
'10' as 'VTWEG',
 '00' as 'SPART',
 '0002' as 'KTOKD',
'' AS 'TITLE',
left(cbi_cusnam,35) as 'NAME1', 
case when len(cbi_cusnam) > 35 then right (cbi_cusnam,  len(cbi_cusnam)-35) else '' end  as 'NAME2', 
'' AS 'NAME3',
'' AS 'NAME4',
cbi_cusno as 'SORT1',
cbi_cussna AS 'SORT2',
'BLOCK C, 6/F., ELDEX INDUSTRIAL BUILDING, 21 MA TAU WAI ROAD' as 'STREET', 
'HUNG HOM' AS 'STR_SUPPL3',
'KOWLOON' AS 'LOCATION',
'' AS 'CITY2',
''  as 'POST_CODE1',
'HONG KONG' as 'CITY1',
cci_cntcty as 'COUNTRY', 
''  as 'REGION',
''  AS 'TAXJURCODE',
 'E' as 'LANGU', 
'' as 'TEL_NUMBER', '' AS 'TEL_EXTENS',
'' AS 'MOB_NUMBER',
'' as 'FAX_NUMBER', '' as 'FAX_EXTENS',
'' as 'SMTP_ADDR',
'1131010000' as 'AKONT', -- cci_sapreconacc AS 'AKONT',
'' AS 'ZTERM',

case cbi_mrkreg
    when 'ASIA PACIFIC' then '001'
    when ' CENTRAL AMERIC' then '002'
     when 'CENTRAL EUROPE' then '003'
     when 'EASTERN EUROPE' then '004'
    when 'NORTH AMERICA' then '005'
      when 'NORTHERN EUROP' then '006'
     when 'OTHER REGIONS' then '007'
     when ' SOUTH AMERICA' then '008'
     when 'WESTERN EUROPE' then '009'
     else '010'
end AS 'BZIRK',

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '001'   
 	 	when 'C' then '001'   	
		when 'D' then '002' 
		when 'E' then '002' 
		when 'F' then '002' 
		when 'G' then '002' 
		when 'H' then '002' 
		when 'I' then '003'
		when 'J' then '003' 
		when 'K' then '003' 
		when 'L' then '001' 
		when 'M' then '001' 
		when 'N' then '003' 
		when 'S' then '001' 
		else ''
end as 'VKBUR', 

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '002'   
 	 	when 'C' then '003'   	
		when 'D' then '004' 
		when 'E' then '005' 
		when 'F' then '006' 
		when 'G' then '007' 
		when 'H' then '008' 
		when 'I' then '009'
		when 'J' then '010' 
		when 'K' then '011' 
		when 'L' then '012' 
		when 'M' then '013' 
		when 'N' then '014' 
		when 'S' then '015' 
		else ''
end as 'VKGRP' ,

case upper(t.ysi_cde) 	when  'CCH' then '01'   
	  	when 'CGR' then '02'   
 	 	when 'DIS' then '03'   	
		when 'DPT' then '04' 
		when 'IMP' then '05' 
		when 'MAL' then '06' 
		when 'MMD' then '07' 
		when 'OTH' then '08' 
		when 'RET' then '09'
		when 'TRD' then '10' 
		when 'WHL' then '11' 
		else ''
 end  as 'KDGRP',
case  when cpi_curcde = '' then '' else cpi_curcde end  as 'WAERS',
'01' AS 'VSBED',
case when cpi_prctrm = '' then '' else substring(cpi_prctrm,1,3) end as 'INCO1',
case when cpi_prctrm = '' then '' else 
 case substring(cpi_prctrm,5,2) 
when  'HK' then 'HONG KONG'  
when  'YT' then 'YANTIAN'  
when  'ZH' then 'ZHONGSHAN'  
when  'JX' then ' JIANG XI'
else substring(cpi_prctrm,5,2) 
end
end as 'INCO2',
isnull(ypm_sappayterm,'') as 'ZTERM_S',
'Z1' AS 'KTGRD',
'3' as 'ACTFLG',
'2' as 'ORDER'

 from cubasinf 
left join sysalrep on cbi_salrep = ysr_code1
left join sysetinf t on cbi_mrktyp = t.ysi_cde and t.ysi_typ = '08'
--left join sysetinf p on cbi_mrktyp = p.ysi_cde and p.ysi_typ = '04'
--left join sypaytermmap on ypm_erppayterm = p.ysi_cde
left join cuprcinf on cpi_cusno = cbi_cusno
left join cucntinf on cci_cusno = cbi_cusno
left join sysetinf p on cpi_paytrm = p.ysi_cde and p.ysi_typ = '04'
left join sypaytermmap on ypm_erppayterm = p.ysi_cde
where cbi_cusno in 
(select distinct cci_cusno from ucperpdb_aud..cucntinf_aud 
--where  (
-----year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate()) 
--CONVERT(NVARCHAR(10),cci_credat,111) = CONVERT(NVARCHAR(10),getdate() ,111)
--)
where cci_credat > '2014-02-01'
and cci_actflg_aud = '3' and cbi_cusno like '6%'
)  and CCI_CNTTYP in ('M','S','B') 

union

--NEW INSERT
select
--PRIMARY CUSTOMER
 cbi_cusno as 'KUNNR', --MANDATORY
 '1010' as 'BUKRS', --MANDATORY
'1010' as 'VKORG', --MANDATORY
'10' as 'VTWEG', --MANDATORY
 '00' as 'SPART', --MANDATORY
 '0001' as 'KTOKD', --MANDATORY
'' AS 'TITLE',
left(cbi_cusnam,35) as 'NAME1', --MANDATORY
case when len(cbi_cusnam) > 35 then right (cbi_cusnam,  len(cbi_cusnam)-35) else '' end  as 'NAME2', 
'' as 'NAME3',
'' as 'NAME4',
cbi_cusno as 'SORT1',
cbi_cussna AS 'SORT2',
'BLOCK C, 6/F., ELDEX INDUSTRIAL BUILDING, 21 MA TAU WAI ROAD' as 'STREET', 
'HUNG HOM' AS 'STR_SUPPL3',
'KOWLOON' AS 'LOCATION',
'' AS 'CITY2',
''  as 'POST_CODE1',
'HONG KONG' as 'CITY1',
cci_cntcty as 'COUNTRY', 
''  as 'REGION',
''  AS 'TAXJURCODE',
 'E' as 'LANGU', 
'' as 'TEL_NUMBER', '' AS 'TEL_EXTENS',
'' AS 'MOB_NUMBER',
'' as 'FAX_NUMBER', '' as 'FAX_EXTENS',
'' as 'SMTP_ADDR',
'1131010000' as 'AKONT', -- cci_sapreconacc AS 'AKONT',
'' AS 'ZTERM',
case cbi_mrkreg
    when 'ASIA PACIFIC' then '001'
    when ' CENTRAL AMERIC' then '002'
     when 'CENTRAL EUROPE' then '003'
     when 'EASTERN EUROPE' then '004'
    when 'NORTH AMERICA' then '005'
      when 'NORTHERN EUROP' then '006'
     when 'OTHER REGIONS' then '007'
     when ' SOUTH AMERICA' then '008'
     when 'WESTERN EUROPE' then '009'
     else '010'
end AS 'BZIRK',

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '001'   
 	 	when 'C' then '001'   	
		when 'D' then '002' 
		when 'E' then '002' 
		when 'F' then '002' 
		when 'G' then '002' 
		when 'H' then '002' 
		when 'I' then '003'
		when 'J' then '003' 
		when 'K' then '003' 
		when 'L' then '001' 
		when 'M' then '001' 
		when 'N' then '003' 
		when 'S' then '001'  -- Which Code should be assigned for Team S
		else ''
end as 'VKBUR', 

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '002'   
 	 	when 'C' then '003'   	
		when 'D' then '004' 
		when 'E' then '005' 
		when 'F' then '006' 
		when 'G' then '007' 
		when 'H' then '008' 
		when 'I' then '009'
		when 'J' then '010' 
		when 'K' then '011' 
		when 'L' then '012' 
		when 'M' then '013' 
		when 'N' then '014' 
		when 'S' then '015' 
		else ''
end as 'VKGRP' ,

case upper(t.ysi_cde) 	when  'CCH' then '01'   
	  	when 'CGR' then '02'   
 	 	when 'DIS' then '03'   	
		when 'DPT' then '04' 
		when 'IMP' then '05' 
		when 'MAL' then '06' 
		when 'MMD' then '07' 
		when 'OTH' then '08' 
		when 'RET' then '09'
		when 'TRD' then '10' 
		when 'WHL' then '11' 
		else ''
 end  as 'KDGRP',
case  when cpi_curcde = '' then '' else cpi_curcde end  as 'WAERS',
'01' AS 'VSBED',
case when cpi_prctrm = '' then '' else substring(cpi_prctrm,1,3) end as 'INCO1',
case when cpi_prctrm = '' then '' else 
 case substring(cpi_prctrm,5,2) 
when  'HK' then 'HONG KONG'  
when  'YT' then 'YANTIAN'  
when  'ZH' then 'ZHONGSHAN'  
when  'JX' then ' JIANG XI'
else substring(cpi_prctrm,5,2) 
end
end as 'INCO2',
isnull(ypm_sappayterm,'') as 'ZTERM_S',
'Z1' AS 'KTGRD',
'1' as 'ACTFLG',
'4' as 'ORDER'

from cubasinf 
left join sysalrep on cbi_salrep = ysr_code1
left join sysetinf t on cbi_mrktyp = t.ysi_cde and t.ysi_typ = '08'
--left join sysetinf p on cbi_mrktyp = p.ysi_cde and p.ysi_typ = '04'
--left join sypaytermmap on ypm_erppayterm = p.ysi_cde
left join cuprcinf on cpi_cusno = cbi_cusno
left join cucntinf on cci_cusno = cbi_cusno and cci_cnttyp = 'M' and cci_cntseq = '1'
left join sysetinf p on cpi_paytrm = p.ysi_cde and p.ysi_typ = '04'
left join sypaytermmap on ypm_erppayterm = p.ysi_cde
where cbi_cusno in 
(select distinct cbi_cusno from ucperpdb_aud..cubasinf_aud 
--where  
----(year(cbi_credat) = year(getdate()) and month(cbi_credat) = month(getdate()) and day(cbi_credat) = day(getdate()) )  
----and 
--
--CONVERT(NVARCHAR(10),cbi_credat,111) = CONVERT(NVARCHAR(10),getdate() ,111) AND 
----cbi_credat > '2013-08-20' and
where cbi_credat > '2014-02-01' and
cbi_actflg_aud = '1' and cbi_cusno like '5%'
)

union 


--SECONDARY CUSTOMERS
select
cbi_cusno as 'KUNNR',
 '1010' as 'BUKRS',
'1010' as 'VKORG',
'10' as 'VTWEG',
 '00' as 'SPART',
 'Z1' as 'KTOKD',
'' AS 'TITLE',
left(cbi_cusnam,35) as 'NAME1', 
case when len(cbi_cusnam) > 35 then right (cbi_cusnam,  len(cbi_cusnam)-35) else '' end  as 'NAME2', 
'' AS ' NAME3',
'' AS 'NAME4',
cbi_cusno as 'SORT1',
cbi_cussna AS 'SORT2',
'BLOCK C, 6/F., ELDEX INDUSTRIAL BUILDING, 21 MA TAU WAI ROAD' as 'STREET', 
'HUNG HOM' AS 'STR_SUPPL3',
'KOWLOON' AS 'LOCATION',
'' AS 'CITY2',
''  as 'POST_CODE1',
'HONG KONG' as 'CITY1',
cci_cntcty as 'COUNTRY', 
''  as 'REGION',
''  AS 'TAXJURCODE',
 'E' as 'LANGU', 
'' as 'TEL_NUMBER', '' AS 'TEL_EXTENS',
'' AS 'MOB_NUMBER',
'' as 'FAX_NUMBER', '' as 'FAX_EXTENS',
'' as 'SMTP_ADDR',
'1131010000' as 'AKONT', -- cci_sapreconacc AS 'AKONT',
'' AS 'ZTERM',
case cbi_mrkreg
    when 'ASIA PACIFIC' then '001'
    when ' CENTRAL AMERIC' then '002'
     when 'CENTRAL EUROPE' then '003'
     when 'EASTERN EUROPE' then '004'
    when 'NORTH AMERICA' then '005'
      when 'NORTHERN EUROP' then '006'
     when 'OTHER REGIONS' then '007'
     when ' SOUTH AMERICA' then '008'
     when 'WESTERN EUROPE' then '009'
     else '010'
end AS 'BZIRK',

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '001'   
 	 	when 'C' then '001'   	
		when 'D' then '002' 
		when 'E' then '002' 
		when 'F' then '002' 
		when 'G' then '002' 
		when 'H' then '002' 
		when 'I' then '003'
		when 'J' then '003' 
		when 'K' then '003' 
		when 'L' then '001' 
		when 'M' then '001' 
		when 'N' then '003' 
		when 'S' then '001' 
		else ''
end as 'VKBUR', 

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '002'   
 	 	when 'C' then '003'   	
		when 'D' then '004' 
		when 'E' then '005' 
		when 'F' then '006' 
		when 'G' then '007' 
		when 'H' then '008' 
		when 'I' then '009'
		when 'J' then '010' 
		when 'K' then '011' 
		when 'L' then '012' 
		when 'M' then '013' 
		when 'N' then '014' 
		when 'S' then '015' 
		else ''
end as 'VKGRP' ,

case upper(t.ysi_cde) 	when  'CCH' then '01'   
	  	when 'CGR' then '02'   
 	 	when 'DIS' then '03'   	
		when 'DPT' then '04' 
		when 'IMP' then '05' 
		when 'MAL' then '06' 
		when 'MMD' then '07' 
		when 'OTH' then '08' 
		when 'RET' then '09'
		when 'TRD' then '10' 
		when 'WHL' then '11' 
		else ''
 end  as 'KDGRP',
case  when cpi_curcde = '' then '' else cpi_curcde end  as 'WAERS',
'01' AS 'VSBED',
case when cpi_prctrm = '' then '' else substring(cpi_prctrm,1,3) end as 'INCO1',
case when cpi_prctrm = '' then '' else 
 case substring(cpi_prctrm,5,2) 
when  'HK' then 'HONG KONG'  
when  'YT' then 'YANTIAN'  
when  'ZH' then 'ZHONGSHAN'  
when  'JX' then ' JIANG XI'
else substring(cpi_prctrm,5,2) 
end
end as 'INCO2',
isnull(ypm_sappayterm,'') as 'ZTERM_S',
'Z1' AS 'KTGRD',
'1' as 'ACTFLG',
'3' as 'ORDER'

 from cubasinf 
left join sysalrep on cbi_salrep = ysr_code1
left join sysetinf t on cbi_mrktyp =t.ysi_cde and t.ysi_typ = '08'
--left join sysetinf p on cbi_mrktyp =p.ysi_cde and p.ysi_typ = '04'
--left join sypaytermmap on ypm_erppayterm = p.ysi_cde
left join cuprcinf on cpi_cusno = cbi_cusno
left join cucntinf on cci_cusno = cbi_cusno and cci_cnttyp = 'M' and cci_cntseq = '1'
left join sysetinf p on cpi_paytrm = p.ysi_cde and p.ysi_typ = '04'
left join sypaytermmap on ypm_erppayterm = p.ysi_cde
where cbi_cusno in 
(select distinct cbi_cusno from ucperpdb_aud..cubasinf_aud 
--where  
--(year(cbi_credat) = year(getdate()) and month(cbi_credat) = month(getdate()) and day(cbi_credat) = day(getdate()) )  
--and 
--CONVERT(NVARCHAR(10),cbi_credat,111) = CONVERT(NVARCHAR(10),getdate() ,111) AND 
--cbi_credat > '2013-08-20' and
where cbi_credat > '2014-02-01' and
cbi_actflg_aud = '1' and cbi_cusno like '6%'
)


union 

select
--GOODS RECIPIENT FOR PRIMARY CUSTOMER
cci_sapshcusno as 'KUNNR',
 '1010' as 'BUKRS',
'1010' as 'VKORG',
'10' as 'VTWEG',
 '00' as 'SPART',
 '0002' as 'KTOKD',
'' AS 'TITLE',
left(cbi_cusnam,35) as 'NAME1', 
case when len(cbi_cusnam) > 35 then right (cbi_cusnam,  len(cbi_cusnam)-35) else '' end  as 'NAME2', 
'' AS 'NAME3',
'' AS 'NAME4',
cbi_cusno as 'SORT1',
cbi_cussna AS 'SORT2',
'BLOCK C, 6/F., ELDEX INDUSTRIAL BUILDING, 21 MA TAU WAI ROAD' as 'STREET', 
'HUNG HOM' AS 'STR_SUPPL3',
'KOWLOON' AS 'LOCATION',
'' AS 'CITY2',
''  as 'POST_CODE1',
'HONG KONG' as 'CITY1',
cci_cntcty as 'COUNTRY', 
'' as 'REGION',
'' AS 'TAXJURCODE',
 'E' as 'LANGU', 
'' as 'TEL_NUMBER', '' AS 'TEL_EXTENS',
'' AS 'MOB_NUMBER',
'' as 'FAX_NUMBER', '' as 'FAX_EXTENS',
'' as 'SMTP_ADDR',
'1131010000' as 'AKONT', -- cci_sapreconacc AS 'AKONT',
'' AS 'ZTERM',
case cbi_mrkreg
    when 'ASIA PACIFIC' then '001'
    when ' CENTRAL AMERIC' then '002'
     when 'CENTRAL EUROPE' then '003'
     when 'EASTERN EUROPE' then '004'
    when 'NORTH AMERICA' then '005'
      when 'NORTHERN EUROP' then '006'
     when 'OTHER REGIONS' then '007'
     when ' SOUTH AMERICA' then '008'
     when 'WESTERN EUROPE' then '009'
     else '010'
end AS 'BZIRK',

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '001'   
 	 	when 'C' then '001'   	
		when 'D' then '002' 
		when 'E' then '002' 
		when 'F' then '002' 
		when 'G' then '002' 
		when 'H' then '002' 
		when 'I' then '003'
		when 'J' then '003' 
		when 'K' then '003' 
		when 'L' then '001' 
		when 'M' then '001' 
		when 'N' then '003' 
		when 'S' then '001' 
		else ''
end as 'VKBUR', 

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '002'   
 	 	when 'C' then '003'   	
		when 'D' then '004' 
		when 'E' then '005' 
		when 'F' then '006' 
		when 'G' then '007' 
		when 'H' then '008' 
		when 'I' then '009'
		when 'J' then '010' 
		when 'K' then '011' 
		when 'L' then '012' 
		when 'M' then '013' 
		when 'N' then '014' 
		when 'S' then '015' 
		else ''
end as 'VKGRP' ,

case upper(t.ysi_cde) 	when  'CCH' then '01'   
	  	when 'CGR' then '02'   
 	 	when 'DIS' then '03'   	
		when 'DPT' then '04' 
		when 'IMP' then '05' 
		when 'MAL' then '06' 
		when 'MMD' then '07' 
		when 'OTH' then '08' 
		when 'RET' then '09'
		when 'TRD' then '10' 
		when 'WHL' then '11' 
		else ''
 end  as 'KDGRP',
case  when cpi_curcde = '' then '' else cpi_curcde end  as 'WAERS',
'01' AS 'VSBED',
case when cpi_prctrm = '' then '' else substring(cpi_prctrm,1,3) end as 'INCO1',
case when cpi_prctrm = '' then '' else 
 case substring(cpi_prctrm,5,2) 
when  'HK' then 'HONG KONG'  
when  'YT' then 'YANTIAN'  
when  'ZH' then 'ZHONGSHAN'  
when  'JX' then ' JIANG XI'
else substring(cpi_prctrm,5,2) 
end
end as 'INCO2',
isnull(ypm_sappayterm,'') as 'ZTERM_S',
'Z1' AS 'KTGRD',
'1' as 'ACTFLG',
'1' as 'ORDER'

 from cubasinf 
left join sysalrep on cbi_salrep = ysr_code1
left join sysetinf t on cbi_mrktyp = t.ysi_cde and t.ysi_typ = '08'
--left join sysetinf p on cbi_mrktyp = p.ysi_cde and p.ysi_typ = '04'
--left join sypaytermmap on ypm_erppayterm = p.ysi_cde
left join cuprcinf on cpi_cusno = cbi_cusno
left join cucntinf on cci_cusno = cbi_cusno
left join sysetinf p on cpi_paytrm = p.ysi_cde and p.ysi_typ = '04'
left join sypaytermmap on ypm_erppayterm = p.ysi_cde
where cci_sapshcusno in 
(select distinct cci_sapshcusno from ucperpdb_aud..cucntinf_aud 
--where  
--(year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate()) )  
--and 
--CONVERT(NVARCHAR(10),cCi_credat,111) = CONVERT(NVARCHAR(10),getdate() ,111) AND 
where cci_credat > '2014-02-01' and
cci_actflg_aud = '1' and cbi_cusno like '5%'
)  and CCI_CNTTYP in ('M','S','B') 



union 

select
--GOODS RECIPIENT FOR SECONDARY CUSTOMER
cci_sapshcusno as 'KUNNR',
 '1010' as 'BUKRS',
'1010' as 'VKORG',
'10' as 'VTWEG',
 '00' as 'SPART',
 '0002' as 'KTOKD',
'' AS 'TITLE',
left(cbi_cusnam,35) as 'NAME1', 
case when len(cbi_cusnam) > 35 then right (cbi_cusnam,  len(cbi_cusnam)-35) else '' end  as 'NAME2', 
'' AS 'NAME3',
'' AS 'NAME4',
cbi_cusno as 'SORT1',
cbi_cussna AS 'SORT2',
'BLOCK C, 6/F., ELDEX INDUSTRIAL BUILDING, 21 MA TAU WAI ROAD' as 'STREET', 
'HUNG HOM' AS 'STR_SUPPL3',
'KOWLOON' AS 'LOCATION',
'' AS 'CITY2',
''  as 'POST_CODE1',

'HONG KONG' as 'CITY1',
cci_cntcty as 'COUNTRY', 
''  as 'REGION',
''  AS 'TAXJURCODE',
 'E' as 'LANGU', 
'' as 'TEL_NUMBER', '' AS 'TEL_EXTENS',
'' AS 'MOB_NUMBER',
'' as 'FAX_NUMBER', '' as 'FAX_EXTENS',
'' as 'SMTP_ADDR',
'1131010000' as 'AKONT', -- cci_sapreconacc AS 'AKONT',
'' AS 'ZTERM',

case cbi_mrkreg
    when 'ASIA PACIFIC' then '001'
    when ' CENTRAL AMERIC' then '002'
     when 'CENTRAL EUROPE' then '003'
     when 'EASTERN EUROPE' then '004'
    when 'NORTH AMERICA' then '005'
      when 'NORTHERN EUROP' then '006'
     when 'OTHER REGIONS' then '007'
     when ' SOUTH AMERICA' then '008'
     when 'WESTERN EUROPE' then '009'
     else '010'
end AS 'BZIRK',

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '001'   
 	 	when 'C' then '001'   	
		when 'D' then '002' 
		when 'E' then '002' 
		when 'F' then '002' 
		when 'G' then '002' 
		when 'H' then '002' 
		when 'I' then '003'
		when 'J' then '003' 
		when 'K' then '003' 
		when 'L' then '001' 
		when 'M' then '001' 
		when 'N' then '003' 
		when 'S' then '001' 
		else ''
end as 'VKBUR', 

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '002'   
 	 	when 'C' then '003'   	
		when 'D' then '004' 
		when 'E' then '005' 
		when 'F' then '006' 
		when 'G' then '007' 
		when 'H' then '008' 
		when 'I' then '009'
		when 'J' then '010' 
		when 'K' then '011' 
		when 'L' then '012' 
		when 'M' then '013' 
		when 'N' then '014' 
		when 'S' then '015' 
		else ''
end as 'VKGRP' ,

case upper(t.ysi_cde) 	when  'CCH' then '01'   
	  	when 'CGR' then '02'   
 	 	when 'DIS' then '03'   	
		when 'DPT' then '04' 
		when 'IMP' then '05' 
		when 'MAL' then '06' 
		when 'MMD' then '07' 
		when 'OTH' then '08' 
		when 'RET' then '09'
		when 'TRD' then '10' 
		when 'WHL' then '11' 
		else ''
 end  as 'KDGRP',
case  when cpi_curcde = '' then '' else cpi_curcde end  as 'WAERS',
'01' AS 'VSBED',
case when cpi_prctrm = '' then '' else substring(cpi_prctrm,1,3) end as 'INCO1',
case when cpi_prctrm = '' then '' else 
 case substring(cpi_prctrm,5,2) 
when  'HK' then 'HONG KONG'  
when  'YT' then 'YANTIAN'  
when  'ZH' then 'ZHONGSHAN'  
when  'JX' then ' JIANG XI'
else substring(cpi_prctrm,5,2) 
end
end as 'INCO2',
isnull(ypm_sappayterm,'') as 'ZTERM_S',
'Z1' AS 'KTGRD',
'1' as 'ACTFLG',
'2' as 'ORDER'

 from cubasinf 
left join sysalrep on cbi_salrep = ysr_code1
left join sysetinf t on cbi_mrktyp = t.ysi_cde and t.ysi_typ = '08'
--left join sysetinf p on cbi_mrktyp = p.ysi_cde and p.ysi_typ = '04'
--left join sypaytermmap on ypm_erppayterm = p.ysi_cde
left join cuprcinf on cpi_cusno = cbi_cusno
left join cucntinf on cci_cusno = cbi_cusno
left join sysetinf p on cpi_paytrm = p.ysi_cde and p.ysi_typ = '04'
left join sypaytermmap on ypm_erppayterm = p.ysi_cde
where cci_sapshcusno in 
(select distinct cci_sapshcusno from ucperpdb_aud..cucntinf_aud 
--where  
--(year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate()) )  
--and 
--CONVERT(NVARCHAR(10),cCi_credat,111) = CONVERT(NVARCHAR(10),getdate() ,111) AND 
where cci_credat > '2014-02-01' and
cci_actflg_aud = '1' and cbi_cusno like '6%'
)  and CCI_CNTTYP in ('M','S','B') 

union

select
--PRIMARY CUSTOMER, as there is a new relationship in its secondary customer
 cbi_cusno as 'KUNNR', --MANDATORY
 '1010' as 'BUKRS', --MANDATORY
'1010' as 'VKORG', --MANDATORY
'10' as 'VTWEG', --MANDATORY
 '00' as 'SPART', --MANDATORY
 '0001' as 'KTOKD', --MANDATORY
'' AS 'TITLE',
left(cbi_cusnam,35) as 'NAME1', --MANDATORY
case when len(cbi_cusnam) > 35 then right (cbi_cusnam,  len(cbi_cusnam)-35) else '' end  as 'NAME2', 
'' as 'NAME3',
'' as 'NAME4',
cbi_cusno as 'SORT1',
cbi_cussna AS 'SORT2',
'BLOCK C, 6/F., ELDEX INDUSTRIAL BUILDING, 21 MA TAU WAI ROAD' as 'STREET', 
'HUNG HOM' AS 'STR_SUPPL3',
'KOWLOON' AS 'LOCATION',
'' AS 'CITY2',
''  as 'POST_CODE1',
'HONG KONG' as 'CITY1',
cci_cntcty as 'COUNTRY', 
''  as 'REGION',
''  AS 'TAXJURCODE',
 'E' as 'LANGU', 
'' as 'TEL_NUMBER', '' AS 'TEL_EXTENS',
'' AS 'MOB_NUMBER',
'' as 'FAX_NUMBER', '' as 'FAX_EXTENS',
'' as 'SMTP_ADDR',
'1131010000' as 'AKONT', -- cci_sapreconacc AS 'AKONT',
'' AS 'ZTERM',
case cbi_mrkreg
    when 'ASIA PACIFIC' then '001'
    when ' CENTRAL AMERIC' then '002'
     when 'CENTRAL EUROPE' then '003'
     when 'EASTERN EUROPE' then '004'
    when 'NORTH AMERICA' then '005'
      when 'NORTHERN EUROP' then '006'
     when 'OTHER REGIONS' then '007'
     when ' SOUTH AMERICA' then '008'
     when 'WESTERN EUROPE' then '009'
     else '010'
end AS 'BZIRK',

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '001'   
 	 	when 'C' then '001'   	
		when 'D' then '002' 
		when 'E' then '002' 
		when 'F' then '002' 
		when 'G' then '002' 
		when 'H' then '002' 
		when 'I' then '003'
		when 'J' then '003' 
		when 'K' then '003' 
		when 'L' then '001' 
		when 'M' then '001' 
		when 'N' then '003' 
		when 'S' then '001'  -- Which Code should be assigned for Team S
		else ''
end as 'VKBUR', 

case  ysr_saltem	 when   'A' then '001'   
	  	when 'B' then '002'   
 	 	when 'C' then '003'   	
		when 'D' then '004' 
		when 'E' then '005' 
		when 'F' then '006' 
		when 'G' then '007' 
		when 'H' then '008' 
		when 'I' then '009'
		when 'J' then '010' 
		when 'K' then '011' 
		when 'L' then '012' 
		when 'M' then '013' 
		when 'N' then '014' 
		when 'S' then '015' 
		else ''
end as 'VKGRP' ,

case upper(t.ysi_cde) 	when  'CCH' then '01'   
	  	when 'CGR' then '02'   
 	 	when 'DIS' then '03'   	
		when 'DPT' then '04' 
		when 'IMP' then '05' 
		when 'MAL' then '06' 
		when 'MMD' then '07' 
		when 'OTH' then '08' 
		when 'RET' then '09'
		when 'TRD' then '10' 
		when 'WHL' then '11' 
		else ''
 end  as 'KDGRP',
case  when cpi_curcde = '' then '' else cpi_curcde end  as 'WAERS',
'01' AS 'VSBED',
case when cpi_prctrm = '' then '' else substring(cpi_prctrm,1,3) end as 'INCO1',
case when cpi_prctrm = '' then '' else 
 case substring(cpi_prctrm,5,2) 
when  'HK' then 'HONG KONG'  
when  'YT' then 'YANTIAN'  
when  'ZH' then 'ZHONGSHAN'  
when  'JX' then ' JIANG XI'
else substring(cpi_prctrm,5,2) 
end
end as 'INCO2',
isnull(ypm_sappayterm,'') as 'ZTERM_S',
'Z1' AS 'KTGRD',
'3' as 'ACTFLG',
'4' as 'ORDER'

from cubasinf 
left join sysalrep on cbi_salrep = ysr_code1
left join sysetinf t on cbi_mrktyp = t.ysi_cde and t.ysi_typ = '08'
left join cuprcinf on cpi_cusno = cbi_cusno
left join cucntinf on cci_cusno = cbi_cusno and cci_cnttyp = 'M' and cci_cntseq = '1'
left join sysetinf p on cpi_paytrm = p.ysi_cde and p.ysi_typ = '04'
left join sypaytermmap on ypm_erppayterm = p.ysi_cde
where cbi_cusno in 
(
select distinct csc_prmcus from  cusubcus
left join ucperpdb_AUD..cucntinf_aud on csc_seccus = cci_cusno
 where  csc_prmcus like '5%' and cci_cnttyp  in ('B','S','M') and  cci_sapshcusno is not null and ( cci_actflg_aud = '1' or cci_actflg_aud = '4' )
 and --year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate()) 
--CONVERT(NVARCHAR(10),cCi_credat,111)  = CONVERT(NVARCHAR(10),getdate() ,111) 
cci_credat > '2014-02-01'
)

 order by [ORDER], actflg,KTOKD, kunnr asc
end
GO
GRANT EXECUTE ON [dbo].[sp_select_ZFM_SY00Z0010U_Info] TO [ERPUSER] AS [dbo]
GO
