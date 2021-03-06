/****** Object:  StoredProcedure [dbo].[sp_update_IMM00008_venno]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMM00008_venno]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMM00008_venno]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
Author		: Lester Wu 
Create Date		: 2006-09-27
Description		: Script to batch Update Items base on data on Source Item
*/


-- sp_update_IMM00008 'UCPP','06A51DA002A01','06A51DA002A02,06A51DA002A03,06A51DA002A04,06A51DA002A05','ENG','MIS'

create procedure [dbo].[sp_update_IMM00008_venno]
@cocde	varchar(6),
@srcItem	varchar(30)
as
Begin
	select * from IMVENINF
	where ivi_itmno = @srcItem
	order by ivi_venno
End



GO
GRANT EXECUTE ON [dbo].[sp_update_IMM00008_venno] TO [ERPUSER] AS [dbo]
GO
