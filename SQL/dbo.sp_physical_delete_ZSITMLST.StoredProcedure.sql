/****** Object:  StoredProcedure [dbo].[sp_physical_delete_ZSITMLST]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_ZSITMLST]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_ZSITMLST]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 28/07/2003

/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 15 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     

*/


------------------------------------------------- 
CREATE procedure [dbo].[sp_physical_delete_ZSITMLST]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@zil_cocde		nvarchar(6) = ' ',
@zil_itmno	varchar(20)

AS
 
delete 
	ZSITMLST
where
	zil_itmno = @zil_itmno
     










GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_ZSITMLST] TO [ERPUSER] AS [dbo]
GO
