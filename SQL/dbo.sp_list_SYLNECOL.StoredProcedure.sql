/****** Object:  StoredProcedure [dbo].[sp_list_SYLNECOL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYLNECOL]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYLNECOL]    Script Date: 09/29/2017 15:29:10 ******/
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
20030715	Allan Yuen		Modify For Merge Porject
*/

CREATE PROCEDURE [dbo].[sp_list_SYLNECOL] 

@ylc_cocde 	nvarchar(6) = ' '
AS

Select * from SYLNECOL
--where ylc_cocde = @ylc_cocde
where ylc_cocde = ' '
Order By ylc_colcde









GO
GRANT EXECUTE ON [dbo].[sp_list_SYLNECOL] TO [ERPUSER] AS [dbo]
GO
