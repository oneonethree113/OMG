/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYMUSRCO]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYMUSRCO]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYMUSRCO]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/****** Object:  Stored Procedure dbo.sp_physical_delete_SYMUSRCO    Script Date:06/10/2003 9:12:53 ******/
/*
=========================================================
Program ID	: sp_physical_delete_SYMUSRCO
Description   	: delete data from table SYMUSRCO
Programmer  	: Lewis To
Create Date   	: 10 June  2003
Last Modified  	: 
Table Read(s) 	: 
Table Write(s) 	:SYMUSRCO
=========================================================
 Modification History                                    
=========================================================
               
=========================================================     
*/


CREATE procedure [dbo].[sp_physical_delete_SYMUSRCO]
                                                                                                                                                                                                                                                               
--declare
@company		nvarchar(62),
@yuc_cocde	nvarchar(6),
@yuc_usrid	nvarchar(30)

AS

begin




Delete from SYMUSRCO
where( yuc_cocde = @yuc_cocde and yuc_usrid  = @yuc_usrid) or  (@yuc_cocde = 'ALL'  and yuc_usrid  = @yuc_usrid)

end

SET QUOTED_IDENTIFIER OFF 




GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYMUSRCO] TO [ERPUSER] AS [dbo]
GO
