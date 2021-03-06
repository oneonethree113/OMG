/****** Object:  StoredProcedure [dbo].[sp_update_MPDLVHDR]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_MPDLVHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_MPDLVHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*  
=========================================================  
Program ID : sp_update_MPDLVHDR  
Description    : Insert Supplier Delivery Records (Hdr)  
Programmer   : Lester Wu  
Create Date    : 2005-10-03  
Last Modified   :   
Table Read(s)  :  
Table Write(s)  :  
=========================================================  
 Modification History                                      
=========================================================  
Date  Author  Description  
  
=========================================================       
  
*/  
  
CREATE  Procedure [dbo].[sp_update_MPDLVHDR]  
@cocde  as varchar(6) ,   
@Mdh_DocNo as varchar(20) ,   
@Mdh_DocSeq as int ,   
@Mdh_MpoNo as varchar(20) ,   
@Mdh_ItmNo as varchar(20) ,   
@Mdh_DQty numeric(9,2) ,   
@Mdh_FreeQty numeric(9,2) ,   
@Mdh_CreDat datetime ,   
@Mdh_CreUsr varchar(30)   
AS  
BEGIN  
  
 Declare   
   @Row_Idx  int,  
   @Err_Idx   int  
   
 Update   
  MPDLVHDR   
 Set  
  Mdh_DQty = Mdh_DQty + @Mdh_DQty ,   
  Mdh_UpdDat = getdate() ,   
  Mdh_UpdUsr = @Mdh_CreUsr  
 where 
  Mdh_DocNo = @Mdh_DocNo and 
  Mdh_DocSeq = @Mdh_DocSeq

END  
  






GO
GRANT EXECUTE ON [dbo].[sp_update_MPDLVHDR] TO [ERPUSER] AS [dbo]
GO
