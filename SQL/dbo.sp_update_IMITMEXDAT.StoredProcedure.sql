/****** Object:  StoredProcedure [dbo].[sp_update_IMITMEXDAT]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMITMEXDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMITMEXDAT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE procedure [dbo].[sp_update_IMITMEXDAT]
                                                                                                                                                                                                                                                                 
------------------------------------------------------- 
@ied_cocde	nvarchar(6),
@ied_venno	nvarchar(6),
@ied_ucpno	nvarchar(20),
@ied_itmseq	int,
@ied_recseq	int,
@ied_stage	nvarchar(3),
@ied_updusr	nvarchar(30)                                 
------------------------------------------------------- 
AS
 
Update	IMITMEXDAT
Set
	ied_stage = @ied_stage, 
	ied_updusr = @ied_updusr,	
	ied_upddat = getdate() 
Where 
	ied_venno = @ied_venno and
	ied_ucpno = @ied_ucpno and 
	ied_itmseq = @ied_itmseq and 	
	ied_recseq = @ied_recseq

-----------------------------------------------------





GO
GRANT EXECUTE ON [dbo].[sp_update_IMITMEXDAT] TO [ERPUSER] AS [dbo]
GO
