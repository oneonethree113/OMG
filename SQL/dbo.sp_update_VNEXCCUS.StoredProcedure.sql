/****** Object:  StoredProcedure [dbo].[sp_update_VNEXCCUS]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_VNEXCCUS]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_VNEXCCUS]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO









/************************************************************************
Author:		Kath Ng     
Date:		25th September, 2001
Description:	Insert data into VNEXCCUS
************************************************************************/

CREATE PROCEDURE [dbo].[sp_update_VNEXCCUS] 
--------------------------------------------------------------------------------------------------------------------------------------

@vec_cocde nvarchar(6),
@vec_venno nvarchar(6),
@vec_cusno nvarchar(6),
@vec_rmark nvarchar(200),
@user nvarchar(30)
--------------------------------------------------------------------------------------------------------------------------------------
AS

begin
 
update VNEXCCUS
set vec_rmark = @vec_rmark, vec_updusr = @user
where vec_cocde = ''
and vec_venno = @vec_venno
and vec_cusno = @vec_cusno




end




GO
GRANT EXECUTE ON [dbo].[sp_update_VNEXCCUS] TO [ERPUSER] AS [dbo]
GO
