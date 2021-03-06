/****** Object:  StoredProcedure [dbo].[sp_update_TOORDHDR]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_TOORDHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_TOORDHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[sp_update_TOORDHDR] 


@toh_cocde		nvarchar(6),
@toh_toordno		nvarchar(20),
@user			nvarchar(30)
AS

UPDATE	TOORDHDR
SET		toh_upddat = getdate(),
		toh_updusr = @user,
		toh_rvsdat = getdate()
		where
		toh_cocde = @toh_cocde and
		toh_toordno= @toh_toordno

GO
GRANT EXECUTE ON [dbo].[sp_update_TOORDHDR] TO [ERPUSER] AS [dbo]
GO
