/****** Object:  StoredProcedure [dbo].[sp_update_IMXLS003_update]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMXLS003_update]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMXLS003_update]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	Program ID	: sp_update_IMXLS003_update
	Programmer	: Lester Wu
	Date		: 2006-07/15
*/

CREATE procedure [dbo].[sp_update_IMXLS003_update]
@cocde	varchar(6) , 
@DisItm	varchar(20) , 
@NewItm	varchar(20) , 
@UsrId	varchar(30)
as
Begin
	
	 Declare   
	  @Row_Idx  int,  
	  @Err_Idx   int  


	Update 
		IMBASINF 
	set 
		ibi_itmsts = 'DIS' , 
		ibi_chndsc = ibi_chndsc + case when len(@NewItm) > 0 then '' +  char(13) + char(10) +  '(refer to (' + @NewItm + '))' else '' end , 
		ibi_upddat = getdate() , 
		ibi_updusr = @UsrId
	where 
		ibi_itmno = @DisItm

	 select @Err_Idx = @@error, @Row_Idx = @@RowCount  

	 if @Err_Idx = 0   and @Row_Idx > 0
	begin
		Update IMDISITM set idi_apvsts = 'Y' ,  idi_flg = 'O' , idi_upddat = getdate(), idi_updusr = @UsrId
		where idi_disitm = @DisItm and idi_newitm = @NewItm
	end
	
	if @Err_Idx <> 0
	Begin
		return (@Err_Idx)  
	End

End





GO
GRANT EXECUTE ON [dbo].[sp_update_IMXLS003_update] TO [ERPUSER] AS [dbo]
GO
