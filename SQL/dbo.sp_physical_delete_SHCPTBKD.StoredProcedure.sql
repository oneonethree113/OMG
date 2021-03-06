/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SHCPTBKD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SHCPTBKD]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SHCPTBKD]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










/*
=================================================================
Program ID	: sp_physical_delete_SHCPTBKD
Description	: Delete entry from SHCPTBKD
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-07-18	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_physical_delete_SHCPTBKD]
@cocde	varchar(6),
@ordno	varchar(20),
@ordseq	int,
@cptseq int

as

delete from SHCPTBKD
where	shb_cocde = @cocde and
	shb_ordno = @ordno and
	shb_ordseq = @ordseq and
	shb_cptseq = @cptseq








GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SHCPTBKD] TO [ERPUSER] AS [dbo]
GO
