/****** Object:  StoredProcedure [dbo].[sp_physical_delete_PKREQDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_PKREQDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_PKREQDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







-- Checked by Allan Yuen at 28/07/2003


CREATE PROCEDURE [dbo].[sp_physical_delete_PKREQDTL] 

@prd_cocde 	nvarchar(20),
@prd_reqno 	nvarchar(20),
@prd_seq 	int

AS

delete from PKREQDTL
where 	
	--vci_cocde 	= @vci_cocde and
	prd_cocde 	= @prd_cocde
and 	prd_reqno	= @prd_reqno
and 	prd_seq		=@prd_seq




 





GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_PKREQDTL] TO [ERPUSER] AS [dbo]
GO
