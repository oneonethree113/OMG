/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYUSRRIGHT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYUSRRIGHT]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYUSRRIGHT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/************************************************************************
Author:		Joe Yim
Date:		15th April, 2010
Description:	Delete data to SYUSRRIGHT

************************************************************************/
CREATE   PROCEDURE [dbo].[sp_physical_delete_SYUSRRIGHT] 
@yur_cocde	nvarchar(6) = ' ',
@yur_cogrp	nvarchar(6),
@yur_usrid	nvarchar(30),
@yur_doctyp	nvarchar(2),
@yur_lvl		int,
@yur_para		nvarchar(30),
@yur_updusr	 nvarchar(30)

AS


delete from SYUSRRIGHT
where	yur_cogrp = @yur_cogrp
and 	yur_usrid= @yur_usrid
and	yur_doctyp=@yur_doctyp
and	yur_lvl=@yur_lvl
and	yur_para=@yur_para




GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYUSRRIGHT] TO [ERPUSER] AS [dbo]
GO
