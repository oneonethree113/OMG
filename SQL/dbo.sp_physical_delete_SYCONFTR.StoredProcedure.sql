/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCONFTR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYCONFTR]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCONFTR]    Script Date: 09/29/2017 15:29:10 ******/
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

CREATE PROCEDURE [dbo].[sp_physical_delete_SYCONFTR] 


@ycf_cocde	 nvarchar(6) = ' ',
@ycf_code1 	nvarchar(6),
@ycf_code2	nvarchar(6),
@yci_usrid	nvarchar(30)
AS


delete from SYCONFTR
--where 	ycf_cocde = @ycf_cocde
where 	ycf_cocde = ' '
and 	ycf_code1= @ycf_code1
and 	ycf_code2 = @ycf_code2










GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYCONFTR] TO [ERPUSER] AS [dbo]
GO
