/****** Object:  StoredProcedure [dbo].[sp_select_VNCNTINF]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_VNCNTINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_VNCNTINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO






/************************************************************************
Author:		Tommy Ho
Date:		31st Jan, 2002	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_select_VNCNTINF]
                                                                                                                                                                                                                                                                 
@cocde nvarchar(6) ,
@venno nvarchar(6) 
                                               
 
AS

begin

select vci_cntctp from vncntinf 
where 	
--	vci_cocde = @cocde and 
	vci_venno = @venno and 
	vci_cnttyp <> 'M' and vci_cnttyp <> 'U'
order by vci_seq
end






GO
GRANT EXECUTE ON [dbo].[sp_select_VNCNTINF] TO [ERPUSER] AS [dbo]
GO
