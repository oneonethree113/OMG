/****** Object:  StoredProcedure [dbo].[sp_update_SHCHGHDR]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SHCHGHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SHCHGHDR]    Script Date: 09/29/2017 15:29:10 ******/
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

CREATE  procedure [dbo].[sp_update_SHCHGHDR]

@sch_cocde nvarchar(6),
@sch_docno nvarchar(20),
@sch_typ nvarchar(6),
@sch_sts nvarchar(20),
@sch_curcde nvarchar(10),
@sch_exchrat numeric(20,8),
@sch_pckdat datetime,
@sch_ctrcfs nvarchar(20),
@sch_ctrsiz nvarchar(20),
@sch_invlst nvarchar(200),
@sch_cuslst nvarchar(200),
@sch_cusnolst nvarchar(200),
@sch_etddat datetime,
@sch_rmk nvarchar(1000),
@sch_updusr nvarchar(30)
 
AS

BEGIN

--------------------------------------------------------------------------------------------------


update SHCHGHDR
set
sch_typ= @sch_typ,
sch_sts= @sch_sts,
sch_curcde= upper(@sch_curcde),
sch_exchrat= @sch_exchrat,
sch_pckdat= @sch_pckdat,
sch_ctrcfs= upper(@sch_ctrcfs),
sch_ctrsiz= upper(@sch_ctrsiz),
sch_invlst= upper(@sch_invlst),
sch_cuslst= @sch_cuslst,
sch_cusnolst= @sch_cusnolst,
sch_etddat= @sch_etddat,
sch_rmk= upper(@sch_rmk),
sch_updusr= @sch_updusr,
sch_upddat= getdate()
WHERE	
sch_docno= @sch_docno


END










GO
GRANT EXECUTE ON [dbo].[sp_update_SHCHGHDR] TO [ERPUSER] AS [dbo]
GO
