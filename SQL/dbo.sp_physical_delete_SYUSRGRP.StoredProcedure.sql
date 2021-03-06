/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYUSRGRP]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_physical_delete_SYUSRGRP]
GO
/****** Object:  StoredProcedure [dbo].[sp_physical_delete_SYUSRGRP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




/*
=========================================================
Program ID	: sp_physical_delete_SYUSRGRP
Description   	: Delete User Grp rights
Programmer  		Lewis To	: 
Create Date   	: 	8 Jul 2003
Last Modified  	: 	
Table Read(s) 	:	
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 8 Jul 2003		Lewis To		Change to ignor company code for multi company        
14 Apr 2005	Lester Wu		add company group
=========================================================     
*/




CREATE PROCEDURE [dbo].[sp_physical_delete_SYUSRGRP] 

@yug_cocde nvarchar(6),
@yug_usrgrp nvarchar(6),
@yug_usrfun nvarchar(10),
@yug_cogrp nvarchar(6)

AS


delete from SYUSRGRP
where 	--yug_cocde = @yug_cocde	-- No Company Code is need to check by Lewis on 20030708
--and
 	yug_usrgrp = @yug_usrgrp
and 	yug_usrfun = @yug_usrfun
and	yug_cogrp = @yug_cogrp	--Lester Wu 2005-04-14 add company group





GO
GRANT EXECUTE ON [dbo].[sp_physical_delete_SYUSRGRP] TO [ERPUSER] AS [dbo]
GO
