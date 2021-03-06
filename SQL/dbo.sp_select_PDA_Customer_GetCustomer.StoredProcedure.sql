/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Customer_GetCustomer]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PDA_Customer_GetCustomer]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PDA_Customer_GetCustomer]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/*
=========================================================
Description   	: sp_select_PDA_Customer_GetCustomer
Programmer  	: Mark Lau
Create Date   	: 2006-06-12
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      Initial  	Description                          
=========================================================     */

CREATE procedure [dbo].[sp_select_PDA_Customer_GetCustomer]
@usrgrp nvarchar (20),
@saltem nvarchar(5),
@typ nvarchar(1),
@cusno nvarchar(10)
as

Select 
	' ' as 'cbi_cocde',
	cbi_cusno,
	cbi_custyp,
	isnull(ysr_saltem,'') as 'cbi_salrep',
	isnull(ysr_code,'') as ysr_code,
	cbi_cussna,
	isnull(cpi_prcsec,'') as 'cpi_prcsec',
	isnull(cpi_grsmgn,0) as 'cpi_grsmgn',
	isnull(cpi_curcde,'') as 'cpi_curcde',
	--isnull(yfi_fml,'')
	''  as 'yfi_fml'
from 
	CUBASINF (nolock)
	 left join SYSALREP (nolock) on --ysr_cocde = cbi_cocde and 
					ysr_code1 = cbi_salrep
	left join CUPRCINF (nolock) on cbi_cusno = cpi_cusno 
	--left join SYFMLINF on cpi_prcfml = yfi_fmlopt --and cpi_cocde = yfi_cocde
where 
--cbi_cocde = cpi_cocde and
left(cbi_cusno,1) >'4' and
cbi_cussts = 'A' --and 
and 
(

(
@typ = 'P'
and substring(cbi_cusno,1,1) = '5'
--cbi_cocde = 'UCP'
and 
(	(@usrgrp like '%MGT%' or @saltem = 'S' or @saltem = '') or (ysr_saltem = @saltem)	)
)

or

(
@typ = 'S' and  substring(cbi_cusno,1,1) = '6' and cbi_cusno = @cusno
)

)
order by cbi_cusno asc





GO
GRANT EXECUTE ON [dbo].[sp_select_PDA_Customer_GetCustomer] TO [ERPUSER] AS [dbo]
GO
