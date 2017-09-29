/****** Object:  StoredProcedure [dbo].[sp_insert_VNPRCTRM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_VNPRCTRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_VNPRCTRM]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE procedure [dbo].[sp_insert_VNPRCTRM]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

@vpt_cocde nvarchar(6),
@vpt_venno nvarchar(6),
@vpt_prctrm nvarchar(6),
@vpt_prcdef char(1),
@vpt_updusr nvarchar(30)


                                   
----------------------------------- 
AS




insert into VNPRCTRM 

(
vpt_cocde, vpt_venno, vpt_prctrm, vpt_prcdef, vpt_creusr, vpt_updusr, vpt_credat, vpt_upddat, vpt_timstp
)
values
(
' ',@vpt_venno,@vpt_prctrm,@vpt_prcdef,@vpt_updusr,@vpt_updusr,getdate(),getdate(),null
)




GO
GRANT EXECUTE ON [dbo].[sp_insert_VNPRCTRM] TO [ERPUSER] AS [dbo]
GO
