/****** Object:  StoredProcedure [dbo].[sp_insert_IMRECTST]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMRECTST]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMRECTST]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/************************************************************************
Author:		Wong Hong
Date:		11th jan, 2002
Description:	Insert data INTO IMRECTST
Parameter:	1. Company
		2. Receiving No.	
************************************************************************/
CREATE PROCEDURE [dbo].[sp_insert_IMRECTST] 
@irt_cocde	nvarchar(6) ,
@irt_recno	nvarchar(20),
@irt_tsttyp	nvarchar(3),
@irt_venno	nvarchar(6),
@irt_purord	nvarchar(20),
@irt_jobno	nvarchar(20),
@irt_cusno	nvarchar(6),
@irt_cusitm	nvarchar(20),
@irt_purseq	int,
@irt_itmno	nvarchar(20),
@irt_colcde	nvarchar(30),
@irt_untcde	nvarchar(6),
@irt_inrqty	int,
@irt_mtrqty	int,
@irt_cft		numeric(11,4),
@irt_qty		int,
@irt_curcde	nvarchar(6),
@irt_ftyprc	numeric(13,4),
@irt_rmk		nvarchar(200),
@irt_updusr		nvarchar(30)

AS

insert into IMRECTST(
irt_cocde,	
irt_recno,	
irt_tstdat,
irt_tsttyp,	
irt_venno,
irt_purord,	
irt_jobno,	
irt_cusno,	
irt_cusitm,	
irt_purseq,	
irt_itmno,	
irt_colcde,	
irt_untcde,	
irt_inrqty,	
irt_mtrqty,	
irt_cft,		
irt_qty,		
irt_curcde,	
irt_ftyprc,	
irt_rmk,		
irt_creusr,	
irt_updusr
) VALUES (
@irt_cocde,	
@irt_recno,	
GETDATE(),
@irt_tsttyp,	
@irt_venno,
@irt_purord,	
@irt_jobno,	
@irt_cusno,	
@irt_cusitm,	
@irt_purseq,	
@irt_itmno,	
@irt_colcde,	
@irt_untcde,	
@irt_inrqty,	
@irt_mtrqty,	
@irt_cft,		
@irt_qty,		
@irt_curcde,	
@irt_ftyprc,	
@irt_rmk,		
@irt_updusr,	
@irt_updusr	
)





GO
GRANT EXECUTE ON [dbo].[sp_insert_IMRECTST] TO [ERPUSER] AS [dbo]
GO
