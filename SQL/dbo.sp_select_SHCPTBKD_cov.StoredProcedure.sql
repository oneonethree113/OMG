/****** Object:  StoredProcedure [dbo].[sp_select_SHCPTBKD_cov]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHCPTBKD_cov]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHCPTBKD_cov]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE   procedure [dbo].[sp_select_SHCPTBKD_cov]
@cocde	varchar(6),
@ordno	varchar(20),
@shb_ordseq INT
as

select	'' as 'shb_status',
	shb_cocde,
	shb_ordno,
	shb_ordseq,
	shb_itmno,
	shb_cptseq,
	shb_cpt,
	shb_curcde,
	shb_cst,
	shb_cstpct,
	shb_pct,
	shb_creusr
from	SHCPTBKD_cov (nolock)
where	shb_cocde = @cocde and
	shb_ordno = @ordno AND
	shb_ordseq = @shb_ordseq
order by shb_ordseq, shb_cptseq









GO
GRANT EXECUTE ON [dbo].[sp_select_SHCPTBKD_cov] TO [ERPUSER] AS [dbo]
GO
