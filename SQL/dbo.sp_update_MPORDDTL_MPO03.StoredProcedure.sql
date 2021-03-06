/****** Object:  StoredProcedure [dbo].[sp_update_MPORDDTL_MPO03]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_MPORDDTL_MPO03]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_MPORDDTL_MPO03]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
=========================================================
Program ID	: sp_update_MPORDDTL_MPO03
Description   	: Update MPO Delivery Qty
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


CREATE procedure [dbo].[sp_update_MPORDDTL_MPO03]
@cocde			as varchar(6) ,
@Mph_MpoNo		as varchar(20) ,
@Mpd_MPOseq		as int , 
@AdjQty			as numeric(9,2), 
@gsUsrId			as varchar(30) , 
@DocNo			as varchar(20) , 
@DocSeq			as int , 
@ItmNo			as varchar(30) , 
@Action 			as varchar(10)
AS
BEGIN

Declare	
		@Row_Idx		int,
		@Err_Idx			int

	
	
	Update  MPORDDTL
	Set 
		Mpd_DQty = Mpd_DQty + @AdjQty , 
		Mpd_UpdDat = Getdate() , 
		Mpd_UpdUsr = @gsUsrId
	where
		Mpd_MpoNo = @Mph_MpoNo and 
		Mpd_MpoSeq = @Mpd_MPOseq	and 
		Mpd_DQty + @AdjQty <= Mpd_Qty and 
		Mpd_DQty + @AdjQty >= 0 and
		Mpd_DQty + @AdjQty >= Mpd_ShpQty

	
	if @Action = 'ADD' 
	Begin
		insert into MPDLVDTL (Mdd_DocNo , Mdd_DocSeq , Mdd_MpoNo , Mdd_MpoSeq , Mdd_ItemNo , Mdd_DQty, Mdd_CreDat , Mdd_CreUsr, Mdd_UpdDat , Mdd_UpdUsr )
		values (@DocNo , @DocSeq , @Mph_MpoNo , @Mpd_MPOseq , @ItmNo , @AdjQty , getdate() , @gsUsrId  , getdate() , @gsUsrId)
		
		select @Err_Idx = @@error, @Row_Idx = @@RowCount
	End
	else
	Begin
		Update 
			MPDLVDTL 
		Set 
			Mdd_DQty = Mdd_DQty + @AdjQty, 
			Mdd_UpdDat = getdate() , 
			Mdd_UpdUsr = @gsUsrId
		where
			Mdd_DocNo = @DocNo and
			Mdd_DocSeq = @DocSeq and 
			Mdd_MpoNo = @Mph_MpoNo and 
			Mdd_MpoSeq = @Mpd_MPOseq

		select @Err_Idx = @@error, @Row_Idx = @@RowCount
	End
	
END








GO
GRANT EXECUTE ON [dbo].[sp_update_MPORDDTL_MPO03] TO [ERPUSER] AS [dbo]
GO
