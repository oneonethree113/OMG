/****** Object:  StoredProcedure [dbo].[sp_select_SearchCustomer]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SearchCustomer]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SearchCustomer]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/************************************************************************
Author:		Kath Ng     
Date:		13th September, 2001
Description:	Select data From CUBASINF
************************************************************************/

CREATE procedure [dbo].[sp_select_SearchCustomer]
                                                                                                                                                                                                                                                                 

@cbi_cocde	nvarchar(6) ,
@cbi_cusno	nvarchar(20),
@cbi_cussna	nvarchar(20),
@cbi_cusnam	nvarchar(30)
 
AS

BEGIN
----------------------------------------------------------------------------------------------------------------

SELECT * from CUBASINF

----------------------------------------------------------------------------------------------------------------
END




GO
GRANT EXECUTE ON [dbo].[sp_select_SearchCustomer] TO [ERPUSER] AS [dbo]
GO
