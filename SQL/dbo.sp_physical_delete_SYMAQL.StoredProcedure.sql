/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYMAQL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYMAQL]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYMAQL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_physical_delete_SYMAQL]

@yal_cocde	nvarchar(6),
@yal_lotfm int,
@yal_lotto int

AS

BEGIN

delete from SYMAQL 
where 
yal_lotfm = @yal_lotfm
and yal_lotto = @yal_lotto 


END






----------------------------


GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYMAQL] TO [ERPUSER] AS [dbo]
GO
