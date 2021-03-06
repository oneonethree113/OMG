/****** Object:  StoredProcedure [dbo].[sp_select_CUBASINF_SR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUBASINF_SR]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUBASINF_SR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/************************************************************************
Author:		Tommy
Date:		18 Dec, 2001
Description:	Select Sales Rep of the Customer
************************************************************************/

CREATE procedure [dbo].[sp_select_CUBASINF_SR]
                                                                                                                                                                                                                                                                 
@cocde 	nvarchar(6),
@salrep 	nvarchar(30),
@creusr	nvarchar(30)
 
AS

begin


select 	ysr_code1, 	ysr_dsc, 		ysr_saltem,
	ysr_code1 + ' - ' + ysr_dsc + ' (TEAM '+ysr_saltem+')'  as 'dsc'
from SYSALREP
where 	ysr_cocde = ' ' --@cocde
 	and
	(ysr_saltem = (select ysr_saltem from sysalrep where ysr_cocde = ' ' --@cocde 
		and ysr_code1 = @salrep)
	or
	ysr_saltem = 'S')


end





GO
GRANT EXECUTE ON [dbo].[sp_select_CUBASINF_SR] TO [ERPUSER] AS [dbo]
GO
