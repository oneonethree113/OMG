/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRGRP_1]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYUSRGRP_1]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRGRP_1]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/*	Author : Tommy Ho	*/
/*
=========================================================
Program ID	: 	sp_select_SYUSRGRP_1
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
2 Jul 2003	Lewis To	Remark condition for company code
				to get all compnay group for the user               
22 April 2005	Allan Yuen	Add company group selection.
=========================================================     
*/
CREATE PROCEDURE [dbo].[sp_select_SYUSRGRP_1] 
@cocde nvarchar(6),
@cogrp varchar(6),
@usrid nvarchar(30)

AS

select distinct a.yug_usrfun, a.yug_fundsc, a.yug_assrig, a.yug_usrgrp
--from syusrprf b , syusrgrp a, syusrfun c
from symusrco b 
left join syusrgrp a on --a.yug_cocde = b.yuc_cocde and 
		a.yug_usrgrp = b.yuc_usrgrp and
		a.yug_cogrp = @cogrp
left join  syusrfun c on --c.yuf_cocde = b.yuc_cocde and  
		a.yug_usrfun = c.yuf_usrfun
where 	--a.yug_usrgrp = b.yuc_usrgrp 
--and 
b.yuc_usrid = @usrid 
and a.yug_cogrp = @cogrp
--and b.yuc_cocde = @cocde
--and a.yug_usrfun = c.yuf_usrfun 
--and c.yuf_cocde = b.yuc_cocde 
--and a.yug_cocde = b.yuc_cocde



GO
GRANT EXECUTE ON [dbo].[sp_select_SYUSRGRP_1] TO [ERPUSER] AS [dbo]
GO
