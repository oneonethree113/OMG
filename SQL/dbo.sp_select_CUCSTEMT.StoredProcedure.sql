/****** Object:  StoredProcedure [dbo].[sp_select_CUCSTEMT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUCSTEMT]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUCSTEMT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/************************************************************************
Author:		Lester Wu    
Date:		12th September, 2008
Description:	Select data From CUCSTEMT
***********************************************************************
*/

CREATE procedure [dbo].[sp_select_CUCSTEMT]


@cce_cocde	nvarchar(6),
@cce_cusno	nvarchar(6)

 
AS

BEGIN

--------------------------------------------------------------------------------------------------


SELECT	
'' as cce_del,
cce_cusno,
cce_seq,
cce_cecde,
ysi_dsc as 'cce_cedsc',
cce_percent,
cce_curcde,
cce_amt,
cce_chg,
cce_creusr,
cce_updusr,
cce_credat,
cce_upddat,
cast(cce_timstp as int) as cce_timstp
from CUCSTEMT
left join SYSETINF on ysi_cde = cce_cecde and ysi_typ = '17'
where	
cce_cusno = @cce_cusno
order by cce_cusno, cce_seq

END






GO
GRANT EXECUTE ON [dbo].[sp_select_CUCSTEMT] TO [ERPUSER] AS [dbo]
GO
