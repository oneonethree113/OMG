/****** Object:  StoredProcedure [dbo].[sp_select_IMITMCUSSTY_qu]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMITMCUSSTY_qu]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMITMCUSSTY_qu]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/************************************************************************
Author:		Lester Wu    
Date:		17th September, 2008
Description:	Select data From IMITMCUSSTY
***********************************************************************
*/

CREATE procedure [dbo].[sp_select_IMITMCUSSTY_qu]
@cocde	nvarchar(6),
@iic_itmno	nvarchar(20),
@iic_cusno	nvarchar(20)




AS
begin
select * from IMITMCUSSTY
where 
iic_itmno = @iic_itmno and iic_cusno = @iic_cusno
and iic_sts = 'A'

END


GO
GRANT EXECUTE ON [dbo].[sp_select_IMITMCUSSTY_qu] TO [ERPUSER] AS [dbo]
GO
