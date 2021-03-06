/****** Object:  StoredProcedure [dbo].[sp_select_SYCOMGRP]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYCOMGRP]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYCOMGRP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
	Program ID 	: sp_select_SYCOMGRP
	Description		: retrieve available company information from database
	Programmer	: Lester Wu
	Create Date		: 2005/04/21
******************************************************************************************************************************
Update History
******************************************************************************************************************************
Last Update	Updated by		Description
******************************************************************************************************************************

******************************************************************************************************************************/

create procedure [dbo].[sp_select_SYCOMGRP]
@cocde	nvarchar(6)
as
begin
	select distinct yco_cogrp as 'compGrp'
	from SYCOMINF

end



GO
GRANT EXECUTE ON [dbo].[sp_select_SYCOMGRP] TO [ERPUSER] AS [dbo]
GO
