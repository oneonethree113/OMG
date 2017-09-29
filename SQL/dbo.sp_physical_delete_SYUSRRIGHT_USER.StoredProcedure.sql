/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYUSRRIGHT_USER]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYUSRRIGHT_USER]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYUSRRIGHT_USER]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









/************************************************************************
Author:		Joe Yim
Date:		15th April, 2010
Description:	Delete data to SYUSRRIGHT

************************************************************************/
CREATE     PROCEDURE [dbo].[sp_physical_delete_SYUSRRIGHT_USER] 
@yur_cocde	nvarchar(6) = ' ',
@yur_usrid	nvarchar(30)

AS

delete from SYUSRRIGHT
where	yur_usrid= @yur_usrid






GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYUSRRIGHT_USER] TO [ERPUSER] AS [dbo]
GO
