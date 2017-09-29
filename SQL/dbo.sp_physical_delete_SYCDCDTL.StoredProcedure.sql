/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCDCDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYCDCDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYCDCDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[sp_physical_delete_SYCDCDTL] 

@idd_cocde	 nvarchar(6) = ' ',
@idd_year	nvarchar(4),
@idd_cdcde	nvarchar(6),
@idd_seq	nvarchar(6),
@updusr	nvarchar(30)
AS

Delete from SYCDCDTL

where 	idd_cocde = ' ' and
 	idd_year= @idd_year and
	idd_cdcde = @idd_cdcde and
	idd_seq = @idd_seq




GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYCDCDTL] TO [ERPUSER] AS [dbo]
GO
