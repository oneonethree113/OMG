/****** Object:  StoredProcedure [dbo].[sp_update_PKREQHDR_CAN]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_PKREQHDR_CAN]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_PKREQHDR_CAN]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_update_PKREQHDR_CAN]

@cocde nvarchar(20),
@reqno nvarchar(20),
@user nvarchar(30)

as

update 
pkreqhdr set 
prh_status = 'CAN',
prh_upddat = getdate(),
prh_TONO ='',
prh_SCNO = '',
prh_updusr = @user

where prh_cocde = @cocde and prh_reqno = @reqno




GO
GRANT EXECUTE ON [dbo].[sp_update_PKREQHDR_CAN] TO [ERPUSER] AS [dbo]
GO
