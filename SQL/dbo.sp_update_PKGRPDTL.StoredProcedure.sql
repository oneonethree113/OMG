/****** Object:  StoredProcedure [dbo].[sp_update_PKGRPDTL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_PKGRPDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_PKGRPDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE procedure [dbo].[sp_update_PKGRPDTL]
@pgd_cocde nvarchar(6),
@pgd_grpno nvarchar(20),
@pgd_grpseq int,
@pgd_ordno nvarchar(20),
@pgd_ordseq int,
@pgd_reqno nvarchar(20),
@pgd_reqseq int,
@pgd_creusr nvarchar(30)

as



update PKGRPDTL set 
pgd_ordno = @pgd_ordno, pgd_ordseq = @pgd_ordseq,
pgd_reqno = @pgd_reqno, pgd_reqseq = @pgd_reqseq,
pgd_updusr = @pgd_creusr, pgd_upddat = getdate()
where pgd_cocde = @pgd_cocde and pgd_grpno = @pgd_grpno and pgd_grpseq = @pgd_grpseq




GO
GRANT EXECUTE ON [dbo].[sp_update_PKGRPDTL] TO [ERPUSER] AS [dbo]
GO
