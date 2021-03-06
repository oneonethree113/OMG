/****** Object:  StoredProcedure [dbo].[sp_physical_delete_FLDOCATT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_FLDOCATT]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_FLDOCATT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









/*
=================================================================
Program ID	: sp_physical_delete_FLDOCATT
Description	: Delete File Document Attachments Records
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2014-05-05 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_physical_delete_FLDOCATT]
@cocde		nvarchar(6),
@docno		nvarchar(20),
@module		nvarchar(6),
@filpath	nvarchar(100),
@usrid		nvarchar(30)

as

delete
from	FLDOCATT
where	fda_cocde = @cocde and
	fda_docno = @docno and
	fda_module = @module and
	fda_filpath = @filpath




GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_FLDOCATT] TO [ERPUSER] AS [dbo]
GO
