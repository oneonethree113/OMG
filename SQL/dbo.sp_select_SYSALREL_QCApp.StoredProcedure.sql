/****** Object:  StoredProcedure [dbo].[sp_select_SYSALREL_QCApp]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYSALREL_QCApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYSALREL_QCApp]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_select_SYSALREL_QCApp]

AS

BEGIN

SELECT
 ssr_cocde
,ssr_saldiv
,ssr_salmgr
,ssr_saltem
,ssr_salrep
,ssr_default
,ssr_creusr
,ssr_updusr
,convert(char, ssr_credat,120) ssr_credat
,convert(char, ssr_upddat,120) ssr_upddat
,null ssr_timstp
FROM	SYSALREL 

END

SET QUOTED_IDENTIFIER OFF 

GO
GRANT EXECUTE ON [dbo].[sp_select_SYSALREL_QCApp] TO [ERPUSER] AS [dbo]
GO
