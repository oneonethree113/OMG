/****** Object:  StoredProcedure [dbo].[sp_select_IMBASINF_Q_Check_Dis]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMBASINF_Q_Check_Dis]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMBASINF_Q_Check_Dis]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/************************************************************************
Author:		Mark Lau
Date:		20061109
Description:	check the new item whether is discontinued
Parameter:		1. Company
		2. Item No.	
*************************************************************************
23 May 2005	Allan Yuen	Add Custom Vendor Code
*/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_IMBASINF_Q_Check_Dis]
                                                                                                                                                                                                                                                                 
@ibi_cocde nvarchar(6) ,
@ibi_itmno nvarchar(20) 
                                               
AS

begin

select 	
	*	
from 		
	IMBASINF
where	
	ibi_alsitmno = @ibi_itmno
order by ibi_itmno
end


GO
GRANT EXECUTE ON [dbo].[sp_select_IMBASINF_Q_Check_Dis] TO [ERPUSER] AS [dbo]
GO
