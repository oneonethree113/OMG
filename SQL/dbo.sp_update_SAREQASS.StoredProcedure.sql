/****** Object:  StoredProcedure [dbo].[sp_update_SAREQASS]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SAREQASS]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SAREQASS]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

/************************************************************************
Author:		Tommy Ho
Date:		8th Feb, 2002
Description:	Update data From SAREQASS
************************************************************************/

CREATE PROCEDURE [dbo].[sp_update_SAREQASS] 

@sra_cocde 	nvarchar(6),	@sra_reqno 	nvarchar(20),	
@sra_reqseq 	int,		@sra_itmno 	nvarchar(20),
@sra_assitm 	nvarchar(20),	@sra_assdsc 	nvarchar(800),	
@sra_cusitm	nvarchar(20),	@sra_colcde	nvarchar(30),
@sra_cussku           	nvarchar(20),	@sra_upcean      	nvarchar(15),
@sra_cusrtl	nvarchar(20),	@sra_untcde 	nvarchar(6),	
@sra_inrqty	int,		@sra_mtrqty	int,		
@sra_updusr	nvarchar(30)

AS

update  SAREQASS	set	sra_assdsc = @sra_assdsc,	sra_cusitm = @sra_cusitm,
			sra_cussku = @sra_cussku,	sra_upcean = @sra_upcean,
			sra_cusrtl = @sra_cusrtl,	sra_updusr = @sra_updusr,
			sra_upddat = GETDATE()	
where 	sra_cocde = @sra_cocde 	and	sra_reqno = @sra_reqno 	and
	sra_reqseq = @sra_reqseq 	and	sra_itmno = @sra_itmno 	and
	sra_assitm = @sra_assitm 	and	sra_colcde = @sra_colcde





GO
GRANT EXECUTE ON [dbo].[sp_update_SAREQASS] TO [ERPUSER] AS [dbo]
GO
