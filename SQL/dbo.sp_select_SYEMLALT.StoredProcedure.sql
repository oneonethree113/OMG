/****** Object:  StoredProcedure [dbo].[sp_select_SYEMLALT]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYEMLALT]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYEMLALT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_select_SYEMLALT]
	@type nvarchar(2)
AS
BEGIN

	select * from SYEMLALT
	where sea_type = @type
END


GO
GRANT EXECUTE ON [dbo].[sp_select_SYEMLALT] TO [ERPUSER] AS [dbo]
GO
