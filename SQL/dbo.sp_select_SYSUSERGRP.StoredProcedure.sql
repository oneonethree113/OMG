/****** Object:  StoredProcedure [dbo].[sp_select_SYSUSERGRP]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYSUSERGRP]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYSUSERGRP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







/************************************************************************
Author:		Louis Siu   
Date:		19th Dec, 2001
Description:	Select data From SYUSRGRP
***********************************************************************
=========================================================
 Modification History                                    
=========================================================
Date		Authour		Description        
=========================================================
8 Jul 2003		Lewis To		Remark the where statment for access by multi Company 
=========================================================     
*/
CREATE procedure [dbo].[sp_select_SYSUSERGRP]
                                                                                                                                                                                                                                                                 

@cocde nvarchar(6)

AS

begin

Select distinct yug_usrgrp

from SYUSRGRP
--where

--yug_cocde = @cocde			-- Remark for change to multi Company by Lewis on 20030708



end





GO
GRANT EXECUTE ON [dbo].[sp_select_SYSUSERGRP] TO [ERPUSER] AS [dbo]
GO
