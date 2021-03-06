/****** Object:  StoredProcedure [dbo].[sp_physical_delete_CUELC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_CUELC]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_CUELC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/************************************************************************
Author:		Lester Wu
Date:		12th September, 2008
Description:	delete data From CUELC
***********************************************************************
*/

CREATE procedure [dbo].[sp_physical_delete_CUELC]


@cec_cocde	nvarchar(6),
@cec_cusno	nvarchar(6),
@cec_grpcde	nvarchar(6)

 
AS

BEGIN

--------------------------------------------------------------------------------------------------

if @cec_grpcde = 'ALL' 
begin

delete FROM	CUELC
WHERE	
cec_cusno = @cec_cusno

end
else
begin

delete FROM	CUELC
WHERE	
cec_cusno = @cec_cusno and
cec_grpcde = @cec_grpcde

end

END






GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_CUELC] TO [ERPUSER] AS [dbo]
GO
