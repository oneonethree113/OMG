/****** Object:  StoredProcedure [dbo].[sp_select_FLDOCATT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_FLDOCATT]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_FLDOCATT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









/*
=================================================================
Program ID	: sp_select_FLDOCATT
Description	: Retrieve File Document Attachments
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2014-05-02 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_select_FLDOCATT]
@cocde		nvarchar(6),
@docno		nvarchar(20),
@module		nvarchar(6),
@usrid		nvarchar(30)

as

select	'' as 'fda_del',
	'' as 'fda_filnam',
	fda_filpath,
	fda_chkdat
from	FLDOCATT (nolock)
where	fda_cocde = @cocde and
	fda_docno = @docno and
	fda_module = @module
order by fda_key





GO
GRANT EXECUTE ON [dbo].[sp_select_FLDOCATT] TO [ERPUSER] AS [dbo]
GO
