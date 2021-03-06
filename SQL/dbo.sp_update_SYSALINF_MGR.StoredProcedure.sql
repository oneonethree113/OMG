/****** Object:  StoredProcedure [dbo].[sp_update_SYSALINF_MGR]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYSALINF_MGR]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYSALINF_MGR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
=================================================================
Program ID	: sp_update_SYSALINF_MGR
Description	: Update Sales Manager Entry from SYSALINF
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-02-20	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_update_SYSALINF_MGR]
@cocde	varchar(6),
@saldiv	nvarchar(20),
@salmgr	nvarchar(30),
@creusr	nvarchar(30)

as

update	SYSALINF
set	ssi_salmgr = @salmgr,
	ssi_updusr = @creusr,
	ssi_upddat = getdate()
where	ssi_typ = 'MGR' and
	ssi_saldiv = @salmgr




GO
GRANT EXECUTE ON [dbo].[sp_update_SYSALINF_MGR] TO [ERPUSER] AS [dbo]
GO
