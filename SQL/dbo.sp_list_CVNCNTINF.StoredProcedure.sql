/****** Object:  StoredProcedure [dbo].[sp_list_CVNCNTINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_CVNCNTINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_CVNCNTINF]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






--Hong

CREATE PROCEDURE [dbo].[sp_list_CVNCNTINF] 

@vci_cocde 	nvarchar(6),
@vci_venno	nvarchar(6)

AS

Select 
vci_cntctp 
from VNCNTINF
where 
vci_cocde = ' '	and --@vci_cocde and
vci_venno = @vci_venno and
vci_cnttyp <> 'M' and
vci_cnttyp <> 'U' 
order by vci_seq





GO
GRANT EXECUTE ON [dbo].[sp_list_CVNCNTINF] TO [ERPUSER] AS [dbo]
GO
