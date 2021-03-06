/****** Object:  StoredProcedure [dbo].[sp_update_TOORDDTL_tbc]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_TOORDDTL_tbc]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_TOORDDTL_tbc]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE    PROCEDURE [dbo].[sp_update_TOORDDTL_tbc] 


@tod_toordno		nvarchar(20),
@tod_toordseq 		int,
@tod_ftycst		decimal(13,4),
@tod_ftyprc		decimal(13,4),
@tod_basprc		decimal(13,4),
@tod_selprc		decimal(13,4),
@user			nvarchar(30)
AS

UPDATE	TOORDDTL
SET		tod_ftycst=@tod_ftycst,
		tod_ftyprc=@tod_ftyprc,
		tod_basprc=@tod_basprc,
		tod_selprc=@tod_selprc,
		tod_sts='CMP',
		tod_updusr =@user,
		tod_upddat = getdate()
		where
		tod_toordno= @tod_toordno	 and 
		 tod_toordseq  = @tod_toordseq  










GO
GRANT EXECUTE ON [dbo].[sp_update_TOORDDTL_tbc] TO [ERPUSER] AS [dbo]
GO
