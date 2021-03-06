/****** Object:  StoredProcedure [dbo].[sp_select_QCREQACT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCREQACT]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCREQACT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









/************************************************************************
Author:		Henry Li  
Date:		03/02/2017
Description:	Select data From QCREQACT
***********************************************************************
*/

CREATE procedure [dbo].[sp_select_QCREQACT]


@inspyear smallint,
@inspweek smallint

 
AS

BEGIN

--------------------------------------------------------------------------------------------------


SELECT [qca_cocde]
      ,[qca_qcno]
      ,[qca_verno]
      ,[qca_usr]
      ,[qca_oldsts]
      ,[qca_newsts]
      ,[qca_actdat]
  FROM [dbo].[QCREQACT] 
  where [qca_alert]='E' and [qca_inspyear]=@inspyear and [qca_inspweek]=@inspweek
  order by [qca_actdat] DESC
END







GO
GRANT EXECUTE ON [dbo].[sp_select_QCREQACT] TO [ERPUSER] AS [dbo]
GO
