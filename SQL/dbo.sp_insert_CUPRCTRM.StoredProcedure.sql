/****** Object:  StoredProcedure [dbo].[sp_insert_CUPRCTRM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_CUPRCTRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_CUPRCTRM]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE procedure [dbo].[sp_insert_CUPRCTRM]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

@cpt_cocde nvarchar(6),
@cpt_cusno nvarchar(6),
@cpt_prctrm nvarchar(6),
@cpt_prcdef char(1),
@cpt_updusr nvarchar(30)


                                   
----------------------------------- 
AS




insert into CUPRCTRM 

(
cpt_cocde, cpt_cusno, cpt_prctrm, cpt_prcdef, cpt_creusr, cpt_updusr, cpt_credat, cpt_upddat, cpt_timstp
)
values
(
' ',@cpt_cusno,@cpt_prctrm,@cpt_prcdef,@cpt_updusr,@cpt_updusr,getdate(),getdate(),null
)




GO
GRANT EXECUTE ON [dbo].[sp_insert_CUPRCTRM] TO [ERPUSER] AS [dbo]
GO
