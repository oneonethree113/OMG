/****** Object:  StoredProcedure [dbo].[sp_select_TOITMDTL_CAN_Chk]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_TOITMDTL_CAN_Chk]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_TOITMDTL_CAN_Chk]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







/*
=================================================================
Program ID	: sp_select_TOITMDTL_CAN_Chk
Description	: Check TOITMDTL if Item has already been matched.
		  Return 'Y' if TO is valid for cancellation,
		  'N' otherwise.
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2014-05-12 	David Yue		SP Created
=================================================================
*/


CREATE procedure [dbo].[sp_select_TOITMDTL_CAN_Chk]
@cocde		varchar(6),
@toordno	varchar(30),
@usrid		varchar(30)

as

select	case (select count(*) from TOITMDTL (nolock) where tid_cocde = @cocde and tid_toordno = @toordno) when 0 then 'N' else 'Y' end as 'tid_exist',
	case (select count(*) from TOITMDTL (nolock) where tid_cocde = @cocde and tid_toordno = @toordno and tid_soqty > 0) when 0 then 'Y' else 'N' end as 'tid_valid'



GO
GRANT EXECUTE ON [dbo].[sp_select_TOITMDTL_CAN_Chk] TO [ERPUSER] AS [dbo]
GO
