/****** Object:  StoredProcedure [dbo].[sp_list_VNPRCTRM]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_VNPRCTRM]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_VNPRCTRM]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO














CREATE  procedure [dbo].[sp_list_VNPRCTRM]
                                                                                                                                                                                                                                                                
@vpt_cocde 	nvarchar(6) ,
@vpt_venno 	nvarchar(6)

AS
Select 

vpt_cocde,
vpt_venno,
vpt_prctrm + ' - ' + ltrim(rtrim(isnull(ysi_dsc,''))) as 'vpt_prctrm',
vpt_prcdef,
vpt_creusr,
vpt_updusr,
vpt_credat,
vpt_upddat,
vpt_timstp

 

from dbo.VNPRCTRM left join  SYSETINF on vpt_prctrm = ysi_cde


where vpt_venno  = @vpt_venno and ysi_typ = '03'

 











GO
GRANT EXECUTE ON [dbo].[sp_list_VNPRCTRM] TO [ERPUSER] AS [dbo]
GO
