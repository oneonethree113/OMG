/****** Object:  StoredProcedure [dbo].[sp_select_syftycde]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_syftycde]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_syftycde]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_select_syftycde] 
@yfd_ftycde nvarchar(4),
@yfd_usrcde nvarchar(10)
AS

select yfd_ftypwd from syftycde where yfd_ftycde = @yfd_ftycde and yfd_usrcde = @yfd_usrcde






GO
GRANT EXECUTE ON [dbo].[sp_select_syftycde] TO [ERPUSER] AS [dbo]
GO
