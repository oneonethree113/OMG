/****** Object:  StoredProcedure [dbo].[sp_physical_delete_PKESDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_PKESDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_PKESDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO








CREATE PROCEDURE [dbo].[sp_physical_delete_PKESDTL] 

@cocde	nvarchar(30),
@reqno 	nvarchar(30),
@reqseq	int

AS

 Delete from PKESDTL
where 
ped_cocde = @cocde and 
ped_reqno = @reqno and 
ped_reqseq = @reqseq



GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_PKESDTL] TO [ERPUSER] AS [dbo]
GO
