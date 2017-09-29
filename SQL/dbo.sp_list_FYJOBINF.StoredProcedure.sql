/****** Object:  StoredProcedure [dbo].[sp_list_FYJOBINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_FYJOBINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_FYJOBINF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

/************************************************************************
Author:		Johnson Lai	
Date:		Mar 03, 2002
Description:	Select data From FYJOBINF
************************************************************************/

CREATE procedure [dbo].[sp_list_FYJOBINF]
                                                                                                                                                                                                                                                               
@fji_cocde nvarchar(6),
@fji_creusr nvarchar(30)
 
AS
begin


select * from FYJOBINF

where 

fji_cocde = @fji_cocde and 

fji_creusr = @fji_creusr

end




GO
GRANT EXECUTE ON [dbo].[sp_list_FYJOBINF] TO [ERPUSER] AS [dbo]
GO
