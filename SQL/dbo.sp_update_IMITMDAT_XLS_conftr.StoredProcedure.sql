/****** Object:  StoredProcedure [dbo].[sp_update_IMITMDAT_XLS_conftr]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMITMDAT_XLS_conftr]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMITMDAT_XLS_conftr]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO













/*
=================================================================
Program ID	: sp_update_IMITMDAT_XLS
Description	: Update IMITMDAT conftr  after Excel Upload
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
*/

CREATE  PROCEDURE [dbo].[sp_update_IMITMDAT_XLS_conftr] 

@cocde		nvarchar(6),
@usrid		nvarchar(30)

AS


	-- Update IMITMDAT --
	update	IMITMDAT
	set	iid_conftr = 1
	where	iid_itmtyp = 'REG'





GO
GRANT EXECUTE ON [dbo].[sp_update_IMITMDAT_XLS_conftr] TO [ERPUSER] AS [dbo]
GO
