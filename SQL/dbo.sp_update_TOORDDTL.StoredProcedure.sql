/****** Object:  StoredProcedure [dbo].[sp_update_TOORDDTL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_TOORDDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_TOORDDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








CREATE   PROCEDURE [dbo].[sp_update_TOORDDTL] 


@tod_cocde		nvarchar(6),
@tod_toordno		nvarchar(20),
@tod_verno		int,
@tod_toordseq 		int,
@tod_projqty		int,
@tod_ftyshpdatstr	datetime,
@tod_ftyshpdatend	datetime,
@tod_cushpdatstr	datetime,
@tod_cushpdatend	datetime,
@tod_rmk		nvarchar(800),
@tod_dsgven		nvarchar(20),
@tod_prdven		nvarchar(20),
@tod_cusven		nvarchar(20),
@tod_podat		datetime,
@tod_cntctp		nvarchar(100),
@tod_match		nvarchar(20),
@user			nvarchar(30)
AS

UPDATE	TOORDDTL
SET		tod_projqty=@tod_projqty,
		 tod_ftyshpdatstr=@tod_ftyshpdatstr,
		tod_ftyshpdatend =@tod_ftyshpdatend,
		 tod_cushpdatstr= @tod_cushpdatstr	,
		tod_cushpdatend = @tod_cushpdatend, 
		tod_rmk  	= @tod_rmk,
		tod_dsgven =	@tod_dsgven,
		tod_prdven = @tod_prdven,
		tod_cusven = @tod_cusven,
		tod_podat = @tod_podat,
		tod_updusr =@user,
		tod_upddat = getdate(),
		tod_cntctp = @tod_cntctp,
		tod_match = @tod_match
		where
		tod_cocde = @tod_cocde and
		tod_toordno= @tod_toordno	 and 
		 tod_toordseq  = @tod_toordseq  and 
		tod_verno = @tod_verno and 
 		tod_latest = 'Y'









GO
GRANT EXECUTE ON [dbo].[sp_update_TOORDDTL] TO [ERPUSER] AS [dbo]
GO
