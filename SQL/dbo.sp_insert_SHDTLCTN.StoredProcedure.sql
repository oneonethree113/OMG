/****** Object:  StoredProcedure [dbo].[sp_insert_SHDTLCTN]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SHDTLCTN]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SHDTLCTN]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






-- Checked by Allan Yuen at 28/07/2003

/************************************************************************
Author:		Johnson Lai
Date:		2 Feb, 2002
Description:	Insert data From SHDTLCTN
Parameter:	1. Company
		2. SHPNO.	
************************************************************************/



CREATE PROCEDURE [dbo].[sp_insert_SHDTLCTN] 
--------------------------------------------------------------------------------------------------------------------------------------

@hdc_cocde  nvarchar  ( 6),
@hdc_shpno  nvarchar  (20),
@hdc_shpseq  int,
@hdc_from  int,
@hdc_to  int,
@hdc_ttlctn  int,
@hdc_updusr  nvarchar  (30)

AS

Declare @hdc_ctnseq  int
Set @hdc_ctnseq = (Select isnull(max(hdc_ctnseq ),0) + 1 from SHDTLCTN Where hdc_cocde = @hdc_cocde and hdc_shpno = @hdc_shpno and hdc_shpseq = @hdc_shpseq)

insert into SHDTLCTN(
hdc_cocde,
hdc_shpno,
hdc_shpseq,
hdc_ctnseq,
hdc_from,
hdc_to,
hdc_ttlctn,
hdc_creusr,
hdc_updusr,
hdc_credat,
hdc_upddat
)
values
(
@hdc_cocde,
@hdc_shpno,
@hdc_shpseq,
@hdc_ctnseq,
@hdc_from,
@hdc_to,
@hdc_ttlctn,
@hdc_updusr,
@hdc_updusr,
GETDATE(),
GETDATE()
)









GO
GRANT EXECUTE ON [dbo].[sp_insert_SHDTLCTN] TO [ERPUSER] AS [dbo]
GO
