/****** Object:  StoredProcedure [dbo].[sp_update_SAORDDTL_Cancel]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SAORDDTL_Cancel]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SAORDDTL_Cancel]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- Checked by Allan Yuen at 28/07/2003

/************************************************************************
Author:		Kenny Chan
Date:		27-05-2002
************************************************************************/
------------------------------------------------- 
CREATE procedure [dbo].[sp_update_SAORDDTL_Cancel]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@qut_cocde  nvarchar     (6),
@qut_qutno  nvarchar     (20),
@qut_updusr  nvarchar     (30)
                                     
------------------------------------ 
AS
Update  SAORDDTL
SET	sad_delflg = 'C' ,	sad_updusr = @qut_updusr
Where	sad_cocde = @qut_cocde and
	sad_qutno = @qut_qutno




GO
GRANT EXECUTE ON [dbo].[sp_update_SAORDDTL_Cancel] TO [ERPUSER] AS [dbo]
GO
