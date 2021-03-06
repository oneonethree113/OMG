/****** Object:  StoredProcedure [dbo].[sp_Spring_LOGIN_PDA]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_Spring_LOGIN_PDA]
GO
/****** Object:  StoredProcedure [dbo].[sp_Spring_LOGIN_PDA]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/*
=========================================================
Description   	: sp_Spring_LOGIN_PDA
Programmer  	: PIC
Create Date   	: 2002-07-30
Last Modified  	: 2003-07-22
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      Initial  	Description                          
=========================================================    */ 

CREATE procedure [dbo].[sp_Spring_LOGIN_PDA]

as

Select 
	distinct ' ' as 'yup_cocde', yup_usrid, yup_paswrd, yuc_usrgrp as 'yup_usrgrp', isnull(ysr_saltem,'') as 'ysr_saltem'
-- isnull(a.yuc_cocde,'')  as 'yup_cocde'
from  
	syusrprf (nolock)
	left join sysalrep (nolock) on --yup_cocde = ysr_cocde and 
					yup_usrid = ysr_code
	left join symusrco a (nolock) on a.yuc_usrid = yup_usrid
where 
--yup_cocde = 'UCP' and 
(a.yuc_usrgrp like 'SAL%'
or a.yuc_usrgrp like 'MGT%'
or a.yuc_usrgrp like 'MIS%'
or a.yuc_usrgrp like 'PIC%')

--and yup_cocde = 'UCP'

GO
GRANT EXECUTE ON [dbo].[sp_Spring_LOGIN_PDA] TO [ERPUSER] AS [dbo]
GO
