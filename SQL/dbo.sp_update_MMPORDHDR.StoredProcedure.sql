/****** Object:  StoredProcedure [dbo].[sp_update_MMPORDHDR]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_MMPORDHDR]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_MMPORDHDR]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 2005/08/11
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     

*/


CREATE PROCEDURE [dbo].[sp_update_MMPORDHDR]

@Mph_cocde  	varchar(6) ,
@Mph_MPONO  	varchar(20),
@Mph_VenNo  	varchar(10),
@Mph_ImpFty  	nvarchar(100),
@Mph_Curr  	varchar(10),
@Mph_ShpPlc 	nvarchar(10),
@Mph_rmk 	nvarchar(600),
@Mph_VenAdr 	nvarchar(400),
@Mph_mporctp 	nvarchar(50),
@Mph_venStt 	nvarchar(40),
@Mph_venCty 	nvarchar(12),
@Mph_venPst 	nvarchar(40),
@Mph_PrcTrm 	nvarchar(12),
@Mph_PayTrm 	nvarchar(12),
@Mph_TtlAmt 	numeric(11,4),
@Mph_DisCnt 	numeric(5,3), 
@Mph_NetAmt 	numeric(11,4),
@Mph_ShpAdr 	nvarchar(400),
@Mph_MpoSts 	char(3),
@Mph_UpdUsr 	varchar(30)

AS




update
	MPORDHDR
set

	Mph_VenNo = @Mph_VenNo ,
	Mph_ImpFty = @Mph_ImpFty,
	Mph_Curr  = @Mph_Curr ,
	Mph_ShpPlc = @Mph_ShpPlc, 
	--Mph_ShpDat = @Mph_ShpDat,
	Mph_rmk = @Mph_rmk,
	Mph_VenAdr = @Mph_VenAdr,
	Mph_Mporctp = @Mph_Mporctp,
	Mph_venStt = @Mph_venStt,
	Mph_venCty = @Mph_venCty,
	Mph_venPst = @Mph_venPst,
	Mph_PrcTrm = @Mph_PrcTrm,
	Mph_PayTrm = @Mph_PayTrm,
	Mph_TtlAmt =  @Mph_TtlAmt,
	Mph_DisCnt = @Mph_DisCnt,
	Mph_NetAmt = @Mph_NetAmt,
	Mph_ShpAdr = @Mph_ShpAdr, 
	Mph_UpdUsr = @Mph_UpdUsr,
	Mph_MpoSts = @Mph_MpoSts,
	Mph_UpdDat = getdate()
where
	Mph_MPONO =@Mph_MPONO





GO
GRANT EXECUTE ON [dbo].[sp_update_MMPORDHDR] TO [ERPUSER] AS [dbo]
GO
