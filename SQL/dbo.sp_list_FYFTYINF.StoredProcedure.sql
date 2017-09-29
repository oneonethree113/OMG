/****** Object:  StoredProcedure [dbo].[sp_list_FYFTYINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_FYFTYINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_FYFTYINF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



-- Checked by Allan Yuen at 28/07/2003


/************************************************************************
Author:		Johnson Lai	
Date:		Mar 03, 2002
Description:	Select data From FYFTYINF
Parameter:	1. Company
		2. Inv no
************************************************************************/

CREATE procedure [dbo].[sp_list_FYFTYINF]
                                                                                                                                                                                                                                                               
@ffi_cocde nvarchar(6),
@ffi_creusr nvarchar(30)

AS
begin

select * from FYFTYINF

where 

ffi_cocde = @ffi_cocde

end





GO
GRANT EXECUTE ON [dbo].[sp_list_FYFTYINF] TO [ERPUSER] AS [dbo]
GO
