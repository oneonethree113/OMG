/****** Object:  StoredProcedure [dbo].[sp_insert_SYSALINF_TEAM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYSALINF_TEAM]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYSALINF_TEAM]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
=================================================================
Program ID	: sp_insert_SYSALINF_TEAM
Description	: Insert Sales Team Entry from SYSALINF
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-02-19 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_insert_SYSALINF_TEAM]
@cocde	varchar(6),
@saldiv	nvarchar(20),
@saltem	nvarchar(30),
@creusr	nvarchar(30)

as

insert into SYSALINF
(	ssi_cocde,		ssi_typ,	ssi_saldiv,
	ssi_saltem,	ssi_salmgr,	ssi_creusr,
	ssi_updusr,	ssi_credat,	ssi_upddat
)
values
(	'',		'TEAM',		@saldiv,
	@saltem,	'',		@creusr,
	@creusr,	getdate(),	getdate()
)




GO
GRANT EXECUTE ON [dbo].[sp_insert_SYSALINF_TEAM] TO [ERPUSER] AS [dbo]
GO
