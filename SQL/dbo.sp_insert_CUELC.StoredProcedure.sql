/****** Object:  StoredProcedure [dbo].[sp_insert_CUELC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_CUELC]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_CUELC]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/************************************************************************
Author:		Lester Wu
Date:		12th September, 2008
Description:	insert data into CUELC
***********************************************************************
*/

CREATE procedure [dbo].[sp_insert_CUELC]

@cec_cocde	nvarchar(6),
@cec_cusno	nvarchar(6),
@cec_grpcde	nvarchar(6),
@cec_grpdsc	nvarchar(200),
@cec_creusr	nvarchar(30)
 
AS

BEGIN

--------------------------------------------------------------------------------------------------


insert into CUELC
(
cec_cusno,
cec_grpcde,
cec_grpdsc,
cec_creusr,
cec_updusr,
cec_credat,
cec_upddat)
values
(
@cec_cusno,
@cec_grpcde,
@cec_grpdsc,
@cec_creusr,
@cec_creusr,
getdate(),
getdate()
)

END







GO
GRANT EXECUTE ON [dbo].[sp_insert_CUELC] TO [ERPUSER] AS [dbo]
GO
