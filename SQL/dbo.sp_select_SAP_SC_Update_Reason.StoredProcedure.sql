/****** Object:  StoredProcedure [dbo].[sp_select_SAP_SC_Update_Reason]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SAP_SC_Update_Reason]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SAP_SC_Update_Reason]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








CREATE  PROCEDURE [dbo].[sp_select_SAP_SC_Update_Reason] 

@cocde		nvarchar(10),
@jobord 		nvarchar(30)


AS


declare @reason	nvarchar(255)
declare @return nvarchar(255)
declare @scno	nvarchar(30)
declare @scseq	int
declare @pono	nvarchar(30)
declare @poseq	int

set @scno = ''
set @scseq = 0
set @pono = ''
set @poseq = 0
set @reason = ''

select top 1 @scno = pod_scno, @scseq = pod_scline, @pono = pod_purord,@poseq = pod_purseq from poorddtl(nolock) where pod_jobord = @jobord


--select top 1 * into #tmp_ERP_SC_DTL from scorddtl (nolock) where sod_ordno = @scno and sod_ordseq = @scseq


-- ERP PO DTL
declare
@pod_cocde_e		nvarchar(6),@pod_purord_e		nvarchar(20),@pod_purseq_e		int,@pod_prdven_e		nvarchar(3),
@pod_prdsubcde_e		nvarchar(5),@pod_itmno_e		nvarchar(20),@pod_itmsts_e		nvarchar(4),@pod_seccusitm_e		nvarchar(10),
@pod_venitm_e		nvarchar(20),@pod_cusitm_e		nvarchar(20),@pod_cussku_e		nvarchar(20),@pod_engdsc_e		nvarchar(800),
@pod_chndsc_e		nvarchar(1600),@pod_vencol_e		nvarchar(30),@pod_cuscol_e		nvarchar(30),@pod_coldsc_e		nvarchar(300),
@pod_pckseq_e		int,@pod_untcde_e		nvarchar(6),@pod_inrctn_e		nvarchar(20),@pod_mtrctn_e		nvarchar(20),
@pod_cubcft_e		numeric(11,4),@pod_cbm_e		numeric(11,4),@pod_dept_e		nvarchar(20),@pod_ordqty_e		int,
@pod_recqty_e		int,@pod_ftyprc_e		numeric(13,4),@pod_cuspno_e		nvarchar(20),@pod_respno_e		nvarchar(20),
@pod_hrmcde_e		nvarchar(20),@pod_lblcde_e		nvarchar(20),@pod_cususd_e		numeric(13,4),@pod_cuscad_e		numeric(13,4),
@pod_shpstr_e		datetime,@pod_shpend_e		datetime,@pod_candat_e		datetime,@pod_ctnstr_e		int,
@pod_ctnend_e		int,@pod_scno_e		nvarchar(20),@pod_ttlctn_e		int,@pod_lneamt_e		numeric(13,4),
@pod_lnecub_e		numeric(13,4),@pod_ttlqty_e		int,@pod_scline_e		int,@pod_jobord_e		nvarchar(20),
@pod_runno_e		nvarchar(10),@pod_assflg_e		nvarchar(1),@pod_dtyrat_e		numeric(6,3),@pod_typcode_e		nvarchar(1),
--Modified by Frankie Cheung 20100520
--@pod_code1_e		nvarchar(15),@pod_code2_e		nvarchar(15),@pod_code3_e		nvarchar(15),@pod_rmk_e		nvarchar(300),
@pod_code1_e		nvarchar(25),@pod_code2_e		nvarchar(25),@pod_code3_e		nvarchar(25),@pod_rmk_e		nvarchar(300),
@pod_pckitr_e		nvarchar(300),@pod_alsitmno_e		nvarchar(20),@pod_alscolcde_e	nvarchar(30)

-- SAP PO DTL
declare
@pod_cocde_s		nvarchar(6),@pod_purord_s		nvarchar(20),@pod_purseq_s		int,@pod_prdven_s		nvarchar(3),
@pod_prdsubcde_s		nvarchar(5),@pod_itmno_s		nvarchar(20),@pod_itmsts_s		nvarchar(4),@pod_seccusitm_s		nvarchar(10),
@pod_venitm_s		nvarchar(20),@pod_cusitm_s		nvarchar(20),@pod_cussku_s		nvarchar(20),@pod_engdsc_s		nvarchar(800),
@pod_chndsc_s		nvarchar(1600),@pod_vencol_s		nvarchar(30),@pod_cuscol_s		nvarchar(30),@pod_coldsc_s		nvarchar(300),
@pod_pckseq_s		int,@pod_untcde_s		nvarchar(6),@pod_inrctn_s		nvarchar(20),@pod_mtrctn_s		nvarchar(20),
@pod_cubcft_s		numeric(11,4),@pod_cbm_s		numeric(11,4),@pod_dept_s		nvarchar(20),@pod_ordqty_s		int,
@pod_recqty_s		int,@pod_ftyprc_s		numeric(13,4),@pod_cuspno_s		nvarchar(20),@pod_respno_s		nvarchar(20),
@pod_hrmcde_s		nvarchar(20),@pod_lblcde_s		nvarchar(20),@pod_cususd_s		numeric(13,4),@pod_cuscad_s		numeric(13,4),
@pod_shpstr_s		datetime,@pod_shpend_s		datetime,@pod_candat_s		datetime,@pod_ctnstr_s		int,
@pod_ctnend_s		int,@pod_scno_s		nvarchar(20),@pod_ttlctn_s		int,@pod_lneamt_s		numeric(13,4),
@pod_lnecub_s		numeric(13,4),@pod_ttlqty_s		int,@pod_scline_s		int,@pod_jobord_s		nvarchar(20),
@pod_runno_s		nvarchar(10),@pod_assflg_s		nvarchar(1),@pod_dtyrat_s		numeric(6,3),@pod_typcode_s		nvarchar(1),
--Modified by Frankie Cheung 20100520
--@pod_code1_s		nvarchar(15),@pod_code2_s		nvarchar(15),@pod_code3_s		nvarchar(15),@pod_rmk_s		nvarchar(300),
@pod_code1_s		nvarchar(25),@pod_code2_s		nvarchar(25),@pod_code3_s		nvarchar(25),@pod_rmk_s		nvarchar(300),
@pod_pckitr_s		nvarchar(300),@pod_alsitmno_s		nvarchar(20),@pod_alscolcde_s	nvarchar(30)

-- ERP SC DTL
declare 
@sod_dv_e		nvarchar(6),@sod_dvftycst_e	numeric(13,4),@sod_dvftyprc_e	numeric(13,4),@sod_dvbomcst_e	numeric(13,4),
@sod_dvfcurcde_e	nvarchar(6),@sod_cusven_e		nvarchar(6),@sod_venno_e		nvarchar(6),@sod_ordqty_e	int

-- SAP SC DTL
declare 
@sod_dv_s		nvarchar(6),@sod_dvftycst_s	numeric(13,4),@sod_dvftyprc_s	numeric(13,4),@sod_dvbomcst_s	numeric(13,4),
@sod_dvfcurcde_s	nvarchar(6),@sod_cusven_s		nvarchar(6),@sod_venno_s		nvarchar(6),@sod_ordqty_s	int


-- ERP PO HDR
declare
@poh_cocde_e		nvarchar(6),@poh_purord_e		nvarchar(20),@poh_pursts_e		nvarchar(3),@poh_issdat_e		datetime,
@poh_venno_e		nvarchar(6),@poh_puradr_e		nvarchar(200),@poh_purstt_e		nvarchar(20),@poh_purcty_e		nvarchar(6),
@poh_purpst_e		nvarchar(20),@poh_porctp_e		nvarchar(50),@poh_puragt_e		nvarchar(6),@poh_salrep_e		nvarchar(30),
@poh_prmcus_e		nvarchar(6),@poh_seccus_e		nvarchar(6),@poh_shpadr_e		nvarchar(200),@poh_shpstt_e		nvarchar(20),
@poh_shpcty_e		nvarchar(6),@poh_shppst_e		nvarchar(20),@poh_prctrm_e		nvarchar(6),@poh_paytrm_e		nvarchar(6),
@poh_ttlcbm_e		numeric(13,4),@poh_ttlctn_e		int,@poh_curcde_e		nvarchar(6),@poh_ttlamt_e		numeric(13,4),
@poh_discnt_e		numeric(6,3),@poh_netamt_e		numeric(13,4),@poh_spoflg_e		nvarchar(1),@poh_cuspno_e		nvarchar(20),
@poh_cpodat_e		datetime,@poh_reppno_e		nvarchar(20),@poh_pocdat_e		datetime,@poh_shpstr_e		datetime,
@poh_shpend_e		datetime,@poh_lbldue_e		datetime,@poh_lblven_e		nvarchar(20),@poh_subcde_e		nvarchar(10),
@poh_rmk_e		nvarchar(400),@poh_ordno_e		nvarchar(20),@poh_purchnadr_e		nvarchar(255)

-- ERP PO HDR
declare
@poh_cocde_s		nvarchar(6),@poh_purord_s		nvarchar(20),@poh_pursts_s		nvarchar(3),@poh_issdat_s		datetime,
@poh_venno_s		nvarchar(6),@poh_puradr_s		nvarchar(200),@poh_purstt_s		nvarchar(20),@poh_purcty_s		nvarchar(6),
@poh_purpst_s		nvarchar(20),@poh_porctp_s		nvarchar(50),@poh_puragt_s		nvarchar(6),@poh_salrep_s		nvarchar(30),
@poh_prmcus_s		nvarchar(6),@poh_seccus_s		nvarchar(6),@poh_shpadr_s		nvarchar(200),@poh_shpstt_s		nvarchar(20),
@poh_shpcty_s		nvarchar(6),@poh_shppst_s		nvarchar(20),@poh_prctrm_s		nvarchar(6),@poh_paytrm_s		nvarchar(6),
@poh_ttlcbm_s		numeric(13,4),@poh_ttlctn_s		int,@poh_curcde_s		nvarchar(6),@poh_ttlamt_s		numeric(13,4),
@poh_discnt_s		numeric(6,3),@poh_netamt_s		numeric(13,4),@poh_spoflg_s		nvarchar(1),@poh_cuspno_s		nvarchar(20),
@poh_cpodat_s		datetime,@poh_reppno_s		nvarchar(20),@poh_pocdat_s		datetime,@poh_shpstr_s		datetime,
@poh_shpend_s		datetime,@poh_lbldue_s		datetime,@poh_lblven_s		nvarchar(20),@poh_subcde_s		nvarchar(10),
@poh_rmk_s		nvarchar(400),@poh_ordno_s		nvarchar(20)


-- ERP PO HDR
select
@poh_cocde_e = poh_cocde ,@poh_purord_e = poh_purord ,@poh_pursts_e = poh_pursts ,@poh_issdat_e = poh_issdat ,
@poh_venno_e = poh_venno ,@poh_puradr_e = poh_puradr ,@poh_purstt_e = poh_purstt ,@poh_purcty_e = poh_purcty ,
@poh_purpst_e = poh_purpst ,@poh_porctp_e = poh_porctp ,@poh_puragt_e = poh_puragt ,@poh_salrep_e = poh_salrep ,
@poh_prmcus_e = poh_prmcus ,@poh_seccus_e = poh_seccus ,@poh_shpadr_e = poh_shpadr ,@poh_shpstt_e = poh_shpstt ,
@poh_shpcty_e = poh_shpcty ,@poh_shppst_e = poh_shppst ,@poh_prctrm_e = poh_prctrm ,@poh_paytrm_e = poh_paytrm ,
@poh_ttlcbm_e = poh_ttlcbm ,@poh_ttlctn_e = poh_ttlctn ,@poh_curcde_e = poh_curcde ,@poh_ttlamt_e = poh_ttlamt ,
@poh_discnt_e = poh_discnt ,@poh_netamt_e = poh_netamt ,@poh_spoflg_e = poh_spoflg ,@poh_cuspno_e = poh_cuspno ,
@poh_cpodat_e = poh_cpodat ,@poh_reppno_e = poh_reppno ,@poh_pocdat_e = poh_pocdat ,@poh_shpstr_e = poh_shpstr ,
@poh_shpend_e = poh_shpend ,@poh_lbldue_e = poh_lbldue ,@poh_lblven_e = poh_lblven ,@poh_subcde_e = poh_subcde ,
@poh_rmk_e = poh_rmk ,@poh_ordno_e = poh_ordno ,@poh_purchnadr_e = poh_purchnadr
from poordhdr (nolock) where poh_purord = @pono 

-- SAP PO HDR
select
@poh_cocde_s = poh_cocde ,@poh_purord_s = poh_purord ,@poh_pursts_s = poh_pursts ,@poh_issdat_s = poh_issdat ,
@poh_venno_s = poh_venno ,@poh_puradr_s = poh_puradr ,@poh_purstt_s = poh_purstt ,@poh_purcty_s = poh_purcty ,

@poh_purpst_s = poh_purpst ,@poh_porctp_s = poh_porctp ,@poh_puragt_s = poh_puragt ,@poh_salrep_s = poh_salrep ,
@poh_prmcus_s = poh_prmcus ,@poh_seccus_s = poh_seccus ,@poh_shpadr_s = poh_shpadr ,@poh_shpstt_s = poh_shpstt ,
@poh_shpcty_s = poh_shpcty ,@poh_shppst_s = poh_shppst ,@poh_prctrm_s = poh_prctrm ,@poh_paytrm_s = poh_paytrm ,
@poh_ttlcbm_s = poh_ttlcbm ,@poh_ttlctn_s = poh_ttlctn ,@poh_curcde_s = poh_curcde ,@poh_ttlamt_s = poh_ttlamt ,
@poh_discnt_s = poh_discnt ,@poh_netamt_s = poh_netamt ,@poh_spoflg_s = poh_spoflg ,@poh_cuspno_s = poh_cuspno ,
@poh_cpodat_s = poh_cpodat ,@poh_reppno_s = poh_reppno ,@poh_pocdat_s = poh_pocdat ,@poh_shpstr_s = poh_shpstr ,
@poh_shpend_s = poh_shpend ,@poh_lbldue_s = poh_lbldue ,@poh_lblven_s = poh_lblven ,@poh_subcde_s = poh_subcde ,
@poh_rmk_s = poh_rmk ,@poh_ordno_s = poh_ordno 
from SAPPOHDR (nolock) where poh_purord = @pono 

-- ERP PO DTL
select 
@pod_cocde_e = pod_cocde,@pod_purord_e = pod_purord,@pod_purseq_e = pod_purseq,@pod_prdven_e = pod_prdven,@pod_prdsubcde_e = pod_prdsubcde,
@pod_itmno_e = pod_itmno,@pod_itmsts_e = pod_itmsts,@pod_seccusitm_e = pod_seccusitm,@pod_venitm_e = pod_venitm,@pod_cusitm_e = pod_cusitm,
@pod_cussku_e = pod_cussku,@pod_engdsc_e = pod_engdsc,@pod_chndsc_e = pod_chndsc,@pod_vencol_e = pod_vencol,@pod_cuscol_e = pod_cuscol,
@pod_coldsc_e = pod_coldsc,@pod_pckseq_e = pod_pckseq,@pod_untcde_e = pod_untcde,@pod_inrctn_e = pod_inrctn,@pod_mtrctn_e = pod_mtrctn,
@pod_cubcft_e = pod_cubcft,@pod_cbm_e = pod_cbm,@pod_dept_e = pod_dept,@pod_ordqty_e = pod_ordqty,@pod_recqty_e = pod_recqty,
@pod_ftyprc_e = pod_ftyprc,@pod_cuspno_e = pod_cuspno,@pod_respno_e = pod_respno,@pod_hrmcde_e = pod_hrmcde,@pod_lblcde_e = pod_lblcde,
@pod_cususd_e = pod_cususd,@pod_cuscad_e = pod_cuscad,@pod_shpstr_e = pod_shpstr,@pod_shpend_e = pod_shpend,@pod_candat_e = pod_candat,
@pod_ctnstr_e = pod_ctnstr,@pod_ctnend_e = pod_ctnend,@pod_scno_e = pod_scno,@pod_ttlctn_e = pod_ttlctn,@pod_lneamt_e = pod_lneamt,
@pod_lnecub_e = pod_lnecub,@pod_ttlqty_e = pod_ttlqty,@pod_scline_e = pod_scline,@pod_jobord_e = pod_jobord,@pod_runno_e = pod_runno,
@pod_assflg_e = pod_assflg,@pod_dtyrat_e = pod_dtyrat,@pod_typcode_e = pod_typcode,@pod_code1_e = pod_code1,@pod_code2_e = pod_code2,
@pod_code3_e = pod_code3,@pod_rmk_e = pod_rmk,@pod_pckitr_e = pod_pckitr,@pod_alsitmno_e = pod_alsitmno,@pod_alscolcde_e = pod_alscolcde
from poorddtl (nolock) where pod_purord = @pono and pod_purseq = @poseq

-- SAP PO DTL
select
@pod_cocde_s = pod_cocde,@pod_purord_s = pod_purord,@pod_purseq_s = pod_purseq,@pod_prdven_s = pod_prdven,@pod_prdsubcde_s = pod_prdsubcde,
@pod_itmno_s = pod_itmno,@pod_itmsts_s = pod_itmsts,@pod_seccusitm_s = pod_seccusitm,@pod_venitm_s = pod_venitm,@pod_cusitm_s = pod_cusitm,
@pod_cussku_s = pod_cussku,@pod_engdsc_s = pod_engdsc,@pod_chndsc_s = pod_chndsc,@pod_vencol_s = pod_vencol,@pod_cuscol_s = pod_cuscol,
@pod_coldsc_s = pod_coldsc,@pod_pckseq_s = pod_pckseq,@pod_untcde_s = pod_untcde,@pod_inrctn_s = pod_inrctn,@pod_mtrctn_s = pod_mtrctn,
@pod_cubcft_s = pod_cubcft,@pod_cbm_s = pod_cbm,@pod_dept_s = pod_dept,@pod_ordqty_s = pod_ordqty,@pod_recqty_s = pod_recqty,
@pod_ftyprc_s = pod_ftyprc,@pod_cuspno_s = pod_cuspno,@pod_respno_s = pod_respno,@pod_hrmcde_s = pod_hrmcde,@pod_lblcde_s = pod_lblcde,
@pod_cususd_s = pod_cususd,@pod_cuscad_s = pod_cuscad,@pod_shpstr_s = pod_shpstr,@pod_shpend_s = pod_shpend,@pod_candat_s = pod_candat,
@pod_ctnstr_s = pod_ctnstr,@pod_ctnend_s = pod_ctnend,@pod_scno_s = pod_scno,@pod_ttlctn_s = pod_ttlctn,@pod_lneamt_s = pod_lneamt,
@pod_lnecub_s = pod_lnecub,@pod_ttlqty_s = pod_ttlqty,@pod_scline_s = pod_scline,@pod_jobord_s = pod_jobord,@pod_runno_s = pod_runno,
@pod_assflg_s = pod_assflg,@pod_dtyrat_s = pod_dtyrat,@pod_typcode_s = pod_typcode,@pod_code1_s = pod_code1,@pod_code2_s = pod_code2,
@pod_code3_s = pod_code3,@pod_rmk_s = pod_rmk,@pod_pckitr_s = pod_pckitr,@pod_alsitmno_s = pod_alsitmno,@pod_alscolcde_s = pod_alscolcde
from SAPPODTL (nolock) where pod_purord = @pono and pod_purseq = @poseq

-- ERP SC
select 
@sod_dv_e = sod_dv,@sod_dvftycst_e = sod_dvftycst,@sod_dvftyprc_e = sod_dvftyprc,@sod_dvbomcst_e = sod_dvbomcst,@sod_dvfcurcde_e = sod_dvfcurcde,
@sod_cusven_e = sod_cusven,@sod_venno_e = sod_venno,@sod_ordqty_e = sod_ordqty
from SCORDDTL (nolock) where sod_ordno = @scno and sod_ordseq = @scseq

-- SAP SC
select 
@sod_dv_s = sod_dv,@sod_dvftycst_s = sod_dvftycst,@sod_dvftyprc_s = sod_dvftyprc,@sod_dvbomcst_s = sod_dvbomcst,@sod_dvfcurcde_s = sod_dvfcurcde,
@sod_cusven_s = sod_cusven,@sod_venno_s = sod_venno,@sod_ordqty_s = sod_ordqty
from SAPSCDTL (nolock) where sod_ordno = @scno and sod_ordseq = @scseq


-- PO DTL Comparison
if ( @pod_prdven_e <> @pod_prdven_s ) 
begin
set @reason = replace(@reason,'更改生產工廠, ','') + '更改生產工廠, '
end 

if ( @pod_seccusitm_e <> @pod_seccusitm_s ) 
begin
set @reason =replace(@reason,'更改第二客人貨號, ','') + '更改第二客人貨號, '
end 

if ( @pod_cusitm_e <> @pod_cusitm_s ) 
begin
set @reason =  replace(@reason,'更改客人貨號, ','') + '更改客人貨號, '
end 

if ( @pod_cussku_e <> @pod_cussku_s ) 
begin
set @reason =  replace(@reason,'更改客人SKU號碼, ','') + '更改客人SKU號碼, '
end 

if ( @pod_engdsc_e <> @pod_engdsc_s ) 
begin
set @reason = replace(@reason,'更改物料描述, ','') + '更改物料描述, '
end 

if ( @pod_chndsc_e <> @pod_chndsc_s ) 
begin
set @reason = replace(@reason,'更改物料描述, ','') + '更改物料描述, '
end 

if ( @pod_cuscol_e <> @pod_cuscol_s ) 
begin
set @reason =  replace(@reason,'更改客人顏色, ','') + '更改客人顏色, '
end 

if ( @pod_coldsc_e <> @pod_coldsc_s ) 
begin
set @reason =  replace(@reason, '更改顏色描述, ','') +  '更改顏色描述, ' 
end 

if ( @pod_ordqty_e <> @pod_ordqty_s ) 
begin
set @reason =replace(@reason, '更改數量, ','')  + '更改數量, '
end 

if ( @pod_cuspno_e <> @pod_cuspno_s ) 
begin
set @reason = replace(@reason, '更改客人PO, ','')  + '更改客人PO, '
end 

if ( @pod_respno_e <> @pod_respno_s ) 
begin
set @reason = replace(@reason, '更改客人PO, ','')  + '更改客人PO, '
end 

if ( convert(nvarchar(10), @pod_shpstr_e,121) <> convert(nvarchar(10), @pod_shpstr_s,121) ) 
begin
set @reason = replace(@reason, '更改貨期, ','') + '更改貨期, '
end 

if ( convert(nvarchar(10), @pod_shpend_e,121)  <> convert(nvarchar(10), @pod_shpend_s,121) ) 
begin
set @reason =  replace(@reason, '更改貨期, ','')  +  '更改貨期, '
end 

if (  convert(nvarchar(10), @pod_candat_e,121)   <> convert(nvarchar(10), @pod_candat_s,121)  ) 
begin
set @reason =  replace(@reason, '更改貨期, ','')  +  '更改貨期, '
end 

if ( @pod_ctnstr_e <> @pod_ctnstr_s ) 
begin
set @reason =  replace(@reason, '更改貨箱編號, ','')  + '更改貨箱編號, '
end 

if ( @pod_ctnend_e <> @pod_ctnend_s ) 
begin
set @reason = replace(@reason, '更改貨箱編號, ','') +  '更改貨箱編號, '
end 


if ( @pod_ttlctn_e <> @pod_ttlctn_s ) 
begin
set @reason = replace(@reason, '更改貨箱編號, ','') +  '更改貨箱編號, '
end 

if ( @pod_ttlqty_e <> @pod_ttlqty_s ) 
begin
set @reason = replace(@reason, '更改數量, ','') +  '更改數量, '
end 

if ( @pod_rmk_e <> @pod_rmk_s ) 
begin
set @reason = replace(@reason, '更改備注, ','') +  '更改備注, '
end 

if ( @pod_pckitr_e <> @pod_pckitr_s ) 
begin
set @reason = replace(@reason, '更改包裝指示, ','') +  '更改包裝指示, '
end 

-- PO HDR Comparison
if ( @poh_ttlcbm_e <> @poh_ttlcbm_s ) 
begin
set @reason = replace(@reason, '更改CBM, ','') +  '更改CBM, '
end 

if ( @poh_ttlctn_e <> @poh_ttlctn_s ) 
begin
set @reason = replace(@reason, '更改貨箱編號, ','') +  '更改貨箱編號, '
end 

if ( @poh_cuspno_e <> @poh_cuspno_s ) 
begin
set @reason = replace(@reason, '更改客人PO, ','')  + '更改客人PO, '
end 

if ( @poh_cpodat_e <> @poh_cpodat_s ) 
begin
set @reason = replace(@reason, '更改客人PO日期, ','')  + '更改客人PO日期, '
end 

if ( @poh_reppno_e <> @poh_reppno_s ) 
begin
set @reason = replace(@reason, '更改客人PO, ','')  + '更改客人PO, '
end 

if ( @poh_pocdat_e <> @poh_pocdat_s ) 
begin
set @reason = replace(@reason, '更改客人PO取消日期, ','')  + '更改客人PO取消日期, '
end 


-- SC DTL Comparison
if ( @sod_dv_e <> @sod_dv_s ) 
begin
set @reason =replace(@reason, '更改貨號設計工廠, ','')  + '更改貨號設計工廠, '
end

if ( @sod_dvftycst_e <> @sod_dvftycst_s ) 
begin
set @reason =replace(@reason, '更改ZI03, ','')  + '更改ZI03, '
end

if ( @sod_dvftyprc_e <> @sod_dvftyprc_s ) 
begin
set @reason =replace(@reason, '更改ZI03, ','')  + '更改ZI03, '
end

if ( @sod_dvbomcst_e <> @sod_dvbomcst_s ) 
begin
set @reason =replace(@reason, '更改ZI03, ','')  + '更改ZI03, '
end

if ( @sod_dvfcurcde_e <> @sod_dvfcurcde_s ) 
begin
set @reason =replace(@reason, '更改ZI03, ','')  + '更改ZI03, '
end

if ( @sod_cusven_e <> @sod_cusven_s ) 
begin
set @reason =replace(@reason, '更改清關工廠, ','')  + '更改清關工廠, '
end

if ( @sod_venno_e <> @sod_venno_s ) 
begin
set @reason = replace(@reason,'更改生產工廠, ','') + '更改生產工廠, '
end

if ( @sod_ordqty_e <> @sod_ordqty_s ) 
begin
set @reason = replace(@reason,'更改數量, ','') + '更改數量, '
end



-- SHP Schedule
if (
 select 
count(*)
 from       
 PODTLSHP erp (nolock)       
 left join SAPDTLSHP sap (nolock) on erp.pds_purord = sap.pds_purord and erp.pds_seq = sap.pds_seq and erp.pds_shpseq = sap.pds_shpseq      
 , IMPNTINF (nolock)      
 , POORDDTL (nolock)       
 , SCORDDTL (nolock)
-- Added by Mark Lau 20090521
, SCORDHDR (nolock)

 where       

 erp.pds_cocde = @cocde      
 and pod_itmno = ipt_itmno     
 and (
 erp.pds_from <> isnull(sap.pds_from,'1900-01-01') or      
 erp.pds_to <> isnull(sap.pds_to,'1900-01-01') or      
 erp.pds_ttlctn <> isnull(sap.pds_ttlctn,-1)      
 )      
 and erp.pds_purord = pod_purord      
 and erp.pds_seq = pod_purseq      
and  sap.pds_purord is not null  
 and pod_jobord <> ''      
 and pod_scno = sod_ordno 
 and pod_scline = sod_ordseq
 and sod_zorvbeln <> ''
and ( sod_upddat >= '2009-01-01' or pod_upddat >= '2009-01-01' or sod_zorvbeln like 'WT%')     
and soh_ordno = sod_ordno and soh_ordsts <> 'CLO'
and pod_jobord = @jobord
) > 0 
begin
	set @reason =  replace(@reason, '更改貨期, ','')  +  '更改貨期, '
end 

-- CTN
if (
 select count(*)
 from       
 PODTLCTN erp (nolock)       
 left join SAPDTLCTN sap (nolock) on erp.pdc_purord = sap.pdc_purord and erp.pdc_seq = sap.pdc_seq and erp.pdc_ctnseq = sap.pdc_ctnseq      
 , IMPNTINF (nolock)      
 , POORDDTL (nolock)       
 , SCORDDTL (nolock)
, SCORDHDR (nolock)
 where       
 erp.pdc_cocde = @cocde      
 and pod_itmno = ipt_itmno      
 and (      
 erp.pdc_from <> isnull(sap.pdc_from,0) or      
 erp.pdc_to <> isnull(sap.pdc_to,0) or      
 erp.pdc_ttlctn <> isnull(sap.pdc_ttlctn,-1)      
 )      
 and erp.pdc_purord = pod_purord      
 and erp.pdc_seq = pod_purseq      
 and sap.pdc_purord is not null  
 and pod_jobord <> ''      
 and pod_scno = sod_ordno 
 and pod_scline = sod_ordseq
 and sod_zorvbeln <> ''
and ( sod_upddat >= '2009-01-01' or pod_upddat >= '2009-01-01' or sod_zorvbeln like 'WT%')
and soh_ordno = sod_ordno and soh_ordsts <> 'CLO'
and pod_jobord = @jobord
) > 0
begin
set @reason =  replace(@reason, '更改貨箱編號, ','')  + '更改貨箱編號, '
end

if (
 select count(*)
 from       
 POSHPMRK erp (nolock)       
 left join SAPSHPMRK sap (nolock) on erp.psm_purord = sap.psm_purord and erp.psm_shptyp = sap.psm_shptyp  
 , IMPNTINF (nolock)      
 , POORDDTL (nolock)       
 , SCORDDTL (nolock)
, SCORDHDR (nolock)

 where       
 erp.psm_cocde = @cocde      
 and pod_itmno = ipt_itmno  
 and (      
 erp.psm_engdsc <> isnull(sap.psm_engdsc,'') or   
 erp.psm_chndsc <> isnull(sap.psm_chndsc,'') or   
 erp.psm_engrmk <> isnull(sap.psm_engrmk,'') or   
 erp.psm_chnrmk <> isnull(sap.psm_chnrmk,'') 
 )      
 and erp.psm_purord = pod_purord      
and sap.psm_purord is not null  
 and pod_jobord <> ''      
 and pod_scno = sod_ordno 
 and pod_scline = sod_ordseq
 and sod_zorvbeln <> ''
and ( sod_upddat >= '2009-01-01' or pod_upddat >= '2009-01-01' or sod_zorvbeln like 'WT%')
and soh_ordno = sod_ordno and soh_ordsts <> 'CLO'
and pod_jobord = @jobord
) > 0
begin
set @reason =  replace(@reason, '更改箱嘜, ','')  + '更改箱嘜, '
end



select replace( isnull( @reason,''),', ','/') as 'reason'

--select * from SAPPODTL (nolock) where pod_purord = @pono and pod_purseq = @poseq
--select * from poorddtl (nolock) where pod_purord = @pono and pod_purseq = @poseq







GO
GRANT EXECUTE ON [dbo].[sp_select_SAP_SC_Update_Reason] TO [ERPUSER] AS [dbo]
GO
