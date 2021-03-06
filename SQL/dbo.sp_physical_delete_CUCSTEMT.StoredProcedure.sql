/****** Object:  StoredProcedure [dbo].[sp_physical_delete_CUCSTEMT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_CUCSTEMT]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_CUCSTEMT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/************************************************************************
Author:		Lester Wu
Date:		12th September, 2008
Description:	delete data From CUCSTEMT
***********************************************************************
*/

CREATE procedure [dbo].[sp_physical_delete_CUCSTEMT]


@cce_cocde	nvarchar(6),
@cce_cusno	nvarchar(6),
@cce_cecde	nvarchar(6)

 
AS

BEGIN

--------------------------------------------------------------------------------------------------

if @cce_cecde = 'ALL' 
begin

delete FROM	CUCSTEMT
WHERE	
cce_cusno = @cce_cusno

end
else
begin

delete FROM	CUCSTEMT
WHERE	
cce_cusno = @cce_cusno and
cce_cecde = @cce_cecde

end

END






GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_CUCSTEMT] TO [ERPUSER] AS [dbo]
GO
