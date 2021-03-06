/****** Object:  StoredProcedure [dbo].[sp_insert_MPDLVHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_MPDLVHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_MPDLVHDR]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
=========================================================
Program ID	: sp_insert_MPDLVHDR
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

Create Procedure [dbo].[sp_insert_MPDLVHDR]
@cocde		as varchar(6) , 
@Mdh_DocNo	as varchar(20) , 
@Mdh_DocSeq	as int , 
@Mdh_MpoNo	as varchar(20) , 
@Mdh_ItmNo	as varchar(20) , 
@Mdh_DQty	numeric(9,2) , 
@Mdh_FreeQty	numeric(9,2) , 
@Mdh_CreDat	datetime , 
@Mdh_CreUsr	varchar(30) 
AS
BEGIN

	Declare	
			@Row_Idx		int,
			@Err_Idx			int
	
	
	insert into MPDLVHDR (Mdh_DocNo, Mdh_DocSeq, Mdh_MpoNo, Mdh_ItmNo, Mdh_DQty, Mdh_FreeQty, Mdh_CreDat, Mdh_CreUsr, Mdh_UpdDat, Mdh_UpdUsr)
	values (@Mdh_DocNo, @Mdh_DocSeq, @Mdh_MpoNo, @Mdh_ItmNo, @Mdh_DQty, @Mdh_FreeQty, getdate(), @Mdh_CreUsr, getdate(), @Mdh_CreUsr)


END





GO
GRANT EXECUTE ON [dbo].[sp_insert_MPDLVHDR] TO [ERPUSER] AS [dbo]
GO
