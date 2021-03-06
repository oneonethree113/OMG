/****** Object:  StoredProcedure [dbo].[sp_insert_SYUSRPRF_1]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SYUSRPRF_1]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SYUSRPRF_1]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO





/*	Author : Tommy Ho	*/

CREATE PROCEDURE [dbo].[sp_insert_SYUSRPRF_1] 
--------------------------------------------------------------------------------------------------------------------------------------

@yup_cocde	nvarchar(6),
@yup_usrid	nvarchar(30),
@yup_usrnam	nvarchar(50),
@yup_paswrd	nvarchar(50),
@yup_expdat	datetime,
--@yup_usrgrp	nvarchar(6),
--@yup_usrank	int,
--@yup_supid	nvarchar(30),
--@yup_flgcst	nvarchar(5),
--@yup_flgrel	nvarchar(1),
@yup_mailad	nvarchar(50),
@yup_creusr	nvarchar(30),
@yup_accexp	datetime

--------------------------------------------------------------------------------------------------------------------------------------
AS

INSERT INTO SYUSRPRF
(
yup_cocde,	yup_usrid,	yup_usrnam,
yup_paswrd,	yup_expdat,	yup_usrgrp,
yup_usrank,	yup_supid,	yup_flgcst,
yup_flgrel,	
yup_mailad,	yup_creusr,
yup_updusr,	yup_credat,		yup_upddat,
yup_paswrd1, 	yup_paswrd2,	yup_accexp
)
--------------------------------------------------------------------------------------------------------------------------------------
values
(
@yup_cocde,	@yup_usrid,	@yup_usrnam,
@yup_paswrd,	@yup_expdat,	'OUT',--@yup_usrgrp,
9, --@yup_usrank,	
'MIS', --@yup_supid,	
0, --@yup_flgcst,
0,  --@yup_flgrel,	
@yup_mailad,	@yup_creusr,
@yup_creusr,	getdate(),		getdate(),
'',		'',		@yup_accexp

)






GO
GRANT EXECUTE ON [dbo].[sp_insert_SYUSRPRF_1] TO [ERPUSER] AS [dbo]
GO
