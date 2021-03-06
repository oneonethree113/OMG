/****** Object:  StoredProcedure [dbo].[sp_Update_SHSHPMRK]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_Update_SHSHPMRK]
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_SHSHPMRK]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO









-- Checked by Allan Yuen at 28/07/2003


/************************************************************************
Author:		Johnson Lai
Date:		20th Jan, 2001
Description:	Update data From SHSHPMRK
Parameter:	1. Company
		2. Ship No
		3. Inv no
		4. Ord no
		5 ShpTyp
************************************************************************/
------------------------------------------------- 
CREATE   procedure [dbo].[sp_Update_SHSHPMRK]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@hsm_cocde  	nvarchar  	(6),
@hsm_shpno 	nvarchar 	(20),
@hsm_invno	nvarchar  (20),
@hsm_ordno  	nvarchar  	(20),
@hsm_shptyp  	nvarchar  	(6),
@hsm_imgnam 	nvarchar  	(30),
@hsm_imgpth  	nvarchar 	(200),
@hsm_engdsc  	nvarchar  (1600),
@hsm_engrmk  	nvarchar  (1600),
@hsm_updusr  	nvarchar  (30)

---------------------------------------------- 
 
AS
begin
Update SHSHPMRK 
Set

hsm_ordno 	= 	@hsm_ordno,
hsm_shptyp	= 	@hsm_shptyp,
hsm_imgnam 	=	@hsm_imgnam,
hsm_imgpth	= 	@hsm_imgpth,
hsm_engdsc	= 	@hsm_engdsc,
hsm_engrmk	= 	@hsm_engrmk,
hsm_updusr	=	@hsm_updusr,
hsm_upddat	=	Getdate()

Where 
hsm_cocde = @hsm_cocde and
hsm_shpno = @hsm_shpno and
hsm_invno = @hsm_invno 
--and 
--hsm_ordno 	= 	@hsm_ordno 

---------------------------------------------------------- 
end









GO
GRANT EXECUTE ON [dbo].[sp_Update_SHSHPMRK] TO [ERPUSER] AS [dbo]
GO
