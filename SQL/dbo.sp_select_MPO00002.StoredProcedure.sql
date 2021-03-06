/****** Object:  StoredProcedure [dbo].[sp_select_MPO00002]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MPO00002]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MPO00002]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*
=========================================================
Program ID	: sp_select_MPO00002
Description   	: 
Programmer  	: Lester Wu
Create Date   	:2005-07-29
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     

*/


Create Procedure [dbo].[sp_select_MPO00002]
@cocde	as varchar(6)

as
BEGIN

SELECT
	Mph_MPONO,
	Mph_VenNo,
	Mph_ImpFty,
	Mph_ShpPlc,
	Mpd_ShpDat,
--
	Mpd_PONo,
	Mpd_POSeq,
	Mpd_PODat,
	Mpd_ItmNo,
	Mpd_ItmNam,
	Mpd_ItmDsc,
	Mpd_ColCde,
	Mpd_UM,
	Mpd_Qty,
	Mph_Curr,
	Mpd_UntPrc,
	Mpd_PckMth,
	Mpd_HdrRmk,
	Mpd_Rmk,
	Mpd_ReqNo,
	Mpd_PrdNo,
	Mpd_Dept,
	Mpd_ShpQty,
	Mpd_MPONO,
	Mpd_MPOseq,
	Mpd_FilNamH,
	Mpd_FilSeqH,
	Mpd_FilNam,
	Mpd_Filseq

FROM
	MPORDHDR(NOLOCK)
LEFT JOIN 
	MPORDDTL(NOLOCK) on mph_mpono = mpd_mpono
WHERE
	Mph_mpono = 'XXX'

END





GO
GRANT EXECUTE ON [dbo].[sp_select_MPO00002] TO [ERPUSER] AS [dbo]
GO
