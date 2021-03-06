/****** Object:  StoredProcedure [dbo].[sp_select_MpoXls]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MpoXls]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MpoXls]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*
=========================================================
Program ID	: sp_select_MpoXls
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


CREATE   procedure [dbo].[sp_select_MpoXls]
@cocde 		nvarchar(6),
@Type		char(1)
as
BEGIN

if @Type = 'D' 
begin
	select 
		--Mxd_FilNam,
		--Mxd_seq,
		Mxd_PONo,
		Mxd_POSeq,
		Mxd_ReqNo,
		Mxd_ShpDat,
		Mxd_ItmNo,
		Mxd_ItmNam,
		Mxd_ItmDsc,
		Mxd_ColCde,
		Mxd_UM,
		Mxd_Qty,
		Mxd_UntPrc,
		Mxd_PckMth,
		Mxd_Dept,
		Mxd_PrdNo,
		Mxd_Rmk,
		Mxd_UpdFlg--,
		--Mxd_Expt,
		--Mxd_MPOFLG,
		--Mxd_MPONO,
		--Mxd_CreDat,
		--Mxd_CreUsr
	from 
		MPOXLSDTL
	where
		Mxd_FilNam = 'XXX'
end
else if @Type = 'H'
begin
	select
		--Mxh_FilNam,
		--Mxh_seq,
		Mxh_PONo,
		Mxh_VenNo,
		Mxh_PODat,
		Mxh_POUsr,
		Mxh_ConUsr,
		Mxh_ConDat,
		Mxh_CntUsr,
		Mxh_Curr,
		Mxh_ImpFty,
		Mxh_ShpPlc,
		Mxh_Rmk,
		Mxh_UpdFlg--,
		--Mxh_Expt,
		--Mxh_MPOFLG,
		--Mxh_MPONO,
		--Mxh_CreDat,
		--Mxh_CreUsr
	from
		MPOXLSHDR
	where
		Mxh_FilNam = 'XXX'
end

END






GO
GRANT EXECUTE ON [dbo].[sp_select_MpoXls] TO [ERPUSER] AS [dbo]
GO
