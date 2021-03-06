/****** Object:  StoredProcedure [dbo].[sp_update_CUCALFML_EFFDAT]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_CUCALFML_EFFDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_CUCALFML_EFFDAT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE procedure [dbo].[sp_update_CUCALFML_EFFDAT]
                                                                                                                                                                                                                                                                 
	@ccf_cocde nvarchar(6),
	@ccf_cus1no nvarchar(10),
	@ccf_cus2no nvarchar(10),
	@ccf_cat nvarchar(20),
            @ccf_venno nvarchar(10),
            @ccf_prctrm nvarchar(10),
            @ccf_trantrm  nvarchar(10),
            @ccf_curcde nvarchar(10),
            @ccf_cumu numeric(13,4),
            @ccf_pm numeric(13,4),
            @ccf_cush numeric(13,4),
            @ccf_thccusper numeric(13,4),
            @ccf_upsper numeric(13,4),
            @ccf_labper numeric(13,4),
            @ccf_faper numeric(13,4),
            @ccf_cstbufper numeric(13,4),
            @ccf_othper  numeric(13,4),
            @ccf_pliper numeric(13,4),
            @ccf_dmdper numeric(13,4),
            @ccf_rbtper numeric(13,4),
            @ccf_pkgper numeric(13,4),
            @ccf_comper numeric(13,4),
            @ccf_icmper numeric(13,4),
	@ccf_effdat datetime,
	@ccf_iseff nvarchar(1),
 	@User nvarchar(30)
AS

begin

Update CUCALFML set
ccf_cumu = @ccf_cumu ,
ccf_pm = @ccf_pm,
ccf_cush = @ccf_cush,
ccf_thccusper = @ccf_thccusper,
ccf_upsper = @ccf_upsper,
ccf_labper = @ccf_labper,
ccf_faper = @ccf_faper,
ccf_cstbufper = @ccf_cstbufper,
ccf_othper = @ccf_othper,
ccf_pliper = @ccf_pliper,
ccf_dmdper = @ccf_dmdper,
ccf_rbtper = @ccf_rbtper,
ccf_comper = @ccf_comper ,
ccf_iseff = @ccf_iseff,
ccf_updusr = @User,
ccf_upddat = getdate()
where
ccf_cus1no = @ccf_cus1no and
ccf_cus2no = @ccf_cus2no and
ccf_cat = @ccf_cat and
ccf_venno = @ccf_venno and 
ccf_prctrm = @ccf_prctrm and 
ccf_trantrm = @ccf_trantrm and
ccf_effdat = @ccf_effdat

end









GO
GRANT EXECUTE ON [dbo].[sp_update_CUCALFML_EFFDAT] TO [ERPUSER] AS [dbo]
GO
