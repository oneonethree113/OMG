/****** Object:  StoredProcedure [dbo].[sp_select_QUPRCEMT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUPRCEMT]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUPRCEMT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO









/*=========================================================
Program ID	: 	sp_select_QUPRCEMT
Description   	: 
Programmer  	: 	Carlos Lui
ALTER  Date   	: 	2013-05-14
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description

=========================================================
*/


CREATE    PROCEDURE [dbo].[sp_select_QUPRCEMT] 

@cocde	nvarchar(6),
@qutno	nvarchar(20),
@qutseq	int

AS

If @qutseq <> ''
begin
	select	qpe_cocde,		qpe_qutno,		qpe_qutseq,
		qpe_itmno,		qpe_untcde,	qpe_inrqty,
		qpe_mtrqty,	qpe_cft,		qpe_cbm,
		qpe_ftyprctrm,	qpe_prctrm,	qpe_trantrm,
		qpe_fml_cus1no,	qpe_fml_cus2no,	qpe_fml_cat,
		qpe_fml_venno, qpe_fml_prctrm, qpe_fml_trantrm, qpe_fml_ventranflg,
		qpe_fcurcde,
		qpe_ftycst,		qpe_ftyprc,		qpe_curcde,
		qpe_basprc,	qpe_mu,		qpe_mumin,
		qpe_muprc,	qpe_cus1sp,	qpe_cus1dp,
		qpe_cushcstbufper,	qpe_cushcstbufamt,	qpe_othdisper,
		qpe_maxapvper,	qpe_maxapvamt,	qpe_spmuper,
		qpe_dpmuper,	qpe_cumu,		qpe_pm,
		qpe_cush,		qpe_thccusper,	qpe_upsper,
		qpe_labper,		qpe_faper,		qpe_cstbufper,
		qpe_othper,	qpe_pliper,		qpe_dmdper,
		qpe_rbtper,		qpe_subttlper,	qpe_pkgper,
		qpe_comper,	qpe_icmper,	qpe_stdprc,	
		qpe_ftycstA,		qpe_ftycstB,		qpe_ftycstC,
		qpe_ftycstD,		qpe_ftycstTran,		qpe_ftycstPack,
		qpe_lightspec,
		qpe_creusr,		qpe_updusr,	qpe_credat,	
		qpe_upddat
	from 	QUPRCEMT
	where	qpe_cocde = @cocde	and
		qpe_qutno = @qutno	and
		qpe_qutseq = @qutseq
end
else
begin
	select	qpe_cocde,		qpe_qutno,		qpe_qutseq,
		qpe_itmno,		qpe_untcde,	qpe_inrqty,
		qpe_mtrqty,	qpe_cft,		qpe_cbm,
		qpe_ftyprctrm,	qpe_prctrm,	qpe_trantrm,
		qpe_fml_cus1no,	qpe_fml_cus2no,	qpe_fml_cat,
		qpe_fml_venno, qpe_fml_prctrm, qpe_fml_trantrm, qpe_fml_ventranflg,
		qpe_fcurcde,
		qpe_ftycst,		qpe_ftyprc,		qpe_curcde,
		qpe_basprc,	qpe_mu,		qpe_mumin,
		qpe_muprc,	qpe_cus1sp,	qpe_cus1dp,
		qpe_cushcstbufper,	qpe_cushcstbufamt,	qpe_othdisper,
		qpe_maxapvper,	qpe_maxapvamt,	qpe_spmuper,
		qpe_dpmuper,	qpe_cumu,		qpe_pm,
		qpe_cush,		qpe_thccusper,	qpe_upsper,
		qpe_labper,		qpe_faper,		qpe_cstbufper,
		qpe_othper,	qpe_pliper,		qpe_dmdper,
		qpe_rbtper,		qpe_subttlper,	qpe_pkgper,
		qpe_comper,	qpe_icmper,	qpe_stdprc,	
		qpe_ftycstA,		qpe_ftycstB,		qpe_ftycstC,
		qpe_ftycstD,		qpe_ftycstTran,		qpe_ftycstPack,
		qpe_lightspec,
		qpe_creusr,		qpe_updusr,	qpe_credat,	
		qpe_upddat
	from 	QUPRCEMT 
	where	qpe_cocde = @cocde	and
		qpe_qutno = @qutno
end








GO
GRANT EXECUTE ON [dbo].[sp_select_QUPRCEMT] TO [ERPUSER] AS [dbo]
GO
