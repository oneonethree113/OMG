/****** Object:  StoredProcedure [dbo].[sp_select_SYSETINF]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYSETINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYSETINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







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
20030715	Allan Yuen		For Merge Porject
*/

/************************************************************************
Author:		Johnson Lai 
Date:		17th September, 2001
Description:	Select data From SETUPINF
Parameter:	1. SYSTEM TYPE
***********************************************************************
20 Aug 2003	Allan Yuen	Fix Deadlock Problem
*/

CREATE procedure [dbo].[sp_select_SYSETINF]

@ysi_cocde 	nvarchar(6)  = ' ',
@ysi_typ	  	nvarchar(2) 
                                               
AS

begin

if @ysi_typ = '05' 
begin

	Select	ysi_cde, ysi_dsc                                 
	
	from SYSETINF (nolock)
	
	where                                                                                                                                                                                                                                                                
	--ysi_cocde	 = @ysi_cocde and
	ysi_cocde = ' ' and
	ysi_typ	 = @ysi_typ                           
	
	order by ysi_cde, ysi_dsc 
end
else
begin
	Select	ysi_cde, ysi_dsc                                 
	
	from SYSETINF (nolock)
	
	where                                                                                                                                                                                                                                                                
	--ysi_cocde	 = @ysi_cocde and
	ysi_cocde = ' ' and
	ysi_typ	 = @ysi_typ                           
	
	order by ysi_dsc, ysi_cde
end
end



GO
GRANT EXECUTE ON [dbo].[sp_select_SYSETINF] TO [ERPUSER] AS [dbo]
GO
