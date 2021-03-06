/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SCBOMINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SCBOMINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SCBOMINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/************************************************************************
Author:		Allan Yuen
Date:		2004-09-08
Description:	Delete data From SCBOMINF
Parameter:	
************************************************************************/
CREATE PROCEDURE [dbo].[sp_physical_delete_SCBOMINF] 

@sbi_cocde 	nvarchar(6),
@sbi_ordno 	nvarchar(20),
@sbi_ordseq 	int,
@sbi_itmno	nvarchar(20) = null,
@sbi_assitm	nvarchar(20) = null,
@sbi_bomitm	nvarchar(20) = null,
@sbi_colcde	nvarchar(30) = null


AS

if @sbi_itmno is null 
begin
	delete from 
		SCBOMINF
	where 	
		sbi_cocde = @sbi_cocde and
		sbi_ordno = @sbi_ordno and
		sbi_ordseq = @sbi_ordseq
end
else
begin
	delete from 
		SCBOMINF
	where 	
		sbi_cocde = @sbi_cocde and
		sbi_ordno = @sbi_ordno and
		sbi_ordseq = @sbi_ordseq and
		sbi_itmno = @sbi_itmno and
		sbi_assitm = @sbi_assitm and
		sbi_bomitm = @sbi_bomitm and
		sbi_colcde	= @sbi_colcde

end





GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SCBOMINF] TO [ERPUSER] AS [dbo]
GO
