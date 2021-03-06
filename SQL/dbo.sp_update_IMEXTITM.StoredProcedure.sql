/****** Object:  StoredProcedure [dbo].[sp_update_IMEXTITM]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMEXTITM]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMEXTITM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	Program 		: sp_update_IMEXTITM
	Programmer 	: Lester Wu
	Create Date		: 2005/07/14
	Description		: A procedure to update IMEXTITM
*/

--sp_help  IMEXTITM
CREATE procedure [dbo].[sp_update_IMEXTITM]
@cocde as varchar(6),
@Iei_ItmNo 	as varchar(20),
@Iei_ItmCol 	as varchar(20),
@Iei_VenItm 	as varchar(20),
@Iei_VenCol 	as varchar(20),
@Iei_Venno 	as varchar(6),
@Iei_PdItmNo 	as varchar(30),
@Iei_PrdLne 	as varchar(20),
@Iei_CatLvl 	as varchar(20),
@Iei_PrcTrm 	as varchar(20),
@Iei_UntCde 	as varchar(20),
@Iei_Inner 	as int,
@Iei_Middle	as int,
@Iei_Master	as int,
@Iei_CFT		as numeric(9,4),
@Iei_CBM	as numeric(9,4),
@Iei_Curr		as varchar(6),
@Iei_ItmCst	as numeric(9,4),
@Iei_MrkUp	as varchar(20),
@Iei_MrkCurr	as varchar(6),
@Iei_MrkCst	as numeric(9,4),
@Iei_MOQUM	as varchar(20),
@Iei_MOQ	as int,
@Iei_ItmDesc	as nvarchar(800),
@Iei_ChiDesc	as nvarchar(800),
@Iei_PckInst	as varchar(100),
@Iei_Rmk		as nvarchar(2000),
@Iei_InnerL	as numeric(9,4),
@Iei_InnerW	as numeric(9,4),
@Iei_InnerH	as numeric(9,4),
@Iei_MasterL	as numeric(9,4),
@Iei_MasterW	as numeric(9,4),
@Iei_MasterH	as numeric(9,4),
@Iei_FilNam	as varchar(100),
@Iei_Seq		as int,
@Iei_FilDat	as datetime,
@Iei_CmpFlg	as char(1),
@Iei_ApvFlg	as char(1),
@Iei_Stage		as char(1),
@UserId		as varchar(30)
as
BEGIN

Declare @Stage as char(1)

Update IMEXTITM set 
Iei_ItmCol = UPPER(@Iei_ItmCol),
Iei_VenItm = @Iei_VenItm,
Iei_VenCol = UPPER(@Iei_VenCol),
Iei_Venno = @Iei_Venno,
Iei_PdItmNo = @Iei_PdItmNo,
Iei_PrdLne = @Iei_PrdLne,
Iei_CatLvl = @Iei_CatLvl,
Iei_PrcTrm = @Iei_PrcTrm,
Iei_UntCde = @Iei_UntCde,
Iei_Inner = @Iei_Inner,
Iei_Middle = @Iei_Middle,
Iei_Master = @Iei_Master,
Iei_CFT = @Iei_CFT,
Iei_CBM = @Iei_CBM,
Iei_Curr = @Iei_Curr,
Iei_ItmCst = @Iei_ItmCst,
Iei_MrkUp = @Iei_MrkUp,
Iei_MrkCurr = @Iei_MrkCurr,
Iei_MrkCst = @Iei_MrkCst,
Iei_MOQUM = @Iei_MOQUM,
Iei_MOQ = @Iei_MOQ,
Iei_ItmDesc = @Iei_ItmDesc,
Iei_ChiDesc = @Iei_ChiDesc,
Iei_PckInst = @Iei_PckInst,
Iei_Rmk = @Iei_Rmk,
Iei_InnerL = @Iei_InnerL,
Iei_InnerW = @Iei_InnerW,
Iei_InnerH = @Iei_InnerH,
Iei_MasterL = @Iei_MasterL,
Iei_MasterW = @Iei_MasterW,
Iei_MasterH = @Iei_MasterH,
Iei_CmpFlg = @Iei_CmpFlg,
Iei_ApvFlg = @Iei_ApvFlg,
Iei_Stage = 'U',
Iei_UpdUsr = @UserId,
Iei_UpdDat = getdate()
where 
Iei_FilNam = @Iei_FilNam and
Iei_Seq = @Iei_Seq and 
Iei_ItmNo = @Iei_ItmNo

END





GO
GRANT EXECUTE ON [dbo].[sp_update_IMEXTITM] TO [ERPUSER] AS [dbo]
GO
