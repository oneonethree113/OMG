/****** Object:  StoredProcedure [dbo].[sp_select_CUCPTBKD_SC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUCPTBKD_SC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUCPTBKD_SC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








/*
=================================================================
Program ID	: sp_select_CUCPTBKD_SC
Description	: Retrieve Component Breakdown from CIH
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=========
========================================================
2014-01-08 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_select_CUCPTBKD_SC]
@cocde	varchar(6),
@cus1no	varchar(6),
@cus2no varchar(6),
@itmno	varchar(30),
@colcde varchar(20)
as

select	ccb_cocde,
	ccb_cus1no,
	ccb_cus2no,
	ccb_itmno,
	ccb_colcde,
	ccb_cpt,
	ccb_curcde,
	ccb_cst,
	ccb_cstpct,
	ccb_pct,
	ccb_creusr
from	CUCPTBKD (nolock)
where	ccb_cus1no = @cus1no and
	ccb_cus2no = @cus2no and
	ccb_itmno = @itmno and
	ccb_colcde = @colcde
	order by ccb_timstp



GO
GRANT EXECUTE ON [dbo].[sp_select_CUCPTBKD_SC] TO [ERPUSER] AS [dbo]
GO
