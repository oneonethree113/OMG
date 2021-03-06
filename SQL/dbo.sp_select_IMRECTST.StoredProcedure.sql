/****** Object:  StoredProcedure [dbo].[sp_select_IMRECTST]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMRECTST]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMRECTST]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/************************************************************************
Author:		Wong Hong
Date:		4th Jan, 2002
Description:	Select data From IMRECTST
Parameter:	1. Company
		2. Receiving No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_IMRECTST]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@irt_cocde nvarchar(6) ,
@irt_recno nvarchar(20)                                   
---------------------------------------------- 
 
AS
begin
Select 
i.*,
v.vbi_vensna,
c.cbi_cussna
--------------------------------- 
from IMRECTST i, VNBASINF v, CUBASINF c
where                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--i.irt_cocde = @irt_cocde and
i.irt_recno = @irt_recno and
--v.vbi_cocde = i.irt_cocde and
v.vbi_venno = i.irt_venno and
--c.cbi_cocde = i.irt_cocde and
c.cbi_cusno = i.irt_cusno
---------------------------------------------------------- 
end





GO
GRANT EXECUTE ON [dbo].[sp_select_IMRECTST] TO [ERPUSER] AS [dbo]
GO
