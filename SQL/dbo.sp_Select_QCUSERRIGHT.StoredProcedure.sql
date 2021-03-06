/****** Object:  StoredProcedure [dbo].[sp_Select_QCUSERRIGHT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Select_QCUSERRIGHT]
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_QCUSERRIGHT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  PROCEDURE [dbo].[sp_Select_QCUSERRIGHT] 
@usrid nvarchar(30)

AS
declare @cocde  nvarchar(6)
declare @cogrp  nvarchar(6)
set @cocde =''
set @cogrp = 'UCG'

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
and yug_usrfun like '%QCW%'
--and b.yuc_cocde = @cocde
--and a.yug_usrfun = c.yuf_usrfun 
--and c.yuf_cocde = b.yuc_cocde 
--and a.yug_cocde = b.yuc_cocde

---------


GO
GRANT EXECUTE ON [dbo].[sp_Select_QCUSERRIGHT] TO [ERPUSER] AS [dbo]
GO
