/****** Object:  StoredProcedure [dbo].[sp_select_SHASSINF_cov]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHASSINF_cov]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHASSINF_cov]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[sp_select_SHASSINF_cov]
@ordno	varchar(20),
@hai_shpseq INT
as
select	*

from	SHASSINF_cov (nolock)
where	
	hai_shpno = @ordno AND
	hai_shpseq = @hai_shpseq










GO
GRANT EXECUTE ON [dbo].[sp_select_SHASSINF_cov] TO [ERPUSER] AS [dbo]
GO
