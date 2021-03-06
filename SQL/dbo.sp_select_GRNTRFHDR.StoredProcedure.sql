/****** Object:  StoredProcedure [dbo].[sp_select_GRNTRFHDR]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_GRNTRFHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_GRNTRFHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





/*
=========================================================
Program ID	: sp_select_GRNTRFHDR
Description   	: 
Programmer  	: Lester Wu
Create Date   	: 2005-08-22
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
2006-03-20	Lester Wu		Show Delivery Date & Container No
=========================================================     

*/



CREATE procedure [dbo].[sp_select_GRNTRFHDR]
@cocde	varchar(6),
@Grh_GrnNo	varchar(20)
as
begin
--sp_help GRNTRFHDR
	select 
		Grh_CreUser as 'CreUsr',
		Grh_GrnNo,
		Grh_ImpFty,
		Grh_Addr,
		Grh_ShpPlc,
		Grh_ShpAddr,
		Grh_InvHdr,
		Grh_AgtNo,
		Grh_TrdCty,
		Grh_Car,
		Grh_CusUM,
		Grh_InvUM,
		--Lester Wu 2006-03-20
		Grh_CtrNo,
		Grh_DlvDat,
		--
		Grh_TtlNW,
		Grh_TtlGW,
		Grh_TtlCtn,
		
		Grh_CreUser,
		Grh_CreDat,
		Grh_UpdUsr,
		Grh_UpdDat,
		cast(Grh_TimStp as int) as 'TimStp',
		Grh_Sts as 'Mode' 
		
	from 
		GRNTRFHDR
	where 
		Grh_GrnNo = @Grh_GrnNo

end






GO
GRANT EXECUTE ON [dbo].[sp_select_GRNTRFHDR] TO [ERPUSER] AS [dbo]
GO
