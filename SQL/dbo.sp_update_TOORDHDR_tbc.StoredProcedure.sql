/****** Object:  StoredProcedure [dbo].[sp_update_TOORDHDR_tbc]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_TOORDHDR_tbc]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_TOORDHDR_tbc]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE    PROCEDURE [dbo].[sp_update_TOORDHDR_tbc] 


@toh_toordno		nvarchar(20),
@user			nvarchar(30)
AS

		UPDATE	TOORDHDR
		SET	toh_ordsts = 'REL',
			toh_upddat = getdate(),
			toh_updusr = @user,
			toh_rvsdat = getdate()
			
		where toh_toordno = @toh_toordno

GO
GRANT EXECUTE ON [dbo].[sp_update_TOORDHDR_tbc] TO [ERPUSER] AS [dbo]
GO
