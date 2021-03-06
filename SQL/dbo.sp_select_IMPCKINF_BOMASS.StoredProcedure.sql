/****** Object:  StoredProcedure [dbo].[sp_select_IMPCKINF_BOMASS]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMPCKINF_BOMASS]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMPCKINF_BOMASS]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
ALTER  Date   	: 
Last Modified  	: 17 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
17 July 2003	Allan Yuen		For Merge Porject, disable company code
13 Dec 2012	David Yue		Add Packing Period
*/

/************************************************************************
Author:		Kenny Chan
Date:		4th Oct, 2001
Description:	Select data From IMPCKINF
Parameter:	1. Company
		2. Item No.	
		3. Item Type
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_IMPCKINF_BOMASS]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ibi_cocde nvarchar(6) ,
@ibi_itmno nvarchar(20),
@ibi_typ nvarchar(4)
---------------------------------------------- 
 
AS


begin
 Select 
ipi_cocde,
ipi_itmno,
ipi_pckseq,
ipi_pckunt,
ipi_mtrqty,
ipi_inrqty,
ipi_inrhin,
ipi_inrwin,
ipi_inrdin,
ipi_inrhcm,
ipi_inrwcm,
ipi_inrdcm,
ipi_mtrhin,
ipi_mtrwin,
ipi_mtrdin,
ipi_mtrhcm,
ipi_mtrwcm,
ipi_mtrdcm,
ipi_cft,
ipi_cbm,
ipi_grswgt,
ipi_netwgt,
ipi_pckitr,
cast(datepart(yyyy,ipi_qutdat) as varchar(4)) + '-' + right('0' + cast(datepart(month, ipi_qutdat) as varchar(2)), 2) as 'ipi_qutdat',
ipi_creusr,
ipi_updusr,
ipi_credat,
ipi_upddat,
ipi_timstp

--------------------------------- 
 from IMBASINF,IMPCKINF
 where                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- ibi_cocde = @ibi_cocde and
 ibi_itmno = @ibi_itmno and
 ipi_itmno = ibi_itmno
                           
-------------------------- 

                                                           
---------------------------------------------------------- 
end









GO
GRANT EXECUTE ON [dbo].[sp_select_IMPCKINF_BOMASS] TO [ERPUSER] AS [dbo]
GO
