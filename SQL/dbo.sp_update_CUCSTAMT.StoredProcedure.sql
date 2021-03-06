/****** Object:  StoredProcedure [dbo].[sp_update_CUCSTAMT]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_CUCSTAMT]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_CUCSTAMT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/************************************************************************
Author:		Lester Wu   
Date:		12th September, 2008
Description:	Update data From CUCSTAMT
***********************************************************************
*/

CREATE procedure [dbo].[sp_update_CUCSTAMT]


@cca_cocde	nvarchar(6),
@cca_cusno	nvarchar(6),
@cca_cecde	nvarchar(6),
@cca_seq	int,
@cca_curcde	nvarchar(6),
@cca_bp1	numeric(13,4),
@cca_bp2	numeric(13,4),
@cca_estqty	numeric(13,0),
@cca_updusr	nvarchar(30)
 
AS

BEGIN

--------------------------------------------------------------------------------------------------


update CUCSTAMT
set
cca_curcde = @cca_curcde,
cca_bp1 = @cca_bp1,
cca_bp2 = @cca_bp2,
cca_estqty = @cca_estqty,
cca_updusr = @cca_updusr,
cca_upddat = getdate()
WHERE	
cca_cusno = @cca_cusno and
cca_cecde = @cca_cecde and 
cca_seq = @cca_seq


END







GO
GRANT EXECUTE ON [dbo].[sp_update_CUCSTAMT] TO [ERPUSER] AS [dbo]
GO
