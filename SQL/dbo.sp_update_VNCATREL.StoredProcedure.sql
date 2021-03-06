/****** Object:  StoredProcedure [dbo].[sp_update_VNCATREL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_VNCATREL]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_VNCATREL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





-- Checked by Allan Yuen at 28/07/2003


------------------------------------------------- 
CREATE procedure [dbo].[sp_update_VNCATREL]
                                                                                                                                                                                                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
@vcr_cocde 	nvarchar(6),
@vcr_venno  	nvarchar(6),
@vcr_catseq	int,
@vcr_catlvl0	nvarchar(20),
@vcr_catlvl1	nvarchar(20),
@vcr_catlvl2	nvarchar(20),
@vcr_catlvl3	nvarchar(20),
@vcr_catlvl4	nvarchar(20),
@vcr_updusr	nvarchar(30)
                                   
----------------------------------- 
AS
 
update VNCATREL
SET

vcr_catlvl0	= @vcr_catlvl0,
vcr_catlvl1	= @vcr_catlvl1,
vcr_catlvl2	= @vcr_catlvl2,
vcr_catlvl3	= @vcr_catlvl3,
vcr_catlvl4	= @vcr_catlvl4,
vcr_updusr	= @vcr_updusr,
vcr_upddat 	= getdate()

where 
--vcr_cocde	= @vcr_cocde and
--vcr_cocde	= ' ' and
vcr_venno	= @vcr_venno and
vcr_catseq	= @vcr_catseq
---------------------------------------------------------------------------------------------------------------------------------------------------------------------



GO
GRANT EXECUTE ON [dbo].[sp_update_VNCATREL] TO [ERPUSER] AS [dbo]
GO
