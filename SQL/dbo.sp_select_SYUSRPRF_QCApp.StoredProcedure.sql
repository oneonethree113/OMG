/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRPRF_QCApp]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYUSRPRF_QCApp]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRPRF_QCApp]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_select_SYUSRPRF_QCApp]

AS

BEGIN

SELECT
 yup_cocde
,yup_usrid
,yup_usrnam
,yup_paswrd
,yup_paswrd1
,yup_paswrd2
,convert(char, yup_expdat,120) yup_expdat
,yup_usrgrp
,yup_usrank
,yup_supid
,yup_flgcst
,yup_flgrel
,yup_mailad
,convert(char, yup_accexp,120) yup_accexp
,yup_creusr
,yup_updusr
,convert(char, yup_credat,120) yup_credat
,convert(char, yup_upddat,120) yup_upddat
,null yup_timstp
FROM	SYUSRPRF 

END

SET QUOTED_IDENTIFIER OFF 

GO
GRANT EXECUTE ON [dbo].[sp_select_SYUSRPRF_QCApp] TO [ERPUSER] AS [dbo]
GO
