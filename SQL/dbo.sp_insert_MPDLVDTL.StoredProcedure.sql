/****** Object:  StoredProcedure [dbo].[sp_insert_MPDLVDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_MPDLVDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_MPDLVDTL]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*
=========================================================
Program ID	: sp_insert_MPDLVDTL
Description   	: Insert Supplier Delivery Records (Hdr)
Programmer  	: Lester Wu
Create Date   	: 2005-10-03
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description

=========================================================     

*/

Create Procedure [dbo].[sp_insert_MPDLVDTL]
@cocde		as varchar(6) , 
@Mdd_DocNo	as varchar(20) , 
@Mdd_DocSeq	as int , 
@Mdd_MpoNo	as varchar(20) , 
@Mdd_MpoSeq	as int , 
@Mdd_ItemNo	varchar(20) , 
@Mdd_DQty	numeric(9,2) , 
@Mdd_CreDat	datetime , 
@Mdd_CreUsr	varchar(30)
AS
BEGIN

	Declare	
			@Row_Idx		int,
			@Err_Idx			int
	
	insert into MPDLVDTL (Mdd_DocNo, Mdd_DocSeq, Mdd_MpoNo, Mdd_MpoSeq, Mdd_ItemNo, Mdd_DQty, Mdd_CreDat, Mdd_CreUsr)
	values (@Mdd_DocNo, @Mdd_DocSeq, @Mdd_MpoNo, @Mdd_MpoSeq, @Mdd_ItemNo, @Mdd_DQty, getdate(), @Mdd_CreUsr)

END






GO
GRANT EXECUTE ON [dbo].[sp_insert_MPDLVDTL] TO [ERPUSER] AS [dbo]
GO
