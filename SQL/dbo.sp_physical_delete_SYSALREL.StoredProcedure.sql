/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYSALREL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYSALREL]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYSALREL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
=================================================================
Program ID	: sp_physical_delete_SYSALREL
Description	: Delete Sales Rep Entry from SYSALREL
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-02-21 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_physical_delete_SYSALREL]
@cocde	varchar(6),
@saltem	nvarchar(20),
@salrep nvarchar(30),
@creusr	nvarchar(30)

as

delete
from	SYSALREL
where	ssr_saltem = @saltem and
	ssr_salrep = @salrep





GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYSALREL] TO [ERPUSER] AS [dbo]
GO
