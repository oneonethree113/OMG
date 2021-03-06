/****** Object:  StoredProcedure [dbo].[sp_physical_delete_CUCPTBKD]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_CUCPTBKD]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_CUCPTBKD]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







/*
=================================================================
Program ID	: sp_physical_delete_CUCPTBKD
Description	: Remove Selected Component Breakdown from CIH
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2014-01-09 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_physical_delete_CUCPTBKD]
@cocde	varchar(6),
@cus1no	varchar(6),
@cus2no varchar(6),
@itmno	varchar(30),
@colcde varchar(20),
@creusr varchar(30)
as

delete
from	CUCPTBKD
where	ccb_cus1no = @cus1no and
	ccb_cus2no = @cus2no and
	ccb_itmno = @itmno and
	ccb_colcde = @colcde



GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_CUCPTBKD] TO [ERPUSER] AS [dbo]
GO
