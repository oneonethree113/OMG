/****** Object:  StoredProcedure [dbo].[sp_physical_delete_VNCSEINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_VNCSEINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_VNCSEINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003




CREATE PROCEDURE [dbo].[sp_physical_delete_VNCSEINF] 

@vcs_cocde 	nvarchar(6),
@vcs_venno 	nvarchar(6),
@vcs_csetyp 	nvarchar(2),
@vcs_cseseq	int

AS

delete from VNCSEINF
where 	
	--vcs_cocde 	= @vcs_cocde and 
	vcs_venno 	= @vcs_venno
and 	vcs_csetyp	= @vcs_csetyp
and 	vcs_cseseq 	= @vcs_cseseq








GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_VNCSEINF] TO [ERPUSER] AS [dbo]
GO
