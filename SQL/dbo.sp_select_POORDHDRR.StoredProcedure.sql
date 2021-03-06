/****** Object:  StoredProcedure [dbo].[sp_select_POORDHDRR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_POORDHDRR]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_POORDHDRR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 27/07/2003




/************************************************************************
Author:		Kenny Chan
Date:		19th dec, 2001
Description:	Select data From SCORDHDR
Parameter:	1. Company
		2. SC No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_POORDHDRR]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@poh_cocde nvarchar(6) ,
@from nvarchar(20),
@to nvarchar(20),
@f nvarchar(1)
                                                
---------------------------------------------- 
 
AS

begin
Select 
poh_purord,
poh_pursts

from POORDHDR

where                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
poh_cocde = @poh_cocde and
poh_purord >= @from and
poh_purord <= @to and
poh_pursts <> (case @f when 'Y' then 'OPE'  else 'REL' end)                                                                            
---------------------------------------------------------- 
end



GO
GRANT EXECUTE ON [dbo].[sp_select_POORDHDRR] TO [ERPUSER] AS [dbo]
GO
