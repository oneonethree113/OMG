/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYMRKFML]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYMRKFML]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYMRKFML]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 28/07/2003




/************************************************************************
Author:		Samuel Chan
Date:		14th September, 2001
************************************************************************/
CREATE PROCEDURE [dbo].[sp_physical_delete_SYMRKFML] 

@ymf_cocde	nvarchar(6) = ' ',
@ymf_degvenno	nvarchar(6),
@ymf_prdvenno	nvarchar(6),
@ymf_seq		int


AS

delete from SYMRKFML
--where 	ymf_cocde = @ymf_cocde
where 	
ymf_cocde = ' '
and 	ymf_degvenno = @ymf_degvenno
and	ymf_prdvenno = @ymf_prdvenno
and	ymf_seq = @ymf_seq









GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYMRKFML] TO [ERPUSER] AS [dbo]
GO
