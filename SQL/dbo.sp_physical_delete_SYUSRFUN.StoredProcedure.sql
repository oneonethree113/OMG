/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYUSRFUN]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYUSRFUN]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYUSRFUN]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_physical_delete_SYUSRFUN] 

@yuf_cocde 	nvarchar(6),
@yuf_usrfun 	nvarchar(10),
@yuf_creusr	nvarchar(30)


AS


delete from SYUSRFUN
where 	yuf_cocde = @yuf_cocde
and 	yuf_usrfun = @yuf_usrfun



GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYUSRFUN] TO [ERPUSER] AS [dbo]
GO
