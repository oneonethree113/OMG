/****** Object:  StoredProcedure [dbo].[sp_select_IMM00015_IMMBDEXDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMM00015_IMMBDEXDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMM00015_IMMBDEXDAT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=================================================================
Program ID	: sp_select_IMM00015_IMMBDEXDAT
Description	: Retrieve IMMBDEXDAT Data from IM
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2014-12-04 	David Yue		SP Created
=================================================================
*/


CREATE PROCEDURE [dbo].[sp_select_IMM00015_IMMBDEXDAT] 

@itmno	nvarchar(30)

AS

select	ibm_itmno,
	ibm_mat,
	ibm_cstper,
	ibm_curcde,
	ibm_cst,
	ibm_wgtper
from	IMMATBKD (nolock)
where	ibm_itmno = @itmno


GO
GRANT EXECUTE ON [dbo].[sp_select_IMM00015_IMMBDEXDAT] TO [ERPUSER] AS [dbo]
GO
