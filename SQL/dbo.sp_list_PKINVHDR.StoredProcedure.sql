/****** Object:  StoredProcedure [dbo].[sp_list_PKINVHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_PKINVHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_PKINVHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




------------------------------------------------- 
CREATE PROCEDURE [dbo].[sp_list_PKINVHDR] 

@cocde  	nvarchar(6)

AS


select pih_cocde,pih_pkgitm,pih_venno,pih_cus1no,pih_avlqty
from PKINVHDR(NOLOCK)




GO
GRANT EXECUTE ON [dbo].[sp_list_PKINVHDR] TO [ERPUSER] AS [dbo]
GO
