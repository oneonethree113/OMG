/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRGRP]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_SYUSRGRP]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SYUSRGRP]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO




/*	Author : Tommy Ho	*/

CREATE PROCEDURE [dbo].[sp_select_SYUSRGRP] 

@cocde nvarchar(6),
@usrid nvarchar(30)

AS

select distinct a.yug_usrfun, a.yug_fundsc, a.yug_assrig, a.yug_usrgrp
from syusrprf b , syusrgrp a, syusrfun c
where 	a.yug_usrgrp = b.yup_usrgrp and b.yup_usrid = @usrid and b.yup_cocde = @cocde and
	a.yug_usrfun = c.yuf_usrfun and c.yuf_cocde = @cocde and a.yug_cocde = @cocde





GO
GRANT EXECUTE ON [dbo].[sp_select_SYUSRGRP] TO [ERPUSER] AS [dbo]
GO
