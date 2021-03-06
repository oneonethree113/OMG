/****** Object:  StoredProcedure [dbo].[sp_select_SHCPTBKD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SHCPTBKD]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SHCPTBKD]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










/*
=================================================================
Program ID	: sp_select_SHCPTBKD
Description	: Retrieve Component Breakdown for SC
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-05-08 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_select_SHCPTBKD]
@cocde	varchar(6),
@ordno	varchar(20)
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
from	SHCPTBKD (nolock)
where	shb_cocde = @cocde and
	shb_ordno = @ordno
order by shb_ordseq, shb_cptseq







GO
GRANT EXECUTE ON [dbo].[sp_select_SHCPTBKD] TO [ERPUSER] AS [dbo]
GO
