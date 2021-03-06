/****** Object:  StoredProcedure [dbo].[sp_update_IMVTLITY]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMVTLITY]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMVTLITY]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/************************************************************************
Author:		Wong Hong
Date:		11th jan, 2002
Description:	UPDATE data INTO IMVTLITY
Parameter:	1. Company
		2. Receiving No.	
************************************************************************/
CREATE PROCEDURE [dbo].[sp_update_IMVTLITY] 
@ivt_cocde	nvarchar(6) ,
@ivt_lotno	nvarchar(10),
@ivt_qty	int,
@ivt_curcde	nvarchar(6),
@ivt_ftyprc	numeric(13,4),
@irt_txntyp	nvarchar(3),
@ivt_refno	nvarchar(100),
@ivt_rmk	nvarchar(200),
@ivt_updusr	nvarchar(30)


AS

UPDATE IMVTLITY 
SET ivt_qty =  ivt_qty - @ivt_qty,
ivt_refno = @ivt_refno,
ivt_rmk = @ivt_rmk,
ivt_updusr = @ivt_updusr,
ivt_upddat = GETDATE()
WHERE ivt_cocde = @ivt_cocde AND
ivt_lotno = @ivt_lotno AND
ivt_locatn = @ivt_cocde


INSERT INTO IMRECTXN (
irt_cocde,
irt_txndat,
irt_txntyp,
irt_locatn,
irt_lotno,
irt_qty,
irt_curcde,
irt_ftyprc,
irt_rmk,
irt_creusr,
irt_updusr
) VALUES (
@ivt_cocde,	
GETDATE(),
@irt_txntyp,
@ivt_cocde,	
@ivt_lotno,	
@ivt_qty,
@ivt_curcde,
@ivt_ftyprc,
@ivt_rmk,	
@ivt_updusr,	
@ivt_updusr	
)




GO
GRANT EXECUTE ON [dbo].[sp_update_IMVTLITY] TO [ERPUSER] AS [dbo]
GO
