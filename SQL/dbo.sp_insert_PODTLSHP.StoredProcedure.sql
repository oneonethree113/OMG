/****** Object:  StoredProcedure [dbo].[sp_insert_PODTLSHP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_PODTLSHP]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_PODTLSHP]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 28/07/2003

/************************************************************************
Author:		Wong Hong
Date:		15th Feb, 2002
Description:	Insert data From PODTLSHP
Parameter:	1. Company
		2. PO No.	
************************************************************************/
CREATE PROCEDURE [dbo].[sp_insert_PODTLSHP] 

@pds_cocde  nvarchar  ( 6),
@pds_purord  nvarchar  (20),
@pds_seq  int,
@pds_from datetime,
@pds_to  datetime,
@pds_ttlctn  int,
@pds_updusr  nvarchar  (30)

AS

Declare @pds_shpseq  int
Set @pds_shpseq = (Select isnull(max(pds_shpseq ),0) + 1 from PODTLSHP Where pds_cocde= @pds_cocde and pds_purord = @pds_purord and pds_seq = pds_seq)

insert into PODTLSHP(
pds_cocde,
pds_purord,
pds_seq,
pds_shpseq,
pds_from,
pds_to,
pds_ttlctn,
pds_creusr,
pds_updusr,
pds_credat,
pds_upddat
)
values
(
@pds_cocde,
@pds_purord,
@pds_seq,
@pds_shpseq,
@pds_from,
@pds_to,
@pds_ttlctn,
@pds_updusr,
@pds_updusr,
GETDATE(),
GETDATE()
)





GO
GRANT EXECUTE ON [dbo].[sp_insert_PODTLSHP] TO [ERPUSER] AS [dbo]
GO
