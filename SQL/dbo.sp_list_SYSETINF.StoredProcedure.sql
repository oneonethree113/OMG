/****** Object:  StoredProcedure [dbo].[sp_list_SYSETINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_SYSETINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_SYSETINF]    Script Date: 09/29/2017 15:29:10 ******/
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
20030715	Allan Yuen		For Merge Porject
*/

CREATE PROCEDURE [dbo].[sp_list_SYSETINF] 

@ysi_cocde 	nvarchar(6) = ' '

AS

Select * from SYSETINF
--where ysi_cocde = @ysi_cocde
where ysi_cocde = ' '

Order By ysi_cocde








GO
GRANT EXECUTE ON [dbo].[sp_list_SYSETINF] TO [ERPUSER] AS [dbo]
GO
