/****** Object:  StoredProcedure [dbo].[sp_select_SCCPTBKD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCCPTBKD]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCCPTBKD]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
=================================================================
Program ID	: sp_select_SCCPTBKD
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


CREATE procedure [dbo].[sp_select_SCCPTBKD]
@cocde	varchar(6),
@ordno	varchar(20)
as

select	'' as 'scb_status',
	scb_cocde,
	scb_ordno,
	scb_ordseq,
	scb_itmno,
	scb_cptseq,
	scb_cpt,
	scb_curcde,
	scb_cst,
	scb_cstpct,
	scb_pct,
	scb_ordseq as 'scb_ordseq2',
	scb_creusr
from	SCCPTBKD (nolock)
where	scb_cocde = @cocde and
	scb_ordno = @ordno
order by scb_ordseq, scb_cptseq




GO
GRANT EXECUTE ON [dbo].[sp_select_SCCPTBKD] TO [ERPUSER] AS [dbo]
GO
