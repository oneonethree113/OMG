/****** Object:  StoredProcedure [dbo].[SP_Select_IMGCHECKING]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[SP_Select_IMGCHECKING]
GO
/****** Object:  StoredProcedure [dbo].[SP_Select_IMGCHECKING]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 17 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
17 July 2003	Allan Yuen		For Merge Porject, disable company code
*/


CREATE PROCEDURE [dbo].[SP_Select_IMGCHECKING] 

@Cocde nvarchar(6)
AS

Select ibi_itmno,ibi_lnecde,isnull(ivi_venitm,'') as 'ivi_venitm' From 
IMBASINF
--left join IMVENINF on ivi_cocde = @cocde and ivi_itmno = ibi_itmno and ivi_venno = ibi_venno
left join IMVENINF on ivi_itmno = ibi_itmno and ivi_venno = ibi_venno
where 	
	--ibi_cocde = @cocde and 
	ibi_venno = '0005' and 
	(ibi_creusr like 'Creat%' or 
	ibi_updusr like 'Updat%')

order by ibi_itmno




GO
GRANT EXECUTE ON [dbo].[SP_Select_IMGCHECKING] TO [ERPUSER] AS [dbo]
GO
