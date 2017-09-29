/****** Object:  StoredProcedure [dbo].[sp_update_CUPRCTRM]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_CUPRCTRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_CUPRCTRM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE procedure [dbo].[sp_update_CUPRCTRM]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

@cpt_cocde nvarchar(6),
@cpt_cusno nvarchar(6),
@cpt_prcdef nvarchar(20),
@cpt_prctrm nvarchar(20),
@cpt_updusr nvarchar(30)


                                   
----------------------------------- 
AS


update  CUPRCTRM set cpt_prcdef = @cpt_prcdef , cpt_updusr = @cpt_updusr , cpt_upddat = getdate()
where cpt_cusno = @cpt_cusno and cpt_prctrm = @cpt_prctrm







GO
GRANT EXECUTE ON [dbo].[sp_update_CUPRCTRM] TO [ERPUSER] AS [dbo]
GO
