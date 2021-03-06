/****** Object:  StoredProcedure [dbo].[sp_select_MPR00002]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MPR00002]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MPR00002]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
=========================================================
Program ID	: sp_select_MPR00002
Description   	: 
Programmer  	: Allan Yuen
ALTER  Date   	: 2005/08/18
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     

*/

CREATE procedure [dbo].[sp_select_MPR00002]
@Code	varchar(6),
@MPOFm	varchar(20),
@MPOTo	varchar(20),
@Rvs	char(1)

--sp_select_mpr00002 '','MP0800141','MP0800141','N'
as

declare
	@dummy varchar(4000),
	@MPONO varchar(20), 
	@ItmNo varchar(20), 
	@UM varchar(5),
	@ItmNam nvarchar(60),
	@MinPrc numeric(18, 4),
	@ShpDat datetime,
	@Qty numeric(18, 2),
	@PONo varchar(20),
	@INV_VENDOR NVARCHAR(10)

	SET NOCOUNT ON

	CREATE TABLE #MPORDDTL
	(
		MPONO varchar(20), 
		ItmNo varchar(20), 
		ItmNam nvarchar(60),
		MinPrc numeric(18, 4),
		Um varchar(5),
		ShpDat datetime,
		detailinfo varchar(4000) 	
	)
	
	INSERT INTO #MPORDDTL
	(
		MPONO, 
		ItmNo,
		ItmNam,
		MinPrc,
		um,
		ShpDat,
		detailinfo
	)
	
	SELECT 
		mpd_MPONO, 
		mpd_ItmNo, 
		mpd_ItmNam,
		mpd_MinPrc,
		mpd_um,
		mpd_ShpDat,
		''
	FROM
		MPORDDTL 
	WHERE 
		MPD_mPONO >= @MPOFm and MPD_mPONO <= @MPOTo 
	group by 
		mpd_MPONO, 
		mpd_ItmNo, 
		mpd_ItmNam,
		mpd_MinPrc,
		mpd_um,		
		mpd_ShpDat

	------ Cursor ------	
	DECLARE MPO_cursor CURSOR FOR 
	SELECT 
		mpd_MPONO, mpd_ItmNo, mpd_ItmNam, 
		mpd_MinPrc, mpd_ShpDat, mpd_qty, mpd_pono, mpd_um
	FROM
		MPORDDTL 
	WHERE 
		MPD_mPONO >= @MPOFm and MPD_mPONO <= @MPOTo 

	OPEN MPO_cursor

	FETCH NEXT FROM MPO_cursor 
	INTO 	
		@MPONO, @ItmNo, 	@ItmNam,
		@MinPrc,	@ShpDat,	@Qty, @PONo, @Um
	
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		UPDATE
			#MPORDDTL
		SET
			DETAILINFO =  DETAILINFO  + @PONo + ' (Qty: ' + convert(varchar(20),@Qty) + '),'  + char(13)
		WHERE
			MPONO = @MPONO  and
			ItmNo  = @ItmNo and
			ItmNam  = @ItmNam and  
			MinPrc  = @MinPrc and
			um = @Um and
			ShpDat  = @ShpDat  

			FETCH NEXT FROM MPO_cursor 
			INTO 	
				@MPONO, @ItmNo, 	@ItmNam,
				@MinPrc,	@ShpDat,	@Qty, @PONo, @Um
	END
   
   	CLOSE MPO_cursor
	DEALLOCATE MPO_cursor
	------ Cursor ------	
	UPDATE
		#MPORDDTL
	SET
		DETAILINFO =  SUBSTRING(DETAILINFO,1,LEN(DETAILINFO)-2) +  char(13) + ' ' 
--	UPDATE
--		#MPORDDTL
--	SET
--		DETAILINFO =  LTRIM(RTRIM(DETAILINFO))
	----------------------
	SET NOCOUNT OFF






	SELECT 
		Mph_MPONO,
		Mph_VenNo,
		-- Changed by Mark Lau 20090102
		--vbi_vennam,
		case when isnull(vbi_venchnnam,'') <> '' then isnull(vbi_venchnnam,'') else isnull(vbi_vennam,'') end as 'vbi_vennam',
		Mph_ImpFty,
		Gvi_VenNam,
		Gvi_EngNam,
		Gvi_VenAddr,
		Gvi_EngAddr,
		Gvi_Tel1,
		Gvi_Tel2,
		Gvi_Fax,
		Gvi_TLX,
		Mph_Curr,
		Mph_ShpPlc,
		Mph_rmk,
		Mph_VenAdr,
		Mph_VenStt,
		Mph_VenCty,
		ysi_dsc,
		Mph_VenPst,
		Mph_MporCtp,
		Mph_DisCnt,
		ISNULL(Mph_ShpAdr,'') AS Mph_ShpAdr,
		convert(char(10), Mph_CreDat, 101) AS 'Mph_CreDat',
		 convert(char(10), Mph_UpdDat, 101) + ' ' + convert(char(10), Mph_UpdDat, 108) AS 'Mph_UpdDat',
		Mpd_ItmNo,
		Mpd_VenItm,
		Mpd_ItmNam,
		upper(Mpd_UM) as 'Mpd_UM',
		detailinfo,	
		sum(Mpd_Qty) as 'MPD_QTY',
		Mpd_MinPrc,
		convert(numeric(13,2),sum(mpd_qty * mpd_minprc)) AS 'mpd_subamt',
		convert(char(10), Mpd_ShpDat, 101) AS 'Mpd_ShpDat',
		@Rvs as 'Revised_Flag'
	from 
		mpordhdr
		left join SYSETINF on   ysi_typ ='02' and ysi_cde = Mph_VenCty
		LEFT JOIN VNBASINF ON VBI_VENNO = MPH_VENNO
		LEFT JOIN GRNVENINF  ON GVI_TYPE = 'INV' AND GVI_INVVEN = Mph_ImpFty,
		MPORDDTL 	
		LEFT JOIN  #MPORDDTL ON MPONO = Mpd_MPONO and ItmNo = mpd_itmno and UM = Mpd_UM and MinPrc = mpd_MinPrc
	WHERE 
		Mph_MPONO  = MPD_mPONO AND
		MPH_mPONO >= @MPOFm and MPH_mPONO <= @MPOTo 
	group by 
		Mph_MPONO,
		Mph_VenNo,
		-- Changed by Mark Lau 20090102
		case when isnull(vbi_venchnnam,'') <> '' then isnull(vbi_venchnnam,'') else isnull(vbi_vennam,'') end, --vbi_vennam,
		Mph_ImpFty,
		Gvi_VenNam,
		Gvi_EngNam,
		Gvi_VenAddr,
		Gvi_EngAddr,
		Gvi_Tel1,
		Gvi_Tel2,
		Gvi_Fax,
		Gvi_TLX,
		Mph_Curr,
		Mph_ShpPlc,
		Mph_rmk,
		Mph_VenAdr,
		Mph_VenStt,
		Mph_VenCty,
		ysi_dsc,
		Mph_VenPst,
		Mph_MporCtp,
		Mph_DisCnt,
		Mph_ShpAdr,
		Mph_CreDat,
		Mph_UpdDat,
		Mpd_ItmNo,
		Mpd_VenItm,
		Mpd_ItmNam,
		Mpd_UM,
		detailinfo,	
		Mpd_MinPrc,
		Mpd_ShpDat
	order by
		Mpd_VenItm,
		Mpd_ItmNo




GO
GRANT EXECUTE ON [dbo].[sp_select_MPR00002] TO [ERPUSER] AS [dbo]
GO
