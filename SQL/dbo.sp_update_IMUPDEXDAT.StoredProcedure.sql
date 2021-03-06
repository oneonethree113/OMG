/****** Object:  StoredProcedure [dbo].[sp_update_IMUPDEXDAT]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMUPDEXDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMUPDEXDAT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





































/*
=========================================================
Program ID	: 	sp_update_IMUPDEXDAT
Description   	: 	Update External IM entry
Programmer  	: 	David Yue
Date Created	:	2013-02-28
=========================================================
 Modification History                                   
=========================================================
2013-02-28	David Yue	External IM Enhancement
2014-01-21	David Yue	New Packing Structure
=========================================================     
*/

CREATE               PROCEDURE [dbo].[sp_update_IMUPDEXDAT] 

@cocde  nvarchar(6), 
@creusr  nvarchar(30)

AS

set nocount on

DECLARE	--IMASSEXDAT
@iad_cocde	nvarchar(6),		@iad_asstno	nvarchar(20),		@iad_assdno	nvarchar(20),
@iad_colcde	nvarchar(200),		@iad_inrqty	int,			@iad_mtrqty	int,
@iad_xlsfil 	nvarchar(50),		@iad_chkdat	datetime,		@iad_untcde	nvarchar(6),	
@iad_conftr	int,			@iad_recseq	int,			@iad_stage	nvarchar(3),	
@iad_sysmsg	nvarchar(300),		@iad_veneml	nvarchar(50),		@iad_malsts	nvarchar(1),	
@iad_venno	nvarchar(6),		@iad_credat	datetime,		@iad_prdven	nvarchar(6),
@iad_seqno	int

DECLARE	-- IMBASINF
@ibi_cosmth	nvarchar(50),		@ibi_rmk	nvarchar(2000)

DECLARE -- IMPCKINF
@ipi_pckseq	int

declare -- IMBOMASS
@iba_fmlopt 	varchar(5),		@iba_bombasprc	numeric(13,4),		@iba_bomqty	int,
@iba_costing	char(1),		@iba_curcde	varchar(4),		@iba_mtrqty	int,	
@iba_assitm	nvarchar(20)

DECLARE 	--IMBOMEXDAT
@ibd_cocde	nvarchar(6),		@ibd_ucpno	nvarchar(20),		@ibd_bomno	nvarchar(20),
@ibd_colcde	nvarchar(200),		@ibd_qty	int,			@ibd_xlsfil 	nvarchar(50),	
@ibd_chkdat	datetime,		@ibd_untcde	nvarchar(6),		@ibd_conftr	int,
@ibd_recseq	int,			@ibd_stage	nvarchar(3),		@ibd_sysmsg	nvarchar(300),	
@ibd_veneml	nvarchar(50),		@ibd_malsts	nvarchar(1),		@ibd_venno	nvarchar(6),	
@ibd_credat	datetime,		@ibd_prdven	nvarchar(6),		@ibd_seqno	int

DECLARE	-- IMITMEXDAT
@ied_cocde  	nvarchar(6),		@ied_venno 	nvarchar(6),		@ied_prdven	nvarchar(6),	
@ied_cusven 	nvarchar(6),		@ied_cus1no  	nvarchar(10),		@ied_cus2no	nvarchar(10),	
@ied_ucpno  	nvarchar(20),		@ied_itmseq 	int,			@ied_recseq	int,
@ied_venitm 	nvarchar(20),		@ied_ditmno 	nvarchar(20),		@ied_mode	nvarchar(3),
@ied_itmsts 	nvarchar(3),		@ied_stage 	nvarchar(3),		@ied_itmtyp	nvarchar(4),
@ied_catlvl4	nvarchar(20),		@ied_lnecde 	nvarchar(10),		@ied_engdsc	nvarchar(800),
@ied_chndsc 	nvarchar(1600),		@ied_finishing 	nvarchar(50),		@ied_matcde	nvarchar(50),
@ied_nat 	nvarchar(6),		@ied_prdtyp 	nvarchar(50),		@ied_prdsztyp	nvarchar(50),
@ied_prdszunt 	nvarchar(50),		@ied_prdszval 	nvarchar(50),		@ied_vencol	nvarchar(20),
@ied_vencoldsc 	nvarchar(50),		@ied_vencol2	nvarchar(20),		@ied_untcde 	nvarchar(6),	
@ied_inrqty	int,			@ied_mtrqty 	int,			@ied_cft 	numeric(13,4),	
@ied_conftr	int,			@ied_inrlin 	numeric(13,4),		@ied_inrwin 	numeric(13,4),	
@ied_inrhin	numeric(13,4),		@ied_mtrlin 	numeric(13,4),		@ied_mtrwin 	numeric(13,4),	
@ied_mtrhin	numeric(13,4),		@ied_grswgt 	numeric(13,4),		@ied_netwgt 	numeric(13,4),	
@ied_pckitr	nvarchar(300),		@ied_sysmsg 	nvarchar(300),		@ied_xlsfil 	nvarchar(50),	
@ied_chkdat	datetime,		@ied_ftyprctrm	nvarchar(10),		@ied_hkprctrm	nvarchar(10),
@ied_trantrm	nvarchar(10),		@ied_curcde 	nvarchar(6),		@ied_ftycst 	numeric(13,4),
@ied_ftyprc 	numeric(13,4),		@ied_fcurcde 	nvarchar(6),		@ied_basprc 	numeric(13,4),
@ied_moqum 	nvarchar(6),		@ied_moq 	int,			@ied_moaccy	nvarchar(6),
@ied_moa 	numeric(13,4),		@ied_qutdat 	datetime,		@ied_expdat	datetime,
@ied_refresh 	char(1),		@ied_remark 	nvarchar(2000),		@ied_bomprc	numeric(13,4),
@ied_bomcst	numeric(13,4),		@ied_fmlopt	nvarchar(10),		@ied_prdgrp 	nvarchar(6),
@ied_prdicon 	nvarchar(6),		@ied_creusr	nvarchar(30),		@ied_pckm	nvarchar(10),
@ied_updusr 	nvarchar(30),		@ied_credat 	datetime,		@ied_upddat	datetime,
@ied_intrmk	nvarchar(2000),		@ied_cstrmk	nvarchar(2000),		@ied_estprcflg	varchar(1),
@ied_estprcref	nvarchar(50),		@ied_seqno	int

DECLARE	-- IMMBDEXDAT (Material Break Down)
@ikd_cocde	nvarchar(6),		@ikd_venno	nvarchar(6),		@ikd_prdven	nvarchar(6),
@ikd_ucpno	nvarchar(20),		@ikd_recseq	int,			
@ikd_matdsc	nvarchar(200),		@ikd_curcde	nvarchar(6),		@ikd_cst		numeric(13,4),
@ikd_cstper	numeric(13,4),		@ikd_wgtper	numeric(13,4),		@ikd_stage	nvarchar(3),
@ikd_sysmsg	nvarchar(300),		@ikd_xlsfil	nvarchar(50),		@ikd_chkdat	datetime,
@ikd_credat	datetime,		@ikd_seqno	int

DECLARE -- IMMOQMOA
@imm_moqunttyp	nvarchar(6),		@imm_moq	int,			@imm_curcde	nvarchar(6),
@imm_moa	numeric (13,4)

DECLARE -- IMPRCCHG
@imu_effdat_before	datetime,	@imu_expdat_before	datetime,
@imu_curcde_before	nvarchar(6),	@imu_ftycst_before	numeric(13,4),
@imu_ftycstA_before	numeric(13,4),	@imu_ftycstB_before	numeric(13,4),
@imu_ftycstC_before	numeric(13,4),	@imu_ftycstD_before	numeric(13,4),
@imu_ftycstTran_before	numeric(13,4),	@imu_ftycstPack_before	numeric(13,4),
@imu_ftyprc_before	numeric(13,4),	@imu_ftyprcA_before	numeric(13,4),
@imu_ftyprcB_before	numeric(13,4),	@imu_ftyprcC_before	numeric(13,4),
@imu_ftyprcD_before	numeric(13,4),	@imu_ftyprcTran_before	numeric(13,4),
@imu_ftyprcPack_before	numeric(13,4),	@imu_ttlcst_before	numeric(13,4),
@imu_negprc_before	numeric(13,4),	@imu_fmlopt_before	nvarchar(5),
@imu_bcurcde_before	nvarchar(6),	@imu_itmprc_before	numeric(13,4),
@imu_basprc_before	numeric(13,4),	@imu_period_before	nvarchar(10),
@imu_cstchgdat_before	datetime,	@imu_negcst_before	numeric(13,4),
@imu_bomcst_before	numeric(13,4),	@imu_bomprc_before	numeric(13,4),
@imu_hkadjper_before	numeric(13,4)

DECLARE	-- IMPRCINF
@imu_curcde	nvarchar(6),		@imu_ftyprc	numeric(13,4),		@imu_bcurcde	nvarchar(6),
@imu_ftycst	numeric(13,4),		@imu_typ	nvarchar(5),		@imu_ventyp	nvarchar(3),
@imu_effdat	datetime,		@imu_cstchgdat	datetime,		@imu_creusr	nvarchar(30),
@imu_credat	datetime,		@imu_fmlopt	nvarchar(6),		@imu_itmprc	numeric(13,4),
@imu_basprc	numeric(21,11),		@imu_status	nvarchar(6),		@imu_ttlcst	numeric(13,4),
@imu_sysgen	nvarchar(1)

DECLARE -- SYCATREL
@ycr_catlvl0	nvarchar(20),		@ycr_catlvl1	nvarchar(20),		@ycr_catlvl2	nvarchar(20),
@ycr_catlvl3	nvarchar(20)

DECLARE -- SYSTEM GENERATED CUSTOMER GROUP (External IM Enhancement)
@sgc_cus1no	nvarchar(6),		@sgc_fmlopt	nvarchar(6),		@sgc_ftyprc	numeric(13,4),
@sgc_moqunttyp	nvarchar(6),		@sgc_moq	int,			@sgc_curcde	nvarchar(6),
@sgc_moa	numeric (13,4),		@sgc_bomprc	numeric(21,11),		@sgc_bomcst	numeric(21,11)

DECLARE -- TEMP
@venitm		nvarchar(30),		@cbmcft		numeric(13,4),		@bomprc		numeric(21,11),
@bomcst		numeric (21,11),	@ventyp		varchar(1),		@fml		nvarchar(300),
@OP		nvarchar(1),		@end		int,			@temp		numeric(13,4),
@colseq		int,			@imu_selrat	numeric(16,11),		@imu_buyrat	numeric(16,11),
@chgreason	nvarchar(800),		@chgfp		numeric(13,4)

CREATE TABLE #IMPRCINF_BUFFER
(	[imu_cocde] [nvarchar] (6) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[imu_itmno] [nvarchar] (20) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[imu_typ] [nvarchar] (4) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[imu_ventyp] [nvarchar] (4) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[imu_venno] [nvarchar] (6) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[imu_prdven] [nvarchar] (6) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[imu_pckunt] [nvarchar] (6) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[imu_conftr] [numeric](18, 0) NOT NULL ,
	[imu_inrqty] [int] NOT NULL ,
	[imu_mtrqty] [int] NOT NULL ,
	[imu_cft] [numeric](11, 4) NOT NULL ,
	[imu_cus1no] [nvarchar] (6) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[imu_cus2no] [nvarchar] (6) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[imu_ftyprctrm] [nvarchar] (10) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[imu_hkprctrm] [nvarchar] (10) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[imu_trantrm] [nvarchar] (10) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[imu_effdat] [datetime] NULL ,
	[imu_expdat] [datetime] NULL ,
	[imu_status] [nvarchar] (6) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[imu_curcde] [nvarchar] (6) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[imu_ftycst] [numeric](13, 4) NULL ,
	[imu_ftycstA] [numeric](13, 4) NULL ,
	[imu_ftycstB] [numeric](13, 4) NULL ,
	[imu_ftycstC] [numeric](13, 4) NULL ,
	[imu_ftycstD] [numeric](13, 4) NULL ,
	[imu_ftycstTran] [numeric](13, 4) NULL ,
	[imu_ftycstPack] [numeric](13, 4) NULL ,
	[imu_fml] [nvarchar] (5) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[imu_fmlA] [nvarchar] (5) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[imu_fmlB] [nvarchar] (5) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[imu_fmlC] [nvarchar] (5) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[imu_fmlD] [nvarchar] (5) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[imu_fmlTran] [nvarchar] (5) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[imu_fmlPack] [nvarchar] (5) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[imu_chgfp] [numeric](13, 4) NULL ,
	[imu_chgfpA] [numeric](13, 4) NULL ,
	[imu_chgfpB] [numeric](13, 4) NULL ,
	[imu_chgfpC] [numeric](13, 4) NULL ,
	[imu_chgfpD] [numeric](13, 4) NULL ,
	[imu_chgfpTran] [numeric](13, 4) NULL ,
	[imu_chgfpPack] [numeric](13, 4) NULL ,
	[imu_ftyprc] [numeric](13, 4) NULL ,
	[imu_ftyprcA] [numeric](13, 4) NULL ,
	[imu_ftyprcB] [numeric](13, 4) NULL ,
	[imu_ftyprcC] [numeric](13, 4) NULL ,
	[imu_ftyprcD] [numeric](13, 4) NULL ,
	[imu_ftyprcTran] [numeric](13, 4) NULL ,
	[imu_ftyprcPack] [numeric](13, 4) NULL ,
	[imu_bomcst] [numeric](13, 4) NULL ,
	[imu_ttlcst] [numeric](13, 4) NULL ,
	[imu_hkadjper] [numeric](13, 4) NULL ,
	[imu_negcst] [numeric](13, 4) NULL ,
	[imu_negprc] [numeric](13, 4) NULL ,
	[imu_fmlopt] [nvarchar] (5) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[imu_bcurcde] [nvarchar] (6) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[imu_itmprc] [numeric](13, 4) NULL ,
	[imu_bomprc] [numeric](13, 4) NULL ,
	[imu_basprc] [numeric](13, 4) NULL ,
	[imu_period] [nvarchar] (10) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[imu_cstchgdat] [datetime] NOT NULL ,
	[imu_sysgen] [nvarchar] (1) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[imu_estprcflg] [char] (1) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[imu_estprcref] [nvarchar] (50) COLLATE Chinese_Taiwan_Stroke_CI_AS NULL ,
	[imu_creusr] [nvarchar] (30) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[imu_updusr] [nvarchar] (30) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL ,
	[imu_credat] [datetime] NOT NULL ,
	[imu_upddat] [datetime] NOT NULL ,
	[imu_timstp] [timestamp] NOT NULL
)

DECLARE cur_IMITMEXDAT CURSOR FAST_FORWARD
FOR
select	ied_cocde,		ied_venno,		ied_prdven,	
	ied_cusven,		ied_cus1no,		ied_cus2no,	
	ied_ucpno,		ied_itmseq,		ied_recseq,
	ied_venitm,		ied_ditmno,		ied_mode,
	ied_itmsts,		ied_stage,		ied_itmtyp,
	ied_catlvl4,		ied_lnecde,		ied_engdsc,
	ied_chndsc,		ied_finishing,		ied_matcde,
	ied_nat,		ied_prdtyp,		ied_prdsztyp,
	ied_prdszunt,		ied_prdszval,		ied_vencol,
	ied_vencoldsc,	        ied_vencol2,		ied_untcde,
	ied_inrqty,		ied_mtrqty,		ied_cft,
	ied_conftr,		ied_inrlin,		ied_inrwin,
	ied_inrhin,		ied_mtrlin,		ied_mtrwin,
	ied_mtrhin,		ied_grswgt,		ied_netwgt,
	ied_pckitr,		ied_sysmsg,		ied_xlsfil,
	ied_chkdat,		ied_prctrm,		ied_hkprctrm,
	ied_trantrm,		ied_curcde,		ied_ftycst,
	ied_ftyprc,		ied_fcurcde,		ied_basprc,
	ied_moqum,		ied_moq,		ied_moaccy,
	ied_moa,		ied_qutdat,		ied_expdat,
	ied_refresh,		ied_remark,		ied_bomprc,
	ied_bomcst,		ied_fmlopt,		ied_pckm,
	ied_creusr,		ied_updusr,		ied_credat,
	ied_upddat,		ied_prdgrp,		ied_prdicon,
	ied_intrmk,		ied_cstrmk,		ied_estprcflg,
	ied_estprcref
from	IMITMEXDAT (nolock)
where	ied_stage <> 'W' and
	(ied_stage <> 'A' or ied_mode <> 'NEW') and
	ied_updusr = @creusr
order by ied_itmtyp desc, ied_ucpno, ied_venno, ied_prdven, ied_cus1no, ied_cus2no, ied_stage, ied_chkdat

OPEN cur_IMITMEXDAT
FETCH NEXT FROM cur_IMITMEXDAT INTO
@ied_cocde,		@ied_venno,		@ied_prdven,	
@ied_cusven,		@ied_cus1no,		@ied_cus2no,	
@ied_ucpno,		@ied_itmseq,		@ied_recseq,
@ied_venitm,		@ied_ditmno,		@ied_mode,
@ied_itmsts,		@ied_stage,		@ied_itmtyp,
@ied_catlvl4,		@ied_lnecde,		@ied_engdsc,
@ied_chndsc,		@ied_finishing,		@ied_matcde,
@ied_nat,		@ied_prdtyp ,		@ied_prdsztyp,
@ied_prdszunt,		@ied_prdszval,		@ied_vencol,
@ied_vencoldsc,		@ied_vencol2,		@ied_untcde,
@ied_inrqty,		@ied_mtrqty,		@ied_cft,
@ied_conftr,		@ied_inrlin,		@ied_inrwin,
@ied_inrhin,		@ied_mtrlin,		@ied_mtrwin,
@ied_mtrhin,		@ied_grswgt,		@ied_netwgt,
@ied_pckitr,		@ied_sysmsg,		@ied_xlsfil,
@ied_chkdat,		@ied_ftyprctrm,		@ied_hkprctrm,
@ied_trantrm,		@ied_curcde,		@ied_ftycst,
@ied_ftyprc,		@ied_fcurcde,		@ied_basprc,
@ied_moqum,		@ied_moq,		@ied_moaccy,
@ied_moa,		@ied_qutdat, 		@ied_expdat,
@ied_refresh,		@ied_remark,		@ied_bomprc,
@ied_bomcst,		@ied_fmlopt,		@ied_pckm,
@ied_creusr,		@ied_updusr,		@ied_credat,
@ied_upddat,		@ied_prdgrp,		@ied_prdicon,
@ied_intrmk,		@ied_cstrmk,		@ied_estprcflg,
@ied_estprcref

set @venitm = ''

select	@cbmcft = isnull(ycf_value,0)
from	SYCONFTR
where	ycf_code1 = 'CBM' and
	ycf_code2 = 'CFT'

WHILE @@fetch_status = 0
BEGIN
	if @ied_itmtyp = 'AST'
	begin
		set @ied_itmtyp = 'ASS'
	end

	if @ied_stage = 'R' and @ied_ucpno <> ''
	begin
		update	IMBASINF
		set	ibi_itmsts = ibi_prvsts, 
			ibi_updusr = left('E-'+ @creusr,30),
			ibi_upddat = getdate()
		where	ibi_itmno = @ied_ucpno and
			(select count(*) from IMITMEXDAT (nolock) where ied_ucpno = @ied_ucpno and
				ied_recseq <> @ied_recseq and ied_stage = 'W') = 0
	end
	
	if @ied_stage = 'A' and @ied_ucpno <> '' and @ied_mode = 'UPD'
	begin
		set @bomprc = 0
		set @bomcst = 0
		
		set @ventyp = 'D'

		if (select count(*) from IMCOLINF (nolock) where icf_itmno = @ied_ucpno) > 0 and
		   (select count(*) from IMPCKINF (nolock) where ipi_itmno = @ied_ucpno) > 0 and
		   ((select count(*) from IMPRCINF (nolock) where imu_itmno = @ied_ucpno and imu_status = 'ACT') > 0 or
		    (select count(*) from #IMPRCINF_BUFFER (nolock) where imu_itmno = @ied_ucpno and imu_status = 'ACT') > 0)
		begin
			set @ied_itmsts = 'CMP'
		end
		else
		begin
			set @ied_itmsts = 'INC'
		end

-- IMBASINF START -----------------------------------------------------------------
		set @ibi_cosmth = ''
		set @ibi_rmk = ''

		set @ycr_catlvl0 = ''
		set @ycr_catlvl1 = ''
		set @ycr_catlvl2 = ''
		set @ycr_catlvl3 = ''

		if ltrim(rtrim(@ied_catlvl4)) <> '' 
		begin
			select	@ycr_catlvl0 = isnull(ycr_catlvl0,''), 
				@ycr_catlvl1 = isnull(ycr_catlvl1,''), 
				@ycr_catlvl2 = isnull(ycr_catlvl2,''), 
				@ycr_catlvl3 = isnull(ycr_catlvl3,'')
			from	SYCATREL
			where	ycr_catlvl4 = @ied_catlvl4
		end
		else -- if ltrim(rtrim(@ied_catlvl4)) = ''
		begin
			set @ycr_catlvl0 = ''
			set @ycr_catlvl1 = ''
			set @ycr_catlvl2 = ''
			set @ycr_catlvl3 = ''
		end

		update	IMBASINF
		set	ibi_itmsts = (case (select count(*) from IMITMEXDAT (nolock) where ied_ucpno = @ied_ucpno and 
					ied_recseq <> @ied_recseq and ied_stage = 'W') when 0 then
					@ied_itmsts else ibi_itmsts end), 	
			ibi_updusr = left('E-'+ @creusr,30),
			ibi_upddat = getdate(),
			ibi_cosmth = @ibi_cosmth, 	
			ibi_catlvl4 = isnull(@ied_catlvl4,''),	
			ibi_catlvl3 = isnull(@ycr_catlvl3,''),
			ibi_catlvl2 = isnull(@ycr_catlvl2,''),
			ibi_catlvl1 = isnull(@ycr_catlvl1,''),
			ibi_catlvl0 = isnull(@ycr_catlvl0,''),
			ibi_lnecde = isnull(@ied_lnecde,'') ,	
			ibi_prvsts = @ied_itmsts,
			ibi_engdsc =@ied_engdsc, 	
			ibi_chndsc = isnull(@ied_chndsc,''),
			ibi_material = @ied_matcde,
			ibi_prdtyp = upper(@ied_prdtyp),
			ibi_dsgno = isnull(@ied_ditmno, ''),
			ibi_itmnat = isnull(@ied_nat,''),
			ibi_finishing = isnull(@ied_finishing,''),
			ibi_prdsizetyp = @ied_prdsztyp,
			ibi_prdsizeunt = @ied_prdszunt,	
			ibi_prdsizeval = @ied_prdszval,
			ibi_prdgrp = @ied_prdgrp,
			ibi_prdicon = @ied_prdicon,
			ibi_cusven = @ied_cusven,
			ibi_examven = @ied_cusven,
			ibi_tradeven = @ied_cusven,	
			ibi_rmk = @ied_intrmk
		where	ibi_itmno = @ied_ucpno
		
		-- Update latest MOQ / MOA --
		if ltrim(rtrim(@ied_moq)) <> '0' and ltrim(rtrim(@ied_moq)) <> ''
		begin
			update	IMBASINF
			set	ibi_tirtyp = '2',
				ibi_moqctn = @ied_moq,
				ibi_moqunttyp = @ied_moqum,
				ibi_curcde = '',
				ibi_moa = 0,
				ibi_updusr = left('E-'+ @creusr,30),
				ibi_upddat = getdate()
			where 	ibi_itmno = @ied_ucpno
   		end
		else if ltrim(rtrim(@ied_moa)) <> '0' and ltrim(rtrim(@ied_moa)) <> ''
		begin
			update	IMBASINF
			set	ibi_tirtyp = '2',
				ibi_moqctn = 0,
				ibi_moqunttyp = '',
				ibi_curcde = @ied_moaccy,
				ibi_moa = @ied_moa,
				ibi_updusr = left('E-'+ @creusr,30),
				ibi_upddat = getdate()
			where 	ibi_itmno = @ied_ucpno					
		end
-- IMBASINF END -------------------------------------------------------------------	
		
-- IMMOQMOA START -----------------------------------------------------------------
		if (select count(*) from CUGRPINF (nolock) where cgi_flg_ext = 'Y' and cgi_cugrpcde = @ied_cus1no) = 0 or
			((select count(*) from CUGRPINF (nolock) where cgi_flg_ext = 'Y' and cgi_cugrpcde = @ied_cus1no) > 0 and
			 (@ied_moq <> 0 or @ied_moa <> 0))
		begin
			if (select count(*) from IMMOQMOA (nolock) where imm_itmno = @ied_ucpno and imm_cus1no = @ied_cus1no and imm_cus2no = @ied_cus2no) = 0
			begin
				if @ied_moq <> 0 or @ied_moa <> 0
				begin
					insert into IMMOQMOA
					(	imm_cocde,		imm_itmno,		imm_cus1no,
						imm_cus2no,		imm_tirtyp,		imm_moqunttyp,
						imm_moqctn,		imm_qty,		imm_curcde,
						imm_moa,		imm_creusr,		imm_updusr,
						imm_credat,		imm_upddat
					)
					values
					(	'',			@ied_ucpno,		@ied_cus1no,
						@ied_cus2no,		'2',			@ied_moqum,
						@ied_moq,		0,			@ied_moaccy,
						@ied_moa,		left('E-'+ @creusr,30),	left('E-'+ @creusr,30),
						getdate(),		getdate()
					)
				end
				else
				begin
					insert into IMMOQMOA
					(	imm_cocde,		imm_itmno,		imm_cus1no,
						imm_cus2no,		imm_tirtyp,		imm_moqunttyp,
						imm_moqctn,		imm_qty,		imm_curcde,
						imm_moa,		imm_creusr,		imm_updusr,
						imm_credat,		imm_upddat
					)
					values
					(	'',			@ied_ucpno,		@ied_cus1no,
						@ied_cus2no,		'1',			'',
						0,			0,			'',
						0,			left('E-'+ @creusr,30),	left('E-'+ @creusr,30),
						getdate(),		getdate()
					)
				end
			end
			else
			begin
				if @ied_moq <> 0 or @ied_moa <> 0
				begin
					if (select count(*) from IMMOQMOA (nolock) where imm_itmno = @ied_ucpno and imm_cus1no = @ied_cus1no and
						imm_cus2no = @ied_cus2no and ((imm_moqctn = @ied_moq and imm_moqunttyp = @ied_moqum and imm_moqunttyp <> '') or
						(imm_curcde = @ied_moaccy and imm_moa = @ied_moa and imm_curcde <> ''))) = 0
					update	IMMOQMOA
					set	imm_tirtyp = '2',
						imm_moqunttyp = @ied_moqum,
						imm_moqctn = @ied_moq,
						imm_curcde = @ied_moaccy,
						imm_moa = @ied_moa,
						imm_updusr = left('E-'+ @creusr,30),
						imm_upddat = getdate()
					where	imm_itmno = @ied_ucpno and
						imm_cus1no = @ied_cus1no and
						imm_cus2no = @ied_cus2no
				end
				else
				begin
					if (select count(*) from IMMOQMOA (nolock) where imm_itmno = @ied_ucpno and imm_cus1no = @ied_cus1no and
						imm_cus2no = @ied_cus2no and imm_tirtyp = '1') = 0
					update	IMMOQMOA
					set	imm_tirtyp = '1',
						imm_moqunttyp = '',
						imm_moqctn = 0,
						imm_curcde = '',
						imm_moa = 0,
						imm_updusr = left('E-'+ @creusr,30),
						imm_upddat = getdate()
					where	imm_itmno = @ied_ucpno and
						imm_cus1no = @ied_cus1no and
						imm_cus2no = @ied_cus2no
				end
			end
		end
		else
		begin
			select	@imm_moqunttyp = isnull(smm_moqunttyp,''),
				@imm_moq = isnull(smm_moq,0),
				@imm_curcde = isnull(smm_curcde,''),
				@imm_moa = isnull(smm_moa,0)
			from	SYMOQMOA (nolock)
			where	smm_nat = @ied_nat and
				smm_cugrpcde = @ied_cus1no

			if (select count(*) from IMMOQMOA (nolock) where imm_itmno = @ied_ucpno and imm_cus1no = @ied_cus1no and imm_cus2no = @ied_cus2no) = 0
			begin
				insert into IMMOQMOA
				(	imm_cocde,		imm_itmno,		imm_cus1no,
					imm_cus2no,		imm_tirtyp,		imm_moqunttyp,
					imm_moqctn,		imm_qty,		imm_curcde,
					imm_moa,		imm_creusr,		imm_updusr,
					imm_credat,		imm_upddat
				)
				values
				(	'',			@ied_ucpno,		@ied_cus1no,
					@ied_cus2no,		'2',			@imm_moqunttyp,
					@imm_moq,		0,			@imm_curcde,
					@imm_moa,		left('E-'+ @creusr,30),	left('E-'+ @creusr,30),
					getdate(),		getdate()
				)
			end
			else
			begin
				if (select count(*) from IMMOQMOA (nolock) where imm_itmno = @ied_ucpno and imm_cus1no = @ied_cus1no and
					imm_cus2no = @ied_cus2no and ((imm_moqctn = @imm_moq and imm_moqunttyp = @imm_moqunttyp and imm_moqunttyp <> '') or
					(imm_curcde = @imm_curcde and imm_moa = @imm_moa and imm_curcde <> ''))) = 0
				begin
					update	IMMOQMOA
					set	imm_tirtyp = '2',
						imm_moqunttyp = @imm_moqunttyp,
						imm_moqctn = @imm_moq,
						imm_curcde = @imm_curcde,
						imm_moa = @imm_moa,
						imm_updusr = left('E-'+ @creusr,30),
						imm_upddat = getdate()
					where	imm_itmno = @ied_ucpno and
						imm_cus1no = @ied_cus1no and
						imm_cus2no = @ied_cus2no
				end
			end
		end
-- IMMOQMOA END -------------------------------------------------------------------
		
-- IMPCKINF START -----------------------------------------------------------------
		if @ied_untcde <> ''
		begin
			select	@ipi_pckseq = isnull(max(ipi_pckseq),0) + 1
			from	IMPCKINF
			where	ipi_itmno = @ied_ucpno

			if (select count(*) from IMPCKINF (nolock) where ipi_itmno = @ied_ucpno and ipi_inrqty = @ied_inrqty and
				ipi_mtrqty = @ied_mtrqty and ipi_pckunt = @ied_untcde and ipi_cus1no = @ied_cus1no and ipi_cus2no = @ied_cus2no) = 0
			begin

				if @ied_inrhin is null
				begin
					set @ied_inrhin = 0
				end
				
				if @ied_inrwin is null
				begin
					set @ied_inrwin = 0
				end

				if @ied_inrlin is null
				begin
					set @ied_inrlin = 0
				end

				if @ied_mtrhin is null
				begin
					set @ied_mtrhin = 0 
				end

				if @ied_mtrwin is null
				begin
					set @ied_mtrwin = 0 
				end

				if @ied_mtrlin is null
				begin
					set @ied_mtrlin = 0 
				end	

				if @ied_grswgt is null
				begin
					set @ied_grswgt = 0 
				end

				if @ied_netwgt is null
				begin
					set @ied_netwgt = 0 
				end

				if @ied_cft is null
				begin
					set @ied_cft = 0 
				end	

				if @ied_cus1no is null
				begin
					set @ied_cus1no = '' 
				end

				insert into IMPCKINF
				(	ipi_cocde,		ipi_itmno,		ipi_pckseq,
					ipi_pckunt,		ipi_mtrqty,		ipi_inrqty,
					ipi_inrhin,			
					ipi_inrwin,				
					ipi_inrdin,
					ipi_inrhcm,			
					ipi_inrwcm,				
					ipi_inrdcm,
					ipi_mtrhin,			
					ipi_mtrwin,				
					ipi_mtrdin,
					ipi_mtrhcm,			
					ipi_mtrwcm,				
					ipi_mtrdcm,
					ipi_cft,		ipi_cbm,		ipi_grswgt,
					ipi_netwgt,		ipi_pckitr,		ipi_qutdat,
					ipi_creusr,		ipi_updusr,		ipi_credat,		
					ipi_upddat,		ipi_conftr,		ipi_cusno,
					ipi_cus1no,		ipi_cus2no
				)
				values 
				(	' ', 			@ied_ucpno,		@ipi_pckseq,
					@ied_untcde,		@ied_mtrqty,		@ied_inrqty,
					(case @ied_pckm when 'INCH' then @ied_inrhin else @ied_inrhin * 0.3937 end),	
					(case @ied_pckm when 'INCH' then @ied_inrwin else @ied_inrwin * 0.3937 end),	
					(case @ied_pckm when 'INCH' then @ied_inrlin else @ied_inrlin * 0.3937 end),	
					(case @ied_pckm when 'INCH' then @ied_inrhin*2.54 else @ied_inrhin end),		
					(case @ied_pckm when 'INCH' then @ied_inrwin*2.54 else @ied_inrwin end),	
					(case @ied_pckm when 'INCH' then @ied_inrlin*2.54 else @ied_inrlin end),		
					(case @ied_pckm when 'INCH' then @ied_mtrhin else @ied_mtrhin * 0.3937 end),	
					(case @ied_pckm when 'INCH' then @ied_mtrwin else @ied_mtrwin * 0.3937 end),	
					(case @ied_pckm when 'INCH' then @ied_mtrlin else @ied_mtrlin * 0.3937 end),	
					(case @ied_pckm when 'INCH' then @ied_mtrhin*2.54 else @ied_mtrhin end),	
					(case @ied_pckm when 'INCH' then @ied_mtrwin*2.54 else @ied_mtrwin end),	
					(case @ied_pckm when 'INCH' then @ied_mtrlin*2.54 else @ied_mtrlin end),			
					round(@ied_cft,4),	isnull(round(@ied_cft*@cbmcft,4),0),	@ied_grswgt,	
					@ied_netwgt,		@ied_pckitr,		@ied_qutdat,
					left('E-'+ @creusr,30),	left('E-'+ @creusr,30),	getdate(),	
					getdate(), 		@ied_conftr,		@ied_cus1no,
					@ied_cus1no,		@ied_cus2no
				)

				if @ipi_pckseq = 1 
				begin
					if (select count(*) from IMVENPCK (nolock) where ivp_itmno = @ied_ucpno and 
						ivp_pckseq = @ipi_pckseq and ivp_venno = @ied_prdven) = 0
					begin
						insert into IMVENPCK
						(	ivp_cocde,		ivp_itmno,		ivp_pckseq,
							ivp_venno,		ivp_relatn,		ivp_creusr,
							ivp_updusr,		ivp_credat,		ivp_upddat		)
						values
						(	' ',			@ied_ucpno,		@ipi_pckseq,
							@ied_prdven,		'Yes',			left('E-'+ @creusr,30),		
							left('E-'+ @creusr,30),	getdate(),		getdate()		
						)
					end
				end
				else -- @ipi_pckseq = 1 , i.e. > 1
				begin
					if (select count(*) from IMVENPCK (nolock) where ivp_itmno = @ied_ucpno and 
						ivp_pckseq = @ipi_pckseq and ivp_venno = @ied_prdven) = 0
					begin
						insert into IMVENPCK
						(	ivp_cocde,		ivp_itmno,		ivp_pckseq,
							ivp_venno,		ivp_relatn,		ivp_creusr,		
							ivp_updusr,		ivp_credat,		ivp_upddat		)
						select  
							' ',			@ied_ucpno,		@ipi_pckseq,
							ivi_venno,		'Yes',			left('E-'+ @creusr,30),	
							left('E-'+ @creusr,30),	getdate(),		getdate()
						from 	IMVENINF
						where 	ivi_itmno = @ied_ucpno	
					end
				end -- @ipi_pckseq = 1 
			end 
			else -- if (select count(*) from IMPCKINF where ipi_itmno = @ied_ucpno and ... > 0
			begin
				/*
				-- Update IMPRCINF if CFT changes --
				if (select count(*) from IMPCKINF (nolock) where ipi_itmno = @ied_ucpno and ipi_pckunt = @ied_untcde and 	
					ipi_inrqty = @ied_inrqty and ipi_mtrqty = @ied_mtrqty and @ied_cft <> isnull(round(@ied_cft,4),0)) > 0
				begin
					update	IMPRCINF
					set	imu_cft = isnull(round(@ied_cft,4),0)
					where	imu_itmno = @ied_ucpno and
				     	      	imu_pckunt = @ied_untcde and 	
						imu_inrqty = @ied_inrqty and	
			 			imu_mtrqty = @ied_mtrqty
				end
				*/
				update	IMPCKINF
				set	ipi_inrhin = (case @ied_pckm when 'INCH' then isnull(@ied_inrhin,0) else isnull(@ied_inrhin,0) * 0.3937 end),		
					ipi_inrwin = (case @ied_pckm when 'INCH' then isnull(@ied_inrwin,0) else isnull(@ied_inrwin,0) * 0.3937 end),	
					ipi_inrdin = (case @ied_pckm when 'INCH' then isnull(@ied_inrlin,0) else isnull(@ied_inrlin,0) * 0.3937 end),	
					ipi_inrhcm = (case @ied_pckm when 'INCH' then isnull(@ied_inrhin,0)*2.54 else  isnull(@ied_inrhin,0) end),	
					ipi_inrwcm = (case @ied_pckm when 'INCH' then isnull(@ied_inrwin,0)*2.54 else  isnull(@ied_inrwin,0) end),		
					ipi_inrdcm = (case @ied_pckm when 'INCH' then isnull(@ied_inrlin,0)*2.54 else  isnull(@ied_inrlin,0) end),		
					ipi_mtrhin =  (case @ied_pckm when 'INCH' then isnull(@ied_mtrhin,0) else isnull(@ied_mtrhin,0) * 0.3937 end),	
					ipi_mtrwin = (case @ied_pckm when 'INCH' then isnull(@ied_mtrwin,0) else isnull(@ied_mtrwin,0) * 0.3937 end),		
					ipi_mtrdin = (case @ied_pckm when 'INCH' then isnull(@ied_mtrlin,0) else isnull(@ied_mtrlin,0) * 0.3937 end),	
					ipi_mtrhcm = (case @ied_pckm when 'INCH' then isnull(@ied_mtrhin,0)*2.54 else  isnull(@ied_mtrhin,0) end),		
					ipi_mtrwcm = (case @ied_pckm when 'INCH' then isnull(@ied_mtrwin,0)*2.54 else  isnull(@ied_mtrwin,0) end),			
					ipi_mtrdcm = (case @ied_pckm when 'INCH' then isnull(@ied_mtrlin,0)*2.54 else  isnull(@ied_mtrlin,0) end),	
					ipi_cft = isnull(round(@ied_cft,4),0),			
					ipi_cbm = isnull(round(@ied_cft*@cbmcft,4),0),
					ipi_grswgt = isnull(@ied_grswgt,0),		
					ipi_netwgt = isnull(@ied_netwgt,0),
					ipi_updusr = left('E-'+ @creusr,30),
					ipi_upddat = getdate(),
					ipi_conftr = @ied_conftr,
					ipi_qutdat = @ied_qutdat,
					ipi_cusno = @ied_cus1no,
					ipi_pckitr = @ied_pckitr
				where	ipi_itmno = @ied_ucpno and
			     	      	ipi_pckunt = @ied_untcde and 	
					ipi_inrqty = @ied_inrqty and	
		 			ipi_mtrqty = @ied_mtrqty and
					ipi_cus1no = @ied_cus1no and
					ipi_cus2no = @ied_cus2no
				
				update	IMPCKINF
				set	ipi_inrhin = (case @ied_pckm when 'INCH' then isnull(@ied_inrhin,0) else isnull(@ied_inrhin,0) * 0.3937 end),		
					ipi_inrwin = (case @ied_pckm when 'INCH' then isnull(@ied_inrwin,0) else isnull(@ied_inrwin,0) * 0.3937 end),	
					ipi_inrdin = (case @ied_pckm when 'INCH' then isnull(@ied_inrlin,0) else isnull(@ied_inrlin,0) * 0.3937 end),	
					ipi_inrhcm = (case @ied_pckm when 'INCH' then isnull(@ied_inrhin,0)*2.54 else  isnull(@ied_inrhin,0) end),	
					ipi_inrwcm = (case @ied_pckm when 'INCH' then isnull(@ied_inrwin,0)*2.54 else  isnull(@ied_inrwin,0) end),		
					ipi_inrdcm = (case @ied_pckm when 'INCH' then isnull(@ied_inrlin,0)*2.54 else  isnull(@ied_inrlin,0) end),		
					ipi_mtrhin =  (case @ied_pckm when 'INCH' then isnull(@ied_mtrhin,0) else isnull(@ied_mtrhin,0) * 0.3937 end),	
					ipi_mtrwin = (case @ied_pckm when 'INCH' then isnull(@ied_mtrwin,0) else isnull(@ied_mtrwin,0) * 0.3937 end),		
					ipi_mtrdin = (case @ied_pckm when 'INCH' then isnull(@ied_mtrlin,0) else isnull(@ied_mtrlin,0) * 0.3937 end),	
					ipi_mtrhcm = (case @ied_pckm when 'INCH' then isnull(@ied_mtrhin,0)*2.54 else  isnull(@ied_mtrhin,0) end),		
					ipi_mtrwcm = (case @ied_pckm when 'INCH' then isnull(@ied_mtrwin,0)*2.54 else  isnull(@ied_mtrwin,0) end),			
					ipi_mtrdcm = (case @ied_pckm when 'INCH' then isnull(@ied_mtrlin,0)*2.54 else  isnull(@ied_mtrlin,0) end),	
					ipi_cft = isnull(round(@ied_cft,4),0),			
					ipi_cbm = isnull(round(@ied_cft*@cbmcft,4),0),
					ipi_grswgt = isnull(@ied_grswgt,0),		
					ipi_netwgt = isnull(@ied_netwgt,0),
					ipi_updusr = left('E-'+ @creusr,30),
					ipi_upddat = getdate(),
					ipi_conftr = @ied_conftr,
					ipi_qutdat = @ied_qutdat,
					ipi_cusno = @ied_cus1no,
					ipi_pckitr = @ied_pckitr
				where	(select count(*) from IMPRCINF (nolock) where imu_itmno = ipi_itmno and imu_pckunt = ipi_pckunt and imu_inrqty = ipi_inrqty and imu_mtrqty = ipi_mtrqty and imu_conftr = ipi_conftr and imu_cus1no = ipi_cus1no and imu_cus2no = ipi_cus2no and imu_sysgen = 'Y') > 0 and
					(select count(*) from IMPRCINF (nolock) where imu_itmno = ipi_itmno and imu_pckunt = ipi_pckunt and imu_inrqty = ipi_inrqty and imu_mtrqty = ipi_mtrqty and imu_conftr = ipi_conftr and imu_cus1no = ipi_cus1no and imu_cus2no = ipi_cus2no and imu_sysgen = 'N') = 0 and
					(select count(*) from CUGRPINF (nolock) where cgi_cugrpcde = ipi_cus1no and cgi_flg_ext = 'Y') > 0 and
					(select count(*) from CUGRPINF (nolock) where cgi_cugrpcde = @ied_cus1no and cgi_flg_ext = 'Y') > 0 and
					ipi_itmno = @ied_ucpno and
			     	      	ipi_pckunt = @ied_untcde and 	
					ipi_inrqty = @ied_inrqty and	
		 			ipi_mtrqty = @ied_mtrqty and
					ipi_cus1no <> @ied_cus1no and
					ipi_cus2no = ''
				
				if (select count(*) from IMVENPCK (nolock) where ivp_itmno = @ied_ucpno and ivp_venno = @ied_prdven) = 0 
				begin
					insert into IMVENPCK
					(	ivp_cocde,		ivp_itmno,		ivp_pckseq,
						ivp_venno,		ivp_relatn,		ivp_creusr,
						ivp_updusr,		ivp_credat,		ivp_upddat		)
					values
					(	' ',			@ied_ucpno,		@ipi_pckseq,
						@ied_prdven,		'Yes',			left('E-'+ @creusr,30),	
						left('E-'+ @creusr,30),	getdate(),		getdate()		
					)		
				end 
			end -- if (select count(*) from IMPCKINF where ipi_itmno = @ied_ucpno and ... > 0
		end -- if @ied_untcde <> ''
-- IMPCKINF END -------------------------------------------------------------------

-- IMCSTINF START -----------------------------------------------------------------
		if ltrim(rtrim(@ied_cstrmk)) <> '' or ltrim(rtrim(@ied_expdat)) <> ''
		begin
			if EXISTS (select * from IMCSTINF where ici_itmno = @ied_ucpno)
			begin
				Update	IMCSTINF 
				set	
					ici_expdat = case when convert(int, @ied_expdat) <> 0
							then @ied_expdat else ici_expdat end,
					ici_cstrmk = case when ltrim(rtrim(@ied_cstrmk)) <> '' 
							then ltrim(rtrim(@ied_cstrmk)) else ici_cstrmk end,
					ici_updusr =  left('E-'+ @creusr,30),
					ici_upddat = getdate()
				where	
					ici_itmno = @ied_ucpno
			end
			else
			begin
				Insert into IMCSTINF
				(
					ici_cocde,		ici_itmno,		ici_cstrmk,
					ici_expdat,		ici_creusr,		ici_updusr,
					ici_credat, 		ici_upddat
				)
				values
				(
					'',			@ied_ucpno,		@ied_cstrmk,
					@ied_expdat,		left('E-'+ @creusr,30),	left('E-'+ @creusr,30),
					getdate(),		getdate()
				)					
			end
		end
-- IMCSTINF END -------------------------------------------------------------------

-- IMBOMASS (BOM) START -----------------------------------------------------------
		if @venitm <> @ied_ucpno and @ied_ucpno <> '' and ltrim(rtrim(@ied_stage)) = 'A'  and  ltrim(rtrim(@ied_itmtyp)) = 'REG'
		begin
			DECLARE cur_IMBOMEXDAT CURSOR
			FOR	select	ibd_cocde,		ibd_ucpno,		ibd_bomno,
					ibd_colcde,		ibd_qty,		ibd_xlsfil,	
					ibd_chkdat,		ibd_untcde,		ibd_conftr,
					ibd_recseq,		ibd_stage,		ibd_veneml,	
					ibd_malsts,		ibd_sysmsg,		ibd_venno,
					ibd_credat,		ibd_prdven
				from	IMBOMEXDAT (nolock)
				where	ibd_ucpno = @ied_ucpno and
					ibd_xlsfil = @ied_xlsfil and
					ibd_chkdat = @ied_chkdat and
					ibd_stage = 'W'
			
			OPEN cur_IMBOMEXDAT
			FETCH NEXT FROM cur_IMBOMEXDAT INTO
			@ibd_cocde,	@ibd_ucpno,	@ibd_bomno,
			@ibd_colcde,	@ibd_qty,	@ibd_xlsfil,	
			@ibd_chkdat,	@ibd_untcde,	@ibd_conftr,
			@ibd_recseq,	@ibd_stage,	@ibd_veneml,	
			@ibd_malsts,	@ibd_sysmsg,	@ibd_venno,
			@ibd_credat,	@ibd_prdven

			WHILE @@fetch_status = 0
			BEGIN
				if @ventyp = 'D'
				begin
					set @imu_curcde = ''
					set @imu_ftyprc = 0
					set @imu_bcurcde = ''
					set @imu_ftycst = 0
					
					select	@imu_curcde = imu_curcde,
						@imu_ftyprc = imu_ftyprc,
						@imu_bcurcde = imu_bcurcde,
						@imu_ftycst = imu_ftycst
					from	IMPRCINF (nolock)
					where	imu_itmno = @ibd_bomno and
						imu_typ = 'BOM' and
						imu_ventyp = 'D'

					if (select count(*) from IMBOMASS (nolock) where iba_itmno = @ibd_ucpno and iba_assitm = @ibd_bomno and
						iba_colcde = @ibd_colcde and iba_typ = 'BOM') = 0
					begin
						insert into IMBOMASS
						(	iba_cocde,		iba_itmno,		iba_assitm,	
							iba_typ,		iba_colcde,		iba_pckunt,	
							iba_bomqty,		iba_inrqty,		iba_mtrqty,	
							iba_creusr,		iba_updusr,		iba_credat,	
							iba_upddat, 		iba_curcde, 		iba_untcst,
							iba_fmlopt,		iba_bombasprc,		iba_costing,
							iba_fcurcde,		iba_ftycst
						)
						values
						(	' ',			@ibd_ucpno,		@ibd_bomno,	
							'BOM',			@ibd_colcde,		@ibd_untcde,	
							@ibd_qty,		0,			0,		
							left('E-'+ @creusr,30),	left('E-'+ @creusr,30),	getdate(),		
							getdate(),		@imu_curcde,		@imu_ftyprc,
							'B01',			@imu_ftyprc*1.0,	'N',		
							@imu_bcurcde,		@imu_ftycst
						)
					end
					else -- if (select count(*) from IMBOMASS where iba_itmno = @ibd_ucpno and ... > 0
					begin
						-- Retrieve BOM Markup Formula (using B01 code) --
						-- Using fmlopt B01 for BOM from External factory
						select 	@fml = yfi_fml 
						from 	SYFMLINF (nolock)
						where 	yfi_fmlopt = 'B01'
						
						-- Update IM BOM Price --
						set @iba_bombasprc = @imu_ftyprc
						
						if ltrim(rtrim(@fml)) <> ''
						begin
							set @fml = ltrim(@fml)
							set @OP = substring(@fml,1,1)
							------
							if (charindex('*', @fml) <> 0)
							begin
								set @end = charindex('*',@fml)
							end
							else
							begin
								set @end = charindex('/', @fml)
							end
							
							if (@end > 0)
							begin
								set @temp = substring(@fml, 1 + @end,len(@fml))
							
								if @OP = '*'
								begin
									set @iba_bombasprc = @iba_bombasprc * @temp
								end
								else if @OP = '/'
								begin
									set @iba_bombasprc = @iba_bombasprc / @temp
								end
							end
							
							update	IMBOMASS
							set	iba_bomqty = @ibd_qty, 
								iba_pckunt = @ibd_untcde, 
								iba_updusr = left('E-'+ @creusr,30),
								iba_upddat = getdate(), 
								iba_curcde = @imu_curcde, 	
								iba_untcst =  @imu_ftyprc,
								iba_bombasprc = @iba_bombasprc ,
								iba_fcurcde = @imu_bcurcde,
								iba_ftycst = @imu_ftycst
							where	iba_itmno = @ibd_ucpno  and 
								iba_assitm = @ibd_bomno and 
								iba_colcde = @ibd_colcde and 
								iba_typ = 'BOM'
						end -- if ltrim(rtrim(@fml)) <> ''
					end -- if (select count(*) from IMBOMASS where iba_itmno = @ibd_ucpno and ... > 0
				end -- if @ventyp = 'D'
				
				select	@ibd_seqno = isnull(max(ibd_seqno),0) + 1
				from	IMBOMEXDATH
				where	ibd_ucpno = @ibd_ucpno and
					ibd_bomno = @ibd_bomno and 
					ibd_venno = @ibd_venno and
					ibd_prdven = @ibd_prdven and
					ibd_xlsfil = @ibd_xlsfil and
					ibd_chkdat = @ibd_chkdat and
					ibd_recseq = @ibd_recseq and
					ibd_colcde = @ibd_colcde

				insert into IMBOMEXDATH
				(	ibd_cocde,		ibd_ucpno,		ibd_bomno,
					ibd_recseq,		ibd_colcde,		ibd_qty,
					ibd_untcde,		ibd_conftr,		ibd_stage,
					ibd_sysmsg,		ibd_xlsfil,		ibd_veneml,
					ibd_malsts,		ibd_chkdat,		ibd_creusr,	
					ibd_updusr,		ibd_credat,		ibd_upddat,
					ibd_venno,		ibd_prdven, 		ibd_seqno,
					ibd_cus1no,		ibd_cus2no	
				)
				values
				(	@ibd_cocde,		@ibd_ucpno,		@ibd_bomno,
					@ibd_recseq,		@ibd_colcde,		@ibd_qty,	
					@ibd_untcde,		@ibd_conftr,		@ibd_stage,
					@ibd_sysmsg,		@ibd_xlsfil,		@ibd_veneml,
					@ibd_malsts,		@ibd_chkdat,		left('E-'+ @creusr,30),
					left('E-'+ @creusr,30),	getdate(),		@ibd_credat,
					@ibd_venno,		@ibd_prdven, 		@ibd_seqno,	
					@ied_cus1no,		@ied_cus2no	
				)
				
				delete from IMBOMEXDAT
				where	ibd_ucpno = @ibd_ucpno and 
					ibd_bomno = @ibd_bomno and 	
					ibd_colcde = @ibd_colcde and
					ibd_xlsfil  = ltrim(rtrim(@ibd_xlsfil)) and
					ibd_chkdat = @ibd_chkdat and
					ibd_recseq = @ibd_recseq
			
			FETCH NEXT FROM cur_IMBOMEXDAT INTO
			@ibd_cocde,	@ibd_ucpno,	@ibd_bomno,
			@ibd_colcde,	@ibd_qty,	@ibd_xlsfil,	
			@ibd_chkdat,	@ibd_untcde,	@ibd_conftr,
			@ibd_recseq,	@ibd_stage,	@ibd_veneml,	
			@ibd_malsts,	@ibd_sysmsg,	@ibd_venno,
			@ibd_credat,	@ibd_prdven
			END -- FETCH cur_IMBOMEXDAT
			CLOSE cur_IMBOMEXDAT
			DEALLOCATE cur_IMBOMEXDAT
		end -- if @venitm <> @ied_ucpno and @ied_ucpno <> '' and ...
-- IMBOMASS (BOM) END -------------------------------------------------------------

-- IMBOMASS (ASS) START -----------------------------------------------------------
		if @venitm <> @ied_ucpno and  ltrim(rtrim(@ied_stage)) = 'A'  and  ltrim(rtrim(@ied_itmtyp)) = 'REG'
		begin
			DECLARE cur_IMASSEXDAT CURSOR
			FOR	select 	iad_cocde,	iad_asstno,	iad_assdno,
					iad_colcde,	iad_inrqty,	iad_mtrqty,
					iad_xlsfil,	iad_chkdat,	iad_untcde,	
					iad_conftr,	iad_recseq,	iad_stage,
					iad_veneml,	iad_malsts,	iad_sysmsg,
					iad_venno,	iad_credat,	iad_prdven
				from	IMASSEXDAT (nolock)
				where	iad_asstno = @ied_ucpno and 
					iad_xlsfil = @ied_xlsfil and 
					iad_chkdat = @ied_chkdat and 
					iad_stage = 'W'
			
			OPEN cur_IMASSEXDAT
			FETCH NEXT FROM cur_IMASSEXDAT INTO 
			@iad_cocde,	@iad_asstno,	@iad_assdno,
			@iad_colcde,	@iad_inrqty,	@iad_mtrqty,
			@iad_xlsfil,	@iad_chkdat,	@iad_untcde,	
			@iad_conftr,	@iad_recseq,	@iad_stage,	
			@iad_veneml,	@iad_malsts,	@iad_sysmsg,
			@iad_venno,	@iad_credat,	@iad_prdven
			
			WHILE @@fetch_status = 0
			BEGIN
				if @ventyp = 'D'
				begin
					if (select count(*) from IMBOMASS (nolock) where iba_itmno = @ied_ucpno and iba_assitm = @iad_assdno and
						iba_colcde = @iad_colcde and iba_typ = 'ASS') = 0
					begin
						insert into IMBOMASS
						(	iba_cocde,		iba_itmno,		iba_assitm,	
							iba_typ,		iba_colcde,		iba_pckunt,	
							iba_bomqty,		iba_inrqty,		iba_mtrqty,	
							iba_creusr,		iba_updusr,		iba_credat,	
							iba_upddat
						)
						values
						(	' ',			@ied_ucpno,		@iad_assdno,	
							'ASS',			@iad_colcde,		@iad_untcde,	
							0,			@iad_inrqty,		@iad_mtrqty,		
							left('E-'+ @creusr,30),	left('E-'+ @creusr,30),	getdate(),		
							getdate()
						)
					end
					else -- if (select count(*) from IMBOMASS where iba_itmno = @ied_ucpno and ... > 0
					begin
						update	IMBOMASS 
						set 	iba_inrqty = @iad_inrqty, 
							iba_mtrqty = @iad_mtrqty,
							iba_pckunt = @iad_untcde, 
							iba_updusr = left('E-'+ @creusr,30),
							iba_upddat = getdate()
						where 	iba_itmno = @ied_ucpno and 
							iba_assitm = @iad_assdno and 
							iba_colcde = @iad_colcde and 
							iba_typ = 'ASS'
					end
				end -- if @ventyp = 'D'
				
				select	@iad_seqno = isnull(max(iad_seqno),0) + 1
				from	IMASSEXDATH
				where	iad_asstno = @iad_asstno and
					iad_assdno = @iad_assdno and 
					iad_venno = @iad_venno and
					iad_prdven = @iad_prdven and			
					iad_xlsfil = @iad_xlsfil and
					iad_chkdat = @iad_chkdat and
					iad_colcde = @iad_colcde and
					iad_recseq = @iad_recseq
				
				insert into IMASSEXDATH
				(	iad_cocde,		iad_asstno,		iad_assdno,
					iad_recseq,		iad_colcde,		iad_inrqty,
					iad_mtrqty,		iad_untcde,		iad_conftr,
					iad_stage,		iad_sysmsg,		iad_xlsfil,
					iad_veneml,		iad_malsts,		iad_chkdat,
					iad_creusr,		iad_updusr,		iad_credat,
					iad_upddat,		iad_venno,		iad_prdven,	
					iad_seqno, 		iad_cus1no,		iad_cus2no
				)
				values
				(	@iad_cocde,		@iad_asstno,		@iad_assdno,
					@iad_recseq,		@iad_colcde,		@iad_inrqty,	
					@iad_mtrqty,		@iad_untcde,		@iad_conftr,
					@iad_stage,		@iad_sysmsg,		@iad_xlsfil,
					@iad_veneml,		@iad_malsts,		@iad_chkdat,
					left('E-'+ @creusr,30),	left('E-'+ @creusr,30),	getdate(),
					@iad_credat,		isnull(@iad_venno,''),	isnull(@iad_prdven,''),
					@iad_seqno,		@ied_cus1no,		@ied_cus2no
				)
				
				delete from IMASSEXDAT
				where	iad_asstno = @iad_asstno and 
					iad_assdno = @iad_assdno and
				 	iad_colcde = @iad_colcde and
					iad_xlsfil  = @iad_xlsfil and
				 	iad_chkdat = @iad_chkdat and
					iad_venno = @iad_venno and
				 	iad_recseq = @iad_recseq and
					iad_prdven = @iad_prdven
			
			FETCH NEXT FROM cur_IMASSEXDAT INTO 
			@iad_cocde,	@iad_asstno,	@iad_assdno,
			@iad_colcde,	@iad_inrqty,	@iad_mtrqty,
			@iad_xlsfil,	@iad_chkdat,	@iad_untcde,	
			@iad_conftr,	@iad_recseq,	@iad_stage,	
			@iad_veneml,	@iad_malsts,	@iad_sysmsg,
			@iad_venno,	@iad_credat,	@iad_prdven
			END -- FETCH cur_IMASSEXDAT
			CLOSE cur_IMASSEXDAT
			DEALLOCATE cur_IMASSEXDAT
		end -- if @venitm <> @ied_ucpno and  ltrim(rtrim(@ied_stage)) = 'A' and ...
-- IMBOMASS (ASS) END -------------------------------------------------------------

-- IMCOLINF START -----------------------------------------------------------------
		if @ventyp = 'D'
		begin
			if (select count(*) from IMCOLINF (nolock) where icf_itmno = @ied_ucpno and icf_colcde = @ied_vencol) = 0
			begin
				select	@colseq = isnull(max(icf_colseq),0) + 1
				from	IMCOLINF
				where	icf_itmno = @ied_ucpno
				
				insert into IMCOLINF
				(	icf_cocde,		icf_itmno,		icf_colcde,	
					icf_colseq,		icf_vencol,		icf_coldsc,	
					icf_typ,		icf_ucpcde,		icf_eancde,
					icf_lnecde,		icf_creusr,		icf_updusr,
					icf_credat,		icf_upddat
				)
				values
				(	' ', 	 		@ied_ucpno,		@ied_vencol,	
					@colseq, 		@ied_vencol2,		@ied_vencoldsc,	
					'',			'',			'',
					@ied_lnecde,		left('E-'+ @creusr,30),	left('E-'+ @creusr,30),
					getdate(),		getdate()
				)
			end
			else -- if (select count(*) from IMCOLINF where icf_itmno = @ied_ucpno and ... > 0
			begin
				update	IMCOLINF
				set	icf_coldsc = @ied_vencoldsc, 
					icf_vencol = @ied_vencol2,
					icf_lnecde = @ied_lnecde,
					icf_updusr = left('E-'+ @creusr,30),
					icf_upddat = getdate()
				where	icf_itmno = @ied_ucpno and 
					icf_colcde = @ied_vencol
			end

			if (select count(*) from IMCOLINF (nolock) where icf_itmno = @ied_ucpno) > 0 and
			   (select count(*) from IMPCKINF (nolock) where ipi_itmno = @ied_ucpno) > 0 and
			   ((select count(*) from IMPRCINF (nolock) where imu_itmno = @ied_ucpno and imu_status = 'ACT') > 0 or
			    (select count(*) from #IMPRCINF_BUFFER (nolock) where imu_itmno = @ied_ucpno and imu_status = 'ACT') > 0)
			begin
				set @ied_itmsts = 'CMP'
				
			end
			else
			begin
				set @ied_itmsts = 'INC'
			end
		end -- if @venitm <> @ied_ucpno
-- IMCOLINF END -------------------------------------------------------------------

-- IMMATBKD START -----------------------------------------------------------------
		if @ied_ucpno <> '' and @ventyp = 'D'
		begin
			delete from IMMATBKD where ibm_itmno = @ied_ucpno
			
			DECLARE cur_IMMBDEXDAT CURSOR
			FOR 	select	ikd_cocde,	ikd_venno,	ikd_prdven,
					ikd_ucpno,	ikd_recseq,	ikd_matdsc,
					ikd_curcde,	ikd_cst,	ikd_cstper,
					ikd_wgtper,	ikd_stage,	ikd_sysmsg,
					ikd_xlsfil,	ikd_chkdat,	ikd_credat
				from	IMMBDEXDAT (nolock)
				where	ikd_ucpno = @ied_ucpno and 
					ikd_xlsfil = @ied_xlsfil and 
					ikd_chkdat = @ied_chkdat and
					ikd_stage = 'W'
			
			OPEN cur_IMMBDEXDAT
			FETCH NEXT FROM cur_IMMBDEXDAT INTO 
			@ikd_cocde,	@ikd_venno,	@ikd_prdven,
			@ikd_ucpno,	@ikd_recseq,	@ikd_matdsc,
			@ikd_curcde,	@ikd_cst,	@ikd_cstper,
			@ikd_wgtper,	@ikd_stage,	@ikd_sysmsg,
			@ikd_xlsfil,	@ikd_chkdat,	@ikd_credat
			
			WHILE @@fetch_status = 0
			BEGIN
				insert into IMMATBKD
				(	ibm_cocde,		ibm_itmno,		ibm_matseq,
					ibm_mat,		ibm_curcde,		ibm_cst,
					ibm_cstper,		ibm_wgtper,		ibm_creusr,
					ibm_updusr,		ibm_credat,		ibm_upddat
				)
				values
				(	@ikd_cocde,		@ikd_ucpno,		@ikd_recseq,
					@ikd_matdsc,		@ikd_curcde,		@ikd_cst,
					@ikd_cstper,		@ikd_wgtper,		left('E-'+ @creusr,30),
					left('E-'+ @creusr,30),	getdate(),		getdate()
				)

				select	@ikd_seqno = isnull(max(ikd_seqno),0) + 1
				from	IMMBDEXDATH
				where	ikd_ucpno = @ikd_ucpno and
					ikd_matdsc = @ikd_matdsc and 
					ikd_venno = @ikd_venno and
					ikd_prdven = @ikd_prdven and 					
					ikd_recseq = @ikd_recseq and 	
					ikd_xlsfil = @ikd_xlsfil and
					ikd_chkdat = @ikd_chkdat
				
				insert into IMMBDEXDATH
				(	ikd_cocde,		ikd_venno,		ikd_prdven,
					ikd_ucpno,		ikd_recseq,		ikd_matdsc,
					ikd_curcde,		ikd_cst,		ikd_cstper,
					ikd_wgtper,		ikd_stage,		ikd_sysmsg,
					ikd_xlsfil,		ikd_chkdat,		ikd_creusr,
					ikd_updusr,		ikd_credat,		ikd_upddat,
			 		ikd_seqno,		ikd_cus1no,		ikd_cus2no
				)
				values
				(
					@ikd_cocde,		isnull(@ikd_venno,''),	isnull(@ikd_prdven,''),
					@ikd_ucpno,		@ikd_recseq,		@ikd_matdsc,
					@ikd_curcde,		@ikd_cst,		@ikd_cstper,
					@ikd_wgtper,		@ikd_stage,		@ikd_sysmsg,
					@ikd_xlsfil,		@ikd_chkdat,		left('E-'+ @creusr,30),
					left('E-'+ @creusr,30),	getdate(),		@ikd_credat,
					@ikd_seqno,		@ied_cus1no,		@ied_cus2no
				)
				
				delete from IMMBDEXDAT
				where	ikd_ucpno = @ied_ucpno and 
					ikd_matdsc = @ikd_matdsc and
					ikd_xlsfil = @ikd_xlsfil and 
					ikd_chkdat = @ikd_chkdat and
					ikd_recseq = @ikd_recseq
				
			FETCH NEXT FROM cur_IMMBDEXDAT INTO 
			@ikd_cocde,	@ikd_venno,	@ikd_prdven,
			@ikd_ucpno,	@ikd_recseq,	@ikd_matdsc,
			@ikd_curcde,	@ikd_cst,	@ikd_cstper,
			@ikd_wgtper,	@ikd_stage,	@ikd_sysmsg,
			@ikd_xlsfil,	@ikd_chkdat,	@ikd_credat
			END -- FETCH cur_IMMBDEXDAT
			CLOSE cur_IMMBDEXDAT
			DEALLOCATE cur_IMMBDEXDAT
		end -- if @ied_ucpno <> '' and @ventyp = 'D'
-- IMMATBKD END -------------------------------------------------------------------
		
		-- Determine Current IMPRCINF entry before update --
		select	@imu_effdat_before = imu_effdat,
			@imu_expdat_before = imu_expdat,
			@imu_curcde_before = imu_curcde,
			@imu_ftycst_before = imu_ftycst,
			@imu_ftycstA_before = imu_ftycstA,
			@imu_ftycstB_before = imu_ftycstB,
			@imu_ftycstC_before = imu_ftycstC,
			@imu_ftycstD_before = imu_ftycstD,
			@imu_ftycstTran_before = imu_ftycstTran,
			@imu_ftycstPack_before = imu_ftycstPack,
			@imu_ftyprc_before = imu_ftyprc,
			@imu_ftyprcA_before = imu_ftyprcA,
			@imu_ftyprcB_before = imu_ftyprcB,
			@imu_ftyprcC_before = imu_ftyprcC,
			@imu_ftyprcD_before = imu_ftyprcD,
			@imu_ftyprcTran_before = imu_ftyprcTran,
			@imu_ftyprcPack_before = imu_ftyprcPack,
			@imu_ttlcst_before = imu_ttlcst,
			@imu_bomcst_before = imu_bomcst,
			@imu_hkadjper_before = imu_hkadjper,
			@imu_negcst_before = imu_negcst,
			@imu_negprc_before = imu_negprc,
			@imu_fmlopt_before = imu_fmlopt,
			@imu_bcurcde_before = imu_bcurcde,
			@imu_itmprc_before = imu_itmprc,
			@imu_basprc_before = imu_basprc,
			@imu_period_before = imu_period,
			@imu_cstchgdat_before = imu_cstchgdat,
			@imu_typ = imu_typ,
			@imu_ventyp = imu_ventyp,
			@imu_effdat = imu_effdat,
			@imu_cstchgdat = imu_cstchgdat,
			@imu_creusr = imu_creusr,
			@imu_credat = imu_credat
		from	IMPRCINF (nolock)
		where	imu_itmno = @ied_ucpno and
			imu_venno = @ied_venno and
			imu_prdven = @ied_prdven and
			imu_pckunt = @ied_untcde and
			imu_inrqty = @ied_inrqty and
			imu_mtrqty = @ied_mtrqty and
			imu_cus1no = @ied_cus1no and
			imu_cus2no = @ied_cus2no and
			imu_ftyprctrm = @ied_ftyprctrm and
			imu_hkprctrm = @ied_hkprctrm and
			imu_trantrm = @ied_trantrm
-- IMPRCINF START -----------------------------------------------------------------
				
		-- Calculate Factory Price / Factory Cost Difference --
		if @ied_ftycst = 0
			set @chgfp = 0
		else
			set @chgfp = round(@ied_ftyprc / @ied_ftycst * 100, 0)
		
		-- Basic price currency for REG, ASS, BOM itemtype
		select	@imu_bcurcde = ysi_cde
		from	SYSETINF 
		where 	ysi_typ = '06' and
			ysi_def = 'Y'
		
		if @ied_itmtyp = 'BOM'
		begin		
			select	@imu_selrat = isnull(yce_selrat, 0)
			from	SYCUREX (nolock)
			where	yce_frmcur = 'HKD' and
				yce_tocur = (select ysi_cde from SYSETINF where ysi_typ = '06' and ysi_def = 'Y') and
				yce_iseff = 'Y'

			
			insert into #IMPRCINF_BUFFER
			(	imu_cocde,			imu_itmno,			imu_typ,
				imu_ventyp,			imu_venno,			imu_prdven,
				imu_pckunt,			imu_conftr,			imu_inrqty,
				imu_mtrqty,			imu_cft,			imu_cus1no,
				imu_cus2no,			imu_ftyprctrm,			imu_hkprctrm,
				imu_trantrm,			imu_effdat,			imu_expdat,
				imu_status,			imu_curcde,			imu_ftycst,
				imu_ftycstA,			imu_ftycstB,			imu_ftycstC,
				imu_ftycstD,			imu_ftycstTran,			imu_ftycstPack,
				imu_fml,			imu_fmlA,			imu_fmlB,
				imu_fmlC,			imu_fmlD,			imu_fmlTran,
				imu_fmlPack,			imu_chgfp,			imu_chgfpA,
				imu_chgfpB,			imu_chgfpC,			imu_chgfpD,
				imu_chgfpTran,			imu_chgfpPack,			imu_ftyprc,
				imu_ftyprcA,			imu_ftyprcB,			imu_ftyprcC,
				imu_ftyprcD,			imu_ftyprcTran,			imu_ftyprcPack,
				imu_bomcst,			imu_ttlcst,			imu_hkadjper,
				imu_negcst,			imu_negprc,			imu_fmlopt,
				imu_bcurcde,			imu_itmprc,			imu_bomprc,
				imu_basprc,			imu_period,			imu_cstchgdat,
				imu_sysgen,			imu_estprcflg,			imu_estprcref,
				imu_creusr,			imu_updusr,			imu_credat,
				imu_upddat
			)
			values
			(	'',				@ied_ucpno,			'BOM',
				@imu_ventyp,			@ied_venno,			@ied_prdven,
				@ied_untcde,			@ied_conftr,			@ied_inrqty,
				@ied_mtrqty,			round(@ied_cft,4),		@ied_cus1no,
				@ied_cus2no,			@ied_ftyprctrm,			@ied_hkprctrm,
				--@ied_trantrm,			@imu_effdat,			@ied_expdat,
				@ied_trantrm,			@ied_qutdat,			@ied_expdat,
				'ACT',				@ied_curcde,			round(@ied_ftycst,4),
				0,				0,				0,
				0,				0,				0,
				'',				'',				'',
				'',				'',				'',
				'',				@chgfp,				0,
				0,				0,				0,
				0,				0,				round(@ied_ftyprc,4),
				0,				0,				0,
				0,				0,				0,
				0,				0,				0,
				0,				0,				'B01',
				@imu_bcurcde,			0,				0,
				0,				'',				@imu_cstchgdat,
				'N',				@ied_estprcflg,			@ied_estprcref,
				@imu_creusr,			left('E-'+ @creusr,30),		@imu_credat,
				getdate()
			)
			
		end
		else -- if @ied_itmtyp <> 'BOM'
		begin
			
			set @bomcst = 0
			set @bomprc = 0
			set @imu_buyrat = 0
			-- Calculate BOM Cost and BOM Price --
			select	@imu_selrat = yce_selrat,
				@imu_buyrat = yce_buyrat
			from	SYCUREX (nolock)
			where	yce_frmcur = 'HKD' and
				yce_tocur = (select ysi_cde from SYSETINF (nolock) where ysi_typ = '06' and ysi_def = 'Y') and
				yce_iseff = 'Y'

			DECLARE cur_calbom CURSOR
			FOR	select	iba_costing,		iba_curcde,		iba_bomqty,
					iba_bombasprc
				from	IMBOMASS
				where	iba_itmno = @ied_ucpno
			
			OPEN cur_calbom
			FETCH NEXT FROM cur_calbom INTO 
			@iba_costing, 		@iba_curcde, 		@iba_bomqty, 
			@iba_bombasprc
			
			WHILE @@fetch_status = 0
			BEGIN
				-- Calculate BOM Cost --
				if @ied_curcde = 'HKD'
				begin
					if @ied_curcde = @iba_curcde
					begin
						if @iba_costing = 'Y'
							set @bomcst = @bomcst + (@iba_bombasprc * @iba_bomqty)
					end
					else
					begin
						if @iba_costing = 'Y'
			 				set @bomcst = @bomcst + ((@iba_bombasprc * @iba_bomqty) / @imu_buyrat)
					end
				end
				else -- if @ied_curcde = 'USD'
				begin
					if @ied_curcde = @iba_curcde
					begin
						if @iba_costing = 'Y'
							set @bomcst = @bomcst + (@iba_bombasprc * @iba_bomqty)
					end
					else -- @D_imu_curcde <> @iba_curcde
					begin
						if @iba_costing = 'Y'
	 						set @bomcst = @bomcst + ((@iba_bombasprc * @iba_bomqty) * @imu_selrat)
					end
				end
				-- Calculate BOM Price --
				if @imu_bcurcde = 'HKD'
				begin
					if  @iba_curcde = 'HKD'
					begin
						if @iba_costing = 'N'
							set @bomprc = @bomprc +(@iba_bombasprc * @iba_bomqty)
					end
					else
					begin	
						if @iba_costing = 'N'
							set @bomprc = @bomprc + ((@iba_bombasprc *  @iba_bomqty) / @imu_selrat)
					end
				end
				else -- if @imu_bcurcde = 'USD'
				begin
					if  @iba_curcde = 'USD'
					begin
						if @iba_costing = 'N'
							set @bomprc = @bomprc + (@iba_bombasprc * @iba_bomqty)
					end
					else -- iba_curcde = 'HKD'
					begin	
						if @iba_costing = 'N'
							set @bomprc = @bomprc + ((@iba_bombasprc * @iba_bomqty) * @imu_selrat)
					end
				end

			FETCH NEXT FROM cur_calbom INTO 
			@iba_costing, 		@iba_curcde, 		@iba_bomqty, 
			@iba_bombasprc
			END -- FETCH cur_calbom
			CLOSE cur_calbom
			DEALLOCATE cur_calbom
			
			
			set @bomcst = round(@bomcst,4)
			set @bomprc = round(@bomprc,4)
			
			-- Initialize variables --
			set @imu_fmlopt = ''
			set @fml = ''
			
			-- Select the appropriate Markup Formula --
			if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
				icf_vencde = 'EXT' and icf_cus1no = @ied_cus1no and icf_cus2no = @ied_cus2no and
				icf_catlvl4 = @ied_catlvl4 and icf_expdat >= getdate() and icf_def = 'Y') > 0 and
				@ied_cus1no <> '' and @ied_cus2no <> '' and @ied_catlvl4 <> ''
			begin
				select	@imu_fmlopt = icf_fml_hk,
					@fml = yfi_fml
				from	IMCALFML (nolock), SYFMLINF (nolock)
				where	icf_caltar = 'IM' and
					icf_caltyp = 'BASIC' and
					icf_vencde = 'EXT' and
					icf_cus1no = @ied_cus1no and
					icf_cus2no = @ied_cus2no and
					icf_catlvl4 = @ied_catlvl4 and
					icf_expdat >= getdate() and
					icf_def = 'Y' and
					yfi_fmlopt = icf_fml_hk
			end
			else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
				icf_vencde = 'EXT' and icf_cus1no = @ied_cus1no and icf_cus2no = '' and
				icf_catlvl4 = @ied_catlvl4 and icf_expdat >= getdate() and icf_def = 'Y') > 0 and
				@ied_cus1no <> '' and @ied_catlvl4 <> ''
			begin
				select	@imu_fmlopt = icf_fml_hk,
					@fml = yfi_fml
				from	IMCALFML (nolock), SYFMLINF (nolock)
				where	icf_caltar = 'IM' and
					icf_caltyp = 'BASIC' and
					icf_vencde = 'EXT' and
					icf_cus1no = @ied_cus1no and
					icf_cus2no = '' and
					icf_catlvl4 = @ied_catlvl4 and
					icf_expdat >= getdate() and
					icf_def = 'Y' and
					yfi_fmlopt = icf_fml_hk
			end
			else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
				icf_vencde = 'EXT' and icf_cus1no = '' and icf_cus2no = '' and
				icf_catlvl4 = @ied_catlvl4 and icf_expdat >= getdate() and icf_def = 'Y') > 0 and
				@ied_catlvl4 <> ''
			begin
				select	@imu_fmlopt = icf_fml_hk,
					@fml = yfi_fml
				from	IMCALFML (nolock), SYFMLINF (nolock)
				where	icf_caltar = 'IM' and
					icf_caltyp = 'BASIC' and
					icf_vencde = 'EXT' and
					icf_cus1no = '' and
					icf_cus2no = '' and
					icf_catlvl4 = @ied_catlvl4 and
					icf_expdat >= getdate() and
					icf_def = 'Y' and
					yfi_fmlopt = icf_fml_hk
			end
			else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
				icf_vencde = 'EXT' and icf_cus1no = @ied_cus1no and icf_cus2no = @ied_cus2no and
				icf_catlvl4 = '' and icf_expdat >= getdate() and icf_def = 'Y') > 0 and
				@ied_cus1no <> '' and @ied_cus2no <> ''
			begin
				select	@imu_fmlopt = icf_fml_hk,
					@fml = yfi_fml
				from	IMCALFML (nolock), SYFMLINF (nolock)
				where	icf_caltar = 'IM' and
					icf_caltyp = 'BASIC' and
					icf_vencde = 'EXT' and
					icf_cus1no = @ied_cus1no and
					icf_cus2no = @ied_cus2no and
					icf_catlvl4 = '' and
					icf_expdat >= getdate() and
					icf_def = 'Y' and
					yfi_fmlopt = icf_fml_hk
			end
			else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
				icf_vencde = 'EXT' and icf_cus1no = @ied_cus1no and icf_cus2no = '' and
				icf_catlvl4 = '' and icf_expdat >= getdate() and icf_def = 'Y') > 0 and @ied_cus1no <> ''
			begin
				select	@imu_fmlopt = icf_fml_hk,
					@fml = yfi_fml
				from	IMCALFML (nolock), SYFMLINF (nolock)
				where	icf_caltar = 'IM' and
					icf_caltyp = 'BASIC' and
					icf_vencde = 'EXT' and
					icf_cus1no = @ied_cus1no and
					icf_cus2no = '' and
					icf_catlvl4 = '' and
					icf_expdat >= getdate() and
					icf_def = 'Y' and
					yfi_fmlopt = icf_fml_hk
			end
			else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
				icf_vencde = @ied_prdven and icf_cus1no = '' and icf_cus2no = '' and
				icf_catlvl4 = '' and icf_expdat >= getdate() and icf_def = 'Y') > 0
			begin
				select	@imu_fmlopt = icf_fml_hk,
					@fml = yfi_fml
				from	IMCALFML (nolock), SYFMLINF (nolock)
				where	icf_caltar = 'IM' and
					icf_caltyp = 'BASIC' and
					icf_vencde = @ied_prdven and
					icf_cus1no = '' and
					icf_cus2no = '' and
					icf_catlvl4 = '' and
					icf_expdat >= getdate() and
					icf_def = 'Y' and
					yfi_fmlopt = icf_fml_hk
			end
			else
			begin
				select	@imu_fmlopt = icf_fml_hk,
					@fml = yfi_fml
				from	IMCALFML (nolock), SYFMLINF (nolock)
				where	icf_caltar = 'IM' and
					icf_caltyp = 'BASIC' and
					icf_vencde = 'EXT' and
					icf_cus1no = '' and
					icf_cus2no = '' and
					icf_catlvl4 = '' and
					icf_expdat >= getdate() and
					icf_def = 'Y' and
					yfi_fmlopt = icf_fml_hk
			end

			if @fml is null or @fml = ''
			begin
				set @fml = '0'
			end
			
			select	@imu_selrat =  isnull(yce_selrat, 0)
			from	SYCUREX (nolock)
			where	yce_frmcur = @ied_curcde and
				yce_tocur = (select ysi_cde from SYSETINF where ysi_typ = '06' and ysi_def = 'Y') and
				yce_iseff = 'Y'

			if @imu_bcurcde is null
			begin
				set @imu_bcurcde = ''
			end
	
			if @imu_selrat is null
			begin
				set @imu_selrat = 0
			end
			
			-- Calculate IM Item Price --
			set @imu_itmprc = @ied_ftyprc
			set @imu_basprc = 0
			
			set @fml = ltrim(rtrim(@fml))
			set @fml = replace(@fml,' ','')
			if (substring(@fml,1,1) <> '*') and (substring(@fml,1,1) <> '/')
			begin
				set @fml = '*' + @fml
			end
			set @OP = substring(@fml,1,1)
			
			set @temp = substring(@fml, 2, len(@fml)-1)
			
			if @OP = '*'
			begin
				set @imu_itmprc = @imu_itmprc * @temp
			end
			else if @OP = '/'
			begin
				set @imu_itmprc = @imu_itmprc / @temp
			end

			set @imu_itmprc = round((@imu_itmprc * @imu_selrat),4)
			
			-- Calculate IM Basic Price --
			set @imu_basprc = round((@imu_itmprc + @bomprc),4)
			
			if @imu_fmlopt is NULL
			begin
				set @imu_fmlopt = ''
			end
			
			if @ied_ftycst is NULL
			begin
				set @ied_ftycst = 0
			end
			
			if @ied_ftyprc is NULL
			begin
				set @ied_ftyprc = 0
			end
		
			if (@ied_prdven = '1882')
			begin
				set @imu_status = 'ACT'
				set @imu_ttlcst = 9999
				set @imu_itmprc = 9999
				set @bomprc = 0
				set @bomcst = 0
				set @imu_basprc = 9999
			end
			else
			begin
				if (select count(*) from CUGRPINF (nolock) where cgi_cugrpcde = @sgc_cus1no) > 0
				begin
					--if (select vcr_flg_ext from VNCUGREL (nolock) where vcr_venno = @ied_prdven and vcr_cugrpcde = @sgc_cus1no) = 'Y'
					if (select vcr_flg_ext from VNCUGREL (nolock) where vcr_venno = @ied_prdven and vcr_cugrpcde = @ied_cus1no) = 'Y'
					begin
						set @imu_status = 'ACT'
					end
					else
					begin
						set @imu_status = 'TBC'
					end
				end
				else
				begin
					set @imu_status = 'ACT'
				end
				set @imu_ttlcst = round(@ied_ftyprc+@bomcst,4)
				set @imu_itmprc = round(@imu_itmprc,4)
				set @bomprc = round(@bomprc,4)
				set @bomcst = round(@bomcst,4)
				set @imu_basprc = round(@imu_basprc,4)
			end

			insert into #IMPRCINF_BUFFER
			(	imu_cocde,			imu_itmno,			imu_typ,
				imu_ventyp,			imu_venno,			imu_prdven,
				imu_pckunt,			imu_conftr,			imu_inrqty,
				imu_mtrqty,			imu_cft,			imu_cus1no,
				imu_cus2no,			imu_ftyprctrm,			imu_hkprctrm,
				imu_trantrm,			imu_effdat,			imu_expdat,
				imu_status,			imu_curcde,			imu_ftycst,
				imu_ftycstA,			imu_ftycstB,			imu_ftycstC,
				imu_ftycstD,			imu_ftycstTran,			imu_ftycstPack,
				imu_fml,			imu_fmlA,			imu_fmlB,
				imu_fmlC,			imu_fmlD,			imu_fmlTran,
				imu_fmlPack,			imu_chgfp,			imu_chgfpA,
				imu_chgfpB,			imu_chgfpC,			imu_chgfpD,
				imu_chgfpTran,			imu_chgfpPack,			imu_ftyprc,
				imu_ftyprcA,			imu_ftyprcB,			imu_ftyprcC,
				imu_ftyprcD,			imu_ftyprcTran,			imu_ftyprcPack,
				imu_bomcst,			imu_ttlcst,			imu_hkadjper,
				imu_negcst,			imu_negprc,			imu_fmlopt,
				imu_bcurcde,			imu_itmprc,			imu_bomprc,
				imu_basprc,			imu_period,			imu_cstchgdat,
				imu_sysgen,			imu_estprcflg,			imu_estprcref,
				imu_creusr,			imu_updusr,			imu_credat,
				imu_upddat
			)
			values
			(	'',				@ied_ucpno,			@ied_itmtyp,
				@imu_ventyp,			@ied_venno,			@ied_prdven,
				@ied_untcde,			@ied_conftr,			@ied_inrqty,
				@ied_mtrqty,			round(@ied_cft,4),		@ied_cus1no,
				@ied_cus2no,			@ied_ftyprctrm,			@ied_hkprctrm,
				--@ied_trantrm,			@imu_effdat,			@ied_expdat,
				@ied_trantrm,			@ied_qutdat,			@ied_expdat,
				@imu_status,			@ied_curcde,			round(@ied_ftycst,4),
				0,				0,				0,
				0,				0,				0,
				'',				'',				'',
				'',				'',				'',
				'',				@chgfp,				0,
				0,				0,				0,
				0,				0,				round(@ied_ftyprc,4),
				0,				0,				0,
				0,				0,				0,
				@bomcst,			@imu_ttlcst,			0,
				0,				0,				@imu_fmlopt,
				@imu_bcurcde,			@imu_itmprc,			@bomprc,
				@imu_basprc,			'',				@imu_cstchgdat,
				'N',				@ied_estprcflg,			@ied_estprcref,
				@imu_creusr,			left('E-'+ @creusr,30),		@imu_credat,
				getdate()
			)
		end -- if @ied_itmtyp <> 'BOM'
-- IMPRCINF END -------------------------------------------------------------------
		
-- IMPRCCHG START -----------------------------------------------------------------
		if (select count(*) from #IMPRCINF_BUFFER (nolock) where imu_itmno = @ied_ucpno and imu_typ = @ied_itmtyp and imu_venno = @ied_venno and
			imu_prdven = @ied_prdven and imu_pckunt = @ied_untcde and imu_inrqty = @ied_inrqty and imu_mtrqty = @ied_mtrqty and
			imu_cus1no = @ied_cus1no and imu_cus2no = @ied_cus2no and imu_ftyprctrm = @ied_ftyprctrm and imu_hkprctrm = @ied_hkprctrm) > 0
		begin
			select	@chgreason = ipc_chgreason
			from	IMPRCCHG_tmp
			where	ipc_itmno = @ied_ucpno and
				ipc_venno = @ied_venno and
				ipc_prdven = @ied_prdven and
				ipc_pckunt = @ied_untcde and
				ipc_inrqty = @ied_inrqty and
				ipc_mtrqty = @ied_mtrqty and
				ipc_cus1no = @ied_cus1no and
				ipc_cus2no = @ied_cus2no and
				ipc_ftyprctrm = @ied_ftyprctrm and
				ipc_hkprctrm = @ied_hkprctrm and
				ipc_trantrm = @ied_trantrm and
				ipc_creusr = @creusr

			if @chgreason = null
				set @chgreason = ''
			
			if @ied_itmtyp = 'BOM'
			begin
				insert into IMPRCCHG
				(	imu_cocde,		imu_itmno,		imu_typ,
					imu_ventyp,		imu_venno,		imu_prdven,
					imu_pckunt,		imu_conftr,		imu_inrqty,
					imu_mtrqty,		imu_cft,		imu_cus1no,
					imu_cus2no,		imu_ftyprctrm,		imu_hkprctrm,
					imu_trantrm,		imu_chgdat,		imu_chgreason,
					imu_effdat_before,	imu_expdat_before,	imu_curcde_before,
					imu_ftycst_before,	imu_ftycstA_before,	imu_ftycstB_before,
					imu_ftycstC_before,	imu_ftycstD_before,	imu_ftycstTran_before,
					imu_ftycstPack_before,	imu_fmlA_before,	imu_fmlB_before,
					imu_fmlC_before,	imu_fmlD_before,	imu_fmlTran_before,
					imu_fmlPack_before,	imu_ftyprc_before,	imu_ftyprcA_before,
					imu_ftyprcB_before,	imu_ftyprcC_before,	imu_ftyprcD_before,
					imu_ftyprcTran_before,	imu_ftyprcPack_before,	imu_bomcst_before,
					imu_ttlcst_before,	imu_hkadjper_before,	imu_negcst_before,
					imu_negprc_before,	imu_fmlopt_before,	imu_bcurcde_before,
					imu_itmprc_before,	imu_bomprc_before,	imu_basprc_before,
					imu_period_before,	imu_cstchgdat_before,	imu_effdat_after,
					imu_expdat_after,	imu_curcde_after,	imu_ftycst_after,
					imu_ftycstA_after,	imu_ftycstB_after,	imu_ftycstC_after,
					imu_ftycstD_after,	imu_ftycstTran_after,	imu_ftycstPack_after,
					imu_fmlA_after,		imu_fmlB_after,		imu_fmlC_after,
					imu_fmlD_after,		imu_fmlTran_after,	imu_fmlPack_after,
					imu_ftyprc_after,	imu_ftyprcA_after,	imu_ftyprcB_after,
					imu_ftyprcC_after,	imu_ftyprcD_after,	imu_ftyprcTran_after,
					imu_ftyprcPack_after,	imu_bomcst_after,	imu_ttlcst_after,
					imu_hkadjper_after,	imu_negcst_after,	imu_negprc_after,
					imu_fmlopt_after,	imu_bcurcde_after,	imu_itmprc_after,
					imu_bomprc_after,	imu_basprc_after,	imu_period_after,
					imu_cstchgdat_after,	imu_creusr,		imu_updusr,
					imu_credat,		imu_upddat
				)
				values
				(	'UCPP',			@ied_ucpno,		@ied_itmtyp,
					@ventyp,		@ied_venno,		@ied_prdven,
					@ied_untcde,		@ied_conftr,		@ied_inrqty,
					@ied_mtrqty,		@ied_cft,		@ied_cus1no,
					@ied_cus2no,		@ied_ftyprctrm,		@ied_hkprctrm,
					@ied_trantrm,		getdate(),		@chgreason,
					@imu_effdat_before,	@imu_expdat_before,	@imu_curcde_before,
					@imu_ftycst_before,	@imu_ftycstA_before,	@imu_ftycstB_before,
					@imu_ftycstC_before,	@imu_ftycstD_before,	@imu_ftycstTran_before,
					@imu_ftycstPack_before,	'',			'',
					'',			'',			'',
					'',			@imu_ftyprc_before,	@imu_ftyprcA_before,
					@imu_ftyprcB_before,	@imu_ftyprcC_before,	@imu_ftyprcD_before,
					@imu_ftyprcTran_before,	@imu_ftyprcPack_before,	@imu_bomcst_before,
					@imu_ttlcst_before,	@imu_hkadjper_before,	@imu_negcst_before,
					@imu_negprc_before,	@imu_fmlopt_before,	@imu_bcurcde_before,
					@imu_itmprc_before,	@imu_bomprc_before,	@imu_basprc_before,
					--@imu_period_before,	@imu_cstchgdat_before,	@ied_credat,
					@imu_period_before,	@imu_cstchgdat_before,	@ied_qutdat,
					@ied_expdat,		@ied_curcde,		@ied_ftycst,
					null,			null,			null,
					null,			null,			null,
					'',			'',			'',
					'',			'',			'',
					@ied_ftyprc,		null,			null,
					null,			null,			null,
					0,			0,			0,
					0,			0,			0,
					'B01',			@imu_bcurcde,		0,
					0,			0,			'',
					getdate(),		left('E-'+ @creusr,30),	left('E-'+ @creusr,30),
					getdate(),		getdate()
				)
			end
			else
			begin
				insert into IMPRCCHG
				(	imu_cocde,		imu_itmno,		imu_typ,
					imu_ventyp,		imu_venno,		imu_prdven,
					imu_pckunt,		imu_conftr,		imu_inrqty,
					imu_mtrqty,		imu_cft,		imu_cus1no,
					imu_cus2no,		imu_ftyprctrm,		imu_hkprctrm,
					imu_trantrm,		imu_chgdat,		imu_chgreason,
					imu_effdat_before,	imu_expdat_before,	imu_curcde_before,
					imu_ftycst_before,	imu_ftycstA_before,	imu_ftycstB_before,
					imu_ftycstC_before,	imu_ftycstD_before,	imu_ftycstTran_before,
					imu_ftycstPack_before,	imu_fmlA_before,	imu_fmlB_before,
					imu_fmlC_before,	imu_fmlD_before,	imu_fmlTran_before,
					imu_fmlPack_before,	imu_ftyprc_before,	imu_ftyprcA_before,
					imu_ftyprcB_before,	imu_ftyprcC_before,	imu_ftyprcD_before,
					imu_ftyprcTran_before,	imu_ftyprcPack_before,	imu_bomcst_before,
					imu_ttlcst_before,	imu_hkadjper_before,	imu_negcst_before,
					imu_negprc_before,	imu_fmlopt_before,	imu_bcurcde_before,
					imu_itmprc_before,	imu_bomprc_before,	imu_basprc_before,
					imu_period_before,	imu_cstchgdat_before,	imu_effdat_after,
					imu_expdat_after,	imu_curcde_after,	imu_ftycst_after,
					imu_ftycstA_after,	imu_ftycstB_after,	imu_ftycstC_after,
					imu_ftycstD_after,	imu_ftycstTran_after,	imu_ftycstPack_after,
					imu_fmlA_after,		imu_fmlB_after,		imu_fmlC_after,
					imu_fmlD_after,		imu_fmlTran_after,	imu_fmlPack_after,
					imu_ftyprc_after,	imu_ftyprcA_after,	imu_ftyprcB_after,
					imu_ftyprcC_after,	imu_ftyprcD_after,	imu_ftyprcTran_after,
					imu_ftyprcPack_after,	imu_bomcst_after,	imu_ttlcst_after,
					imu_hkadjper_after,	imu_negcst_after,	imu_negprc_after,
					imu_fmlopt_after,	imu_bcurcde_after,	imu_itmprc_after,
					imu_bomprc_after,	imu_basprc_after,	imu_period_after,
					imu_cstchgdat_after,	imu_creusr,		imu_updusr,
					imu_credat,		imu_upddat
				)
				values
				(	'UCPP',			@ied_ucpno,		@ied_itmtyp,
					@ventyp,		@ied_venno,		@ied_prdven,
					@ied_untcde,		@ied_conftr,		@ied_inrqty,
					@ied_mtrqty,		@ied_cft,		@ied_cus1no,
					@ied_cus2no,		@ied_ftyprctrm,		@ied_hkprctrm,
					@ied_trantrm,			getdate(),		@chgreason,
					@imu_effdat_before,	@imu_expdat_before,	@imu_curcde_before,
					@imu_ftycst_before,	@imu_ftycstA_before,	@imu_ftycstB_before,
					@imu_ftycstC_before,	@imu_ftycstD_before,	@imu_ftycstTran_before,
					@imu_ftycstPack_before,	'',			'',
					'',			'',			'',
					'',			@imu_ftyprc_before,	@imu_ftyprcA_before,
					@imu_ftyprcB_before,	@imu_ftyprcC_before,	@imu_ftyprcD_before,
					@imu_ftyprcTran_before,	@imu_ftyprcPack_before,	@imu_bomcst_before,
					@imu_ttlcst_before,	@imu_hkadjper_before,	@imu_negcst_before,
					@imu_negprc_before,	@imu_fmlopt_before,	@imu_bcurcde_before,
					@imu_itmprc_before,	@imu_bomprc_before,	@imu_basprc_before,
					--@imu_period_before,	@imu_cstchgdat_before,	@ied_credat,
					@imu_period_before,	@imu_cstchgdat_before,	@ied_qutdat,
					@ied_expdat,		@ied_curcde,		@ied_ftycst,
					null,			null,			null,
					null,			null,			null,
					'',			'',			'',
					'',			'',			'',
					@ied_ftyprc,		null,			null,
					null,			null,			null,
					0,			@bomcst,		@imu_ttlcst,
					0,			0,			0,
					@imu_fmlopt,		@imu_bcurcde,		@imu_itmprc,
					@bomprc,		@imu_basprc,		'',
					getdate(),		left('E-'+ @creusr,30),	left('E-'+ @creusr,30),
					getdate(),		getdate()
				)
			end
			
			delete from IMPRCCHG_tmp
			where	ipc_itmno = @ied_ucpno and
				ipc_venno = @ied_venno and
				ipc_prdven = @ied_prdven and
				ipc_pckunt = @ied_untcde and
				ipc_inrqty = @ied_inrqty and
				ipc_mtrqty = @ied_mtrqty and
				ipc_cus1no = @ied_cus1no and
				ipc_cus2no = @ied_cus2no and
				ipc_ftyprctrm = @ied_ftyprctrm and
				ipc_hkprctrm = @ied_hkprctrm and
				ipc_trantrm = @ied_trantrm and
				ipc_creusr = @creusr

		end
-- IMPRCCHG END -------------------------------------------------------------------

-- External IM Enhancement START --------------------------------------------------
		if @ied_itmtyp <> 'BOM' and @ied_cus1no <> '' and (select count(*) from CUBASINF (nolock) where cbi_cusno = @ied_cus1no) = 0
		begin
			-- Determine the remaining customer group who's not in IMITMEXDAT and #IMPRCINF_BUFFER
			DECLARE cur_IMPRCINF_BUFFER CURSOR
			FOR
			select	cgi_cugrpcde
			from	CUGRPINF (nolock)
			where	cgi_flg_ext = 'Y' and
				cgi_cugrpcde not in (select ied_cus1no from IMITMEXDAT (nolock) where ied_ucpno = @ied_ucpno and
							ied_venno = @ied_venno and ied_prdven = @ied_prdven and
							ied_untcde = @ied_untcde and ied_inrqty = @ied_inrqty and 
							ied_mtrqty = @ied_mtrqty and ied_prctrm = @ied_ftyprctrm and
							ied_hkprctrm = @ied_hkprctrm and ied_trantrm = @ied_trantrm and
							ied_stage = 'A' union 
						     select imu_cus1no from #IMPRCINF_BUFFER (nolock) where imu_itmno = @ied_ucpno and
							imu_venno = @ied_venno and imu_prdven = @ied_prdven and 
							imu_pckunt = @ied_untcde and imu_inrqty = @ied_inrqty and 
							imu_mtrqty = @ied_mtrqty and imu_ftyprctrm = @ied_ftyprctrm and 
							imu_hkprctrm = @ied_hkprctrm and imu_trantrm = @ied_trantrm)
			
			OPEN cur_IMPRCINF_BUFFER
			FETCH NEXT FROM cur_IMPRCINF_BUFFER INTO
			@sgc_cus1no

			WHILE @@fetch_status = 0
			BEGIN
				-- IMPCKINF START (AUTO-GEN) --
				if (select count(*) from IMPCKINF (nolock) where ipi_itmno = @ied_ucpno and ipi_pckunt = @ied_untcde and
					ipi_inrqty = @ied_inrqty and ipi_mtrqty = @ied_mtrqty and ipi_cus1no = @sgc_cus1no and ipi_cus2no = @ied_cus2no) = 0
				begin
					-- Insert IMPCKINF
					select	@ipi_pckseq = isnull(max(ipi_pckseq),0) + 1
					from	IMPCKINF (nolock)
					where	ipi_itmno = @ied_ucpno

					insert into IMPCKINF
					(	ipi_cocde,		ipi_itmno,		ipi_pckseq,
						ipi_pckunt,		ipi_mtrqty,		ipi_inrqty,
						ipi_inrhin,			
						ipi_inrwin,				
						ipi_inrdin,
						ipi_inrhcm,			
						ipi_inrwcm,				
						ipi_inrdcm,
						ipi_mtrhin,			
						ipi_mtrwin,				
						ipi_mtrdin,
						ipi_mtrhcm,			
						ipi_mtrwcm,				
						ipi_mtrdcm,
						ipi_cft,		ipi_cbm,		ipi_grswgt,
						ipi_netwgt,		ipi_pckitr,		ipi_qutdat,
						ipi_creusr,		ipi_updusr,		ipi_credat,		
						ipi_upddat,		ipi_conftr,		ipi_cusno,
						ipi_cus1no,		ipi_cus2no
					)
					values 
					(	' ', 			@ied_ucpno,		@ipi_pckseq,
						@ied_untcde,		@ied_mtrqty,		@ied_inrqty,
						(case @ied_pckm when 'INCH' then @ied_inrhin else @ied_inrhin * 0.3937 end),	
						(case @ied_pckm when 'INCH' then @ied_inrwin else @ied_inrwin * 0.3937 end),	
						(case @ied_pckm when 'INCH' then @ied_inrlin else @ied_inrlin * 0.3937 end),	
						(case @ied_pckm when 'INCH' then @ied_inrhin*2.54 else @ied_inrhin end),		
						(case @ied_pckm when 'INCH' then @ied_inrwin*2.54 else @ied_inrwin end),	
						(case @ied_pckm when 'INCH' then @ied_inrlin*2.54 else @ied_inrlin end),		
						(case @ied_pckm when 'INCH' then @ied_mtrhin else @ied_mtrhin * 0.3937 end),	
						(case @ied_pckm when 'INCH' then @ied_mtrwin else @ied_mtrwin * 0.3937 end),	
						(case @ied_pckm when 'INCH' then @ied_mtrlin else @ied_mtrlin * 0.3937 end),	
						(case @ied_pckm when 'INCH' then @ied_mtrhin*2.54 else @ied_mtrhin end),	
						(case @ied_pckm when 'INCH' then @ied_mtrwin*2.54 else @ied_mtrwin end),	
						(case @ied_pckm when 'INCH' then @ied_mtrlin*2.54 else @ied_mtrlin end),			
						round(@ied_cft,4),	isnull(round(@ied_cft*@cbmcft,4),0),	@ied_grswgt,	
						@ied_netwgt,		@ied_pckitr,		@ied_qutdat,
						left('E-'+ @creusr,30),	left('E-'+ @creusr,30),	getdate(),	
						getdate(), 		@ied_conftr,		@sgc_cus1no,
						@sgc_cus1no,		@ied_cus2no
					)

					if @ipi_pckseq = 1 
					begin
						insert into IMVENPCK
						(	ivp_cocde,		ivp_itmno,		ivp_pckseq,
							ivp_venno,		ivp_relatn,		ivp_creusr,
							ivp_updusr,		ivp_credat,		ivp_upddat		)
						values
						(	' ',			@ied_ucpno,		@ipi_pckseq,
							@ied_prdven,		'Yes',			left('E-'+ @creusr,30),		
							left('E-'+ @creusr,30),	getdate(),		getdate()		
						)		
					end
					else -- @ipi_pckseq = 1 , i.e. > 1
					begin
						insert into IMVENPCK
						(	ivp_cocde,		ivp_itmno,		ivp_pckseq,
							ivp_venno,		ivp_relatn,		ivp_creusr,		
							ivp_updusr,		ivp_credat,		ivp_upddat		)
						select  
							' ',			@ied_ucpno,		@ipi_pckseq,
							ivi_venno,		'Yes',			left('E-'+ @creusr,30),	
							left('E-'+ @creusr,30),	getdate(),		getdate()
						from 	IMVENINF
						where 	
							ivi_itmno = @ied_ucpno	
					end -- @ipi_pckseq = 1 
				end
				else
				begin
					-- Update IMPCKINF
					update	IMPCKINF
					set	ipi_inrhin = (case @ied_pckm when 'INCH' then isnull(@ied_inrhin,0) else isnull(@ied_inrhin,0) * 0.3937 end),		
						ipi_inrwin = (case @ied_pckm when 'INCH' then isnull(@ied_inrwin,0) else isnull(@ied_inrwin,0) * 0.3937 end),	
						ipi_inrdin = (case @ied_pckm when 'INCH' then isnull(@ied_inrlin,0) else isnull(@ied_inrlin,0) * 0.3937 end),	
						ipi_inrhcm = (case @ied_pckm when 'INCH' then isnull(@ied_inrhin,0)*2.54 else  isnull(@ied_inrhin,0) end),	
						ipi_inrwcm = (case @ied_pckm when 'INCH' then isnull(@ied_inrwin,0)*2.54 else  isnull(@ied_inrwin,0) end),		
						ipi_inrdcm = (case @ied_pckm when 'INCH' then isnull(@ied_inrlin,0)*2.54 else  isnull(@ied_inrlin,0) end),		
						ipi_mtrhin =  (case @ied_pckm when 'INCH' then isnull(@ied_mtrhin,0) else isnull(@ied_mtrhin,0) * 0.3937 end),	
						ipi_mtrwin = (case @ied_pckm when 'INCH' then isnull(@ied_mtrwin,0) else isnull(@ied_mtrwin,0) * 0.3937 end),		
						ipi_mtrdin = (case @ied_pckm when 'INCH' then isnull(@ied_mtrlin,0) else isnull(@ied_mtrlin,0) * 0.3937 end),	
						ipi_mtrhcm = (case @ied_pckm when 'INCH' then isnull(@ied_mtrhin,0)*2.54 else  isnull(@ied_mtrhin,0) end),		
						ipi_mtrwcm = (case @ied_pckm when 'INCH' then isnull(@ied_mtrwin,0)*2.54 else  isnull(@ied_mtrwin,0) end),			
						ipi_mtrdcm = (case @ied_pckm when 'INCH' then isnull(@ied_mtrlin,0)*2.54 else  isnull(@ied_mtrlin,0) end),	
						ipi_cft = isnull(round(@ied_cft,4),0),			
						ipi_cbm = isnull(round(@ied_cft*@cbmcft,4),0),
						ipi_grswgt = isnull(@ied_grswgt,0),		
						ipi_netwgt = isnull(@ied_netwgt,0),
						ipi_updusr = left('E-'+ @creusr,30),
						ipi_upddat = getdate(),
						ipi_conftr = @ied_conftr,
						ipi_qutdat = @ied_qutdat,
						ipi_cusno = @sgc_cus1no
					where	ipi_itmno = @ied_ucpno and
				     	      	ipi_pckunt = @ied_untcde and 	
						ipi_inrqty = @ied_inrqty and	
			 			ipi_mtrqty = @ied_mtrqty and
						ipi_cus1no = @sgc_cus1no and
						ipi_cus2no = @ied_cus2no
					
					if (select count(*) from IMVENPCK (nolock) where ivp_itmno = @ied_ucpno and ivp_venno = @ied_prdven) = 0 
					begin
						insert into IMVENPCK
						(	ivp_cocde,		ivp_itmno,		ivp_pckseq,
							ivp_venno,		ivp_relatn,		ivp_creusr,
							ivp_updusr,		ivp_credat,		ivp_upddat		)
						values
						(	' ',			@ied_ucpno,		@ipi_pckseq,
							@ied_prdven,		'Yes',			left('E-'+ @creusr,30),	
							left('E-'+ @creusr,30),	getdate(),		getdate()		
						)		
					end 
				end
				-- IMPCKINF END (AUTO-GEN) --

				set @sgc_bomprc = @bomprc
				set @sgc_bomcst = @bomcst
				
				-- Insert or Update IMMOQMOA --
				select	@sgc_moqunttyp = isnull(smm_moqunttyp,''),
					@sgc_moq = isnull(smm_moq,0),
					@sgc_curcde = isnull(smm_curcde,''),
					@sgc_moa = isnull(smm_moa,0)
				from	SYMOQMOA (nolock)
				where	smm_nat = @ied_nat and
					smm_cugrpcde = @sgc_cus1no
	
				if (select count(*) from IMMOQMOA (nolock) where imm_itmno = @ied_ucpno and imm_cus1no = @sgc_cus1no and imm_cus2no = @ied_cus2no) = 0
				begin
					insert into IMMOQMOA
					(	imm_cocde,		imm_itmno,		imm_cus1no,
						imm_cus2no,		imm_tirtyp,		imm_moqunttyp,
						imm_moqctn,		imm_qty,		imm_curcde,
						imm_moa,		imm_creusr,		imm_updusr,
						imm_credat,		imm_upddat
					)
					values
					(	'',			@ied_ucpno,		@sgc_cus1no,
						@ied_cus2no,		'2',			@sgc_moqunttyp,
						@sgc_moq,		0,			@sgc_curcde,
						@sgc_moa,		left('E-'+ @creusr,30),	left('E-'+ @creusr,30),
						getdate(),		getdate()
					)
				end
				else
				begin
					if (select count(*) from IMMOQMOA (nolock) where imm_itmno = @ied_ucpno and imm_cus1no = @sgc_cus1no and
						imm_cus2no = @ied_cus2no and ((imm_moqctn = @sgc_moq and imm_moqunttyp = @sgc_moqunttyp) or
						(imm_curcde = @sgc_curcde and imm_moa = @sgc_moa))) = 0
					begin
						update	IMMOQMOA
						set	imm_tirtyp = '2',
							imm_moqunttyp = @sgc_moqunttyp,
							imm_moqctn = @sgc_moq,
							imm_curcde = @sgc_curcde,
							imm_moa = @sgc_moa,
							imm_updusr = left('E-'+ @creusr,30),
							imm_upddat = getdate()
						where	imm_itmno = @ied_ucpno and
							imm_cus1no = @sgc_cus1no and
							imm_cus2no = @ied_cus2no
					end
				end
				
				-- Determine Current IMPRCINF entry before update --
				select	@imu_effdat_before = imu_effdat,
					@imu_expdat_before = imu_expdat,
					@imu_curcde_before = imu_curcde,
					@imu_ftycst_before = imu_ftycst,
					@imu_ftycstA_before = imu_ftycstA,
					@imu_ftycstB_before = imu_ftycstB,
					@imu_ftycstC_before = imu_ftycstC,
					@imu_ftycstD_before = imu_ftycstD,
					@imu_ftycstTran_before = imu_ftycstTran,
					@imu_ftycstPack_before = imu_ftycstPack,
					@imu_ftyprc_before = imu_ftyprc,
					@imu_ftyprcA_before = imu_ftyprcA,
					@imu_ftyprcB_before = imu_ftyprcB,
					@imu_ftyprcC_before = imu_ftyprcC,
					@imu_ftyprcD_before = imu_ftyprcD,
					@imu_ftyprcTran_before = imu_ftyprcTran,
					@imu_ftyprcPack_before = imu_ftyprcPack,
					@imu_ttlcst_before = imu_ttlcst,
					@imu_bomcst_before = imu_bomcst,
					@imu_hkadjper_before = imu_hkadjper,
					@imu_negcst_before = imu_negcst,
					@imu_negprc_before = imu_negprc,
					@imu_fmlopt_before = imu_fmlopt,
					@imu_bcurcde_before = imu_bcurcde,
					@imu_itmprc_before = imu_itmprc,
					@imu_basprc_before = imu_basprc,
					@imu_period_before = imu_period,
					@imu_cstchgdat_before = imu_cstchgdat,
					@imu_typ = imu_typ,
					@imu_ventyp = imu_ventyp,
					@imu_sysgen = imu_sysgen,
					@imu_effdat = imu_effdat,
					@imu_cstchgdat = imu_cstchgdat,
					@imu_creusr = imu_creusr,
					@imu_credat = imu_credat
				from	IMPRCINF (nolock)
				where	imu_itmno = @ied_ucpno and
					imu_venno = @ied_venno and
					imu_prdven = @ied_prdven and
					imu_pckunt = @ied_untcde and
					imu_inrqty = @ied_inrqty and
					imu_mtrqty = @ied_mtrqty and
					imu_cus1no = @sgc_cus1no and
					imu_cus2no = @ied_cus2no and
					imu_ftyprctrm = @ied_ftyprctrm and
					imu_hkprctrm = @ied_hkprctrm and
					imu_trantrm = @ied_trantrm
				
				-- Determine Converted Factory Price / Factory Cost
				set @sgc_ftyprc = @ied_ftyprc * (select dbo.IMCGCFML_conversion(@ied_prdven, @ied_cus1no, @sgc_cus1no))
				
				-- Calculate Factory Price / Factory Cost Difference --
				if @ied_ftycst = 0
					set @chgfp = 0
				else
					set @chgfp = round(@sgc_ftyprc / @ied_ftycst * 100, 0)
				
				-- Basic price currency for REG, ASS, BOM itemtype
				select	@imu_bcurcde = ysi_cde
				from	SYSETINF (nolock) 
				where 	ysi_typ = '06' and
					ysi_def = 'Y'
				
				if @ied_itmtyp <> 'BOM' and @imu_sysgen = 'Y'
				begin
					-- Calculate BOM Cost and BOM Price --
					select	@imu_selrat = yce_selrat,
						@imu_buyrat = yce_buyrat
					from	SYCUREX (nolock)
					where	yce_frmcur = 'HKD' and
						yce_tocur = (select ysi_cde from SYSETINF (nolock) where ysi_typ = '06' and ysi_def = 'Y') and
						yce_iseff = 'Y'
					
					-- Initialize variables --
					set @sgc_fmlopt = ''
					set @fml = ''
					
					-- Select the appropriate Markup Formula --
					if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
						icf_vencde = 'EXT' and icf_cus1no = @sgc_cus1no and icf_cus2no = @ied_cus2no and
						icf_catlvl4 = @ied_catlvl4 and icf_expdat >= getdate() and icf_def = 'Y') > 0 and
						@sgc_cus1no <> '' and @ied_cus2no <> '' and @ied_catlvl4 <> ''
					begin
						select	@sgc_fmlopt = icf_fml_hk,
							@fml = yfi_fml
						from	IMCALFML (nolock), SYFMLINF (nolock)
						where	icf_caltar = 'IM' and
							icf_caltyp = 'BASIC' and
							icf_vencde = 'EXT' and
							icf_cus1no = @sgc_cus1no and
							icf_cus2no = @ied_cus2no and
							icf_catlvl4 = @ied_catlvl4 and
							icf_expdat >= getdate() and
							icf_def = 'Y' and
							yfi_fmlopt = icf_fml_hk
					end
					else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
						icf_vencde = 'EXT' and icf_cus1no = @sgc_cus1no and icf_cus2no = '' and
						icf_catlvl4 = @ied_catlvl4 and icf_expdat >= getdate() and icf_def = 'Y') > 0 and
						@sgc_cus1no <> '' and @ied_catlvl4 <> ''
					begin
						select	@sgc_fmlopt = icf_fml_hk,
							@fml = yfi_fml
						from	IMCALFML (nolock), SYFMLINF (nolock)
						where	icf_caltar = 'IM' and
							icf_caltyp = 'BASIC' and
							icf_vencde = 'EXT' and
							icf_cus1no = @sgc_cus1no and
							icf_cus2no = '' and
							icf_catlvl4 = @ied_catlvl4 and
							icf_expdat >= getdate() and
							icf_def = 'Y' and
							yfi_fmlopt = icf_fml_hk
					end
					else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
						icf_vencde = 'EXT' and icf_cus1no = '' and icf_cus2no = '' and
						icf_catlvl4 = @ied_catlvl4 and icf_expdat >= getdate() and icf_def = 'Y') > 0 and
						@ied_catlvl4 <> ''
					begin
						select	@sgc_fmlopt = icf_fml_hk,
							@fml = yfi_fml
						from	IMCALFML (nolock), SYFMLINF (nolock)
						where	icf_caltar = 'IM' and
							icf_caltyp = 'BASIC' and
							icf_vencde = 'EXT' and
							icf_cus1no = '' and
							icf_cus2no = '' and
							icf_catlvl4 = @ied_catlvl4 and
							icf_expdat >= getdate() and
							icf_def = 'Y' and
							yfi_fmlopt = icf_fml_hk
					end
					else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
						icf_vencde = 'EXT' and icf_cus1no = @sgc_cus1no and icf_cus2no = @ied_cus2no and
						icf_catlvl4 = '' and icf_expdat >= getdate() and icf_def = 'Y') > 0 and
						@sgc_cus1no <> '' and @ied_cus2no <> ''
					begin
						select	@sgc_fmlopt = icf_fml_hk,
							@fml = yfi_fml
						from	IMCALFML (nolock), SYFMLINF (nolock)
						where	icf_caltar = 'IM' and
							icf_caltyp = 'BASIC' and
							icf_vencde = 'EXT' and
							icf_cus1no = @sgc_cus1no and
							icf_cus2no = @ied_cus2no and
							icf_catlvl4 = '' and
							icf_expdat >= getdate() and
							icf_def = 'Y' and
							yfi_fmlopt = icf_fml_hk
					end
					else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
						icf_vencde = 'EXT' and icf_cus1no = @sgc_cus1no and icf_cus2no = '' and
						icf_catlvl4 = '' and icf_expdat >= getdate() and icf_def = 'Y') > 0 and @sgc_cus1no <> ''
					begin
						select	@sgc_fmlopt = icf_fml_hk,
							@fml = yfi_fml
						from	IMCALFML (nolock), SYFMLINF (nolock)
						where	icf_caltar = 'IM' and
							icf_caltyp = 'BASIC' and
							icf_vencde = 'EXT' and
							icf_cus1no = @sgc_cus1no and
							icf_cus2no = '' and
							icf_catlvl4 = '' and
							icf_expdat >= getdate() and
							icf_def = 'Y' and
							yfi_fmlopt = icf_fml_hk
					end
					else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
						icf_vencde = @ied_prdven and icf_cus1no = '' and icf_cus2no = '' and
						icf_catlvl4 = '' and icf_expdat >= getdate() and icf_def = 'Y') > 0
					begin
						select	@sgc_fmlopt = icf_fml_hk,
							@fml = yfi_fml
						from	IMCALFML (nolock), SYFMLINF (nolock)
						where	icf_caltar = 'IM' and
							icf_caltyp = 'BASIC' and
							icf_vencde = @ied_prdven and
							icf_cus1no = '' and
							icf_cus2no = '' and
							icf_catlvl4 = '' and
							icf_expdat >= getdate() and
							icf_def = 'Y' and
							yfi_fmlopt = icf_fml_hk
					end
					else
					begin
						select	@sgc_fmlopt = icf_fml_hk,
							@fml = yfi_fml
						from	IMCALFML (nolock), SYFMLINF (nolock)
						where	icf_caltar = 'IM' and
							icf_caltyp = 'BASIC' and
							icf_vencde = 'EXT' and
							icf_cus1no = '' and
							icf_cus2no = '' and
							icf_catlvl4 = '' and
							icf_expdat >= getdate() and
							icf_def = 'Y' and
							yfi_fmlopt = icf_fml_hk
					end
		
					if @fml is null or @fml = ''
					begin
						set @fml = '0'
					end
					
					select	@imu_selrat =  isnull(yce_selrat, 0)
					from	SYCUREX (nolock)
					where	yce_frmcur = @ied_curcde and
						yce_tocur = (select ysi_cde from SYSETINF where ysi_typ = '06' and ysi_def = 'Y') and
						yce_iseff = 'Y'

					if @imu_bcurcde is null
					begin
						set @imu_bcurcde = ''
					end
			
					if @imu_selrat is null
					begin
						set @imu_selrat = 0
					end
					
					-- Calculate IM Item Price --
					set @imu_itmprc = @sgc_ftyprc
					set @imu_basprc = 0
					
					set @fml = ltrim(rtrim(@fml))
					set @fml = replace(@fml,' ','')
					if (substring(@fml,1,1) <> '*') and (substring(@fml,1,1) <> '/')
					begin
						set @fml = '*' + @fml
					end
					set @OP = substring(@fml,1,1)
					
					set @temp = substring(@fml, 2, len(@fml)-1)
					
					if @OP = '*'
					begin
						set @imu_itmprc = @imu_itmprc * @temp
					end
					else if @OP = '/'
					begin
						set @imu_itmprc = @imu_itmprc / @temp
					end
		
					set @imu_itmprc = round((@imu_itmprc * @imu_selrat),4)
					
					-- Calculate IM Basic Price --
					set @imu_basprc = round((@imu_itmprc + @sgc_bomprc),4)
					
					if @sgc_fmlopt is NULL
					begin
						set @sgc_fmlopt = ''
					end
					
					if @ied_ftycst is NULL
					begin
						set @ied_ftycst = 0
					end
					
					if @sgc_ftyprc is NULL
					begin
						set @sgc_ftyprc = 0
					end
				
					if (@ied_venno = @ied_prdven and @ied_prdven = '1882')
					begin
						set @imu_status = 'TBC'
						set @imu_ttlcst = 0
						set @imu_itmprc = 0
						set @sgc_bomprc = 0
						set @sgc_bomcst = 0
						set @imu_basprc = 0
					end
					else
					begin
						if (select count(*) from CUGRPINF (nolock) where cgi_cugrpcde = @sgc_cus1no) > 0
						begin
							if (select vcr_flg_ext from VNCUGREL (nolock) where vcr_venno = @ied_prdven and vcr_cugrpcde = @sgc_cus1no) = 'Y'
							begin
								if @ied_cus1no = '1'
								begin
									set @imu_status = 'ACT'
								end
								else
								begin
									set @imu_status = 'INA'
								end
							end
							else
							begin
								set @imu_status = 'TBC'
							end
						end
						else
						begin
							set @imu_status = 'ACT'
						end
						set @imu_ttlcst = round(@sgc_ftyprc+@sgc_bomcst,4)
						set @imu_itmprc = round(@imu_itmprc,4)
						set @sgc_bomprc = round(@sgc_bomprc,4)
						set @sgc_bomcst = round(@sgc_bomcst,4)
						set @imu_basprc = round(@imu_basprc,4)
					end
		
					insert into #IMPRCINF_BUFFER
					(	imu_cocde,			imu_itmno,			imu_typ,
						imu_ventyp,			imu_venno,			imu_prdven,
						imu_pckunt,			imu_conftr,			imu_inrqty,
						imu_mtrqty,			imu_cft,			imu_cus1no,
						imu_cus2no,			imu_ftyprctrm,			imu_hkprctrm,
						imu_trantrm,			imu_effdat,			imu_expdat,
						imu_status,			imu_curcde,			imu_ftycst,
						imu_ftycstA,			imu_ftycstB,			imu_ftycstC,
						imu_ftycstD,			imu_ftycstTran,			imu_ftycstPack,
						imu_fml,			imu_fmlA,			imu_fmlB,
						imu_fmlC,			imu_fmlD,			imu_fmlTran,
						imu_fmlPack,			imu_chgfp,			imu_chgfpA,
						imu_chgfpB,			imu_chgfpC,			imu_chgfpD,
						imu_chgfpTran,			imu_chgfpPack,			imu_ftyprc,
						imu_ftyprcA,			imu_ftyprcB,			imu_ftyprcC,
						imu_ftyprcD,			imu_ftyprcTran,			imu_ftyprcPack,
						imu_bomcst,			imu_ttlcst,			imu_hkadjper,
						imu_negcst,			imu_negprc,			imu_fmlopt,
						imu_bcurcde,			imu_itmprc,			imu_bomprc,
						imu_basprc,			imu_period,			imu_cstchgdat,
						imu_sysgen,			imu_estprcflg,			imu_estprcref,
						imu_creusr,			imu_updusr,			imu_credat,
						imu_upddat
					)
					values
					(	'',				@ied_ucpno,			@ied_itmtyp,
						@imu_ventyp,			@ied_venno,			@ied_prdven,
						@ied_untcde,			@ied_conftr,			@ied_inrqty,
						@ied_mtrqty,			round(@ied_cft,4),		@sgc_cus1no,
						@ied_cus2no,			@ied_ftyprctrm,			@ied_hkprctrm,
						--@ied_trantrm,			@imu_effdat,			@ied_expdat,
						@ied_trantrm,			@ied_qutdat,			@ied_expdat,
						@imu_status,			@ied_curcde,			round(@ied_ftycst,4),
						0,				0,				0,
						0,				0,				0,
						'',				'',				'',
						'',				'',				'',
						'',				@chgfp,				0,
						0,				0,				0,
						0,				0,				round(@sgc_ftyprc,4),
						0,				0,				0,
						0,				0,				0,
						@sgc_bomcst,			@imu_ttlcst,			0,
						0,				0,				@sgc_fmlopt,
						@imu_bcurcde,			@imu_itmprc,			@sgc_bomprc,
						@imu_basprc,			'',				@imu_cstchgdat,
						'Y',				@ied_estprcflg,			@ied_estprcref,
						@imu_creusr,			left('E-'+ @creusr,30),		@imu_credat,
						getdate()
					)
					
					insert into IMPRCCHG
					(	imu_cocde,		imu_itmno,		imu_typ,
						imu_ventyp,		imu_venno,		imu_prdven,
						imu_pckunt,		imu_conftr,		imu_inrqty,
						imu_mtrqty,		imu_cft,		imu_cus1no,
						imu_cus2no,		imu_ftyprctrm,		imu_hkprctrm,
						imu_trantrm,		imu_chgdat,		imu_chgreason,
						imu_effdat_before,	imu_expdat_before,	imu_curcde_before,
						imu_ftycst_before,	imu_ftycstA_before,	imu_ftycstB_before,
						imu_ftycstC_before,	imu_ftycstD_before,	imu_ftycstTran_before,
						imu_ftycstPack_before,	imu_fmlA_before,	imu_fmlB_before,
						imu_fmlC_before,	imu_fmlD_before,	imu_fmlTran_before,
						imu_fmlPack_before,	imu_ftyprc_before,	imu_ftyprcA_before,
						imu_ftyprcB_before,	imu_ftyprcC_before,	imu_ftyprcD_before,
						imu_ftyprcTran_before,	imu_ftyprcPack_before,	imu_bomcst_before,
						imu_ttlcst_before,	imu_hkadjper_before,	imu_negcst_before,
						imu_negprc_before,	imu_fmlopt_before,	imu_bcurcde_before,
						imu_itmprc_before,	imu_bomprc_before,	imu_basprc_before,
						imu_period_before,	imu_cstchgdat_before,	imu_effdat_after,
						imu_expdat_after,	imu_curcde_after,	imu_ftycst_after,
						imu_ftycstA_after,	imu_ftycstB_after,	imu_ftycstC_after,
						imu_ftycstD_after,	imu_ftycstTran_after,	imu_ftycstPack_after,
						imu_fmlA_after,		imu_fmlB_after,		imu_fmlC_after,
						imu_fmlD_after,		imu_fmlTran_after,	imu_fmlPack_after,
						imu_ftyprc_after,	imu_ftyprcA_after,	imu_ftyprcB_after,
						imu_ftyprcC_after,	imu_ftyprcD_after,	imu_ftyprcTran_after,
						imu_ftyprcPack_after,	imu_bomcst_after,	imu_ttlcst_after,
						imu_hkadjper_after,	imu_negcst_after,	imu_negprc_after,
						imu_fmlopt_after,	imu_bcurcde_after,	imu_itmprc_after,
						imu_bomprc_after,	imu_basprc_after,	imu_period_after,
						imu_cstchgdat_after,	imu_creusr,		imu_updusr,
						imu_credat,		imu_upddat
					)
					values
					(	'UCPP',			@ied_ucpno,		@ied_itmtyp,
						@ventyp,		@ied_venno,		@ied_prdven,
						@ied_untcde,		@ied_conftr,		@ied_inrqty,
						@ied_mtrqty,		@ied_cft,		@sgc_cus1no,
						@ied_cus2no,		@ied_ftyprctrm,		@ied_hkprctrm,
						@ied_trantrm,		getdate(),		'Price auto-generated by SYSTEM via Excel Upload',
						@imu_effdat_before,	@imu_expdat_before,	@imu_curcde_before,
						@imu_ftycst_before,	@imu_ftycstA_before,	@imu_ftycstB_before,
						@imu_ftycstC_before,	@imu_ftycstD_before,	@imu_ftycstTran_before,
						@imu_ftycstPack_before,	'',			'',
						'',			'',			'',
						'',			@imu_ftyprc_before,	@imu_ftyprcA_before,
						@imu_ftyprcB_before,	@imu_ftyprcC_before,	@imu_ftyprcD_before,
						@imu_ftyprcTran_before,	@imu_ftyprcPack_before,	@imu_bomcst_before,
						@imu_ttlcst_before,	@imu_hkadjper_before,	@imu_negcst_before,
						@imu_negprc_before,	@imu_fmlopt_before,	@imu_bcurcde_before,
						@imu_itmprc_before,	@imu_bomprc_before,	@imu_basprc_before,
--						@imu_period_before,	@imu_cstchgdat_before,	@ied_credat,
						@imu_period_before,	@imu_cstchgdat_before,	@ied_qutdat,
						@ied_expdat,		@ied_curcde,		@ied_ftycst,
						null,			null,			null,
						null,			null,			null,
						'',			'',			'',
						'',			'',			'',
						@sgc_ftyprc,		null,			null,
						null,			null,			null,
						0,			@sgc_bomcst,		@imu_ttlcst,
						0,			0,			0,
						@sgc_fmlopt,		@imu_bcurcde,		@imu_itmprc,
						@sgc_bomprc,		@imu_basprc,		'',
						getdate(),		left('E-'+ @creusr,30),	left('E-'+ @creusr,30),
						getdate(),		getdate()
					)
				end -- if @ied_itmtyp <> 'BOM' and @imu_sysgen = 'Y'
				
				FETCH NEXT FROM cur_IMPRCINF_BUFFER INTO
				@sgc_cus1no
			END
			CLOSE cur_IMPRCINF_BUFFER
			DEALLOCATE cur_IMPRCINF_BUFFER
		end -- if @ied_itmtyp <> 'BOM' and @ied_cus1no <> '' and (select ...

-- External IM Enhancement END ----------------------------------------------------
		if @ied_untcde <> ''
		begin
			if (select count(*) from IMCOLINF (nolock) where icf_itmno = @ied_ucpno) > 0 and
			   (select count(*) from IMPCKINF (nolock) where ipi_itmno = @ied_ucpno) > 0 and
			   ((select count(*) from IMPRCINF (nolock) where imu_itmno = @ied_ucpno and imu_status = 'ACT') > 0 or
			    (select count(*) from #IMPRCINF_BUFFER (nolock) where imu_itmno = @ied_ucpno and imu_status = 'ACT') > 0)
			begin
				set @ied_itmsts = 'CMP'
			end
			else
			begin
				set @ied_itmsts = 'INC'
			end

			update	IMBASINF 	
			set 	ibi_updusr = left('E-'+ @creusr,30),
				ibi_upddat = getdate(),	
				ibi_itmsts = @ied_itmsts
			where	ibi_itmno = @ied_ucpno and 
				ibi_itmsts <> @ied_itmsts and								
				(select	count(*) 
				 from	IMITMEXDAT (nolock) 
				 where 	ied_ucpno = @ied_ucpno and 
					ied_recseq <> @ied_recseq and
					(ied_stage = 'A' or ied_stage = 'R' or ied_stage = 'W')
				) = 0
		end -- if @ied_untcde <> ''
	end -- if @ied_stage = 'A' and @ied_ucpno <> '' and @ied_mode = 'UPD'

	if (@ied_stage = 'A' and @ied_mode = 'UPD') or @ied_stage = 'O' or @ied_stage = 'R' or @ied_stage =  'I'
	begin

		if (select count(*) from IMCOLINF (nolock) where icf_itmno = @ied_ucpno) > 0 and
		   (select count(*) from IMPCKINF (nolock) where ipi_itmno = @ied_ucpno) > 0 and
		   ((select count(*) from IMPRCINF (nolock) where imu_itmno = @ied_ucpno and imu_status = 'ACT') > 0 or
		    (select count(*) from #IMPRCINF_BUFFER (nolock) where imu_itmno = @ied_ucpno and imu_status = 'ACT') > 0)
		begin
			set @ied_itmsts = 'CMP'
		end
		else
		begin
			set @ied_itmsts = 'INC'
		end

		select	@ied_seqno = (isnull(max(ied_seqno),0) + 1) 
		from	IMITMEXDATH 
		where	ied_venno = @ied_venno and
			ied_prdven = @ied_prdven and
			ied_ucpno = @ied_ucpno and
			ied_xlsfil = @ied_xlsfil and
			ied_cus1no = @ied_cus1no and
			ied_cus2no = @ied_cus2no and
			ied_itmseq = @ied_itmseq and
			ied_recseq = @ied_recseq and
			ied_chkdat = @ied_chkdat
		
		insert into IMITMEXDATH 
		(	
			ied_cocde,		ied_venno,		ied_prdven,	
			ied_cusven,		ied_cus1no,		ied_cus2no,	
			ied_ucpno,		ied_itmseq,		ied_recseq,
			ied_venitm,		ied_ditmno,		ied_mode,
			ied_itmsts,		ied_stage,		ied_itmtyp,
			ied_catlvl4,		ied_lnecde,		ied_engdsc,
			ied_chndsc,		ied_finishing,		ied_matcde,
			ied_nat,		ied_prdtyp,		ied_prdsztyp,
			ied_prdszunt,		ied_prdszval,		ied_vencol,
			ied_vencoldsc,		ied_vencol2,		ied_untcde,
			ied_inrqty,		ied_mtrqty,		ied_cft,
			ied_conftr,		ied_inrlin,		ied_inrwin,
			ied_inrhin,		ied_mtrlin,		ied_mtrwin,
			ied_mtrhin,		ied_grswgt,		ied_netwgt,
			ied_pckitr,		ied_sysmsg,		ied_xlsfil,
			ied_chkdat,		ied_prctrm,		ied_hkprctrm,
			ied_trantrm,		ied_curcde,		ied_ftycst,
			ied_ftyprc,		ied_fcurcde,		ied_basprc,
			ied_moqum,		ied_moq,		ied_moaccy,
			ied_moa,		ied_qutdat,		ied_expdat,
			ied_refresh,		ied_remark,		ied_bomprc,
			ied_bomcst,		ied_fmlopt,		ied_creusr,
			ied_updusr,		ied_credat,		ied_upddat,
			ied_seqno,		ied_prdgrp,		ied_prdicon,
			ied_intrmk,		ied_cstrmk,		ied_estprcflg,
			ied_estprcref
		)
		values
		(	
			@ied_cocde,		@ied_venno,		@ied_prdven,	
			@ied_cusven,		@ied_cus1no,		@ied_cus2no,	
			@ied_ucpno,		@ied_itmseq,		@ied_recseq,
			@ied_venitm,		@ied_ditmno,		@ied_mode,
			@ied_itmsts,		@ied_stage,		@ied_itmtyp,
			@ied_catlvl4,		@ied_lnecde,		@ied_engdsc,
			@ied_chndsc,		@ied_finishing,		@ied_matcde,
			@ied_nat,		@ied_prdtyp,		@ied_prdsztyp,
			@ied_prdszunt,		@ied_prdszval,		@ied_vencol,
			@ied_vencoldsc,		@ied_vencol2,		@ied_untcde,
			@ied_inrqty,		@ied_mtrqty,		@ied_cft,
			@ied_conftr,		@ied_inrlin,		@ied_inrwin,
			@ied_inrhin,		@ied_mtrlin,		@ied_mtrwin,
			@ied_mtrhin,		@ied_grswgt,		@ied_netwgt,
			@ied_pckitr,		@ied_sysmsg,		@ied_xlsfil,
			@ied_chkdat,		@ied_ftyprctrm,		@ied_hkprctrm,
			@ied_trantrm,		@ied_curcde,		@ied_ftycst,
			@ied_ftyprc,		@ied_fcurcde,		@ied_basprc,
			@ied_moqum,		@ied_moq,		@ied_moaccy,
			@ied_moa,		@ied_qutdat, 		@ied_expdat,
			@ied_refresh,		@ied_remark,		@ied_bomprc,
			@ied_bomcst,		@ied_fmlopt,		@ied_creusr,
			@ied_updusr,		@ied_credat,		@ied_upddat,
			@ied_seqno,		@ied_prdgrp,		@ied_prdicon,
			@ied_intrmk,		@ied_cstrmk,		@ied_estprcflg,
			@ied_estprcref
		)
		
	
		delete from IMITMEXDAT 
		where 	ied_venno = @ied_venno and
			ied_prdven = @ied_prdven and
			ied_ucpno = @ied_ucpno and 
			ied_itmseq = @ied_itmseq and
			ied_recseq = @ied_recseq
	
		set @venitm = @ied_venitm
	end -- if (@ied_stage = 'A' and @ied_mode = 'UPD') or @ied_stage = 'O' or ...

FETCH NEXT FROM cur_IMITMEXDAT INTO 
@ied_cocde,		@ied_venno,		@ied_prdven,	
@ied_cusven,		@ied_cus1no,		@ied_cus2no,	
@ied_ucpno,		@ied_itmseq,		@ied_recseq,
@ied_venitm,		@ied_ditmno,		@ied_mode,
@ied_itmsts,		@ied_stage,		@ied_itmtyp,
@ied_catlvl4,		@ied_lnecde,		@ied_engdsc,
@ied_chndsc,		@ied_finishing,		@ied_matcde,
@ied_nat,		@ied_prdtyp ,		@ied_prdsztyp,
@ied_prdszunt,		@ied_prdszval,		@ied_vencol,
@ied_vencoldsc,		@ied_vencol2,		@ied_untcde,
@ied_inrqty,		@ied_mtrqty,		@ied_cft,
@ied_conftr,		@ied_inrlin,		@ied_inrwin,
@ied_inrhin,		@ied_mtrlin,		@ied_mtrwin,
@ied_mtrhin,		@ied_grswgt,		@ied_netwgt,
@ied_pckitr,		@ied_sysmsg,		@ied_xlsfil,
@ied_chkdat,		@ied_ftyprctrm,		@ied_hkprctrm,
@ied_trantrm,		@ied_curcde,		@ied_ftycst,
@ied_ftyprc,		@ied_fcurcde,		@ied_basprc,
@ied_moqum,		@ied_moq,		@ied_moaccy,
@ied_moa,		@ied_qutdat, 		@ied_expdat,
@ied_refresh,		@ied_remark,		@ied_bomprc,
@ied_bomcst,		@ied_fmlopt,		@ied_pckm,
@ied_creusr,		@ied_updusr,		@ied_credat,
@ied_upddat,		@ied_prdgrp,		@ied_prdicon,
@ied_intrmk,		@ied_cstrmk,		@ied_estprcflg,
@ied_estprcref

END
CLOSE cur_IMITMEXDAT
DEALLOCATE cur_IMITMEXDAT

-- Removed under direction of Jennifer Chow 2013-05-08
/*
-- For all System Generated Customer Group 3 IMPRCINF entries, if
-- not FOR HK / FOB HK, then set status to INA
-- Agreed by Mary Wong on 2013-03-11
update	#IMPRCINF_BUFFER
set	imu_status = 'INA'
where	imu_cus1no = '3' and
	imu_ftyprctrm <> 'FOR HK' and
	imu_hkprctrm <> 'FOB HK' and
	imu_sysgen = 'Y'
*/
--

-- Copy buffered IMPRCINF entries from #IMPRCINF_BUFFER to IMPRCINF --
update	a
set	a.imu_cft = b.imu_cft,
	a.imu_curcde = b.imu_curcde,
	a.imu_ftycst = b.imu_ftycst,
	a.imu_chgfp = b.imu_chgfp,
	a.imu_ftyprc = b.imu_ftyprc,
	a.imu_bomcst = b.imu_bomcst,
	a.imu_ttlcst = b.imu_ttlcst,
	a.imu_negprc = b.imu_negprc,
	a.imu_negcst = b.imu_negcst,
	a.imu_fmlopt = b.imu_fmlopt,
	a.imu_bcurcde = b.imu_bcurcde,	
	a.imu_itmprc = b.imu_itmprc,
	a.imu_bomprc = b.imu_bomprc,
	a.imu_basprc = b.imu_basprc,
	a.imu_sysgen = b.imu_sysgen,
	a.imu_estprcflg = b.imu_estprcflg,
	a.imu_estprcref = b.imu_estprcref,
	a.imu_updusr = b.imu_updusr,
	a.imu_upddat = b.imu_upddat,
	a.imu_status = b.imu_status,
	a.imu_period = b.imu_period,
	a.imu_expdat = b.imu_expdat
from	IMPRCINF a, #IMPRCINF_BUFFER b
where	a.imu_itmno = b.imu_itmno and
	a.imu_venno = b.imu_venno and
	a.imu_prdven = b.imu_prdven and
	a.imu_cus1no = b.imu_cus1no and
	a.imu_cus2no = b.imu_cus2no and
	a.imu_pckunt = b.imu_pckunt and
	a.imu_inrqty = b.imu_inrqty and
	a.imu_mtrqty = b.imu_mtrqty and
	a.imu_ftyprctrm = b.imu_ftyprctrm and
	a.imu_hkprctrm = b.imu_hkprctrm and
	a.imu_trantrm = b.imu_trantrm


DROP TABLE #IMPRCINF_BUFFER

set nocount off



























GO
GRANT EXECUTE ON [dbo].[sp_update_IMUPDEXDAT] TO [ERPUSER] AS [dbo]
GO
