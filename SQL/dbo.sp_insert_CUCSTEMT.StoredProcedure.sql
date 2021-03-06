/****** Object:  StoredProcedure [dbo].[sp_insert_CUCSTEMT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_CUCSTEMT]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_CUCSTEMT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/************************************************************************
Author:		Lester Wu
Date:		12th September, 2008
Description:	insert data into CUCSTEMT
***********************************************************************
*/

CREATE procedure [dbo].[sp_insert_CUCSTEMT]

@cce_cocde	nvarchar(6),
@cce_cusno	nvarchar(6),
@cce_cecde	nvarchar(6),
@cce_seq	int,
@cce_percent	numeric(13,4),
@cce_curcde	nvarchar(6),
@cce_amt	numeric(13,4),
@cce_chg	char(1),
@cce_creusr	nvarchar(30)
 
AS

BEGIN

--------------------------------------------------------------------------------------------------


insert into CUCSTEMT
(
cce_cusno,
cce_cecde,
cce_seq,
cce_percent,
cce_curcde,
cce_amt,
cce_chg,
cce_creusr,
cce_updusr,
cce_credat,
cce_upddat)
values
(
@cce_cusno,
@cce_cecde,
@cce_seq,
@cce_percent,
@cce_curcde,
@cce_amt,
@cce_chg,
@cce_creusr,
@cce_creusr,
getdate(),
getdate()
)

END







GO
GRANT EXECUTE ON [dbo].[sp_insert_CUCSTEMT] TO [ERPUSER] AS [dbo]
GO
