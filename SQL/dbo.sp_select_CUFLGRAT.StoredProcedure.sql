/****** Object:  StoredProcedure [dbo].[sp_select_CUFLGRAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUFLGRAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUFLGRAT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/***********************************************************************************
Author:		Frankie Cheung
Date:		10th December, 2008
Description:	Select data From CUFLGRAT (Customer Flight Rate)
************************************************************************************
*/

CREATE procedure [dbo].[sp_select_CUFLGRAT]

@cfr_cocde	nvarchar(6),
@cfr_cusno	nvarchar(6)
 
AS

BEGIN

--------------------------------------------------------------------------------------------------


SELECT	
'' as cfr_del,
cfr_cocde,
cfr_cusno,
cfr_prctrm,
cfr_flgrat,
cfr_creusr,
cfr_updusr,
cfr_credat,
convert(varchar(20), cfr_upddat, 101) as 'cfr_upddat'

from CUFLGRAT
where	
cfr_cusno = @cfr_cusno
order by cfr_cusno, cfr_prctrm

END


GO
GRANT EXECUTE ON [dbo].[sp_select_CUFLGRAT] TO [ERPUSER] AS [dbo]
GO
