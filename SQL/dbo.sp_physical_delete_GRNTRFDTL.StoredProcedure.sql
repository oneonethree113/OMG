/****** Object:  StoredProcedure [dbo].[sp_physical_delete_GRNTRFDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_GRNTRFDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_GRNTRFDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
=========================================================
Program ID	: sp_physical_delete_GRNTRFDTL
Description   	: 
Programmer  	: Lester Wu
Create Date   	:
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     

*/


CREATE Procedure [dbo].[sp_physical_delete_GRNTRFDTL]
@cocde		varchar(6),
@Grd_GrnNo	varchar(20),
@Grd_seq		int,
@TimStp		int,
@gsUsrID		varchar(30)
as
BEGIN

	Declare	
		@Row_Idx		int,
		@Err_Idx			int

	Begin Tran

	Delete From 
		GRNTRFDTL
	Where
		Grd_GrnNo = @Grd_GrnNo
		and Grd_seq = @Grd_seq	

	select @Err_Idx = @@error, @Row_Idx = @@RowCount
	
		

	if @Err_Idx = 0 
	begin
		commit tran
	end
	else
	begin
		rollback tran
		return (@Err_Idx)
	end


END





GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_GRNTRFDTL] TO [ERPUSER] AS [dbo]
GO
