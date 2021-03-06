/****** Object:  StoredProcedure [dbo].[sp_Update_SHCBNHDR]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_Update_SHCBNHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_SHCBNHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/************************************************************************
Author:		Wong Hong
Date:		4th dec, 2002
Description:	Update data From SHCBNHDR
Parameter:	1. Company
		2. Note No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_Update_SHCBNHDR]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@hnh_cocde  nvarchar(6), 	@hnh_noteno  nvarchar(20),
@hnh_ttlamt	numeric(9,4),
@hnh_rmk	nvarchar(200),	@hnh_updusr nvarchar(30)
---------------------------------------------- 
 
AS
begin
Update SHCBNHDR SET
hnh_ttlamt	=	@hnh_ttlamt,
hnh_rmk	 	=  	@hnh_rmk,
hnh_updusr	=	@hnh_updusr,
hnh_upddat	=	GETDATE()
--------------------------------- 
Where                                                                                                                                                                                                                           
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
hnh_cocde = @hnh_cocde and
hnh_noteno = @hnh_noteno                                                                             
---------------------------------------------------------- 


end





GO
GRANT EXECUTE ON [dbo].[sp_Update_SHCBNHDR] TO [ERPUSER] AS [dbo]
GO
