/****** Object:  StoredProcedure [dbo].[sp_insert_FLDOCATT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_FLDOCATT]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_FLDOCATT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









/*
=================================================================
Program ID	: sp_insert_FLDOCATT
Description	: Insert File Document Attachments Records
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2014-05-05 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_insert_FLDOCATT]
@cocde		nvarchar(6),
@docno		nvarchar(20),
@module		nvarchar(6),
@filpath	nvarchar(100),
@chkdat		nvarchar(50),
@usrid		nvarchar(30)

as

insert into FLDOCATT
(	fda_cocde,		fda_docno,		fda_module,
	fda_key,		fda_filpath,		fda_chkdat,
	fda_creusr,		fda_updusr,		fda_credat,
	fda_upddat
)
values
(	@cocde,			@docno,			@module,
	'',			@filpath,		@chkdat,
	left(@usrid, 30),	left(@usrid, 30),	getdate(),
	getdate()
)





GO
GRANT EXECUTE ON [dbo].[sp_insert_FLDOCATT] TO [ERPUSER] AS [dbo]
GO
