/****** Object:  StoredProcedure [dbo].[sp_select_PGM00005_Check]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PGM00005_Check]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PGM00005_Check]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



------------------------------------------------- 
CREATE PROCEDURE [dbo].[sp_select_PGM00005_Check] 

@cocde  	nvarchar(6),
@from	  	nvarchar(20),
@to		nvarchar(20)

AS


select pgd_cocde , pgd_grpno ,  pgd_grpseq,
          pgd_reqno , pgd_reqseq
from PKGRPDTL (NOLOCK)
where pgd_cocde = @cocde and pgd_reqno between @from and @to
order by  pgd_grpseq




GO
GRANT EXECUTE ON [dbo].[sp_select_PGM00005_Check] TO [ERPUSER] AS [dbo]
GO
