/****** Object:  StoredProcedure [dbo].[sp_select_MMPORDDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MMPORDDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MMPORDDTL]    Script Date: 09/29/2017 15:29:10 ******/
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
--sp_select_MMPORDDTL  '','MP0500027'

CREATE PROCEDURE [dbo].[sp_select_MMPORDDTL] 

@Mpd_cocde as varchar(6) = '',
@Mpd_MPONO as varchar(20)


AS

declare @Mpd_timstp int


	Set  @Mpd_TimStp  = (Select max(cast(Mpd_TimStp as int)) from MPORDDTL where Mpd_MPONO = @MpD_MPONO)

	SELECT 
		'N' as 'del',
		Mpd_MPONO,
		Mpd_MPOseq,
		Mpd_PONo,
		Mpd_POSeq,
		Mpd_PODat,
		Mpd_ShpDat,
		Mpd_OrgShpDat,
		Mpd_ReqNo,
		isnull(Mpd_VenItm,'') as 'Mpd_VenItm',
		Mpd_ItmNo,
		Mpd_ItmNam,
		Mpd_ItmDsc,
		Mpd_ColCde,
		Mpd_UM,
		Mpd_Qty,
		Mpd_Dqty,
		Mpd_ShpQty,
		Mpd_UntPrc,
		Mpd_MinPrc,
		Mpd_Qty * Mpd_MinPrc as 'mpd_SubTotal',
		Mpd_PckMth,
		Mpd_Dept,
		Mpd_PrdNo,
		Mpd_FilNamH,
		Mpd_FilseqH,
		Mpd_FilNam,
		Mpd_Filseq,
		Mpd_HdrRmk,
		Mpd_Rmk,
		mph_curr,
		Mpd_CreDat,
		Mpd_CreUsr,
		Mpd_UpdDat,
		Mpd_UpdUsr,
		--Mpd_TimStp
		@Mpd_TimStp AS 'Mpd_TimStp'
	FROM
		MPORDDTL
		LEFT JOIN MPORDHDR ON Mph_MPONO = @Mpd_MPONO
	where
		Mpd_MPONO = @Mpd_MPONO
	order by 
		Mpd_MPONO,
		Mpd_MPOseq





GO
GRANT EXECUTE ON [dbo].[sp_select_MMPORDDTL] TO [ERPUSER] AS [dbo]
GO
