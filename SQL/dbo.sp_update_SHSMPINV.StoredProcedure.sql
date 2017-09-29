/****** Object:  StoredProcedure [dbo].[sp_update_SHSMPINV]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SHSMPINV]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SHSMPINV]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO










CREATE               procedure [dbo].[sp_update_SHSMPINV]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@hsi_cocde nvarchar (6),
@hsi_cus1no nvarchar (6),
@hsi_shpno nvarchar (20) ,
@hsi_shinvno nvarchar (20) ,
@hsi_sminvno nvarchar (20) ,
@hsi_rmk nvarchar (1000) ,
@hsi_creusr nvarchar (30)   
                                     
------------------------------------ 
AS
 
update   SHSMPINV
set 
hsi_cus1no=@hsi_cus1no,
hsi_sminvno=@hsi_sminvno,
hsi_rmk=@hsi_rmk,
hsi_creusr=@hsi_creusr,
hsi_updusr=@hsi_creusr,
hsi_credat=getdate(),
hsi_upddat =getdate()

where
hsi_cocde	=@hsi_cocde and 
hsi_shpno	=@hsi_shpno and
hsi_shinvno	=@hsi_shinvno and
hsi_sminvno	=@hsi_sminvno 



---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------


 









GO
GRANT EXECUTE ON [dbo].[sp_update_SHSMPINV] TO [ERPUSER] AS [dbo]
GO
