/****** Object:  StoredProcedure [dbo].[sp_update_CUCSTEMT]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_CUCSTEMT]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_CUCSTEMT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/************************************************************************
Author:		Lester Wu   
Date:		12th September, 2008
Description:	Update data From CUCSTEMT
***********************************************************************
*/

CREATE procedure [dbo].[sp_update_CUCSTEMT]


@cce_cocde	nvarchar(6),
@cce_cusno	nvarchar(6),
@cce_cecde	nvarchar(6),
@cce_seq	int,
@cce_percent	numeric(13,4),
@cce_curcde	nvarchar(6),
@cce_amt	numeric(13,4),
@cce_chg	char(1),
@cce_updusr	nvarchar(30)
 
AS

BEGIN

--------------------------------------------------------------------------------------------------


update CUCSTEMT
set
cce_seq = @cce_seq,
cce_percent = @cce_percent,
cce_curcde = @cce_curcde,
cce_amt = @cce_amt,
cce_chg = @cce_chg,
cce_updusr = @cce_updusr,
cce_upddat = getdate()
WHERE	
cce_cusno = @cce_cusno and
cce_cecde = @cce_cecde


END







GO
GRANT EXECUTE ON [dbo].[sp_update_CUCSTEMT] TO [ERPUSER] AS [dbo]
GO
