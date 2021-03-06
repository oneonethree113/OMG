/****** Object:  StoredProcedure [dbo].[sp_select_SCCNTINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCCNTINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCCNTINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 27/07/2003



/************************************************************************
Author:		Kenny Chan
Date:		19th dec, 2001
Description:	Select data From SCCNTINF
Parameter:	1. Company
		2. SC No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_SCCNTINF]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@sci_cocde nvarchar(6) ,
@sci_ordno nvarchar(20)                                                
---------------------------------------------- 
 
AS
begin
Select 
sci_cocde,
sci_ordno,
sci_csenam,
sci_cseadr,
sci_csestt,
sci_csecty,
sci_csezip,
sci_fwdtyp,
sci_fwdno,
sci_fwddsc,
sci_fwditr,
sci_noptyp,
sci_nopadr,
sci_nopstt,
sci_nopcty,
sci_nopzip,
sci_nopctp,
sci_noptil,
sci_nopphn,
sci_nopfax,
sci_nopeml,
sci_creusr,
sci_updusr,
sci_credat,
sci_upddat,
cast(sci_timstp as int) as sci_timstp
--------------------------------- 
from SCCNTINF
where                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
sci_cocde = @sci_cocde and
sci_ordno = @sci_ordno                                                                                    
---------------------------------------------------------- 
end





GO
GRANT EXECUTE ON [dbo].[sp_select_SCCNTINF] TO [ERPUSER] AS [dbo]
GO
