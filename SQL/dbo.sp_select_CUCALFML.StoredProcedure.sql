/****** Object:  StoredProcedure [dbo].[sp_select_CUCALFML]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_CUCALFML]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_CUCALFML]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE procedure [dbo].[sp_select_CUCALFML]
                                                                                                                                                                                                                                                                 

@cbi_cocde nvarchar(6) ,
@cbi_cusno nvarchar(20) 
 
AS

begin

declare @cus1 as char(1)
set @cus1 = left(@cbi_cusno,1)

declare @pricus as nvarchar(10)
declare @seccus as nvarchar(10)


if @cus1 = '6' 
begin

select 
'' as 'DEL',
ccf_cocde,
ccf_cus1no,
ccf_cus2no,
ccf_cat,
ccf_venno,
ccf_prctrm,
ccf_trantrm,
ccf_curcde,
ccf_cumu * 100 as 'ccf_cumu',
ccf_pm * 100 as 'ccf_pm',
ccf_cush * 100 as 'ccf_cush',
ccf_thccusper * 100  as 'ccf_thccusper',
ccf_upsper * 100  as 'ccf_upsper',
ccf_labper * 100 as 'ccf_labper',
ccf_faper * 100  as 'ccf_faper',
ccf_cstbufper * 100  as 'ccf_cstbufper',
ccf_othper * 100  as 'ccf_othper',
ccf_pliper * 100  as 'ccf_pliper',
ccf_dmdper * 100 as 'ccf_dmdper',
ccf_rbtper * 100 as 'ccf_rbtper',
ccf_pkgper * 100 as 'ccf_pkgper',
ccf_comper * 100 as 'ccf_comper',
ccf_icmper * 100 as 'ccf_icmper',
(ccf_cumu + ccf_pm + ccf_thccusper + ccf_upsper + ccf_labper + ccf_faper + ccf_cstbufper + ccf_othper + ccf_pliper + ccf_dmdper + ccf_rbtper) * 100  as 'ccf_subttl',
ccf_creusr,
ccf_updusr,
ccf_credat,
ccf_upddat,
ccf_latest,
ccf_effdat,
ccf_iseff
from CUCALFML (nolock)
where ccf_cus2no = @cbi_cusno

end
else
begin

select 
'' as 'DEL',
ccf_cocde,
ccf_cus1no,
ccf_cus2no,
ccf_cat,
ccf_venno,
ccf_prctrm,
ccf_trantrm,
ccf_curcde,
ccf_cumu * 100 as 'ccf_cumu',
ccf_pm * 100 as 'ccf_pm',
ccf_cush * 100 as 'ccf_cush',
ccf_thccusper * 100  as 'ccf_thccusper',
ccf_upsper * 100  as 'ccf_upsper',
ccf_labper * 100 as 'ccf_labper',
ccf_faper * 100  as 'ccf_faper',
ccf_cstbufper * 100  as 'ccf_cstbufper',
ccf_othper * 100  as 'ccf_othper',
ccf_pliper * 100  as 'ccf_pliper',
ccf_dmdper * 100 as 'ccf_dmdper',
ccf_rbtper * 100 as 'ccf_rbtper',
ccf_pkgper * 100 as 'ccf_pkgper',
ccf_comper * 100 as 'ccf_comper',
ccf_icmper * 100 as 'ccf_icmper',
(ccf_cumu + ccf_pm + ccf_thccusper + ccf_upsper + ccf_labper + ccf_faper + ccf_cstbufper + ccf_othper + ccf_pliper + ccf_dmdper + ccf_rbtper) * 100  as 'ccf_subttl',
ccf_creusr,
ccf_updusr,
ccf_credat,
ccf_upddat,
ccf_latest,
ccf_effdat,
ccf_iseff
from CUCALFML (nolock)
where ccf_cus1no = @cbi_cusno and ccf_cus2no = ''

end







end






GO
GRANT EXECUTE ON [dbo].[sp_select_CUCALFML] TO [ERPUSER] AS [dbo]
GO
