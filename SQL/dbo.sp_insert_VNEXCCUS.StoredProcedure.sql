/****** Object:  StoredProcedure [dbo].[sp_insert_VNEXCCUS]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_VNEXCCUS]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_VNEXCCUS]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO









/************************************************************************
Author:		Kath Ng     
Date:		25th September, 2001
Description:	Insert data into VNEXCCUS
************************************************************************/

CREATE PROCEDURE [dbo].[sp_insert_VNEXCCUS] 
--------------------------------------------------------------------------------------------------------------------------------------

@vec_cocde nvarchar(6),
@vec_venno nvarchar(6),
@vec_cusno nvarchar(6),
@vec_rmark nvarchar(200),
@user nvarchar(30)
--------------------------------------------------------------------------------------------------------------------------------------
AS

begin

insert into  VNEXCCUS values 
(@vec_cocde,
@vec_venno,
@vec_cusno,
'',
'',
@vec_rmark,
@user,
@user,
getdate(),
getdate(),
null)

end




GO
GRANT EXECUTE ON [dbo].[sp_insert_VNEXCCUS] TO [ERPUSER] AS [dbo]
GO
