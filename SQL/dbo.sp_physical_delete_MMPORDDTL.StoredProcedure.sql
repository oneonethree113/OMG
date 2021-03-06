/****** Object:  StoredProcedure [dbo].[sp_physical_delete_MMPORDDTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_MMPORDDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_MMPORDDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




/*
=========================================================
Program ID	: sp_physical_delete_MMPORDDTL
Description   	: 
Programmer  	: Allan Yuen
Create Date   	: 2005/08/11
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
2005-09-23	Lester Wu		Update Excately the Generated Detail Record Only
*/
--sp_physical_delete_MMPORDDTL  '','MP0500027'

CREATE PROCEDURE [dbo].[sp_physical_delete_MMPORDDTL] 

@Mpd_cocde varchar(6) = '',
@Mpd_MPONO varchar(20),
@Mpd_MPOseq  int,
@Mpd_PONo  varchar(20),
@Mpd_POSeq int,
@Mpd_UpdUsr varchar(30)

AS

	--- Delete Upload Flag ---
	if ltrim(rtrim(@Mpd_PONo)) <> '' and @Mpd_MPOseq <> 0 
	begin
		if (select Mpd_Qty from MPORDDTL where Mpd_Mpono = @Mpd_MPONO and Mpd_MpoSeq =  @Mpd_MPOseq  ) > 0 
		begin
			update 
				MPOXLSDTL 
			set
				Mxd_MPONO ='',
				Mxd_MPOFlg = 'N',
				Mxd_UpdUsr = @Mpd_UpdUsr,
				Mxd_UpdDat = getdate()
			where
				Mxd_PONo = @Mpd_PONo and
				Mxd_POSEq = @Mpd_POSeq and 
				-- Lester Wu 2005-09-23 Upate Excately the Generated Item only
				Mxd_MPONo = @Mpd_MPONO and
				Mxd_MPOFlg = 'G'

			update 
				MPOXLSHDR 
			set
				Mxh_MPOFlg = 'N',
				Mxh_UpdUsr = @Mpd_UpdUsr,
				Mxh_UpdDat = getdate()
			where
				Mxh_PONo = @Mpd_PONo and
				Mxh_MPOFlg = 'G'
		end
		else
		begin
			update 
				MPOXLSDTL 
			set
				Mxd_MPONO ='',
				Mxd_MPOFlg = 'O',
				Mxd_UpdUsr = @Mpd_UpdUsr,
				Mxd_UpdDat = getdate()
			where
				Mxd_PONo = @Mpd_PONo and
				Mxd_POSEq = @Mpd_POSeq and 
				Mxd_MPONo = @Mpd_MPONO and
				Mxd_MPOFlg = 'G'

			update 
				MPOXLSHDR 
			set
				Mxh_MPOFlg = 'N',
				Mxh_UpdUsr = @Mpd_UpdUsr,
				Mxh_UpdDat = getdate()
			where
				Mxh_PONo = @Mpd_PONo and
				Mxh_MPOFlg = 'G'
		end
		
	end

	DELETE FROM
		MPORDDTL
	WHERE
		Mpd_MPONO = @Mpd_MPONO AND
		Mpd_MPOseq = @Mpd_MPOseq	and
		Mpd_PONo = @Mpd_PONo and
		Mpd_POSEq = @Mpd_POSeq



GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_MMPORDDTL] TO [ERPUSER] AS [dbo]
GO
