/****** Object:  StoredProcedure [dbo].[sp_select_IMCSTINFH]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMCSTINFH]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMCSTINFH]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO








-- Checked by Allan Yuen at 30/07/2003

/*
=========================================================
Program ID	: 
Description   	: 
Programmer  	: 
Create Date   	: 
Last Modified  	: 03 JAN 2006
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
*/

CREATE procedure [dbo].[sp_select_IMCSTINFH]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ici_cocde nvarchar(6) ,
@ici_itmno nvarchar(20) 
                                               
---------------------------------------------- 
 
AS


begin
Select 
	ici_cocde,
	ici_itmno,
	ici_cstrmk,
	convert(varchar(10),ici_expdat,101) as 'ici_expdat',
	ici_creusr,
	ici_updusr,
	ici_credat,
	ici_upddat,
	cast(ici_timstp as int) as 'ici_timstp'
from 
	IMCSTINFH
where
	 ici_itmno = @ici_itmno
end



GO
GRANT EXECUTE ON [dbo].[sp_select_IMCSTINFH] TO [ERPUSER] AS [dbo]
GO
