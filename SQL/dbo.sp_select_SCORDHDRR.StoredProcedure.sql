/****** Object:  StoredProcedure [dbo].[sp_select_SCORDHDRR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCORDHDRR]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCORDHDRR]    Script Date: 09/29/2017 15:29:10 ******/
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

Modification information
Date		By		Description
25 Feb 2003	Lewis To	Added check SC# lenght to bound the incorrect input.

************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_SCORDHDRR]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@soh_cocde nvarchar(6) ,
@from nvarchar(20),
@to nvarchar(20),
@f nvarchar(1)
                                                
---------------------------------------------- 
 
AS

begin
Select 
soh_ordno,
soh_ordsts

from SCORDHDR

where                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
soh_cocde = @soh_cocde and
soh_ordno >= @from and
soh_ordno <= @to and
soh_ordsts <> (case @f when 'Y' then 'ACT'  else 'REL' end)    and
-- added by Lewis for checking incorrect SC# input at 2003-02-25
len(rtrim(soh_ordno)) = len(rtrim(@from))                                                                       
---------------------------------------------------------- 
end




GO
GRANT EXECUTE ON [dbo].[sp_select_SCORDHDRR] TO [ERPUSER] AS [dbo]
GO
