/****** Object:  StoredProcedure [dbo].[sp_select_SYUM]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYUM]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYUM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=================================================================
Program ID	: sp_select_SYUM
Description	: Retrieve SAP UM
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-12-23 	David Yue		SP Created
=================================================================
*/


CREATE PROCEDURE [dbo].[sp_select_SYUM] 

@cocde  nvarchar(6),
@creusr	nvarchar(30)

AS

select	'' as yum_status,
	yum_msehi,
	yum_msehte,
	yum_zaehl,
	yum_msehle,
	yum_creusr
from	SYUM (nolock)



GO
GRANT EXECUTE ON [dbo].[sp_select_SYUM] TO [ERPUSER] AS [dbo]
GO
