/****** Object:  StoredProcedure [dbo].[sp_list_CUVENINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_CUVENINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_CUVENINF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/************************************************************************
Author:		Kath Ng     
Date:		20th September, 2001
Description:	Select data From CUBASINF
Parameter:	1. Company Code range    
		2. Customer Code range    
***********************************************************************
7 Jul 2003		Lewis To		Ignor Comp Code for handle multi Company
*/


CREATE procedure [dbo].[sp_list_CUVENINF]
                                                                                                                                                                                                                                                               
@cvi_cocde nvarchar(6) 

 AS  Select 

*

 from CUVENINF
-- where                                                                                                                                                                                                                                                                 
-- cvi_cocde = @cvi_cocde







GO
GRANT EXECUTE ON [dbo].[sp_list_CUVENINF] TO [ERPUSER] AS [dbo]
GO
