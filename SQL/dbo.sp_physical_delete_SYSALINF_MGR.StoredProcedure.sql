/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYSALINF_MGR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYSALINF_MGR]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYSALINF_MGR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
=================================================================
Program ID	: sp_physical_delete_SYSALINF_MGR
Description	: Delete Sales Manager Entry from SYSALINF
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-02-20 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_physical_delete_SYSALINF_MGR]
@cocde	varchar(6),
@saldiv	nvarchar(20),
@creusr	nvarchar(30)

as

delete
from	SYSALINF
where	ssi_typ = 'MGR' and
	ssi_saldiv = @saldiv





GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYSALINF_MGR] TO [ERPUSER] AS [dbo]
GO
