/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYMSHC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYMSHC]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYMSHC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









/************************************************************************
Author:		Marco Chan
Date:		15th February, 2011
Description:	insert data into SYMSHC
***********************************************************************
*/


CREATE procedure [dbo].[sp_physical_delete_SYMSHC]


@ysc_cocde	nvarchar(6),
@ysc_chgcde	nvarchar(20),
@ysc_usrid	nvarchar(30)

 
AS

BEGIN

--------------------------------------------------------------------------------------------------

delete FROM	SYMSHC WHERE	ysc_chgcde = @ysc_chgcde


END








GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYMSHC] TO [ERPUSER] AS [dbo]
GO
