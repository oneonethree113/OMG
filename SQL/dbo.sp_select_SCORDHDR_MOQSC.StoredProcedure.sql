/****** Object:  StoredProcedure [dbo].[sp_select_SCORDHDR_MOQSC]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCORDHDR_MOQSC]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCORDHDR_MOQSC]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
/*
Program ID	: sp_select_SCORDHDR_MOQSC
Author		: Lester Wu
Create Date		: 2007-10-07
Description		: SP to check MOQ SC# Exist
*/
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- Update Date		Update By		Description
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--
--
--
--
--
--
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- sp_select_SCORDHDR_MOQSC 'UCPP','US0700001','50036','','MIS'
CREATE procedure [dbo].[sp_select_SCORDHDR_MOQSC]
@cocde varchar(6),
@moqsc varchar(30),
@priCust varchar(10),
@secCust varchar(10),
@UserID varchar(30)
as
begin
	Declare @RET varchar(1000) , @cus1no varchar(10)
	set @RET = 'Invalid MOQ SC #'
	set @cus1no = ''

	set @moqsc = ltrim(rtrim(@moqsc))
	set @priCust = ltrim(rtrim(@priCust))
	set @secCust = ltrim(rtrim(@secCust))

	--select top 1 soh_cus1no from SCORDHDR where soh_ordno  = @moqsc 
	select top 1 @cus1no = soh_cus1no from SCORDHDR where soh_ordno = @moqsc 
	
	if @@ROWCOUNT > 0
	begin
		if @cus1no = @priCust
			set @RET = 'OK'
		else
			set @RET = 'MOQ SC # vs Primary Customer # Not Match!'
	end
		
	select @RET as 'RET'

end 
            





GO
GRANT EXECUTE ON [dbo].[sp_select_SCORDHDR_MOQSC] TO [ERPUSER] AS [dbo]
GO
