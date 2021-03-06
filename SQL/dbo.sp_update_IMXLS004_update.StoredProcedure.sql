/****** Object:  StoredProcedure [dbo].[sp_update_IMXLS004_update]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMXLS004_update]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMXLS004_update]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



/*
	Program ID	: sp_update_IMXLS004_update
	Programmer	: Lester Wu
	Date		: 2007-03-01
*/

CREATE procedure [dbo].[sp_update_IMXLS004_update]
@cocde	varchar(6) , 
@ItemNo	varchar(20) , 
@CustNo	varchar(30), 
@CustAls	varchar(30) , 
@UsrId	varchar(30)
as
Begin
	
	 Declare   
	  @Row_Idx  int,  
	  @Err_Idx   int  


	-- Update Existing Records
	Update 
		IMCUSALS 
	set 
		ica_apvsts = 'X' ,  
		ica_upddat = getdate(), 
		ica_updusr = @UsrId
	where 
		ica_cusno = @CustNo and 
		ica_Itmno = @ItemNo and
		ica_apvsts = 'Y' 

	 select @Err_Idx = @@error, @Row_Idx = @@RowCount  

	 if @Err_Idx = 0
	begin

		Update 
			IMCUSALS 
		set 
			ica_apvsts = 'Y' ,  
			ica_flg = 'O' , 
			ica_upddat = getdate(), 
			ica_updusr = @UsrId
		where 
			ica_cusno = @CustNo and 
			ica_Itmno = @ItemNo and
			ica_cusalsitm = @CustAls and 
			ica_apvsts = 'N' and
			ica_flg <> 'O'
	end		


End



GO
GRANT EXECUTE ON [dbo].[sp_update_IMXLS004_update] TO [ERPUSER] AS [dbo]
GO
