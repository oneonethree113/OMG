/****** Object:  StoredProcedure [dbo].[sp_select_VNCTNPER_PG04]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_VNCTNPER_PG04]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_VNCTNPER_PG04]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






------------------------------------------------- 
CREATE PROCEDURE [dbo].[sp_select_VNCTNPER_PG04] 

@cocde  	nvarchar(6),
@venno		nvarchar(20)

AS


select vci_cntctp , vci_cntphn
from vncntinf 
where vci_venno = @venno
and vci_cntctp <>''

 





GO
GRANT EXECUTE ON [dbo].[sp_select_VNCTNPER_PG04] TO [ERPUSER] AS [dbo]
GO
