/****** Object:  StoredProcedure [dbo].[sp_list_SYCLMIST]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYCLMIST]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYCLMIST]    Script Date: 09/29/2017 15:29:10 ******/
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
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
*/



CREATE  PROCEDURE [dbo].[sp_list_SYCLMIST] 

@ycc_cocde 	nvarchar(6) = ' '
AS

Select 
*
from SYCLMIST










GO
GRANT EXECUTE ON [dbo].[sp_list_SYCLMIST] TO [ERPUSER] AS [dbo]
GO
