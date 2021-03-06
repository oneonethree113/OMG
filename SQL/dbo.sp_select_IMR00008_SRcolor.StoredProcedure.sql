/****** Object:  StoredProcedure [dbo].[sp_select_IMR00008_SRcolor]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMR00008_SRcolor]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMR00008_SRcolor]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--  sp_select_IMR00008_SRcolor 'UCPP','07/18/2007','mis','','','071432-00001','071432-00001',1

-- sp_insert_IMRTEMP 'UCPP','07/18/2007','N/A','N','mis'

/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 17 July 2003
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
17 July 2003	Allan Yuen		For Merge Porject, disable company code
15 July 2005	Allan Yuen		Change read color code from icf_colcde -> icf_vencol
18 Oct 2005	Lester Wu		show vendor item no
03 Mar 2006	Lester Wu		Show Our Color Code instead Vendor Color
*/



/********************************************************************************
Author:		Louis Siu
Date:		17th Jan, 2002
Description:	Bar Code Printing Report - Create TempTable for Show Report by Color
*********************************************************************************/

	CREATE PROCEDURE [dbo].[sp_select_IMR00008_SRcolor] 

	@cocde		nvarchar(6),	
	@credat		datetime,
	@creusr		nvarchar(30),
	@productLineFm	nvarchar(6),
	@productLineTo	nvarchar(6),
	@itmnoFm	nvarchar(20),
	@itmnoTo		nvarchar(20),
	@startNo		int
	
AS



	-- * Create Temporary Table------------------------------------------------------------------------------------------------------------------------------------
	CREATE TABLE #tempTable
	(                 
 	temp_cocde	nvarchar(6)	NULL,                                                                                                                                                                                                                                 
    
	temp_itmno 	nvarchar(20) 	NULL,
	temp_engdsc 	nvarchar(800)	NULL,
	temp_venno 	nvarchar(6) 	NULL,
	temp_lnecde 	nvarchar(10)	NULL,
	temp_colcde 	nvarchar(30) 	NULL,
	temp_coldsc	nvarchar(200) 	NULL, 
	-------------- 
	temp_venitm	nvarchar(30)	NULL,		-- Lester Wu 2005-10-18
	temp_imlnecde	varchar(30)		NULL
	) ON [PRIMARY]     

	
	------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Declare 
	@sql 	nvarchar(2000),
	@i 	int

	IF @startNo >= 2
	begin
		set @i = 1
		while @i < @startNo 
		begin
		                INSERT INTO #tempTable (temp_cocde,temp_itmno,temp_engdsc,temp_venno,temp_lnecde,temp_colcde,temp_coldsc, temp_venitm,temp_imlnecde) 
			VALUES ('','','','','','','', '','')

		set @i  = @i + 1
		end 		
	end


	-- select @cocde , @credat , @creusr , @productLineFm , @productLineTo , @itmnoFm , @itmnoTo , @startNo


--INSERT INTO #tempTable select ibi_cocde, ibi_itmno, ibi_engdsc, ibi_venno, ibi_lnecde, icf_colcde,icf_coldsc from IMBASINF , IMCOLINF , IMRTEMP
----INSERT INTO #tempTable select ' ', ibi_itmno, ibi_engdsc, ibi_venno, ibi_lnecde, icf_colcde,icf_coldsc from IMBASINF , IMCOLINF , IMRTEMP
INSERT INTO #tempTable select ' ', ibi_itmno, ibi_engdsc, ibi_venno, ibi_lnecde, 
			--icf_vencol,	Show Our Color Code instead of Vendor Color
			icf_colcde, 
			icf_coldsc , ivi_venitm
			-- Lester Wu 2006-03-01
			, icf_lnecde
			from IMBASINF , IMCOLINF , IMRTEMP, IMVENINF
--		   	where ibi_itmno = icf_itmno and ibi_cocde = @cocde and icf_cocde = @cocde
		   	where ibi_itmno = icf_itmno 
			and (
				(ibi_lnecde >= @productLineFm and ibi_lnecde <= @productLineTo )
				or (@productLineFm = ''  )
			) 
			and (
				(ibi_itmno >= @itmnoFm and ibi_itmno <= @itmnoTo) 
				or (@itmnoFm = '' )
			)
			and icf_vencol =  imr_colcde and imr_credat = @credat and imr_creusr = @creusr
			and ibi_itmno = ivi_itmno

	DELETE   FROM IMRTEMP WHERE imr_credat = @credat and imr_creusr = @creusr
	-- * Select data from Temporary  Table
	SELECT temp_cocde, temp_itmno, convert(varchar(200),temp_engdsc) as 'temp_engdsc', temp_venno, temp_lnecde, temp_colcde,temp_coldsc, temp_venitm
	-- Lester Wu 2006-03-01
	, isnull(left(temp_imlnecde,2),'') as 'icf_lnecde'
	 FROM #tempTable










GO
GRANT EXECUTE ON [dbo].[sp_select_IMR00008_SRcolor] TO [ERPUSER] AS [dbo]
GO
