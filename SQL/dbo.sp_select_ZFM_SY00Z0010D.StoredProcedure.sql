/****** Object:  StoredProcedure [dbo].[sp_select_ZFM_SY00Z0010D]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_ZFM_SY00Z0010D]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_ZFM_SY00Z0010D]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE procedure [dbo].[sp_select_ZFM_SY00Z0010D]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

@cocde nvarchar(6) 
             

---------------------------------------------- 
 
AS


begin
select
--PRIMARY CUSTOMER
 cbi_cusno as 'KUNNR', --MANDATORY
 '1010' as 'BUKRS', --MANDATORY
'1010' as 'VKORG', --MANDATORY
'10' as 'VTWEG', --MANDATORY
 '00' as 'SPART', --MANDATORY
'4' as 'ORDER'

 from ucperpdb_aud..cubasinf_aud 
--where  (year(cbi_credat) = year(getdate()) and month(cbi_credat) = month(getdate()) and day(cbi_credat) = day(getdate()) )  
where cbi_credat > '2014-02-01'
and cbi_actflg_aud = '4' and cbi_cusno like '5%'

union 


--SECONDARY CUSTOMERS
select
cbi_cusno as 'KUNNR',
 '1010' as 'BUKRS',
'1010' as 'VKORG',
'10' as 'VTWEG',
 '00' as 'SPART',
'3' as 'ORDER'
 from ucperpdb_aud..cubasinf_aud 
--where  (year(cbi_credat) = year(getdate()) and month(cbi_credat) = month(getdate()) and day(cbi_credat) = day(getdate()) )  
where cbi_credat > '2014-02-01'
and cbi_actflg_aud = '4' and cbi_cusno like '6%'


union 

select
--GOODS RECIPIENT FOR PRIMARY CUSTOMER
cci_sapshcusno as 'KUNNR',
 '1010' as 'BUKRS',
'1010' as 'VKORG',
'10' as 'VTWEG',
 '00' as 'SPART',
'2' as 'ORDER'
 from ucperpdb_aud..cucntinf_aud 
--where  (year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate()) )  
where cci_credat > '2014-02-01'
and cci_actflg_aud = '3' and cci_cusno like '5%'  and CCI_CNTTYP in ('M','S','B') and cci_delete = 'Y'



union 

select
--GOODS RECIPIENT FOR SECONDARY CUSTOMER
cci_sapshcusno as 'KUNNR',
 '1010' as 'BUKRS',
'1010' as 'VKORG',
'10' as 'VTWEG',
 '00' as 'SPART',
'' as 'ORDER'
 from ucperpdb_aud..cucntinf_aud 
--where  (year(cci_credat) = year(getdate()) and month(cci_credat) = month(getdate()) and day(cci_credat) = day(getdate()) )  
where cci_credat > '2014-02-01'
and cci_actflg_aud = '3' and cci_cusno like '6%'  and CCI_CNTTYP in ('M','S','B') and cci_delete = 'Y'


 order by  [ORDER], kunnr asc



end
GO
GRANT EXECUTE ON [dbo].[sp_select_ZFM_SY00Z0010D] TO [ERPUSER] AS [dbo]
GO
