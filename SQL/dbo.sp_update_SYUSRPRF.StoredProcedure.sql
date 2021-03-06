/****** Object:  StoredProcedure [dbo].[sp_update_SYUSRPRF]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SYUSRPRF]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SYUSRPRF]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






------------------------------------------------- 
CREATE procedure [dbo].[sp_update_SYUSRPRF]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@yup_cocde 	nvarchar(6),
@yup_usrid	nvarchar(30),
@yup_usrnam	nvarchar(50),
@yup_usrpwd	nvarchar(50),
@yup_usrpwd1	nvarchar(50),
@yup_usrpwd2	nvarchar(50),
@yup_expdat	datetime,
@yup_usrgrp  	nvarchar(6),
@yup_usrank	int,
@yup_supid	nvarchar(30),
@yup_flgcst	nvarchar(5),
@yup_flgrel	nvarchar(1),
@yup_mailad	nvarchar(50),
@yup_updusr	nvarchar(30),
@yup_accexp	datetime
                                   
------------------------------------ 
AS
 
update SYUSRPRF
SET
yup_usrnam = @yup_usrnam, 	yup_paswrd2 = @yup_usrpwd2, 
yup_paswrd1 = @yup_usrpwd1, 	yup_paswrd =@yup_usrpwd,
yup_expdat = @yup_expdat,		yup_usrgrp = @yup_usrgrp,
yup_usrank = @yup_usrank,		yup_supid = @yup_supid,
yup_flgcst = @yup_flgcst,		yup_flgrel = @yup_flgrel,
yup_mailad = @yup_mailad,		yup_updusr = @yup_updusr,
yup_upddat = getdate(),		yup_accexp = @yup_accexp

where 
yup_cocde = @yup_cocde and
yup_usrid = @yup_usrid
---------------------------------------------------------------------------------------------------------------------------------------------------------------------






GO
GRANT EXECUTE ON [dbo].[sp_update_SYUSRPRF] TO [ERPUSER] AS [dbo]
GO
