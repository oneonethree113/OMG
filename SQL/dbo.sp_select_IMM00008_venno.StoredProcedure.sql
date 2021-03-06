/****** Object:  StoredProcedure [dbo].[sp_select_IMM00008_venno]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMM00008_venno]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMM00008_venno]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
Author		: Lester Wu 
Create Date		: 2006-09-27
Description		: Script to batch Update Items base on data on Source Item
*/


-- sp_select_IMM00008_venno 'UCPP','06A51DA002A01','06A51DA002A02,06A51DA002A03,06A51DA002A04,06A51DA002A05'

CREATE procedure [dbo].[sp_select_IMM00008_venno]
@cocde	varchar(6),
@srcItem	varchar(30)
as
Begin
	--select * from IMVENINF where ivi_itmno = @srcItem
	

	select 
		ivi.*, isnull(vbi.vbi_vensna,'') as 'vbi_vensna' 
	from 
		IMVENINF ivi 
		left join VNBASINF  vbi on ivi.ivi_venno = vbi_venno
	where 
		ivi.ivi_itmno = @srcItem
	order by 
		isnull(ivi.ivi_venno,'')

End




GO
GRANT EXECUTE ON [dbo].[sp_select_IMM00008_venno] TO [ERPUSER] AS [dbo]
GO
