/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRGRP_COMP]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYUSRGRP_COMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRGRP_COMP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO






/*	Author : Tommy Ho	*/
/*
=========================================================
Program ID	: 	sp_select_SYUSRGRP_COMP
Description   	: Get User rights by Multi Comapny
Programmer  	: 
Create Date   	: 
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
               
=========================================================     
*/
CREATE PROCEDURE [dbo].[sp_select_SYUSRGRP_COMP] 

@cocde nvarchar(6),
@usrid nvarchar(30),
@form nvarchar(20)
AS

select distinct
yuc_cocde, 
yug_usrfun,
yuc_flgdef 
from symusrco b 
left join  syusrgrp on yug_usrgrp = yuc_usrgrp
where 	 
b.yuc_usrid = @usrid 
and yug_usrfun = @form
order by yuc_flgdef desc






GO
GRANT EXECUTE ON [dbo].[sp_select_SYUSRGRP_COMP] TO [ERPUSER] AS [dbo]
GO
