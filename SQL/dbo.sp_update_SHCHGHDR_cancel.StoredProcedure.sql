/****** Object:  StoredProcedure [dbo].[sp_update_SHCHGHDR_cancel]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SHCHGHDR_cancel]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SHCHGHDR_cancel]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










/************************************************************************
Author:		Marco Chan
Date:		15th February, 2011
Description:	insert data into SHCHGHDR
***********************************************************************
*/

CREATE procedure [dbo].[sp_update_SHCHGHDR_cancel]

@sch_cocde nvarchar(6),
@sch_docno nvarchar(20),
@sch_rmk nvarchar(1000),
@sch_updusr nvarchar(30)
 
AS

BEGIN

--------------------------------------------------------------------------------------------------


update SHCHGHDR
set
sch_sts = 'CAN',
sch_rmk = @sch_rmk,
sch_updusr = @sch_updusr,
sch_upddat = getdate()
WHERE sch_docno = @sch_docno


update SHCHGDTL set scd_fee = 0 where scd_docno = @sch_docno




END









GO
GRANT EXECUTE ON [dbo].[sp_update_SHCHGHDR_cancel] TO [ERPUSER] AS [dbo]
GO
