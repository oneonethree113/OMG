/****** Object:  StoredProcedure [dbo].[sp_select_CUGRPINF]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUGRPINF]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUGRPINF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO




/*=========================================================
Program ID	: 	sp_select_CUGRPINF
Description   	: 
Programmer  	: 	Carlos Lui
Create Date   	: 	2012-12-28
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description

=========================================================
*/


CREATE  PROCEDURE [dbo].[sp_select_CUGRPINF] 

@cocde	nvarchar(6)

AS

select 	cgi_cocde,		cgi_cugrpcde,	cgi_cugrpdsc,
	cgi_flg_int,		cgi_flg_ext
from 	CUGRPINF
where	cgi_cocde = @cocde
order by 	cgi_cocde, cgi_cugrpcde





GO
GRANT EXECUTE ON [dbo].[sp_select_CUGRPINF] TO [ERPUSER] AS [dbo]
GO
