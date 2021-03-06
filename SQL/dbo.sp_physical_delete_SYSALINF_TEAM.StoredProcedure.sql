/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYSALINF_TEAM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYSALINF_TEAM]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYSALINF_TEAM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
=================================================================
Program ID	: sp_physical_delete_SYSALINF_TEAM
Description	: Delete Sales Team Entry from SYSALINF
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-02-19 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_physical_delete_SYSALINF_TEAM]
@cocde	varchar(6),
@saltem	nvarchar(20),
@creusr	nvarchar(30)

as

delete
from	SYSALINF
where	ssi_typ = 'TEAM' and
	ssi_saltem = @saltem





GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYSALINF_TEAM] TO [ERPUSER] AS [dbo]
GO
