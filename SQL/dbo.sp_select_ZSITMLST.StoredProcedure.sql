/****** Object:  StoredProcedure [dbo].[sp_select_ZSITMLST]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_ZSITMLST]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_ZSITMLST]    Script Date: 09/29/2017 15:29:10 ******/
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
2005-10-10	Allan Yuen	Add Column     

*/

--sp_select_zsitmlst '','120','20000'
--sp_select_zsitmlst '','',''

CREATE PROCEDURE [dbo].[sp_select_ZSITMLST] 

@zil_cocde	nvarchar(6) = '',
@zil_itmnofr	varchar(20) = '',
@zil_itmnoto	varchar(20) = ''
AS

declare @Zil_timstp int

IF @zil_itmnofr = '' 
BEGIN
	--Set  @Zil_timstp  = (Select max(cast(Zil_TimStp as int)) from ZSITMLST )

	SELECT 
		Zil_CreUsr AS 'Zil_status',
		Zil_ItmNo,
		Zil_ItmNam,
		Zil_ItmDesc,
		Zil_UM,
		Zil_CUR,
		Zil_Prc,
		Zil_CustUM,
		Zil_CatCde1,
		isnull(aa.ymc_catdsc,'') as 'cat1desc',
		Zil_CatCde2,
		isnull(bb.ymc_catdsc,'') as 'cat2desc',
		Zil_Moq,
		Zil_MtyBy,
		Zil_CreDat,
		Zil_CreUsr,
		Zil_UpdDat,
		Zil_UpdUsr,
		--Zil_TimStp
		--@Zil_TimStp AS 'Zil_TimStp'
		cast(Zil_TimStp as int) as 'Zil_TimStp'
	FROM
		ZSITMLST
		LEFT JOIN SYMCATCDE AA ON aa.YMC_TYPE = '0' AND aa.YMC_CATCDE = Zil_CatCde1
		LEFT JOIN SYMCATCDE BB ON bb.YMC_TYPE = '1' AND bb.YMC_CATCDE = Zil_CatCde2
	order by 
		Zil_ItmNo
END
ELSE
BEGIN
	Set  @Zil_timstp = (Select max(cast(Zil_TimStp as int)) from ZSITMLST WHERE zil_itmno >= @zil_itmnofr AND zil_itmno <= @zil_itmnoto)

	SELECT 
		Zil_CreUsr AS 'Zil_status',
		Zil_ItmNo,
		Zil_ItmNam,
		Zil_ItmDesc,
		Zil_UM,
		Zil_CUR,
		Zil_Prc,
		Zil_CustUM,
		Zil_CatCde1,
		isnull(aa.ymc_catdsc,'') as 'cat1desc',
		Zil_CatCde2,
		isnull(bb.ymc_catdsc,'') as 'cat2desc',
		Zil_Moq,
		Zil_MtyBy,
		Zil_CreDat,
		Zil_CreUsr,
		Zil_UpdDat,
		Zil_UpdUsr,
		--Zil_TimStp
		@ZIL_timstp AS 'Zil_TimStp'

	FROM
		ZSITMLST
		LEFT JOIN SYMCATCDE AA ON aa.YMC_TYPE = '0' AND aa.YMC_CATCDE = Zil_CatCde1
		LEFT JOIN SYMCATCDE BB ON bb.YMC_TYPE = '1' AND bb.YMC_CATCDE = Zil_CatCde2
	where
		zil_itmno >= @zil_itmnofr AND zil_itmno <= @zil_itmnoto
	order by 
		Zil_ItmNo

END


GO
GRANT EXECUTE ON [dbo].[sp_select_ZSITMLST] TO [ERPUSER] AS [dbo]
GO
