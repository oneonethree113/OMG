/****** Object:  StoredProcedure [dbo].[sp_physical_delete_VNCNTINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_VNCNTINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_VNCNTINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 28/07/2003


CREATE PROCEDURE [dbo].[sp_physical_delete_VNCNTINF] 

@vci_cocde 	nvarchar(6),
@vci_venno 	nvarchar(6),
@vci_cnttyp 	nvarchar(6),
@vci_seq		int

AS

delete from VNCNTINF
where 	
	--vci_cocde 	= @vci_cocde and
	vci_venno 	= @vci_venno
and 	vci_cnttyp	= @vci_cnttyp
and 	vci_seq 		= @vci_seq








GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_VNCNTINF] TO [ERPUSER] AS [dbo]
GO
