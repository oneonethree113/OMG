/****** Object:  StoredProcedure [dbo].[sp_select_PKINVDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PKINVDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PKINVDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





------------------------------------------------- 
CREATE PROCEDURE [dbo].[sp_select_PKINVDTL] 

@cocde  	nvarchar(6)

AS


 

select pid_ordno , pid_ordseq , pid_stkqty as 'pih_avlqty'  ,  pid_pkgitm as 'pih_pkgitm' 
from PKINVDTL(nolock)
where  pid_latest = 'Y'    and pid_stkqty <> 0
order by pid_pkgitm , pid_ordno , pid_ordseq




GO
GRANT EXECUTE ON [dbo].[sp_select_PKINVDTL] TO [ERPUSER] AS [dbo]
GO
