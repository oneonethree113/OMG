/****** Object:  StoredProcedure [dbo].[sp_Spring_CUSTOMER_PDA]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_Spring_CUSTOMER_PDA]
GO
/****** Object:  StoredProcedure [dbo].[sp_Spring_CUSTOMER_PDA]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/*
=========================================================
Description   	: sp_SPRING_CUSTOMER_PDA
Programmer  	: Lewis To
Create Date   	: 2002-07-30
Last Modified  	: 2003-07-22
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      Initial  	Description                          
=========================================================     */

CREATE procedure [dbo].[sp_Spring_CUSTOMER_PDA]

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
--cbi_cocde = 'UCP'

order by cbi_cusno


GO
GRANT EXECUTE ON [dbo].[sp_Spring_CUSTOMER_PDA] TO [ERPUSER] AS [dbo]
GO
