/****** Object:  StoredProcedure [dbo].[sp_insert_FYPDOHIS]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_FYPDOHIS]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_FYPDOHIS]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=================================================================
Program ID	: sp_insert_FYPDOHIS
Description	: Insert PDO File History
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2011-12-04 	David Yue		SP Created
=================================================================
*/


CREATE PROCEDURE [dbo].[sp_insert_FYPDOHIS] 

@cocde  nvarchar(6),
@batno	nvarchar(20),
@jobord	nvarchar(30),
@filnam	nvarchar(100),
@creusr	nvarchar(30)

AS

declare @gendat nvarchar(10)
set @gendat = ltrim(rtrim(str(datepart(yyyy, getdate())))) + '-' + right('0' + ltrim(rtrim(str(datepart(mm, getdate())))), 2) + '-' + right('0' + ltrim(rtrim(str(datepart(dd, getdate())))), 2)

insert into FYPDOHIS
(	fph_cocde,	fph_batno,	fph_jobord,
	fph_gendat,	fph_filnam,	fph_creusr,
	fph_credat
)
values
(	@cocde,		@batno,		@jobord,
	@gendat,	@filnam,	@creusr,
	getdate()
)




GO
GRANT EXECUTE ON [dbo].[sp_insert_FYPDOHIS] TO [ERPUSER] AS [dbo]
GO
