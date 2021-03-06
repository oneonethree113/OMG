/****** Object:  StoredProcedure [dbo].[sp_select_cuelc_qu]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_cuelc_qu]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_cuelc_qu]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



/************************************************************************
Author:		Lester Wu    
Date:		28th September, 2008
Description:	Select data From CUELC
***********************************************************************
*/

CREATE procedure [dbo].[sp_select_cuelc_qu]


@cec_cocde	nvarchar(6),
@cec_cusno	nvarchar(6)

 
AS

BEGIN

select * from cuelc
where	
cec_cusno = @cec_cusno
order by cec_cusno, cec_grpcde asc

END


GO
GRANT EXECUTE ON [dbo].[sp_select_cuelc_qu] TO [ERPUSER] AS [dbo]
GO
