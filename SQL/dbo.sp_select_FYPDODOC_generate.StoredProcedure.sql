/****** Object:  StoredProcedure [dbo].[sp_select_FYPDODOC_generate]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_FYPDODOC_generate]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_FYPDODOC_generate]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=================================================================
Program ID	: sp_select_FYPDODOC_generate
Description	: Generate Filename for PDO
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2011-11-12 	David Yue		SP Created
=================================================================
*/


CREATE PROCEDURE [dbo].[sp_select_FYPDODOC_generate] 

@cocde  nvarchar(6),
@ftycde	nvarchar(10),
@filext	nvarchar(6),
@creusr	nvarchar(30)

AS

declare @gendat nvarchar(10)
set @gendat = convert(nvarchar(10),getdate(), 121)

declare @filnam nvarchar(50)
set @filnam = @ftycde + right('0' + ltrim(rtrim(str(datepart(mm,getdate())))), 2) + right('0' + ltrim(rtrim(str(datepart(dd,getdate())))), 2)


if (select count(*) from FYPDODOC (nolock) where fpd_ftycde = @ftycde and fpd_gendat = @gendat) = 0
begin
	if (select count(*) from FYPDODOC (nolock) where fpd_ftycde = @ftycde) = 0
	begin
		insert into FYPDODOC
		(	fpd_ftycde,	fpd_filseq,	fpd_gendat,	fpd_filnam,	
			fpd_creusr,	fpd_credat,	fpd_updusr,	fpd_upddat
		)
		values
		(	@ftycde,	1,		@gendat,	@filnam + '01' + @filext,
			@creusr,	getdate(),	@creusr,	getdate()
		)	
	end
	else
	begin
		update	FYPDODOC
		set	fpd_filseq = 1,
			fpd_gendat = @gendat,
			fpd_filnam = @filnam + '01' + @filext,
			fpd_updusr = @creusr,
			fpd_upddat = getdate()
		where	fpd_ftycde = @ftycde
	end
end
else
begin
	update	FYPDODOC
	set	fpd_filseq = fpd_filseq + 1,
		fpd_gendat = @gendat,
		fpd_filnam = @filnam + right('0' + ltrim(rtrim(str(fpd_filseq + 1))), 2) + @filext,
		fpd_updusr = @creusr,
		fpd_upddat = getdate()
	where	fpd_ftycde = @ftycde
end


select	fpd_filnam
from	FYPDODOC (nolock)
where	fpd_ftycde = @ftycde





GO
GRANT EXECUTE ON [dbo].[sp_select_FYPDODOC_generate] TO [ERPUSER] AS [dbo]
GO
