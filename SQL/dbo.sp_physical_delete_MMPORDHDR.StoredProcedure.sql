/****** Object:  StoredProcedure [dbo].[sp_physical_delete_MMPORDHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_MMPORDHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_MMPORDHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 2005/08/11
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     

*/



CREATE PROCEDURE [dbo].[sp_physical_delete_MMPORDHDR]

@Mph_cocde  varchar(6) = '',
@Mph_MPONO  varchar(20)


AS

DELETE  FROM
	MPORDHDR
where
	Mph_MPONO =@Mph_MPONO




GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_MMPORDHDR] TO [ERPUSER] AS [dbo]
GO
