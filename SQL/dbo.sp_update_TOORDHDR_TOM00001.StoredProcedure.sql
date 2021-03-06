/****** Object:  StoredProcedure [dbo].[sp_update_TOORDHDR_TOM00001]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_TOORDHDR_TOM00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_TOORDHDR_TOM00001]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[sp_update_TOORDHDR_TOM00001] 


@toh_cocde		nvarchar(6),
@toh_toordno		nvarchar(20),
@TO			nvarchar(100),
@CC			nvarchar(100),
@FM			nvarchar(100),
@rmk			nvarchar(300),
@buyer			nvarchar(20),
@user			nvarchar(30)
AS

UPDATE	TOORDHDR
SET		toh_upddat = getdate(),
		toh_updusr = @user,
		toh_to = @TO,
		toh_cc = @CC,
		toh_fm = @FM,
		toh_rmk = @rmk,
		toh_buyer = @buyer,
		toh_rvsdat = getdate()
		where
		toh_cocde = @toh_cocde and
		toh_toordno= @toh_toordno

GO
GRANT EXECUTE ON [dbo].[sp_update_TOORDHDR_TOM00001] TO [ERPUSER] AS [dbo]
GO
