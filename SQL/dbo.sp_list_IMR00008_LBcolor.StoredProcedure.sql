/****** Object:  StoredProcedure [dbo].[sp_list_IMR00008_LBcolor]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_IMR00008_LBcolor]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_IMR00008_LBcolor]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







-- Checked by Allan Yuen at 28/07/2003


/************************************************************************
Author:		Louis Siu
Date:		14th Jan, 2002
Description:	Bar Code Printing Report - data apply to List Box by Color
************************************************************************
2005-07-15	Allan Yuen		Change read color code from icf_colcde -> icf_vencol.
*/

	CREATE PROCEDURE [dbo].[sp_list_IMR00008_LBcolor] 

	@cocde		nvarchar(6),
	@productLineFm	nvarchar(10),
	@productLineTo	nvarchar(10),
	@itmnoFm	nvarchar(20),
	@itmnoTo		nvarchar(20)

	AS


	BEGIN


	Declare 
		@plft	nvarchar(1),
		@itmft	nvarchar(1)

	set @plft = 'N'
		If @productLineFm = '' and @productLineTo = ''
		begin
			set @plft = 'Y'
		end

	set @itmft = 'N'
		If @itmnoFm = '' and @itmnoTo = ''
		begin
			set @itmft = 'Y'
		end



		select 
			distinct icf_colcde, ibi_itmno, ibi_lnecde 
--			distinct icf_vencol, ibi_itmno, ibi_lnecde 
		from 
			IMBASINF, IMCOLINF 
		where 
			ibi_itmno = icf_itmno and 
			--ibi_cocde = @cocde and 
			--icf_cocde = @cocde and 
--			((@plft = 'N' and ibi_lnecde between @productLineFm and @productLineTo and ibi_cocde = @cocde) or (@plft = 'Y')) and
--			((@itmft = 'N' and ibi_itmno between @itmnoFm and @itmnoTo and ibi_cocde = @cocde) or (@itmft = 'Y')) 
			((@plft = 'N' and ibi_lnecde between @productLineFm and @productLineTo ) or (@plft = 'Y')) and
			((@itmft = 'N' and ibi_itmno between @itmnoFm and @itmnoTo ) or (@itmft = 'Y')) 
		order by 
--			icf_vencol
			icf_colcde



/*
		select distinct icf_colcde from IMBASINF , IMCOLINF where ibi_itmno = icf_itmno and ibi_cocde = @cocde and icf_cocde = @cocde and 
--		((ibi_lnecde >= @productLineFm and ibi_lnecde <= @productLineTo and ibi_cocde = @cocde) or (ibi_lnecde = '' and ibi_cocde = @cocde)) 
		((ibi_lnecde >= @productLineFm and ibi_lnecde <= @productLineTo and ibi_cocde = @cocde) or (ibi_cocde = @cocde))
		and (ibi_itmno >= @itmnoFm and ibi_itmno <= @itmnoTo and ibi_cocde = @cocde) order by icf_colcde
*/



	END



GO
GRANT EXECUTE ON [dbo].[sp_list_IMR00008_LBcolor] TO [ERPUSER] AS [dbo]
GO
