/****** Object:  StoredProcedure [dbo].[sp_select_PKINVHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PKINVHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PKINVHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

















CREATE  procedure [dbo].[sp_select_PKINVHDR]
                                                                                                                                                                                                                                                                 
@pkgitem nvarchar(20)


---------------------------------------------- 

 
AS
 

begin

 select pih_pkgitm , pih_avlqty 
from PKINVHDR(NOLOCK)
where pih_pkgitm = @pkgitem
end













GO
GRANT EXECUTE ON [dbo].[sp_select_PKINVHDR] TO [ERPUSER] AS [dbo]
GO
