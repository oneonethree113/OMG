/****** Object:  StoredProcedure [dbo].[sp_list_VNCUGREL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_VNCUGREL]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_VNCUGREL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[sp_list_VNCUGREL]
                                                                                                                                                                                                                                                               
@vcr_cocde 	nvarchar(6) ,
@vcr_venno 	nvarchar(6)

AS
Select 

vcr_cocde,
vcr_venno,
vcr_cugrpcde,
vcr_flg_int,
vcr_flg_ext,
icf_mrkup,
vcr_creusr,
vcr_updusr,
vcr_credat,
vcr_upddat,
vcr_timstp
 

from VNCUGREL
left join IMCGCFML 
on	vcr_venno = icf_venno and vcr_cugrpcde = icf_cugrpcde

where vcr_venno = @vcr_venno

order by vcr_cugrpcde









GO
GRANT EXECUTE ON [dbo].[sp_list_VNCUGREL] TO [ERPUSER] AS [dbo]
GO
