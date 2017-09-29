/****** Object:  StoredProcedure [dbo].[sp_update_VNPRCTRM]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_VNPRCTRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_VNPRCTRM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE procedure [dbo].[sp_update_VNPRCTRM]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

@vpt_cocde nvarchar(6),
@vpt_venno nvarchar(6),
@vpt_prcdef nvarchar(20),
@vpt_prctrm nvarchar(20),
@vpt_updusr nvarchar(30)


                                   
----------------------------------- 
AS


update  VNPRCTRM set vpt_prcdef = @vpt_prcdef , vpt_updusr = @vpt_updusr , vpt_upddat = getdate()
where vpt_venno = @vpt_venno and vpt_prctrm = @vpt_prctrm







GO
GRANT EXECUTE ON [dbo].[sp_update_VNPRCTRM] TO [ERPUSER] AS [dbo]
GO
