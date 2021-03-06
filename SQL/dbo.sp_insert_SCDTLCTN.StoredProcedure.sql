/****** Object:  StoredProcedure [dbo].[sp_insert_SCDTLCTN]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SCDTLCTN]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SCDTLCTN]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 27/07/2003


/************************************************************************
Author:		Kenny Chan
Date:		14th jan, 2002
Description:	Insert data From SCDTLCTN
Parameter:	1. Company
		2. SC No.	
************************************************************************/
CREATE PROCEDURE [dbo].[sp_insert_SCDTLCTN] 

@sdc_cocde  nvarchar  ( 6),
@sdc_ordno  nvarchar  (20),
@sdc_seq  int,
@sdc_from  int,
@sdc_to  int,
@sdc_ttlctn  int,
@sdc_updusr  nvarchar  (30)

AS

Declare @sdc_ctnseq  int
Set @sdc_ctnseq = (Select isnull(max(sdc_ctnseq ),0) + 1 from SCDTLCTN Where sdc_cocde = @sdc_cocde and sdc_ordno = @sdc_ordno and sdc_seq = @sdc_seq)

insert into SCDTLCTN(
sdc_cocde,
sdc_ordno,
sdc_seq,
sdc_ctnseq,
sdc_from,
sdc_to,
sdc_ttlctn,
sdc_creusr,
sdc_updusr,
sdc_credat,
sdc_upddat
)
values
(
@sdc_cocde,
@sdc_ordno,
@sdc_seq,
@sdc_ctnseq,
@sdc_from,
@sdc_to,
@sdc_ttlctn,
@sdc_updusr,
@sdc_updusr,
GETDATE(),
GETDATE()
)






GO
GRANT EXECUTE ON [dbo].[sp_insert_SCDTLCTN] TO [ERPUSER] AS [dbo]
GO
