/****** Object:  StoredProcedure [dbo].[sp_update_IMB00001]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMB00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMB00001]    Script Date: 09/29/2017 15:29:10 ******/
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


CREATE procedure [dbo].[sp_update_IMB00001]
                                                                                                                                                                                                                                                               
@cocde	nvarchar(6),
@itmno	nvarchar(20),
@imgpth	nvarchar(200),
@user	nvarchar(30)

AS

BEGIN

	UPDATE 
		IMBASINF
	SET 
		ibi_imgpth = @imgpth--,
--		ibi_updusr = 'SYSIMG-UPD',
--		ibi_upddat = getdate()
--,
--	ibi_updusr = @user,
--	ibi_upddat = GETDATE()
	WHERE 
	--ibi_cocde = @cocde and
	ibi_itmno = @itmno and
	ibi_imgpth <> @imgpth

END


GO
GRANT EXECUTE ON [dbo].[sp_update_IMB00001] TO [ERPUSER] AS [dbo]
GO
