/****** Object:  StoredProcedure [dbo].[sp_insert_SHSMPINV]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_SHSMPINV]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_SHSMPINV]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








------------------------------------------------- 
CREATE              procedure [dbo].[sp_insert_SHSMPINV]                                                                                                                                                                                                                                                                
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
 
insert into  SHSMPINV
(
hsi_cocde,
hsi_cus1no,
hsi_shpno,
hsi_shinvno,
hsi_sminvno,
hsi_rmk,
hsi_creusr,
hsi_updusr,
hsi_credat,
hsi_upddat
)

values(
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

@hsi_cocde,
@hsi_cus1no,
@hsi_shpno,
@hsi_shinvno,
@hsi_sminvno,
@hsi_rmk,
@hsi_creusr,
@hsi_creusr,
getdate(),
getdate()
)     
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

 












GO
GRANT EXECUTE ON [dbo].[sp_insert_SHSMPINV] TO [ERPUSER] AS [dbo]
GO
