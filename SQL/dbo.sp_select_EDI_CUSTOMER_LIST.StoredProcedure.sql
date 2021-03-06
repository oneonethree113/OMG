/****** Object:  StoredProcedure [dbo].[sp_select_EDI_CUSTOMER_LIST]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_EDI_CUSTOMER_LIST]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_EDI_CUSTOMER_LIST]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





--select * from [UCPERPDB_AUD].[DBO].[CUBASINF_AUD] where cbi_cusno = '50359'
--sp_select_EDI_CUSTOMER_LIST 'X','2005-01-01', '2005-01-31'

/*
=========================================================
Program ID	: sp_select_EDI_CUSTOMER_LIST
Description   	: 
Programmer  	: Lester Wu
Create Date   	: 
Last Modified  	: 
Table Read(s) 	: 
Table Write(s) 	: 
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     

*/
create procedure [dbo].[sp_select_EDI_CUSTOMER_LIST]
@cocde	as varchar(6), 
@dtFm	as datetime, 
@dtTo	as datetime
as
Begin


select 
	distinct 
	CUST_1.cbi_cusno as 'CUST_ID', 
	CUST_1.cbi_cussna as 'CUST_SNAME' , 
	'FLAG' = 'NEW' 
INTO	#RESULT
from 
	[UCPERPDB_AUD].[DBO].[CUBASINF_AUD] as CUST_1  (NOLOCK)
where 
	CUST_1.cbi_upddat between @dtFm and @dtTo + ' 23:59:59' 
	and CUST_1.cbi_cussts='A'
	and CUST_1.cbi_custyp in ('P', 'S')
	and CUST_1.cbi_actflg_aud = 1

select 
	CUST_3.cbi_cusno as 'CUST_ID', 
	CUST_3.cbi_cussna as 'CUST_SNAME' , 
	'FLAG' = 'UPD' 
	, CUST_3.cbi_credat as 'CREATE_DAT'

INTO 	#RESULT_UPD
from 
	[UCPERPDB_AUD].[DBO].[CUBASINF_AUD] as CUST_2  (NOLOCK)
	LEFT JOIN [UCPERPDB_AUD].[DBO].[CUBASINF_AUD] as CUST_3 ( NOLOCK) on CUST_2.cbi_cusno = CUST_3.cbi_cusno and CUST_3.cbi_actflg_aud = 3
where 
	CUST_2.cbi_credat between @dtFm and @dtTo + ' 23:59:59' 
	and CUST_3.cbi_credat between @dtFm and @dtTo + ' 23:59:59' 
	and CUST_2.cbi_cussts='A'
	and CUST_3.cbi_cussts='A'
	and CUST_2.cbi_custyp in ('P', 'S')
	and CUST_2.cbi_actflg_aud = 2
	and CUST_3.cbi_cusno is not null
	and CUST_2.cbi_cussna <> CUST_3.cbi_cussna
--	and CUST_2.cbi_cusno not in (select CUST_ID from #RESULT_NEW)


select
	CUST_ID,
	MAX(CREATE_DAT) as 'MAX_DAT'
into	
	#RESULT_MAX
from
	#RESULT_UPD
GROUP BY
	CUST_ID


Insert into #RESULT
Select 
	#RESULT_UPD.CUST_ID,
	#RESULT_UPD.CUST_SNAME , 
	#RESULT_UPD.FLAG
from
	#RESULT_UPD
	LEFT JOIN #RESULT_MAX on #RESULT_UPD.CUST_ID = #RESULT_MAX.CUST_ID and #RESULT_UPD.CREATE_DAT = #RESULT_MAX.MAX_DAT
where
	#RESULT_MAX.CUST_ID is not null




select 
	* 
from 
	#RESULT
order by 
	CUST_ID , 
	FLAG

	
END 





GO
GRANT EXECUTE ON [dbo].[sp_select_EDI_CUSTOMER_LIST] TO [ERPUSER] AS [dbo]
GO
