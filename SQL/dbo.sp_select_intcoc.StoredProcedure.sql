/****** Object:  StoredProcedure [dbo].[sp_select_intcoc]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_intcoc]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_intcoc]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[sp_select_intcoc]
@intcoc11	nvarchar(6)
AS

select * from intcoc  where intcoc11 = @intcoc11






GO
GRANT EXECUTE ON [dbo].[sp_select_intcoc] TO [ERPUSER] AS [dbo]
GO
