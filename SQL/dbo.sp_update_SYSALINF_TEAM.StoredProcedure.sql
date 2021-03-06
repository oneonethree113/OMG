/****** Object:  StoredProcedure [dbo].[sp_update_SYSALINF_TEAM]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYSALINF_TEAM]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYSALINF_TEAM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
=================================================================
Program ID	: sp_update_SYSALINF_TEAM
Description	: Update Sales Team Entry from SYSALINF
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-02-19	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_update_SYSALINF_TEAM]
@cocde	varchar(6),
@saldiv	nvarchar(20),
@saltem	nvarchar(20),
@creusr	nvarchar(30)

as

update	SYSALINF
set	ssi_saldiv = @saldiv,
	ssi_updusr = @creusr,
	ssi_upddat = getdate()
where	ssi_typ = 'TEAM' and
	ssi_saltem = @saltem




GO
GRANT EXECUTE ON [dbo].[sp_update_SYSALINF_TEAM] TO [ERPUSER] AS [dbo]
GO
