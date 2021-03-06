/****** Object:  StoredProcedure [dbo].[sp_select_SYCDCHDR]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYCDCHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYCDCHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/************************************************************************
Author:		Frankie Cheung
Date:		28th November, 2008
Description:	Select data From SYCDCHDR

************************************************************************/

CREATE procedure [dbo].[sp_select_SYCDCHDR]                                                                                                                                                                                                                                                                

@idd_cocde	nvarchar(6)  = ' '                                               
 
AS

begin

Select	                         
	idh_year,
	idh_cdcde,
	idh_engdsc,
	idh_chndsc,
	idh_creusr,
	idh_updusr,
	idh_credat,
	idh_upddat
from  SYCDCHDR                        
order by 
idh_year, idh_cdcde

end


GO
GRANT EXECUTE ON [dbo].[sp_select_SYCDCHDR] TO [ERPUSER] AS [dbo]
GO
