/****** Object:  StoredProcedure [dbo].[sp_Insert_SCSHPMRK]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_Insert_SCSHPMRK]
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_SCSHPMRK]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 27/07/2003



/************************************************************************
Author:		Kenny Chan
Date:		21th dec, 2001
Description:	Insert data From SCSHPMRK
Parameter:	1. Company
		2. SC No.	
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_Insert_SCSHPMRK]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@ssm_cocde  nvarchar     (6),
@ssm_ordno  nvarchar     (20),
@ssm_imgnam  nvarchar     (30),
@ssm_imgpth  nvarchar     (200),
@ssm_shptyp  nvarchar     (6),
@ssm_engdsc  nvarchar     (1600),
@ssm_chndsc  nvarchar     (3200),
@ssm_engrmk  nvarchar     (1600),
@ssm_chnrmk  nvarchar     (3200),
@ssm_updusr  nvarchar     (30)

---------------------------------------------- 
 
AS
begin
Insert into  SCSHPMRK 
(
ssm_cocde,
ssm_ordno,
ssm_imgnam,
ssm_imgpth,
ssm_shptyp,
ssm_engdsc,
ssm_chndsc,
ssm_engrmk,
ssm_chnrmk,
ssm_creusr,
ssm_updusr,
ssm_credat,
ssm_upddat
)
Values
(
@ssm_cocde,
@ssm_ordno,
@ssm_imgnam,
@ssm_imgpth,
@ssm_shptyp,
@ssm_engdsc,
@ssm_chndsc,
@ssm_engrmk,
@ssm_chnrmk,
@ssm_updusr,
@ssm_updusr,
GETDATE(),
GETDATE()
)                                                 
---------------------------------------------------------- 
end




GO
GRANT EXECUTE ON [dbo].[sp_Insert_SCSHPMRK] TO [ERPUSER] AS [dbo]
GO
