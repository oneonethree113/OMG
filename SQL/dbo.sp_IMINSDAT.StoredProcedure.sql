/****** Object:  StoredProcedure [dbo].[sp_IMINSDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_IMINSDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_IMINSDAT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







































/*
=========================================================
Program ID	: 	sp_IMINSDAT
Description   	: 	Insert Item Master Entry (Batch Job)
Programmer  	: 	David Yue
=========================================================
 Modification History                                   
=========================================================
2012-07-30	David Yue	Added feature - adding any REG with BOM will remove
				any existing BOM affiliations of that item
2012-08-20	David Yue	Added feature - Price Change Table\
2012-09-14	David Yue	Added Packing Inner Size, Master Size, Material
2012-09-14	David Yue	Added item Factory Temp Flag, Alias Temp Item
2013-06-05	David Yue	Phase 2 Implementation
2013-12-12	David Yue	Add SAP UM
2014-01-17	David Yue	New Packing Structure
=========================================================     
*/

CREATE           PROCEDURE [dbo].[sp_IMINSDAT] 

AS

set nocount on

DECLARE		-- TEMP
@cbmcft		numeric(12,4),	@venitm		nvarchar(20),	@itmno 		nvarchar(20),
@defven		nvarchar(6),	@ventyp		nvarchar(1),	@ibi_typ 	nvarchar(4),
@ibi_cosmth	nvarchar(50),	@ibi_rmk	nvarchar(2000),	@imd_rmk	nvarchar(200),
@ipi_pckseq	int,		@imu_ftyprc	numeric(21,8),	@imu_curcde	nvarchar(6),
@imu_bcurcde	nvarchar(6),	@imu_ftycst	numeric(13,4),	@bomcst		numeric(21,11),
@bomprc		numeric(21,11),	@imu_selrat	numeric(16,11),	@imu_fmlopt	nvarchar(5),
@fml		nvarchar(300),	@i		int,		@OP		nvarchar(1),
@end		int,		@imu_bomprc	numeric(13,4),	@imu_itmprc	numeric(13,4),
@imu_basprc	numeric(21,11),	@imu_bomcst	numeric(13,4),	@temp 		numeric(13,4),
@updsts		nvarchar(1),	@colseq		int,		@imu_period	nvarchar(10),
@imu_expdat	datetime,	@chgreason	nvarchar(800)



DECLARE		-- IMITMDAT
@iid_cocde 	nvarchar(6),	@iid_venno 	nvarchar(6),	@iid_venitm 	nvarchar(20),
@iid_itmseq 	int,		@iid_recseq 	int,		@iid_mode 	nvarchar(3),
@iid_itmsts 	nvarchar(3),	@iid_stage 	nvarchar(3),	@iid_engdsc 	nvarchar(800),
@iid_chndsc 	nvarchar(1600),	@iid_lnecde 	nvarchar(10),	@iid_catlvl4	nvarchar(20),
@iid_untcde 	nvarchar(6),	@iid_inrqty 	int,		@iid_mtrqty 	int,
@iid_inrlcm 	numeric(11,4),	@iid_inrwcm 	numeric(11,4),	@iid_inrhcm 	numeric(11,4),
@iid_mtrlcm 	numeric(11,4),	@iid_mtrwcm 	numeric(11,4),	@iid_mtrhcm 	numeric(11,4),
@iid_cft 	numeric(11,4),	@iid_conftr 	int,		@iid_curcde 	nvarchar(6),
@iid_ftycst 	numeric(13,4),	@iid_ftyprc 	numeric(13,4),	@iid_ftyprctrm 	nvarchar(10),
@iid_prctrm	nvarchar(10),	@iid_trantrm	nvarchar(10),
@iid_grswgt 	numeric(6,3),	@iid_netwgt 	numeric(6,3),	@iid_pckitr 	nvarchar(300),
@iid_engdsc_bef nvarchar(800),		@iid_chndsc_bef 	nvarchar(1600),	
@iid_lnecde_bef nvarchar(10),		@iid_catlvl4_bef 	nvarchar(20),	
@iid_inrlcm_bef numeric(11,4),		@iid_inrwcm_bef 	numeric(11,4),
@iid_inrhcm_bef numeric(11,4),		@iid_mtrlcm_bef 	numeric(11,4),	
@iid_mtrwcm_bef numeric(11,4),		@iid_mtrhcm_bef 	numeric(11,4),
@iid_cft_bef 	numeric(11,4),		@iid_conftr_bef 	int,
@iid_curcde_bef nvarchar(6),		@iid_ftycst_bef		numeric(13,4),	
@iid_ftyprc_bef numeric(13,4),
@iid_grswgt_bef numeric(6,3),		@iid_netwgt_bef 	numeric(6,3),
@iid_pckitr_bef nvarchar(300),		@iid_creusr 		nvarchar(30),		
@iid_updusr 	nvarchar(30),		@iid_credat 		datetime,		
@iid_upddat 	datetime,		@iid_itmno		nvarchar(20),		
@iid_sysmsg	nvarchar(300),		@iid_xlsfil 		nvarchar(30),		
@iid_veneml	nvarchar(50),		@iid_malsts		nvarchar(1),
@iid_chkdat	datetime,		@iid_prdven		nvarchar(6),
@iid_bomflg 	char(1),		@iid_orgdsgvenno 	varchar(6),	
@iid_moq 	int,			@iid_fcurcde		varchar(6),
@iid_wastage	numeric(5,2),		@iid_wastage_bef	numeric(5,2),
@iid_remark	nvarchar(2000),		@iid_remark_bef		nvarchar(2000),
@iid_itmtyp 	nvarchar(4),		@iid_cusven		varchar(6),
@iid_alsitmno	nvarchar(20),		@iid_alsitmno_bef	nvarchar(20),
@iid_alscolcde	nvarchar(30),		@iid_alscolcde_bef	nvarchar(30),
@iid_basprc	numeric(13,4),		@iid_basprc_bef 	numeric(13,4),
@iid_bomprc	numeric(13,4),		@iid_bomprc_bef 	numeric(13,4),
@iid_curr_bef	varchar(6),
@iid_assconftr_bef	int,		@iid_assconftr		int,
@iid_period		datetime,		
@iid_period_bef		datetime,
@iid_cstexpdat		datetime,
@iid_cstexpdat_bef	datetime,
@iid_cus1no 		nvarchar(10),
-- David Yue	2012-09-14	Packing Inner Size, Master Size, Material
@iid_inrsze	nvarchar(500),	@iid_mtrsze	nvarchar(500),	@iid_mat	nvarchar(500),
@iid_inrsze_bef	nvarchar(500),	@iid_mtrsze_bef	nvarchar(500),	@iid_mat_bef	nvarchar(500),
-- David Yue	2012-09-14	Item Factory Temp Flag, Alias Temp Item
@iid_ftytmp	nvarchar(1),	@iid_alstmpitmno	nvarchar(20),
@iid_ftytmp_bef	nvarchar(1),	@iid_alstmpitmno_bef nvarchar(20),
-- David Yue	2013-12-12	Add SAP UM
@iid_sapum	nvarchar(6)

DECLARE 	-- SYCATREL
@ycr_catlvl0	nvarchar(20),
@ycr_catlvl1	nvarchar(20),
@ycr_catlvl2	nvarchar(20),
@ycr_catlvl3	nvarchar(20)

DECLARE 	--IMBOMDAT
@ibd_cocde	nvarchar(6),	@ibd_venitm	nvarchar(20),	@ibd_acsno	nvarchar(20),
@ibd_colcde	nvarchar(200),	@ibd_qty	int,		@ibd_xlsfil 	nvarchar(30),	
@ibd_chkdat	datetime,	@ibd_untcde	nvarchar(6),	@ibd_conftr	int,
@ibd_recseq	int,		@ibd_stage	nvarchar(3),	@ibd_sysmsg	nvarchar(300),	
@ibd_veneml	nvarchar(50),	@ibd_malsts	nvarchar(1),	@ibd_venno	nvarchar(6),	
@ibd_credat	datetime,	@ibd_prdven	nvarchar(6),	@ibd_seqno	int,
@ibd_period	datetime

DECLARE 	-- IMITMDATCST
@iic_venno	nvarchar(6),	@iic_prdven	nvarchar(6),	@iic_venitm	nvarchar(20),
@iic_itmseq	int,		@iic_recseq	int,		@iic_untcde	nvarchar(6),
@iic_cus1no	nvarchar(6),	@iic_cus2no	nvarchar(6),
@iic_fcA	numeric(13,4),	@iic_fcB	numeric(13,4),	@iic_fcC	numeric(13,4),
@iic_fcD	numeric(13,4),	@iic_fcTran	numeric(13,4),	@iic_fcPack	numeric(13,4),
@iic_ftycst	numeric(13,4),	@iic_icA	numeric(13,4),	@iic_icB	numeric(13,4),
@iic_icC 	numeric(13,4),	@iic_icD 	numeric(13,4),	@iic_icTran 	numeric(13,4),
@iic_icPack 	numeric(13,4),	@iic_ftyprc 	numeric(13,4),	@iic_nat 	nvarchar(6),
@iic_negprc	numeric(13,4), 	@iic_mtrqty	int,		@iic_inrqty	int,
@iic_seqno	int,		@iic_stage	nvarchar(1),	@iic_xlsfil 	nvarchar(50),
@iic_chkdat	datetime,	@iic_credat	datetime,	@iic_conftr	int

DECLARE		--IMCOLDAT
@icd_cocde	nvarchar(6),	@icd_venitm	nvarchar(20),	@icd_colcde	nvarchar(30),
@icd_coldsc	nvarchar(200),	@icd_xlsfil	nvarchar(30),	@icd_chkdat	datetime,
@icd_recseq	int,		@icd_sysmsg	nvarchar(300),	@icd_veneml	nvarchar(50),
@icd_malsts	nvarchar(1),	@icd_stage	nvarchar(3),	@icd_venno	nvarchar(6),
@icd_credat	datetime,	@icd_prdven	nvarchar(6)

DECLARE		--IMASSDAT
@iad_cocde	nvarchar(6),	@iad_venitm	nvarchar(20),	@iad_acsno	nvarchar(20),
@iad_colcde	nvarchar(200),	@iad_inrqty	int,		@iad_mtrqty	int,
@iad_xlsfil 	nvarchar(30),	@iad_chkdat	datetime,	@iad_untcde	nvarchar(6),	
@iad_conftr	int,		@iad_recseq	int,		@iad_stage	nvarchar(3),	
@iad_sysmsg	nvarchar(300),	@iad_veneml	nvarchar(50),	@iad_malsts	nvarchar(1),	
@iad_venno	nvarchar(6),	@iad_credat	datetime,	@iad_prdven	nvarchar(6),
@iad_period	datetime

DECLARE	-- IMPRCINF
@imu_chgfp	numeric(13,2),	@imu_chgfpA	numeric(13,2),	@imu_chgfpB	numeric(13,2),
@imu_chgfpC	numeric(13,2),	@imu_chgfpD	numeric(13,2),	@imu_chgfpTran	numeric(13,2),
@imu_chgfpPack	numeric(13,2)

DECLARE cur_IMITMDAT CURSOR
FOR 	select	iid_cocde,		iid_venno,		iid_venitm,
		iid_itmseq,		iid_recseq,		iid_mode,
		iid_itmsts,		iid_stage,		iid_engdsc,
		iid_chndsc,		iid_lnecde,		iid_catlvl4,
		iid_untcde,		iid_inrqty,		iid_mtrqty,
		iid_inrlcm,		iid_inrwcm,		iid_inrhcm,
		iid_mtrlcm,		iid_mtrwcm,		iid_mtrhcm,
		iid_cft,		iid_conftr,		iid_curcde,
		iid_ftycst,		iid_ftyprc,		iid_ftyprctrm,
		iid_prctrm,		iid_trantrm,
		iid_grswgt,		iid_netwgt,		iid_pckitr,
		iid_engdsc_bef,		iid_chndsc_bef,		iid_lnecde_bef,
		iid_catlvl4_bef,	iid_inrlcm_bef,		iid_inrwcm_bef,
		iid_inrhcm_bef,		iid_mtrlcm_bef,		iid_mtrwcm_bef,
		iid_mtrhcm_bef,		iid_cft_bef,		iid_conftr_bef,
		iid_curcde_bef,		iid_ftycst_bef,		iid_ftyprc_bef,
		iid_grswgt_bef,		iid_netwgt_bef,
		iid_pckitr_bef,		iid_creusr,		iid_updusr,
		iid_credat,		iid_upddat,		iid_itmno,
		iid_sysmsg,		iid_xlsfil,		iid_chkdat,
		iid_veneml,		iid_malsts,		iid_prdven,
		iid_bomflg,		iid_orgdsgvenno,	iid_moq,
		iid_fcurcde,		iid_wastage,		iid_wastage_bef,
		iid_remark,		iid_remark_bef,		iid_cusven,
		iid_itmtyp,		iid_alsitmno,		iid_alsitmno_bef,
		iid_alscolcde,		iid_alscolcde_bef,	iid_basprc,
		iid_basprc_bef,		iid_bomprc,		iid_bomprc_bef, 
		iid_curr_bef,		iid_assconftr_bef,	iid_assconftr,
		iid_period,		iid_period_bef,		iid_cstexpdat,
		iid_cstexpdat_bef,	iid_cus1no,
		-- David Yue	2012-09-14	Add Packing Inner Size, Master Size, Material
		iid_inrsze,		iid_mtrsze,		iid_mat,
		iid_inrsze_bef,		iid_mtrsze_bef,		iid_mat_bef,
		-- David Yue	2012-09-14	Add Item Factory Temp Flag, Alias Item Temp Flag
		iid_ftytmp,		iid_ftytmp_bef,
		iid_alstmpitmno,	iid_alstmpitmno_bef,	iid_sapum
	from	IMITMDAT (nolock)
	where 	iid_stage = 'A' and 
		iid_mode = 'NEW'
	order by iid_itmtyp desc, iid_venitm, iid_chkdat

OPEN cur_IMITMDAT
FETCH NEXT from cur_IMITMDAT INTO 
@iid_cocde,		@iid_venno ,		@iid_venitm ,
@iid_itmseq,		@iid_recseq ,		@iid_mode ,
@iid_itmsts,		@iid_stage ,		@iid_engdsc ,
@iid_chndsc,		@iid_lnecde ,		@iid_catlvl4 ,
@iid_untcde,		@iid_inrqty ,		@iid_mtrqty ,
@iid_inrlcm,		@iid_inrwcm ,		@iid_inrhcm ,
@iid_mtrlcm,		@iid_mtrwcm ,		@iid_mtrhcm ,
@iid_cft,		@iid_conftr ,		@iid_curcde ,
@iid_ftycst,		@iid_ftyprc ,		@iid_ftyprctrm ,
@iid_prctrm,		@iid_trantrm ,
@iid_grswgt,		@iid_netwgt ,		@iid_pckitr ,
@iid_engdsc_bef,	@iid_chndsc_bef ,	@iid_lnecde_bef ,
@iid_catlvl4_bef,	@iid_inrlcm_bef ,	@iid_inrwcm_bef ,
@iid_inrhcm_bef,	@iid_mtrlcm_bef ,	@iid_mtrwcm_bef ,
@iid_mtrhcm_bef,	@iid_cft_bef ,		@iid_conftr_bef ,
@iid_curcde_bef,	@iid_ftycst_bef ,	@iid_ftyprc_bef ,
@iid_grswgt_bef ,	@iid_netwgt_bef ,
@iid_pckitr_bef,	@iid_creusr ,		@iid_updusr ,
@iid_credat,		@iid_upddat ,		@iid_itmno,
@iid_sysmsg,		@iid_xlsfil,		@iid_chkdat,
@iid_veneml,		@iid_malsts,		@iid_prdven,
@iid_bomflg,		@iid_orgdsgvenno ,	@iid_moq ,
@iid_fcurcde,		@iid_wastage,		@iid_wastage_bef,
@iid_remark,		@iid_remark_bef,	@iid_cusven,
@iid_itmtyp,		@iid_alsitmno,		@iid_alsitmno_bef,
@iid_alscolcde,		@iid_alscolcde_bef,	@iid_basprc,
@iid_basprc_bef,	@iid_bomprc,		@iid_bomprc_bef,
@iid_curr_bef,		@iid_assconftr_bef,	@iid_assconftr,
@iid_period,		@iid_period_bef,	@iid_cstexpdat,
@iid_cstexpdat_bef,	@iid_cus1no,
-- David Yue	2012-09-14	Add Packing Inner Size, Master Size, Material
@iid_inrsze,		@iid_mtrsze,		@iid_mat,
@iid_inrsze_bef,	@iid_mtrsze_bef,	@iid_mat_bef,
-- David Yue	2012-09-14	Add Item Factory Temp Flag, Alias Item Temp Flag
@iid_ftytmp,		@iid_ftytmp_bef,
@iid_alstmpitmno,	@iid_alstmpitmno_bef,	@iid_sapum

set @imu_period = Right('0000' + CAST(DATEPART(YYYY,@iid_period) AS nvarchar),4) +
			'-'+Right('0' + CAST(DATEPART(MM,@iid_period) AS nvarchar), 2)

set @venitm = ''
select	@cbmcft = isnull(ycf_value,0)
from	SYCONFTR (nolock)
where	ycf_code1 = 'CBM' and
	ycf_code2 = 'CFT'

WHILE @@fetch_status = 0
BEGIN
	set @itmno = ''
	set @defven = ''
	set @ventyp = ''
	
	select	@itmno = ibi_itmno,
		@defven = ibi_venno
	from	IMBASINF (nolock)
	where	ibi_itmno = @iid_venitm

	if @itmno is not NULL and @itmno <> ''
	begin
		if @defven is not NULL and @defven <> ''
		begin
			if @defven <> @iid_prdven
			begin
				set @ventyp = 'P'
			end
			else
			begin
				set @ventyp = 'D'
			end
		end
		else
		begin
			set @ventyp = 'D'
		end
	end
	else
	begin
		set @ventyp = 'D'
	end

	if @itmno is NULL or @itmno = ''
	begin
		set @itmno = @iid_venitm
	end

	-- Retrieve Data from IMITMDATCST

	select top 1
		@iic_cus1no = isnull(iic_cus1no,''),
		@iic_cus2no = isnull(iic_cus2no,''),				
		@iic_fcA = iic_fcA,
		@iic_fcB = iic_fcB,
		@iic_fcC = iic_fcC,		
		@iic_fcD = iic_fcD,
		@iic_fcTran = iic_fcTran,
		@iic_fcPack = iic_fcPack,	
		@iic_ftycst = iic_ftycst,
		@iic_icA = iic_icA,
		@iic_icB = iic_icB,		
		@iic_icC = iic_icC,
		@iic_icD = iic_icD,
		@iic_icTran = iic_icTran,		
		@iic_icPack = iic_icPack,
		@iic_ftyprc = iic_ftyprc,	
		@iic_negprc = round(isnull(iic_negprc,0),4)
	from 	IMITMDATCST (nolock)
	where	iic_venno = @iid_venno and  
		iic_prdven = @iid_prdven and  
           	iic_venitm = @iid_venitm and 
		iic_untcde = @iid_untcde and  
		iic_inrqty = @iid_inrqty and 
		iic_mtrqty = @iid_mtrqty and
		iic_itmseq = @iid_itmseq and
		iic_recseq = @iid_recseq and 
		iic_xlsfil = @iid_xlsfil and
		iic_chkdat = @iid_chkdat-- and
		--iic_stage = 'W' and
		--iic_conftr = @iid_assconftr
	ORDER BY iic_credat desc

-- IMBASINF START ---------------------------------------------------
	if @venitm <> @iid_venitm
	begin
		if (select count(*) from IMASSDAT (nolock) where iad_venitm = @iid_venitm and iad_prdven = @iid_prdven and
			iad_venno = @iid_venno and  iad_xlsfil = @iid_xlsfil and iad_chkdat = @iid_chkdat) > 0 
		begin
			set @ibi_typ = 'ASS'
			
			if @ventyp = 'D'
			begin
				delete IMPCKINF where ipi_itmno = @itmno 
				delete IMVENPCK where ivp_itmno = @itmno 
				delete IMPRCINF where imu_itmno = @itmno
			end
		end
		else
		begin
			if @iid_bomflg = 'Y' 
			    set @ibi_typ = 'BOM'
			else
			    set @ibi_typ = 'REG'	
		end
			
		set @ibi_cosmth = (select distinct imd_cosmth from IMITMDAT (nolock), IMCOMDAT (nolock)
					where iid_venitm = @iid_venitm and iid_venitm = imd_venitm and
					iid_xlsfil = imd_xlsfil and iid_chkdat = imd_chkdat and
					iid_venno = imd_venno and iid_prdven = imd_prdven)
			
		if @ibi_cosmth is NULL	
		begin
			set @ibi_cosmth = ''
		end	
			
		set @ibi_rmk = ''

		--IMMATBKD - START-------------------------
		DECLARE cur_IMCOMDAT CURSOR
		FOR 	select 	imd_rmk
			from 	IMCOMDAT (nolock)
			where 	imd_stage = 'W' and
				imd_venitm = @iid_venitm and
				imd_xlsfil = @iid_xlsfil and
				imd_chkdat = @iid_chkdat and
				imd_venno = @iid_venno and
				imd_prdven = @iid_prdven

		OPEN cur_IMCOMDAT
		FETCH NEXT from cur_IMCOMDAT INTO 
		@imd_rmk
		
		WHILE @@fetch_status = 0
		BEGIN
			if @imd_rmk is not NULL and @imd_rmk <> '' 
			begin
				set @ibi_rmk = @ibi_rmk + @imd_rmk + char(13) + char(10)
			end

		FETCH NEXT from cur_IMCOMDAT INTO 
		@imd_rmk			
		END -- FETCH cur_IMCOMDAT
		CLOSE cur_IMCOMDAT
		DEALLOCATE cur_IMCOMDAT

		set @ibi_rmk = left(@ibi_rmk,2000)		
			
		if (select count(*) from IMBASINF (nolock) where ibi_itmno = @itmno) = 0 
		begin
			set @ycr_catlvl0 = ''
			set @ycr_catlvl1 = ''
			set @ycr_catlvl2 = ''
			set @ycr_catlvl3 = ''
			select	@ycr_catlvl0 = ycr_catlvl0, 
				@ycr_catlvl1 = ycr_catlvl1, 
				@ycr_catlvl2 = ycr_catlvl2, 
				@ycr_catlvl3 = ycr_catlvl3
			from	SYCATREL
			where	ycr_catlvl4 =  @iid_catlvl4
				
			if @iid_moq <> 0 
			begin 
				insert into IMBASINF
				(	ibi_cocde,	ibi_itmno,	ibi_lnecde,	
					ibi_curcde,	ibi_catlvl4,	ibi_itmsts,	
					ibi_typ,	ibi_engdsc,	ibi_chndsc,	
					ibi_venno,	ibi_cusven,	ibi_cosmth,
					ibi_creusr,	ibi_updusr,	ibi_credat,
					ibi_upddat,	ibi_tirtyp,	ibi_orgitm,
					ibi_catlvl0,	ibi_catlvl1,	ibi_catlvl2,
					ibi_catlvl3,	ibi_imgpth,	ibi_hamusa,
					ibi_hameur,	ibi_dtyusa,	ibi_dtyeur,
					ibi_rmk,	ibi_moqctn,	ibi_qty,
					ibi_moa,	ibi_wastage,	ibi_prvsts,
					ibi_orgdvenno,
					ibi_alsitmno,	ibi_alscolcde,
					ibi_tradeven,	ibi_examven,
					-- David Yue	2012-09-14	Add Factory Temp Flag
					ibi_ftytmp
				)
				values
				(	' ',		@itmno,		@iid_lnecde,
					@iid_curcde,	@iid_catlvl4,	'INC',
					@ibi_typ,	@iid_engdsc,	@iid_chndsc,
					@iid_venno,	@iid_cusven,	@ibi_cosmth,
					'EXCEL',	'EXCEL',	getdate(),
					getdate(),	'2',		'',
					@ycr_catlvl0,	@ycr_catlvl1,	@ycr_catlvl2,
					@ycr_catlvl3,	'',		'',
					'',		0,		0,
					@iid_remark,	@iid_moq,	0,
					0,		@iid_wastage,	'INC',
					@iid_orgdsgvenno,
					@iid_alsitmno,	@iid_alscolcde,
					@iid_venno,	@iid_venno,
					-- David Yue	2012-09-14	Add Factory Temp Flag
					isnull(@iid_ftytmp,'N')
				)
			end
			else -- @iid_moq = 0
			begin
				insert into IMBASINF
				(	ibi_cocde ,	ibi_itmno ,	ibi_lnecde ,	
					ibi_curcde ,	ibi_catlvl4 ,	ibi_itmsts ,	
					ibi_typ ,	ibi_engdsc ,	ibi_chndsc ,	
					ibi_venno ,	ibi_cusven,	ibi_cosmth ,
					ibi_creusr ,	ibi_updusr ,	ibi_credat ,
					ibi_upddat,	ibi_tirtyp,	ibi_orgitm,
					ibi_catlvl0,	ibi_catlvl1,	ibi_catlvl2,
					ibi_catlvl3,	ibi_imgpth,	ibi_hamusa,
					ibi_hameur,	ibi_dtyusa,	ibi_dtyeur,
					ibi_rmk,	ibi_moqctn,	ibi_qty,
					ibi_moa,	ibi_wastage,	ibi_prvsts,
					ibi_orgdvenno,
					ibi_alsitmno,	ibi_alscolcde,
					ibi_tradeven,	ibi_examven,
					-- David Yue	2012-09-14	Add Factory Temp Flag
					ibi_ftytmp
				)
				values
				(	' ',		@itmno,		@iid_lnecde,
					@iid_curcde,	@iid_catlvl4,	'INC',
					@ibi_typ,	@iid_engdsc,	@iid_chndsc,
					@iid_venno,	@iid_cusven,	@ibi_cosmth,
					'EXCEL',	'EXCEL',	getdate(),
					getdate(),	'1',		'',
					@ycr_catlvl0,	@ycr_catlvl1,	@ycr_catlvl2,
					@ycr_catlvl3,	'',		'',
					'',		0,		0,	
					@iid_remark,	0,		0,
					0,		@iid_wastage,	'INC',
					@iid_orgdsgvenno,
					@iid_alsitmno,	@iid_alscolcde,
					@iid_venno,	@iid_venno,
					-- David Yue	2012-09-14	Add Item Factory Temp Flag
					isnull(@iid_ftytmp,'N')
				)
			end
		end -- if (select count(*) from IMBASINF where ibi_itmno = @itmno) = 0
		else
		begin
			if (select count(*) from IMCOLINF (nolock) where icf_itmno = @iid_itmno) > 0 and
			   (select count(*) from IMPCKINF (nolock) where ipi_itmno = @iid_itmno) > 0 and
			   (select count(*) from IMPRCINF (nolock) where imu_itmno = @iid_itmno and imu_status = 'ACT') > 0
			begin
				set @iid_itmsts = 'CMP'
			end
			else
			begin
				set @iid_itmsts = 'INC'
			end
				
			if @ventyp = 'D'
			begin
				update	IMBASINF 	
				set	ibi_cosmth = @ibi_cosmth,	
					ibi_updusr = 'EXCEL' ,
					ibi_upddat = getdate(),	
					ibi_itmsts = (case (select count(*) from IMITMDAT (nolock) where iid_venitm = @iid_venitm and
							iid_recseq <> @iid_recseq and (iid_stage = 'A' or iid_stage = 'R' or
							iid_stage = 'W')) when 0 then @iid_itmsts else ibi_itmsts end),
					ibi_prvsts = (case (select count(*) from IMITMDAT (nolock) where iid_venitm = @iid_venitm and
							iid_recseq <> @iid_recseq and (iid_stage = 'A' or iid_stage = 'R' or
							iid_stage = 'W')) when 0 then @iid_itmsts else ibi_prvsts end),
					ibi_engdsc = @iid_engdsc,
					ibi_chndsc = @iid_chndsc,
					ibi_rmk = left(@iid_remark,2000),
					-- David Yue	2012-09-14	Add Item Factory Temp Flag
					ibi_ftytmp = isnull(@iid_ftytmp,'N')
				where	ibi_itmno = @itmno and 
					ibi_itmsts = 'HLD' 
			end
			else
			begin
				update	IMBASINF 	
				set 	ibi_updusr = 'EXCEL' ,
					ibi_upddat = getdate(),	
					ibi_itmsts = (case (select count(*) from IMITMDAT (nolock) where iid_venitm = @iid_venitm and
							iid_recseq <> @iid_recseq and (iid_stage = 'A' or iid_stage = 'R' or
							iid_stage = 'W')) when 0 then @iid_itmsts else ibi_itmsts end),
					ibi_prvsts = (case (select count(*) from IMITMDAT (nolock) where iid_venitm = @iid_venitm and
							iid_recseq <> @iid_recseq and (iid_stage = 'A' or iid_stage = 'R' or
							iid_stage = 'W')) when 0 then @iid_itmsts else ibi_prvsts end),
					ibi_rmk = left(@iid_remark,2000),
					-- David Yue	2012-09-14	Add Item Factory Temp Flag
					ibi_ftytmp = isnull(@iid_ftytmp,'N')
				where	ibi_itmno = @itmno and 
					ibi_itmsts = 'HLD' 
			end
		end
-- IMBASINF END -----------------------------------------------------

-- IMVENINF START ---------------------------------------------------
		if (select count(*) from IMVENINF (nolock) where ivi_itmno = @iid_venitm and ivi_venno = @iid_venno)  = 0 
		begin
			insert into IMVENINF
			(	ivi_cocde,	ivi_itmno,	ivi_venitm,
				ivi_venno,	ivi_def,	ivi_creusr,	
				ivi_updusr,	ivi_credat,	ivi_upddat,
				ivi_subcde
			)
			values
			(	' ',		@itmno,		@iid_venitm,
				@iid_venno,	'Y',		'EXCEL' ,
				'EXCEL', 	getdate(),	getdate(),
				''
			)
		end
	end -- if @venitm <> @iid_venitm
-- IMVENINF END -----------------------------------------------------

-- IMPCKINF START ---------------------------------------------------
	if @iid_untcde <> ''
	begin
		if (select count(*) from IMPCKINF (nolock) where ipi_itmno = @itmno and ipi_pckunt = @iid_untcde and
			((ipi_conftr = @iid_conftr and @iid_itmtyp <> 'ASS') or (ipi_conftr = @iid_assconftr and @iid_itmtyp = 'ASS')) and 
			ipi_inrqty = @iid_inrqty and ipi_mtrqty = @iid_mtrqty and ipi_cus1no = @iic_cus1no and ipi_cus2no = @iic_cus2no) = 0 
		begin
			set  @ipi_pckseq = (select isnull(max(ipi_pckseq),0) + 1 from IMPCKINF where ipi_itmno = @itmno)
			
			if @iid_inrhcm is null
			begin
				set @iid_inrhcm = 0 
			end
			if @iid_inrwcm is null
			begin
				set @iid_inrwcm = 0 
			end
			if @iid_inrlcm is null
			begin
				set @iid_inrlcm = 0 
			end	
			if @iid_mtrhcm is null
			begin
				set @iid_mtrhcm = 0 
			end
			if @iid_mtrwcm is null
			begin
				set @iid_mtrwcm = 0 
			end
			if @iid_mtrlcm is null
			begin
				set @iid_mtrlcm = 0 
			end	
			if @iid_grswgt is null
			begin
				set @iid_grswgt = 0 
			end
			if @iid_netwgt is null
			begin
				set @iid_netwgt = 0 
			end
			if @iid_cft is null
			begin
				set @iid_cft = 0 
			end

			insert into IMPCKINF
			(	ipi_cocde,		ipi_itmno,		ipi_pckseq,
				ipi_pckunt,		ipi_mtrqty,		ipi_inrqty,
				ipi_inrhin,		ipi_inrwin,		ipi_inrdin,
				ipi_inrhcm,		ipi_inrwcm,		ipi_inrdcm,
				ipi_mtrhin,		ipi_mtrwin,		ipi_mtrdin,
				ipi_mtrhcm,		ipi_mtrwcm,		ipi_mtrdcm,
				ipi_cft,		ipi_cbm,
				ipi_grswgt,		ipi_netwgt,		ipi_pckitr,
				ipi_creusr,		ipi_updusr,
				ipi_credat,		ipi_upddat,
				ipi_conftr,		ipi_qutdat,		ipi_cusno,
				-- David Yue	2012-09-14	Add Packing Inner Size, Master Size, Material
				ipi_inrsze,		ipi_mtrsze,		ipi_mat,
				-- David Yue	2014-01-17	New Packing Structure
				ipi_cus1no,		ipi_cus2no
			)
			values
			(	' ', 			@itmno,			@ipi_pckseq,
				@iid_untcde,		@iid_mtrqty,		@iid_inrqty,
				@iid_inrhcm,		@iid_inrwcm,		@iid_inrlcm,
				@iid_inrhcm*2.54,	@iid_inrwcm*2.54,	@iid_inrlcm*2.54,
				@iid_mtrhcm,		@iid_mtrwcm,		@iid_mtrlcm,
				@iid_mtrhcm*2.54,	@iid_mtrwcm*2.54,	@iid_mtrlcm*2.54,
				@iid_cft,		isnull(@iid_cft*@cbmcft,0),
				@iid_grswgt,		@iid_netwgt,		@iid_pckitr,
				'EXCEL',		'EXCEL',
				getdate(),		getdate() , 
				@iid_assconftr,		@iid_period,		@iid_cus1no,
				-- David Yue	2012-09-14	Add Packing Inner Size, Master Size, Material
				isnull(@iid_inrsze,''),	isnull(@iid_mtrsze,''),	isnull(@iid_mat,''),
				-- David Yue	2014-01-17	New Packing Structure
				isnull(@iic_cus1no,''),	isnull(@iic_cus2no,'')
			)
			
			if @ipi_pckseq = 1 
			begin
				insert into IMVENPCK
				(	ivp_cocde,	ivp_itmno,	ivp_pckseq,
					ivp_venno,	ivp_relatn,	ivp_creusr,
					ivp_updusr,	ivp_credat,	ivp_upddat
				)
				values
				(	' ',		@itmno,		@ipi_pckseq,
					@iid_venno,	'Yes',		'EXCEL',
					'EXCEL',	getdate(),	getdate()		
				)		
			end
			else -- @ipi_pckseq <> 1
			begin
				insert into IMVENPCK
				(	ivp_cocde,	ivp_itmno,	ivp_pckseq,
					ivp_venno,	ivp_relatn,	ivp_creusr,
					ivp_updusr,	ivp_credat,	ivp_upddat
				)
				select  ' ',		@itmno,		@ipi_pckseq,
					ivi_venno,	'Yes',		'EXCEL',
					'EXCEL',	getdate(),	getdate()
				from 	IMVENINF
				where 	ivi_itmno = @itmno

			end -- @ipi_pckseq <> 1 
		end
		else -- if (select count(*) from IMPCKINF where ipi_itmno = @itmno and > 0
		begin
			set @ipi_pckseq = (select isnull(max(ipi_pckseq),0) from IMPCKINF where ipi_itmno = @itmno)
			/*
			if (select count(*) from IMPRCINF (nolock) where imu_itmno = @iid_venitm and imu_pckunt = @iid_untcde and
				imu_inrqty = @iid_inrqty and imu_mtrqty = @iid_mtrqty) > 0 and (select ipi_cft from IMPCKINF (nolock)
				where ipi_itmno = @iid_venitm and ipi_pckunt = @iid_untcde and ipi_inrqty = @iid_inrqty and 
				ipi_mtrqty = @iid_mtrqty and ipi_cus1no = @iic_cus1no and ipi_cus2no = @iic_cus2no) <> isnull(@iid_cft,0)
			begin
				update	IMPRCINF
				set	imu_cft = isnull(@iid_cft,0),
					imu_period = @imu_period,
					imu_updusr = 'Excel',
					imu_upddat = getdate()
				where	imu_itmno = @iid_venitm and
					imu_pckunt = @iid_untcde and
					imu_inrqty = @iid_inrqty and
					imu_mtrqty = @iid_mtrqty
			end
			*/
			update	IMPCKINF 
				set	ipi_inrhin = isnull(@iid_inrhcm,0),
					ipi_inrwin = isnull(@iid_inrwcm,0),		
					ipi_inrdin = isnull(@iid_inrlcm,0),
					ipi_inrhcm = isnull(round(@iid_inrhcm*2.54,4),0),		
					ipi_inrwcm = isnull(round(@iid_inrwcm*2.54,4),0),
					ipi_inrdcm = isnull(round(@iid_inrlcm*2.54,4),0),
					ipi_mtrhin = isnull(@iid_mtrhcm,0),
					ipi_mtrwin = isnull(@iid_mtrwcm,0),		
					ipi_mtrdin = isnull(@iid_mtrlcm,0),
					ipi_mtrhcm = isnull(round(@iid_mtrhcm*2.54,4),0),		
					ipi_mtrwcm = isnull(round(@iid_mtrwcm*2.54,4),0),
					ipi_mtrdcm = isnull(round(@iid_mtrlcm*2.54,4),0),
					ipi_cft = isnull(@iid_cft,0),			
					ipi_cbm = isnull(@iid_cft*@cbmcft,0),
					ipi_grswgt = isnull(@iid_grswgt,0),		
					ipi_netwgt = isnull(@iid_netwgt,0),
					ipi_updusr = 'Excel',
					ipi_upddat = getdate(),
					ipi_conftr = @iid_assconftr,
					ipi_qutdat = @iid_period,
					ipi_cusno = @iid_cus1no,
					-- David Yue	2012-09-13	Add Packing Inner Size, Master Size, Material
					ipi_inrsze = isnull(@iid_inrsze,''),
					ipi_mtrsze = isnull(@iid_mtrsze,''),
					ipi_mat = isnull(@iid_mat,''),
					ipi_pckitr = isnull(@iid_pckitr,'')
				where	ipi_itmno = @iid_itmno and
			     	      	ipi_pckunt = @iid_untcde and 	
					ipi_inrqty = @iid_inrqty and	
			 		ipi_mtrqty = @iid_mtrqty and
					ipi_cus1no = @iic_cus1no and
					ipi_cus2no = @iic_cus2no

/*
			if @iid_cocde = 'UCP'
			begin
				update	IMPCKINF 
				set	ipi_inrhin = isnull(round(@iid_inrhcm*0.3937,4),0),		
					ipi_inrwin = isnull(round(@iid_inrwcm*0.3937,4),0),
					ipi_inrdin = isnull(round(@iid_inrlcm*0.3937,4),0),		
					ipi_inrhcm = isnull(@iid_inrhcm,0),
					ipi_inrwcm = isnull(@iid_inrwcm,0),		
					ipi_inrdcm = isnull(@iid_inrlcm,0),
					ipi_mtrhin = isnull(round(@iid_mtrhcm*0.3937,4),0),	
					ipi_mtrwin = isnull(round(@iid_mtrwcm*0.3937,4),0),
					ipi_mtrdin = isnull(round(@iid_mtrlcm*0.3937,4),0),	
					ipi_mtrhcm = isnull(@iid_mtrhcm,0),
					ipi_mtrwcm = isnull(@iid_mtrwcm,0),		
					ipi_mtrdcm = isnull(@iid_mtrlcm,0),
					ipi_cft = isnull(@iid_cft,0),			
					ipi_cbm = isnull(@iid_cft*@cbmcft,0),
					ipi_grswgt = isnull(@iid_grswgt,0),		
					ipi_netwgt = isnull(@iid_netwgt,0),
					ipi_updusr = 'Excel',
					ipi_upddat = getdate(),
					ipi_conftr = @iid_assconftr,
					ipi_qutdat = @iid_period,
					ipi_cusno = @iid_cus1no,
					-- David Yue	2012-09-14	Add Packing Inner Size, Master Size, Material
					ipi_inrsze = isnull(@iid_inrsze,''),
					ipi_mtrsze = isnull(@iid_mtrsze,''),
					ipi_mat = isnull(@iid_mat,'')
				where	ipi_itmno = @iid_itmno and
			     	      	ipi_pckunt = @iid_untcde and 	
					ipi_inrqty = @iid_inrqty and	
			 		ipi_mtrqty = @iid_mtrqty
			end  -- if @iid_cocde = 'UCP'
			
			if @iid_cocde = 'UCPP' or @iid_cocde = 'MS'
			begin
				if @ventyp = 'D'
				begin
					update	IMPCKINF 
					set	ipi_inrhin = isnull(@iid_inrhcm,0),		
						ipi_inrwin = isnull(@iid_inrwcm,0),
						ipi_inrdin = isnull(@iid_inrlcm,0),		
						ipi_inrhcm = isnull(round(@iid_inrhcm*2.54,4),0),
						ipi_inrwcm = isnull(round(@iid_inrwcm*2.54,4),0),	
						ipi_inrdcm = isnull(round(@iid_inrlcm*2.54,4),0),
						ipi_mtrhin = isnull(@iid_mtrhcm,0),		
						ipi_mtrwin = isnull(@iid_mtrwcm,0),
						ipi_mtrdin = isnull(@iid_mtrlcm,0),		
						ipi_mtrhcm = isnull(round(@iid_mtrhcm*2.54,4),0),
						ipi_mtrwcm = isnull(round(@iid_mtrwcm*2.54,4),0),	
						ipi_mtrdcm = isnull(round(@iid_mtrlcm*2.54,4),0),
						ipi_cft = isnull(@iid_cft,0),			
						ipi_cbm = isnull(@iid_cft*@cbmcft,0),
						ipi_grswgt = isnull(@iid_grswgt,0),		
						ipi_netwgt = isnull(@iid_netwgt,0),
						ipi_pckitr = @iid_pckitr,
						ipi_updusr = 'Excel',
						ipi_upddat = getdate(),
						ipi_conftr = @iid_assconftr,
						ipi_qutdat = @iid_period,
						ipi_cusno = @iid_cus1no,
						-- David Yue	2012-09-14	Add Packing Inner Size, Master Size, Material
						ipi_inrsze = isnull(@iid_inrsze,''),
						ipi_mtrsze = isnull(@iid_mtrsze,''),
						ipi_mat = isnull(@iid_mat,'')
					where	ipi_itmno = @iid_itmno and
						ipi_pckunt = @iid_untcde and 	
						ipi_inrqty = @iid_inrqty and	
				 		ipi_mtrqty = @iid_mtrqty
				end
				else -- @ventyp = 'P'
				begin
					update	IMPCKINF 
					set	ipi_inrhin = isnull(@iid_inrhcm,0),		
						ipi_inrwin = isnull(@iid_inrwcm,0),
						ipi_inrdin = isnull(@iid_inrlcm,0),		
						ipi_inrhcm = isnull(round(@iid_inrhcm*2.54,4),0),
						ipi_inrwcm = isnull(round(@iid_inrwcm*2.54,4),0),	
						ipi_inrdcm = isnull(round(@iid_inrlcm*2.54,4),0),
						ipi_mtrhin = isnull(@iid_mtrhcm,0),		
						ipi_mtrwin = isnull(@iid_mtrwcm,0),
						ipi_mtrdin = isnull(@iid_mtrlcm,0),		
						ipi_mtrhcm = isnull(round(@iid_mtrhcm*2.54,4),0),
						ipi_mtrwcm = isnull(round(@iid_mtrwcm*2.54,4),0),	
						ipi_mtrdcm = isnull(round(@iid_mtrlcm*2.54,4),0),
						ipi_cft = isnull(@iid_cft,0),			
						ipi_cbm = isnull(@iid_cft*@cbmcft,0),
						ipi_grswgt = isnull(@iid_grswgt,0),		
						ipi_netwgt = isnull(@iid_netwgt,0),
						ipi_updusr = 'Excel',			
						ipi_upddat = getdate(),
						ipi_conftr = @iid_assconftr,
						ipi_qutdat = @iid_period,
						ipi_cusno = @iid_cus1no,
						-- David Yue	2012-09-14	Add Packing Inner Size, Master Size, Material
						ipi_inrsze = isnull(@iid_inrsze,''),
						ipi_mtrsze = isnull(@iid_mtrsze,''),
						ipi_mat = isnull(@iid_mat,'')
					where	ipi_itmno = @iid_itmno and
						ipi_pckunt = @iid_untcde and 
						ipi_inrqty = @iid_inrqty and	
				 		ipi_mtrqty = @iid_mtrqty
				end
			end -- if @iid_cocde = 'UCPP' or @iid_cocde = 'MS'
*/
		end -- if (select count(*) from IMPCKINF where ipi_itmno = @itmno and > 0
	end -- if @iid_untcde <> ''
-- IMPCKINF END -----------------------------------------------------
		
-- IMCSTINF START ---------------------------------------------------

/*
	if @itmno <> ''
	begin
		if isnull(@iid_cstexpdat,'') <> '' 
		begin
			if (select count(*) from IMCSTINF where ici_cocde = @iid_cocde and ici_itmno = @itmno) = 0 
			begin					
				insert into imcstinf
				(	ici_cocde,	ici_itmno,	ici_cstrmk,
					ici_expdat,	ici_creusr,	ici_updusr,
					ici_credat,	ici_upddat
				)				
				values
				(	@iid_cocde,	@itmno,		'',
					@iid_cstexpdat,	'EXCEL',	'EXCEL',
					getdate(),	getdate()
				)     
			end				
			else
			begin
				update	IMCSTINF 
				set	ici_expdat = @iid_cstexpdat,
					ici_updusr = 'EXCEL',
					ici_upddat = getdate()
				where	ici_cocde = @iid_cocde and
					ici_itmno = @itmno
			end
		end
		else
		begin
			delete from IMCSTINF
			where	ici_cocde = @iid_cocde and
				ici_itmno = @itmno				
		end
	end -- if @itmno <> ''
*/

-- IMCSTINF END -----------------------------------------------------

-- IMBOMASS (BOM) START ---------------------------------------------
	if @venitm <> @iid_venitm and ltrim(rtrim(@iid_stage)) = 'A'  and  ltrim(rtrim(@iid_itmtyp)) = 'REG'
	begin

		-- Added by David Yue 2012-07
		-- Remove Previous Existing BOM Affiliations --
		delete from IMBOMASS
		where	iba_typ = 'BOM' and
			exists (select ibd_venitm from IMBOMDAT (nolock) where ibd_venitm = iba_itmno)

		DECLARE cur_IMBOMDAT CURSOR
		FOR	select 	ibd_cocde,	ibd_venitm,	ibd_acsno,
				ibd_colcde,	ibd_qty,	ibd_xlsfil,	
				ibd_chkdat,	ibd_untcde,	ibd_conftr,
				ibd_recseq,	ibd_stage,	ibd_veneml,	
				ibd_malsts,	ibd_sysmsg,	ibd_venno,
				ibd_credat,	ibd_prdven,	ibd_period
			from 	IMBOMDAT (nolock)
			where	ibd_venitm = @iid_venitm and
				ibd_venno = @iid_venno and 
				ibd_xlsfil = @iid_xlsfil and
				ibd_chkdat = @iid_chkdat and
				ibd_prdven = @iid_prdven and
				ibd_stage <> 'I'
		OPEN cur_IMBOMDAT
		FETCH NEXT from cur_IMBOMDAT INTO 
		@ibd_cocde,	@ibd_venitm,	@ibd_acsno,
		@ibd_colcde,	@ibd_qty,	@ibd_xlsfil,	
		@ibd_chkdat,	@ibd_untcde,	@ibd_conftr,
		@ibd_recseq,	@ibd_stage,	@ibd_veneml,	
		@ibd_malsts,	@ibd_sysmsg,	@ibd_venno,
		@ibd_credat,	@ibd_prdven,	@ibd_period
		
		WHILE @@fetch_status = 0
		BEGIN
			if @ventyp = 'D'
			begin
				--- Retrive Price Info Information form IM ---
				set @IMU_CURCDE = ' '
				set @IMU_FTYPRC = 0
				set @imu_bcurcde = ''
				set @imu_ftycst = 0.0
				
				select	@imu_bcurcde = imu_bcurcde,
					@imu_curcde = imu_curcde,
					@imu_ftycst = imu_ftycst,
					@imu_ftyprc = imu_ftyprc
				from	IMPRCINF (nolock)
				where	imu_itmno =  @ibd_acsno and
					imu_typ = 'BOM' and
					imu_ventyp = 'D'

				if (select count(*) from IMBOMASS (nolock) where iba_itmno = @itmno and
					iba_assitm = @ibd_acsno and iba_colcde = @ibd_colcde and iba_typ = 'BOM') = 0
				begin
					insert into IMBOMASS 
					(	iba_cocde,	iba_itmno,	iba_assitm,	
						iba_typ,	iba_colcde,	iba_pckunt,	
						iba_bomqty,	iba_inrqty,	iba_mtrqty,	
						iba_creusr,	iba_updusr,	iba_credat,	
						iba_upddat,	iba_curcde, 	iba_untcst,
						iba_fmlopt, 	iba_ftyfmlopt,	iba_bombasprc,
						iba_costing,	iba_fcurcde, 	iba_ftycst,
						iba_period
					)
					values
					(	' ',		@ibd_venitm,	@ibd_acsno,	
						'BOM',		@ibd_colcde,	@ibd_untcde,	
						@ibd_qty,	0,		0,		
						'EXCEL',	'EXCEL',	getdate(),		
						getdate(),	@imu_curcde,	@imu_ftyprc,	
						'', 		'', 		0,
						'N',		@imu_bcurcde,	@imu_ftycst,
						@ibd_period
					) 
				end -- if (select count(*) from IMBOMASS...
				else
				begin
					update	IMBOMASS 
					set	iba_bomqty = @ibd_qty, 
						iba_pckunt = @ibd_untcde, 
						iba_updusr = 'EXCEL' ,
						iba_upddat = getdate(), 
						iba_curcde = @imu_curcde, 	
						iba_untcst =  @imu_ftyprc,
						iba_bombasprc = 0,
						iba_fcurcde = @imu_bcurcde,
						iba_ftycst = @imu_ftycst,
						iba_fmlopt = '',
						iba_ftyfmlopt = '',
						iba_period = @ibd_period
					where 	iba_itmno = @ibd_venitm  and 
						iba_assitm = @ibd_acsno and 
						iba_colcde = @ibd_colcde and 
						iba_typ = 'BOM' 
				end
			end -- if @ventype = 'D'

			select	@ibd_seqno = isnull(max(ibd_seqno),0) + 1
			from	IMBOMDATH 
			where	ibd_cocde = @ibd_cocde and
				ibd_venitm = @ibd_venitm and
				ibd_acsno = @ibd_acsno

			insert into IMBOMDATH
			(	ibd_cocde,	ibd_venitm,	ibd_acsno,
				ibd_recseq,	ibd_colcde,	ibd_qty,
				ibd_untcde,	ibd_conftr,	ibd_stage,
				ibd_sysmsg,	ibd_xlsfil,	ibd_veneml,
				ibd_malsts,	ibd_chkdat,	ibd_creusr,	
				ibd_updusr,	ibd_credat,	ibd_upddat,
				ibd_venno,	ibd_prdven, 	ibd_seqno,	
				ibd_itmdsc, 	ibd_period
			)
			values
			(	@ibd_cocde,	@ibd_venitm,	@ibd_acsno,
				@ibd_recseq,	@ibd_colcde,	@ibd_qty,	
				@ibd_untcde,	@ibd_conftr,	@ibd_stage,	
				@ibd_sysmsg,	@ibd_xlsfil,	@ibd_veneml,
				@ibd_malsts,	@ibd_chkdat,	'EXCEL',
				'EXCEL',	getdate(),	@ibd_credat,
				@ibd_venno,	@ibd_prdven, 	@ibd_seqno,	
				'',		@ibd_period
			)

			delete from IMBOMDAT where 
				ibd_cocde = @ibd_cocde and
				ibd_venitm = @ibd_venitm and 
				ibd_acsno = @ibd_acsno and
				ibd_colcde = @ibd_colcde and
				ibd_xlsfil  = @ibd_xlsfil and
			 	ibd_chkdat = @ibd_chkdat and
				ibd_venno = @ibd_venno and
			 	ibd_recseq = @ibd_recseq and
				ibd_prdven = @ibd_prdven
		
		FETCH NEXT from cur_IMBOMDAT INTO 
		@ibd_cocde,	@ibd_venitm,	@ibd_acsno,
		@ibd_colcde,	@ibd_qty,	@ibd_xlsfil,	
		@ibd_chkdat,	@ibd_untcde,	@ibd_conftr,
		@ibd_recseq,	@ibd_stage,	@ibd_veneml,
		@ibd_malsts,	@ibd_sysmsg,	@ibd_venno,	
		@ibd_credat,	@ibd_prdven,	@ibd_period
		END -- FETCH cur_IMBOMDAT
		CLOSE cur_IMBOMDAT
		DEALLOCATE cur_IMBOMDAT
	end -- if @venitm <> @iid_venitm and ltrim(rtrim(@iid_stage)) = 'A'...
-- IMBOMASS (BOM) END -----------------------------------------------

-- IMPRCINF START ---------------------------------------------------
	set @bomcst = 0
	set @bomprc = 0
	set @imu_selrat  = 0
	set @imu_basprc = 0
	
	select	@imu_bcurcde = ysi_cde 
	from	SYsetINF 
	where 	ysi_typ = '06' and 
		ysi_def = 'Y' 

	if @iid_cstexpdat <> ''
		set @imu_expdat = cast(datepart(year,@iid_cstexpdat) as varchar(4)) + '-' +
					cast(datepart(month,@iid_cstexpdat) as nvarchar(2)) + '-' +
					cast(datepart(day,@iid_cstexpdat) as nvarchar(2)) + ' 23:59:59.99'
	else
		set @imu_expdat = cast(datepart(year,dateadd(year,1,@iid_period)) as varchar(4)) + '-' +
					cast(datepart(month,@iid_period) as nvarchar(2)) + '-' +
					cast(datepart(day,@iid_period) as nvarchar(2)) + ' 23:59:59.99'
	
	if @iid_itmtyp = 'BOM'
	begin
		set @imu_fmlopt = 'B01'
		set @imu_itmprc = 0
		set @imu_basprc = 0

		insert into IMPRCINF
		(	imu_cocde,	imu_itmno,	imu_typ,
			imu_ventyp,	imu_venno,	imu_prdven,
			imu_pckunt,	imu_conftr,	imu_inrqty,
			imu_mtrqty,	imu_cft,	imu_cus1no,
			imu_cus2no,	imu_ftyprctrm,	imu_hkprctrm,
			imu_trantrm,	imu_effdat,	imu_expdat,
			imu_status,	imu_curcde,	imu_ftycst,
			imu_ftycstA,	imu_ftycstB,	imu_ftycstC,
			imu_ftycstD,	imu_ftycstTran,	imu_ftycstPack,
			imu_fml,	imu_fmlA,	imu_fmlB,
			imu_fmlC,	imu_fmlD,	imu_fmlTran,
			imu_fmlPack,	imu_chgfp,	imu_chgfpA,
			imu_chgfpB,	imu_chgfpC,	imu_chgfpD,
			imu_chgfpTran,	imu_chgfpPack,	imu_ftyprc,
			imu_ftyprcA,	imu_ftyprcB,	imu_ftyprcC,
			imu_ftyprcD,	imu_ftyprcTran,	imu_ftyprcPack,
			imu_bomcst,	imu_ttlcst,	imu_hkadjper,
			imu_negcst,	imu_negprc,	imu_fmlopt,
			imu_bcurcde,	imu_itmprc,	imu_bomprc,
			imu_basprc,	imu_period,	imu_cstchgdat,
			imu_creusr,	imu_updusr,	imu_credat,
			imu_upddat
		)
		values
		(	'',		@iid_venitm,	@iid_itmtyp,
			@ventyp,	@iid_venno,	@iid_prdven,
			@iid_untcde,	@iid_assconftr,	@iid_inrqty,
			@iid_mtrqty,	@iid_cft,	@iic_cus1no,
			@iic_cus2no,	@iid_ftyprctrm,	@iid_prctrm,
			@iid_trantrm,	getdate(),	@imu_expdat,
			'ACT',		@iid_curcde,	@iid_ftycst,
			0,		0,		0,
			0,		0,		0,
			'',		'',		'',
			'',		'',		'',
			'',		0,		0,
			0,		0,		0,
			0,		0,		@iid_ftyprc,
			0,		0,		0,
			0,		0,		0,
			0,		@iid_ftyprc,	0,
			0,		0,		@imu_fmlopt,
			--@imu_bcurcde,	@imu_itmprc,	0,
			@imu_curcde,	@imu_itmprc,	0,
			@imu_basprc,	@imu_period,	getdate(),
			'EXCEL',	'EXCEL',	getdate(),
			getdate()
		)
	end -- if @iid_itmtyp = 'BOM'
	else -- @iid_itmtyp <> 'BOM'
	begin
		-- select the appropriate Markup Formula --
		if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
			icf_vencde = 'INT' and icf_cus1no = @iic_cus1no and icf_cus2no = @iic_cus2no and
			icf_catlvl4 = @iid_catlvl4 and icf_expdat >= getdate()) > 0 and
			@iic_cus1no <> '' and @iic_cus2no <> '' and @iid_catlvl4 <> ''
		begin
			select	@imu_fmlopt = icf_fml_hk,
				@fml = yfi_fml
			from	IMCALFML (nolock), SYFMLINF (nolock)
			where	icf_caltar = 'IM' and
				icf_caltyp = 'BASIC' and
				icf_vencde = 'INT' and
				icf_cus1no = @iic_cus1no and
				icf_cus2no = @iic_cus2no and
				icf_catlvl4 = @iid_catlvl4 and
				icf_expdat >= getdate() and
				yfi_fmlopt = icf_fml_hk
		end
		else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
			icf_vencde = 'INT' and icf_cus1no = @iic_cus1no and icf_cus2no = '' and
			icf_catlvl4 = @iid_catlvl4 and icf_expdat >= getdate()) > 0 and
			@iic_cus1no <> '' and @iid_catlvl4 <> ''
		begin
			select	@imu_fmlopt = icf_fml_hk,
				@fml = yfi_fml
			from	IMCALFML (nolock), SYFMLINF (nolock)
			where	icf_caltar = 'IM' and
				icf_caltyp = 'BASIC' and
				icf_vencde = 'INT' and
				icf_cus1no = @iic_cus1no and
				icf_cus2no = '' and
				icf_catlvl4 = @iid_catlvl4 and
				icf_expdat >= getdate() and
				yfi_fmlopt = icf_fml_hk
		end
		else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
			icf_vencde = 'INT' and icf_cus1no = '' and icf_cus2no = '' and
			icf_catlvl4 = @iid_catlvl4 and icf_expdat >= getdate()) > 0 and @iid_catlvl4 <> ''
		begin
			select	@imu_fmlopt = icf_fml_hk,
				@fml = yfi_fml
			from	IMCALFML (nolock), SYFMLINF (nolock)
			where	icf_caltar = 'IM' and
				icf_caltyp = 'BASIC' and
				icf_vencde = 'INT' and
				icf_cus1no = '' and
				icf_cus2no = '' and
				icf_catlvl4 = @iid_catlvl4 and
				icf_expdat >= getdate() and
				yfi_fmlopt = icf_fml_hk
		end
		else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
			icf_vencde = 'INT' and icf_cus1no = @iic_cus1no and icf_cus2no = @iic_cus2no and
			icf_catlvl4 = '' and icf_expdat >= getdate()) > 0 and @iic_cus1no <> '' and @iic_cus2no <> ''
		begin
			select	@imu_fmlopt = icf_fml_hk,
				@fml = yfi_fml
			from	IMCALFML (nolock), SYFMLINF (nolock)
			where	icf_caltar = 'IM' and
				icf_caltyp = 'BASIC' and
				icf_vencde = 'INT' and
				icf_cus1no = @iic_cus1no and
				icf_cus2no = @iic_cus2no and
				icf_catlvl4 = '' and
				icf_expdat >= getdate() and
				yfi_fmlopt = icf_fml_hk
		end
		else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
			icf_vencde = 'INT' and icf_cus1no = @iic_cus1no and icf_cus2no = '' and
			icf_catlvl4 = '' and icf_expdat >= getdate()) > 0 and @iic_cus1no <> ''
		begin
			select	@imu_fmlopt = icf_fml_hk,
				@fml = yfi_fml
			from	IMCALFML (nolock), SYFMLINF (nolock)
			where	icf_caltar = 'IM' and
				icf_caltyp = 'BASIC' and
				icf_vencde = 'INT' and
				icf_cus1no = @iic_cus1no and
				icf_cus2no = '' and
				icf_catlvl4 = '' and
				icf_expdat >= getdate() and
				yfi_fmlopt = icf_fml_hk
		end
		else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
			icf_vencde = @iid_venno and icf_cus1no = '' and icf_cus2no = '' and
			icf_catlvl4 = '' and icf_expdat >= getdate()) > 0
		begin
			select	@imu_fmlopt = icf_fml_hk,
				@fml = yfi_fml
			from	IMCALFML (nolock), SYFMLINF (nolock)
			where	icf_caltar = 'IM' and
				icf_caltyp = 'BASIC' and
				icf_vencde = @iid_venno and
				icf_cus1no = '' and
				icf_cus2no = '' and
				icf_catlvl4 = '' and
				icf_expdat >= getdate() and
				yfi_fmlopt = icf_fml_hk
		end
		else
		begin
			select	@imu_fmlopt = icf_fml_hk,
				@fml = yfi_fml
			from	IMCALFML (nolock), SYFMLINF (nolock)
			where	icf_caltar = 'IM' and
				icf_caltyp = 'BASIC' and
				icf_vencde = 'INT' and
				icf_cus1no = '' and
				icf_cus2no = '' and
				icf_catlvl4 = '' and
				icf_expdat >= getdate() and
				yfi_fmlopt = icf_fml_hk
		end

		if @fml is null or @fml = ''
		begin
			set @fml = '0'
		end
		
		/*
		select	@imu_selrat = isnull(ysi_selrat, 0) 
		from	SYsetINF 
		where 	ysi_typ = '06' and 
			ysi_cde = @iid_curcde
		*/
		
		select	@imu_selrat = isnull(yce_selrat, 0)
		from	SYCUREX (nolock)
		where	yce_frmcur = @iid_curcde and
			yce_tocur = (select ysi_cde from SYSETINF (nolock) where ysi_typ = '06' and ysi_def = 'Y') and
			yce_iseff = 'Y'
		
		
		set @fml = LTRIM(RTRIM(@fml))
		set @i  = 1

		set @fml = replace(@fml, ' ','')

		if (substring(@fml,1,1) <> '*') and (substring(@fml,1,1)<> '/')
		begin
			set @fml = '*' + @fml
		end
		
		-- Assign Variable START --
		set @imu_bomprc = @bomprc		-- BOM Price
		set @imu_itmprc = @iid_ftyprc		-- Item Price
		set @imu_basprc = 0			-- Basic Price
		set @imu_bomcst = @bomcst		-- BOM Cost
		set @imu_ftyprc = @iid_ftyprc		-- Factory Price		
		set @imu_chgfp = 0
		set @imu_chgfpA = 0
		set @imu_chgfpB = 0
		set @imu_chgfpC = 0
		set @imu_chgfpD = 0
		set @imu_chgfpTran = 0
		set @imu_chgfpPack = 0
		-- Assign Variable END --
		
		while len(@fml) <> 0
		begin
			set @fml = ltrim(@fml)
			set @OP = substring(@fml,1,1)
			set @fml = substring(@fml, 2, len(@fml))
			if (charindex('*', @fml) = 0 and charindex('/', @fml) = 0)
			    begin
				set @end = len(@fml) + 1
			    end
			else if (charindex('*', @fml) = 0) 
				set @end = charindex('/', @fml)
			else if (charindex('/', @fml) = 0) 
				set @end = charindex('*', @fml)
			else
			    begin
				if (charindex('*', @fml) < charindex('/', @fml)) 
					set @end = charindex('*', @fml)
				else
					set @end = charindex('/', @fml)
			    end	
			---------------------------
			set @temp = substring(@fml, 1, @end -1)
			if @OP = '*'
				set @imu_itmprc = @imu_itmprc   * @temp
			else if @OP = '/' 
				set @imu_itmprc = @imu_itmprc   / @temp
			---------------------------
			set @fml = substring(@fml, @end, len(@fml))
		end
		
		--- Calculate Basic Price ---
			
		set @imu_basprc = round((@imu_itmprc * @imu_selrat) + @imu_bomprc,4)
		set @imu_itmprc = round(@imu_itmprc * @imu_selrat ,4)	

		-- END Basic Price Calculation --
		
		if @imu_fmlopt is NULL
		begin
			set @imu_fmlopt = ''
		end

		if @iid_ftycst is NULL
		begin
			set @iid_ftycst = 0
		end

		if @iid_ftyprc is NULL
		begin
			set @iid_ftyprc = 0
		end
		
		-- Calculate Change in Factory Price --
		if @iid_ftycst = 0 or @iid_ftyprc = 0
			set @imu_chgfp = 0
		else
			set @imu_chgfp = round((@iid_ftyprc / @iid_ftycst * 100) - 100, 2)
		if @iic_icA = 0 or @iic_fcA = 0
			set @imu_chgfpA = 0
		else
			set @imu_chgfpA = round((@iic_icA / @iic_fcA * 100) - 100, 2)

		if @iic_icB = 0 or @iic_fcB = 0
			set @imu_chgfpB = 0
		else
			set @imu_chgfpB = round((@iic_icB / @iic_fcB * 100) - 100, 2)

		if @iic_icC = 0 or @iic_fcC = 0
			set @imu_chgfpC = 0
		else
			set @imu_chgfpC = round((@iic_icC / @iic_fcC * 100) - 100, 2)
		
		if @iic_icD = 0 or @iic_fcD = 0
			set @imu_chgfpD = 0
		else
			set @imu_chgfpD = round((@iic_icD / @iic_fcD * 100) - 100, 2)
		
		if @iic_icTran = 0 or @iic_fcTran = 0
			set @imu_chgfpTran = 0
		else
			set @imu_chgfpTran = round((@iic_icTran / @iic_fcTran * 100) - 100, 2)
		
		if @iic_icPack = 0 or @iic_fcPack = 0
			set @imu_chgfpPack = 0
		else
			set @imu_chgfpPack = round((@iic_icPack / @iic_fcPack * 100) - 100, 2)

		-- insert into IMPRCINF --
		if @ventyp = 'D' -- Design Vendor
		begin
			insert into IMPRCINF
			(	imu_cocde,	imu_itmno,	imu_typ,
				imu_ventyp,	imu_venno,	imu_prdven,
				imu_pckunt,	imu_conftr,	imu_inrqty,
				imu_mtrqty,	imu_cft,	imu_cus1no,
				imu_cus2no,	imu_ftyprctrm,	imu_hkprctrm,
				imu_trantrm,	imu_effdat,	imu_expdat,
				imu_status,	imu_curcde,	imu_ftycst,
				imu_ftycstA,	imu_ftycstB,	imu_ftycstC,
				imu_ftycstD,	imu_ftycstTran,	imu_ftycstPack,
				imu_fml,	imu_fmlA,	imu_fmlB,
				imu_fmlC,	imu_fmlD,	imu_fmlTran,
				imu_fmlPack,	imu_chgfp,	imu_chgfpA,
				imu_chgfpB,	imu_chgfpC,	imu_chgfpD,
				imu_chgfpTran,	imu_chgfpPack,	imu_ftyprc,
				imu_ftyprcA,	imu_ftyprcB,	imu_ftyprcC,
				imu_ftyprcD,	imu_ftyprcTran,	imu_ftyprcPack,
				imu_bomcst,	imu_ttlcst,	imu_hkadjper,
				imu_negcst,	imu_negprc,	imu_fmlopt,
				imu_bcurcde,	imu_itmprc,	imu_bomprc,
				imu_basprc,	imu_period,	imu_cstchgdat,
				imu_creusr,	imu_updusr,	imu_credat,
				imu_upddat
			)
			values
			(	'',		@iid_venitm,	@iid_itmtyp,
				'D',		@iid_venno,	@iid_prdven,
				@iid_untcde,	@iid_assconftr,	@iid_inrqty,
				@iid_mtrqty,	@iid_cft,	@iic_cus1no,
				@iic_cus2no,	@iid_ftyprctrm,	@iid_prctrm,
				@iid_trantrm,	getdate(),	@imu_expdat,
				'ACT',		@iid_curcde,	@iid_ftycst,
				@iic_fcA,	@iic_fcB,	@iic_fcC,
				@iic_fcD,	@iic_fcTran,	@iic_fcPack,
				'',		'',		'',
				'',		'',		'',
				'',		@imu_chgfp,	@imu_chgfpA,
				@imu_chgfpB,	@imu_chgfpC,	@imu_chgfpD,
				@imu_chgfpTran,	@imu_chgfpPack,	@iid_ftyprc,
				@iic_icA,	@iic_icB,	@iic_icC,
				@iic_icD,	@iic_icTran,	@iic_icPack,
				0,		@iid_ftyprc,	0,
				0,		@iic_negprc,	@imu_fmlopt,
				@imu_bcurcde,	@imu_itmprc,	0,
				@imu_basprc,	@imu_period,	getdate(),
				'EXCEL',	'EXCEL',	getdate(),
				getdate()
			)
			
			/*
			update	IMPRCINF 
			set	imu_bcurcde = @iid_fcurcde,
				imu_updusr = 'EXCEL' 
			where	imu_itmno = @itmno and
				imu_ventyp = 'D' and 
				imu_venno = @iid_venno and
				imu_pckunt = @iid_untcde and 
				imu_typ = 'BOM'
			*/
		end
		else -- Production Vendor
		begin
			insert into IMPRCINF
			(	imu_cocde,	imu_itmno,	imu_typ,
				imu_ventyp,	imu_venno,	imu_prdven,
				imu_pckunt,	imu_conftr,	imu_inrqty,
				imu_mtrqty,	imu_cft,	imu_cus1no,
				imu_cus2no,	imu_ftyprctrm,	imu_hkprctrm,
				imu_trantrm,	imu_effdat,	imu_expdat,
				imu_status,	imu_curcde,	imu_ftycst,
				imu_ftycstA,	imu_ftycstB,	imu_ftycstC,
				imu_ftycstD,	imu_ftycstTran,	imu_ftycstPack,
				imu_fml,	imu_fmlA,	imu_fmlB,
				imu_fmlC,	imu_fmlD,	imu_fmlTran,
				imu_fmlPack,	imu_chgfp,	imu_chgfpA,
				imu_chgfpB,	imu_chgfpC,	imu_chgfpD,
				imu_chgfpTran,	imu_chgfpPack,	imu_ftyprc,
				imu_ftyprcA,	imu_ftyprcB,	imu_ftyprcC,
				imu_ftyprcD,	imu_ftyprcTran,	imu_ftyprcPack,
				imu_bomcst,	imu_ttlcst,	imu_hkadjper,
				imu_negcst,	imu_negprc,	imu_fmlopt,
				imu_bcurcde,	imu_itmprc,	imu_bomprc,
				imu_basprc,	imu_period,	imu_cstchgdat,
				imu_creusr,	imu_updusr,	imu_credat,
				imu_upddat
			)
			values
			(	'',		@iid_venitm,	@iid_itmtyp,
				'P',		@iid_venno,	@iid_prdven,
				@iid_untcde,	@iid_assconftr,	@iid_inrqty,
				@iid_mtrqty,	@iid_cft,	@iic_cus1no,
				@iic_cus2no,	@iid_ftyprctrm,	@iid_prctrm,
				@iid_trantrm,	getdate(),	@imu_expdat,
				'ACT',		@iid_curcde,	@iid_ftycst,
				@iic_fcA,	@iic_fcB,	@iic_fcC,
				@iic_fcD,	@iic_fcTran,	@iic_fcPack,
				'',		'',		'',
				'',		'',		'',
				'',		@imu_chgfp,	@imu_chgfpA,
				@imu_chgfpB,	@imu_chgfpC,	@imu_chgfpD,
				@imu_chgfpTran,	@imu_chgfpPack,	@iid_ftyprc,
				@iic_icA,	@iic_icB,	@iic_icC,
				@iic_icD,	@iic_icTran,	@iic_icPack,
				0,		@iid_ftyprc,	0,
				0,		@iic_negprc,	@imu_fmlopt,
				@imu_bcurcde,	@imu_itmprc,	0,
				@imu_basprc,	@imu_period,	getdate(),
				'EXCEL',	'EXCEL',	getdate(),
				getdate()
			)
		end
	end -- @iid_itmtyp <> 'BOM'
-- IMPRCINF END -----------------------------------------------------

-- IMPRCCHG START ---------------------------------------------------
	if (select count(*) from IMITMDATCST (nolock) where iic_venno = @iid_venno and iic_prdven = @iid_prdven and
		iic_venitm = @iid_venitm and iic_untcde = @iid_untcde and iic_inrqty = @iid_inrqty and 
		iic_mtrqty = @iid_mtrqty and iic_itmseq = @iid_itmseq and iic_recseq = @iid_recseq and 
		iic_xlsfil = @iid_xlsfil and iic_chkdat = @iid_chkdat and iic_stage = 'W' and
		iic_conftr = @iid_assconftr) > 0
	begin
		select top 1
			@iic_venno = iic_venno,
			@iic_venitm = iic_venitm,
			@iic_itmseq = iic_itmseq,	
			@iic_recseq = iic_recseq,
			@iic_cus1no = iic_cus1no,
			@iic_cus2no = isnull(iic_cus2no,''),				
			@iic_fcA = iic_fcA,
			@iic_fcB = iic_fcB,
			@iic_fcC = iic_fcC,		
			@iic_fcD = iic_fcD,
			@iic_fcTran = iic_fcTran,
			@iic_fcPack = iic_fcPack,	
			@iic_ftycst = iic_ftycst,
			@iic_icA = iic_icA,
			@iic_icB = iic_icB,		
			@iic_icC = iic_icC,
			@iic_icD = iic_icD,
			@iic_icTran = iic_icTran,		
			@iic_icPack = iic_icPack,
			@iic_ftyprc = iic_ftyprc,
			@iic_nat = iic_nat,		
			@iic_negprc = iic_negprc,
			@iic_untcde = iic_untcde,
			@iic_mtrqty = iic_mtrqty,
			@iic_inrqty = iic_inrqty,
			@iic_prdven = iic_prdven,
			@iic_stage = iic_stage,
			@iic_xlsfil = iic_xlsfil,
			@iic_chkdat = iic_chkdat,
			@iic_credat = iic_credat,
			@iic_conftr = isnull(iic_conftr,1)
		from 	IMITMDATCST (nolock)
		where	iic_venno = @iid_venno and  
			iic_prdven = @iid_prdven and  
	           	iic_venitm = @iid_venitm and 
			iic_untcde = @iid_untcde and  
			iic_inrqty = @iid_inrqty and 
			iic_mtrqty = @iid_mtrqty and
			iic_itmseq = @iid_itmseq and
			iic_recseq = @iid_recseq and 
			iic_xlsfil = @iid_xlsfil and
			iic_chkdat = @iid_chkdat-- and
			--iic_stage = 'W' and
			--iic_conftr = @iid_assconftr
		ORDER BY iic_credat desc

		set @chgreason = ''

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
		(	'UCPP',			@iid_venitm,		@iid_itmtyp,
			@ventyp,		@iid_venno,		@iid_prdven,
			@iid_untcde,		@iid_conftr,		@iid_inrqty,
			@iid_mtrqty,		@iid_cft,		@iic_cus1no,
			@iic_cus2no,		@iid_ftyprctrm,		@iid_prctrm,
			@iid_trantrm,		getdate(),		@chgreason,
			null,			null,			null,
			null,			null,			null,
			null,			null,			null,
			null,			null,			null,
			null,			null,			null,
			null,			null,			null,
			null,			null,			null,
			null,			null,			null,
			null,			null,			null,
			null,			null,			null,
			null,			null,			null,
			null,			null,			getdate(), --@iid_period,
			@imu_expdat,		@iid_curcde,		@iic_ftycst,
			@iic_fcA,		@iic_fcB,		@iic_fcC,
			@iic_fcD,		@iic_fcTran,		@iic_fcPack,
			'',			'',			'',
			'',			'',			'',
			@iic_ftyprc,		@iic_icA,		@iic_icB,
			@iic_icC,		@iic_icD,		@iic_icTran,
			@iic_icPack,		0,			@iid_ftyprc,
			0,			0,			@iic_negprc,
			@imu_fmlopt,		@imu_bcurcde,		@imu_itmprc,
			0,			@imu_basprc,		@imu_period,
			getdate(),		'EXCEL',		'EXCEL',
			getdate(),		getdate()
		)

		delete from IMPRCCHG_tmp
		where	ipc_itmno = @iid_venitm and
			ipc_venno = @iid_venno and
			ipc_prdven = @iid_prdven and
			ipc_pckunt = @iid_untcde and
			ipc_inrqty = @iid_inrqty and
			ipc_mtrqty = @iid_mtrqty and
			ipc_cus1no = @iic_cus1no and
			ipc_cus2no = @iic_cus2no and
			ipc_ftyprctrm = @iid_prctrm and
			ipc_hkprctrm = @iid_prctrm and
			ipc_trantrm = @iid_trantrm-- and
			--ipc_creusr = 'EXCEL'
	end
-- IMPRCCHG END -----------------------------------------------------

-- IMCSTDTL START ---------------------------------------------------
	if (select count(*) from IMITMDATCST (nolock) where iic_venno = @iid_venno and iic_prdven = @iid_prdven and
		iic_venitm = @iid_venitm and iic_untcde = @iid_untcde and iic_inrqty = @iid_inrqty and 
		iic_mtrqty = @iid_mtrqty and iic_itmseq = @iid_itmseq and iic_recseq = @iid_recseq and 
		iic_xlsfil = @iid_xlsfil and iic_chkdat = @iid_chkdat and iic_stage = 'W' and
		iic_conftr = @iid_assconftr) > 0
	begin
		select top 1
			@iic_venno = iic_venno,
			@iic_venitm = iic_venitm,
			@iic_itmseq = iic_itmseq,	
			@iic_recseq = iic_recseq,
			@iic_cus1no = iic_cus1no,
			@iic_cus2no = isnull(iic_cus2no,''),				
			@iic_fcA = iic_fcA,
			@iic_fcB = iic_fcB,
			@iic_fcC = iic_fcC,		
			@iic_fcD = iic_fcD,
			@iic_fcTran = iic_fcTran,
			@iic_fcPack = iic_fcPack,	
			@iic_ftycst = iic_ftycst,
			@iic_icA = iic_icA,
			@iic_icB = iic_icB,		
			@iic_icC = iic_icC,
			@iic_icD = iic_icD,
			@iic_icTran = iic_icTran,		
			@iic_icPack = iic_icPack,
			@iic_ftyprc = iic_ftyprc,
			@iic_nat = iic_nat,		
			@iic_negprc = iic_negprc,
			@iic_untcde = iic_untcde,
			@iic_mtrqty = iic_mtrqty,
			@iic_inrqty = iic_inrqty,
			@iic_prdven = iic_prdven,
			@iic_stage = iic_stage,
			@iic_xlsfil = iic_xlsfil,
			@iic_chkdat = iic_chkdat,
			@iic_credat = iic_credat,
			@iic_conftr = isnull(iic_conftr,1)
		from 	IMITMDATCST
		where	iic_venno = @iid_venno and  
			iic_prdven = @iid_prdven and  
	           	iic_venitm = @iid_venitm and 
			iic_untcde = @iid_untcde and  
			iic_inrqty = @iid_inrqty and 
			iic_mtrqty = @iid_mtrqty	and
			iic_itmseq = @iid_itmseq and
			iic_recseq = @iid_recseq and 
			iic_xlsfil = @iid_xlsfil and
			iic_chkdat = @iid_chkdat-- and
			--iic_stage = 'W' and
			--iic_conftr = @iid_assconftr
		ORDER BY iic_credat desc

		if (select count(*) from IMCSTDTL (nolock) where itd_cocde = ' ' and itd_itmno = @iid_venitm and  
			itd_typ = @iid_itmtyp and itd_ventyp = @ventyp and itd_venno = @iid_venno and 
			itd_prdven = @iid_prdven and itd_untcde = @iid_untcde and itd_mtrqty = @iid_mtrqty and
			itd_inrqty = @iid_inrqty and itd_cus1no = @iic_cus1no and 
			itd_cus2no = @iic_cus2no and itd_conftr = @iid_assconftr) = 0
		begin
			insert into IMCSTDTL
			(	
				itd_cocde ,			itd_itmno ,			itd_typ ,
				itd_ventyp ,			itd_venno ,			itd_pckseq ,
				itd_prdven,			itd_untcde,			itd_mtrqty,
				itd_inrqty,			itd_cus1no,			itd_cus2no,
				itd_catlvl4,			itd_curcde,			itd_fcA,
				itd_fcB,			itd_fcC,			itd_fcD,
				itd_fctran,			itd_fcpck,			itd_icA,
				itd_icB,			itd_icC,			itd_icD,
				itd_ictran,			itd_icpck,			itd_fm1A,
				itd_fm1B,			itd_fm1C,			itd_fm1D,
				itd_fm1tran,			itd_fm1pck,			itd_fm2A,
				itd_fm2B,			itd_fm2C,			itd_fm2D,
				itd_fm2tran,			itd_fm2pck,			itd_fcttl,
				itd_icttl,			itd_fmlopt,			itd_bcurcde,
				itd_basprc,			itd_lgtno,			itd_frtchg,
				itd_dbxlbcst,			itd_dbxlbcstch,
				itd_tgtret,			itd_pckitr,			itd_lgtspec,	
				itd_prctrm,			itd_conftr,			itd_ccA,		
				itd_ccB,			itd_ccC,			itd_ccD,
				itd_cctran,			itd_ccpck,			itd_calftyprc,		
				itd_negprc,			itd_tranhk,			itd_tranfty,
				itd_creusr ,			itd_updusr ,			itd_credat ,		
				itd_upddat
			)
			values	
			(	'' ,				@iic_venitm ,			@iid_itmtyp ,
				@ventyp ,			@iic_venno ,			@ipi_pckseq ,
				@iic_prdven,			@iic_untcde,			isnull(@iic_mtrqty,0),
				isnull(@iic_inrqty,0),		@iic_cus1no,			isnull(@iic_cus2no,''),
				@iid_catlvl4,			@iid_curcde,			isnull(@iic_fcA,0),	
				isnull(@iic_fcB,0),		isnull(@iic_fcC,0),		isnull(@iic_fcD,0),
				isnull(@iic_fcTran,0),		isnull(@iic_fcPack,0),		isnull(@iic_icA,0),
				isnull(@iic_icB,0),		isnull(@iic_icC,0),		isnull(@iic_icD,0),
				isnull(@iic_icTran,0),		isnull(@iic_icPack,0),		'',
				'',				'',				'',
				'',				'',				'',
				'',				'',				'',
				'',				'',				isnull(@iic_ftycst,0),
				isnull(@iic_ftyprc,0),		@imu_fmlopt,			'USD',
				isnull(round(@imu_basprc+@bomprc,4),0),	0,			'',
				0,				'',	
				0,				@iid_pckitr,			'',	
				@iid_prctrm,			@iid_assconftr,		
				0,		
				0,				0,				@bomprc,
				0,				0,				0,
				0,				0,				0,
				'EXCEL',			'EXCEL',			getdate(),
				getdate()
			)
		end -- if (select count(*) from IMCSTDTL...

		select	@iic_seqno = isnull(max(iic_seqno),0) + 1
		from	IMITMDATCSTH 
		where	iic_venitm = @iic_venitm and 
			iic_venno = @iic_venno and
			iic_prdven = @iic_prdven


		insert into IMITMDATCSTH
		(	iic_venno,		iic_venitm,		iic_itmseq,	
			iic_recseq,		iic_cus1no,		iic_cus2no,
			iic_fcA,		iic_fcB,		iic_fcC,		
			iic_fcD,		iic_fcTran,		iic_fcPack,	
			iic_ftycst,		iic_icA,		iic_icB,		
			iic_icC,		iic_icD,		iic_icTran,		
			iic_icPack,		iic_ftyprc,		iic_nat,		
			iic_negprc,		iic_untcde,		iic_mtrqty,
			iic_inrqty,		iic_prdven,		iic_seqno,
			iic_cocde,		iic_stage,		iic_xlsfil,
			iic_conftr,
			iic_chkdat,		iic_creusr,		iic_updusr,	
			iic_credat,		iic_upddat						
		)
		values
		(	@iic_venno,		@iic_venitm,		@iic_itmseq,	
			@iic_recseq,		@iic_cus1no,		isnull(@iic_cus2no,''),				
			@iic_fcA,		@iic_fcB,		@iic_fcC,		
			@iic_fcD,		@iic_fcTran,		@iic_fcPack,	
			@iic_ftycst,		@iic_icA,		@iic_icB,		
			@iic_icC,		@iic_icD,		@iic_icTran,		
			@iic_icPack,		@iic_ftyprc,		@iic_nat,		
			@iic_negprc,		@iic_untcde,		@iic_mtrqty,
			@iic_inrqty,		@iic_prdven, 		@iic_seqno,
			'',			@iic_stage,		@iic_xlsfil,
			@iic_conftr,
			@iic_chkdat,		'EXCEL',		'EXCEL',	
			getdate(),		@iic_credat
		)
		
		delete from IMITMDATCST 	
		where	iic_venno = @iid_venno and  
			iic_prdven = @iid_prdven and  
	           	iic_venitm = @iid_venitm and 
			iic_untcde = @iid_untcde and  
			iic_inrqty = @iid_inrqty and 
			iic_mtrqty = @iid_mtrqty and
			iic_itmseq = @iid_itmseq and
			iic_recseq = @iid_recseq and 
			iic_xlsfil = @iid_xlsfil and			
			iic_chkdat = @iid_chkdat and
			iic_stage = @iic_stage and
			iic_conftr = @iid_assconftr

	end -- if (select count(*) from IMITMDATCST...
-- IMCSTDTL END -----------------------------------------------------

-- IMCOLINF START ---------------------------------------------------
	if @venitm <> @iid_venitm
	begin		
		set @updsts = 'N'
		-- Color Info related to Item Info
		DECLARE cur_IMCOLDAT CURSOR
		FOR 	select 	icd_cocde,	icd_venitm,	icd_colcde,
				icd_coldsc,	icd_xlsfil,	icd_chkdat,
				icd_recseq,	icd_sysmsg,	icd_veneml,	
				icd_malsts,	icd_stage,	icd_venno,
				icd_credat,	icd_prdven
			from 	IMCOLDAT (nolock)
			where	icd_venitm = @iid_venitm and 
				icd_venno = @iid_venno and 
				icd_xlsfil = @iid_xlsfil and 
				icd_chkdat = @iid_chkdat and 
				icd_prdven = @iid_prdven

		OPEN cur_IMCOLDAT
		FETCH NEXT from cur_IMCOLDAT INTO 
		@icd_cocde,	@icd_venitm,	@icd_colcde,
		@icd_coldsc,	@icd_xlsfil,	@icd_chkdat,
		@icd_recseq,	@icd_sysmsg,	@icd_veneml,	
		@icd_malsts,	@icd_stage,	@icd_venno,
		@icd_credat,	@icd_prdven

		WHILE @@fetch_status = 0
		BEGIN	
			if @ventyp = 'D'
			begin
				if (select count(*) from IMCOLINF (nolock) where icf_itmno = @iid_venitm and icf_vencol = @icd_colcde) = 0
				begin

					set @colseq = (select isnull(max(icf_colseq),0) + 1 from IMCOLINF where icf_itmno = @iid_venitm)
					insert into IMCOLINF
					(	icf_cocde,	icf_itmno,	icf_colcde,	
						icf_colseq,	icf_vencol,	icf_coldsc,	
						icf_typ,	icf_ucpcde,	icf_eancde,	
						icf_creusr,	icf_updusr,	icf_credat,	
						icf_upddat
					)
					values 
					(	' ', 		@iid_venitm,	@icd_colcde,	
						@colseq,	@icd_colcde,	@icd_coldsc,	
						'',		'',		'',		
						'EXCEL',	'EXCEL',	getdate(),	
						getdate()
					)
					set @updsts = 'Y'
				end
				else
				begin
					update	IMCOLINF
					set	icf_coldsc = @icd_coldsc,
						icf_updusr = 'EXCEL' ,
						icf_upddat = getdate()
					where	icf_itmno = @iid_venitm and 
						icf_vencol = @icd_colcde
					set @updsts = 'Y'
				end
			end -- if @ventyp = 'D'

			insert into IMCOLDATH
			(	icd_cocde,	icd_venitm,	icd_recseq,
				icd_colcde,	icd_coldsc,	icd_sysmsg,	
				icd_xlsfil,	icd_veneml,	icd_malsts,	
				icd_chkdat,	icd_creusr,	icd_updusr,	
				icd_credat,	icd_upddat,	icd_stage,
				icd_venno,	icd_prdven	)
			values
			(	' ',		@icd_venitm,	@icd_recseq,
				@icd_colcde,	@icd_coldsc,	@icd_sysmsg,	
				@icd_xlsfil,	@icd_veneml,	@icd_malsts,	
				@icd_chkdat,	'EXCEL',	'EXCEL',		
				getdate(),	@icd_credat,	@icd_stage,
				@icd_venno,	@icd_prdven
			)
		
			delete from IMCOLDAT 
			where 	icd_cocde = @icd_cocde and 
				icd_venitm = @icd_venitm and 
				icd_venno = @icd_venno and 
				icd_recseq = @icd_recseq and 
				icd_colcde = @icd_colcde and 
				icd_prdven = @icd_prdven
		
		FETCH NEXT from cur_IMCOLDAT INTO 
			@icd_cocde,	@icd_venitm,	@icd_colcde,
			@icd_coldsc,	@icd_xlsfil,	@icd_chkdat,
			@icd_recseq,	@icd_sysmsg,	@icd_veneml,	
			@icd_malsts,	@icd_stage,	@icd_venno,
			@icd_credat,	@icd_prdven
		END -- FETCH cur_IMCOLDAT
		CLOSE cur_IMCOLDAT
		DEALLOCATE cur_IMCOLDAT
		
		if @updsts = 'Y' and (select count(*) from IMCOLINF (nolock) where icf_itmno = @iid_itmno) > 0 and
			   (select count(*) from IMPCKINF (nolock) where ipi_itmno = @iid_itmno) > 0 and
			   (select count(*) from IMPRCINF (nolock) where imu_itmno = @iid_itmno and imu_status = 'ACT') > 0
		begin
			update	IMBASINF
			set	ibi_itmsts = 'CMP', 
				ibi_prvsts = 'CMP' 
			where	ibi_itmno = @itmno and 
				ibi_itmsts <> 'CMP' and
				(select count(*) from IMITMDAT where iid_venitm = @iid_venitm and
					iid_recseq <> @iid_recseq and (iid_stage = 'A' or
					iid_stage = 'R' or iid_stage = 'W')) = 0
		end
	end -- if @venitm <> @iid_venitm
-- IMCOLINF END -----------------------------------------------------

-- IMMATBKD START ---------------------------------------------------
	if @venitm <> @iid_venitm
	begin		
		if @ventyp = 'D'
		begin
			delete from IMMATBKD where ibm_itmno = @itmno			
			insert into IMMATBKD
			(	ibm_cocde,	ibm_itmno,	ibm_matseq,
				ibm_mat,	ibm_curcde,	ibm_cst,
				ibm_cstper,	ibm_wgtper,	ibm_creusr,
				ibm_updusr,	ibm_credat,	ibm_upddat
			)
			select 	imd_cocde,	@itmno,		imd_recseq,
				imd_compon,	@iid_curcde,	0,
				imd_asstive,	0,		'EXCEL',
				'EXCEL',	getdate(),	getdate() 
			from	IMCOMDAT (nolock)
			where	imd_cocde = ' ' and 
				imd_venitm = @iid_venitm and
				imd_venno = @iid_venno and 
				imd_xlsfil = @iid_xlsfil and
				imd_chkdat = @iid_chkdat and
				imd_prdven = @iid_prdven and  
				imd_stage <> 'I' and
				imd_compon <> '' and
				imd_compon is not NULL
			ORDER BY imd_recseq
		end

		insert into IMCOMDATH
		(	imd_cocde,	imd_venitm,	imd_itmseq,
			imd_recseq,	imd_cosmth,	imd_compon,
			imd_asstive,	imd_stage,	imd_sysmsg,
			imd_xlsfil,	imd_veneml,	imd_malsts,
			imd_chkdat,	imd_creusr,	imd_updusr,
			imd_credat,	imd_upddat,	imd_venno,
			imd_prdven
		)
		select  imd_cocde, 	imd_venitm, 	imd_itmseq,
			imd_recseq, 	imd_cosmth,	imd_compon,	
			imd_asstive,	imd_stage,	imd_sysmsg,
			imd_xlsfil,	imd_veneml,	imd_malsts,
			imd_chkdat,	'EXCEL', 	'EXCEL',
			getdate(),	imd_credat,	imd_venno,
			imd_prdven
		from 	IMCOMDAT (nolock)
		where	imd_venitm = @iid_venitm and
			imd_venno = @iid_venno and 
			imd_xlsfil = @iid_xlsfil and
			imd_chkdat = @iid_chkdat and
			imd_prdven = @iid_prdven
		ORDER BY imd_recseq

		delete from IMCOMDAT
		where	imd_venitm = @iid_venitm and
			imd_venno = @iid_venno and 
			imd_xlsfil = @iid_xlsfil and
			imd_chkdat = @iid_chkdat and
			imd_prdven = @iid_prdven
	end -- if @venitm <> @iid_venitm
-- IMMATBKD END -----------------------------------------------------

-- IMBOMASS (ASS) START ---------------------------------------------
	if @venitm <> @iid_venitm or @ibi_typ = 'ASS'
	begin
		DECLARE cur_IMASSDAT CURSOR
		FOR	select 	iad_cocde,	iad_venitm,	iad_acsno,
				iad_colcde,	iad_inrqty,	iad_mtrqty,
				iad_xlsfil,	iad_chkdat,	iad_untcde,	
				iad_conftr,	iad_recseq,	iad_stage,
				iad_veneml,	iad_malsts,	iad_sysmsg,
				iad_venno,	iad_credat,	iad_prdven,
				iad_period
			from	IMASSDAT (nolock)
			where	iad_venitm = @iid_venitm and
				iad_venno = @iid_venno and
				iad_xlsfil = @iid_xlsfil and
				iad_chkdat = @iid_chkdat and
				iad_prdven = @iid_prdven and
				iad_stage <> 'I'		
		OPEN cur_IMASSDAT
		FETCH NEXT from cur_IMASSDAT INTO 
		@iad_cocde,	@iad_venitm,	@iad_acsno,
		@iad_colcde,	@iad_inrqty,	@iad_mtrqty,
		@iad_xlsfil,	@iad_chkdat,	@iad_untcde,	
		@iad_conftr,	@iad_recseq,	@iad_stage,	
		@iad_veneml,	@iad_malsts,	@iad_sysmsg,
		@iad_venno,	@iad_credat,	@iad_prdven,
		@iad_period
		
		WHILE @@fetch_status = 0
		BEGIN
			if @ventyp = 'D'
			begin
				if (select count(*) from IMBOMASS (nolock) where iba_itmno = @itmno and iba_assitm = @iad_acsno and
					iba_colcde = @iad_colcde and iba_typ = 'ASS') = 0 
				begin
					insert into IMBOMASS 
					(	iba_cocde,	iba_itmno,	iba_assitm,	
						iba_typ,	iba_colcde,	iba_pckunt,	
						iba_bomqty,	iba_inrqty,	iba_mtrqty,	
						iba_creusr,	iba_updusr,	iba_credat,	
						iba_upddat,	iba_period
					)
					values 
					(	' ',		@itmno,		@iad_acsno,	
						'ASS',		@iad_colcde,	@iad_untcde,	
						0,		@iad_inrqty,	@iad_mtrqty,		
						'EXCEL',	'EXCEL',	getdate(),		
						getdate(),	@iad_period
					)
				end
				else
				begin
					update	IMBOMASS 
					set 	iba_inrqty = @iad_inrqty, 
						iba_mtrqty = @iad_mtrqty,
						iba_pckunt = @iad_untcde, 
						iba_updusr = 'EXCEL' ,
						iba_upddat = getdate(),
						iba_period = @iad_period
					where 	iba_itmno = @itmno and 
						iba_assitm = @iad_acsno and 
						iba_colcde = @iad_colcde and 
						iba_typ = 'ASS'
				end
			end -- if @ventyp = 'D'

			insert into IMASSDATH
			(	iad_cocde,	iad_venitm,	iad_acsno,
				iad_recseq,	iad_colcde,	iad_inrqty,
				iad_mtrqty,	iad_untcde,	iad_conftr,
				iad_stage,	iad_sysmsg,	iad_xlsfil,
				iad_veneml,	iad_malsts,	iad_chkdat,
				iad_creusr,	iad_updusr,	iad_credat,
				iad_upddat,	iad_venno,	iad_prdven,
				iad_period
			)
			values
			(	@iad_cocde,	@iad_venitm,	@iad_acsno,
				@iad_recseq,	@iad_colcde,	@iad_inrqty,	
				@iad_mtrqty,	@iad_untcde,	@iad_conftr,
				@iad_stage,	@iad_sysmsg,	@iad_xlsfil,
				@iad_veneml,	@iad_malsts,	@iad_chkdat,
				'EXCEL',	'EXCEL',	getdate(),
				@iad_credat,	@iad_venno,	@iad_prdven,
				@iad_period
			)

			delete from IMASSDAT
			where	iad_cocde = @iad_cocde and
				iad_venitm = @iad_venitm and 
				iad_acsno = @iad_acsno and
				iad_colcde = @iad_colcde and
				iad_xlsfil  = @iad_xlsfil and
				iad_chkdat = @iad_chkdat and
				iad_venno = @iad_venno and
				iad_recseq = @iad_recseq and
				iad_prdven = @iad_prdven
		
		FETCH NEXT from cur_IMASSDAT INTO 
		@iad_cocde,	@iad_venitm,	@iad_acsno,
		@iad_colcde,	@iad_inrqty,	@iad_mtrqty,
		@iad_xlsfil,	@iad_chkdat,	@iad_untcde,	
		@iad_conftr,	@iad_recseq,	@iad_stage,
		@iad_veneml,	@iad_malsts,	@iad_sysmsg,	
		@iad_venno,	@iad_credat,	@iad_prdven,
		@iad_period
		END -- FETCH cur_IMASSDAT
		CLOSE cur_IMASSDAT
		DEALLOCATE cur_IMASSDAT
	end -- if @venitm <> @iid_venitm or @ibi_typ = 'ASS'
-- IMBOMASS (ASS) END -----------------------------------------------

-- David Yue	2012-09-14	Add Alias Temp Item
-- IMTMPREL START ---------------------------------------------------

	if ltrim(rtrim(@iid_alstmpitmno)) <> ''
	begin

		if (select count(*) from IMTMPREL (nolock) where itr_itmno = @iid_venitm and itr_tmpitm = @iid_alstmpitmno) = 0
		begin
			insert into IMTMPREL
			(	itr_cocde,	itr_itmno,	itr_tmpitm,
				itr_creusr,	itr_updusr,	itr_credat,
				itr_upddat
			)
			values
			(	'UCPP',		@iid_venitm,	ltrim(rtrim(@iid_alstmpitmno)),
				'Excel',	'Excel',	getdate(),
				getdate()
			)
		end
	end

-- IMTMPREL END -----------------------------------------------------

	if (select count(*) from IMCOLINF (nolock) where icf_itmno = @iid_venitm) > 0 and
	   (select count(*) from IMPCKINF (nolock) where ipi_itmno = @iid_venitm) > 0 and
	   (select count(*) from IMPRCINF (nolock) where imu_itmno = @iid_venitm and imu_status = 'ACT') > 0
	begin
		set @iid_itmsts = 'CMP'
	end
	else
	begin
		set @iid_itmsts = 'INC'
	end
	
	update	IMBASINF
	set	ibi_prvsts = ibi_itmsts,
		ibi_itmsts = @iid_itmsts,
		ibi_updusr = 'EXCEL',
		ibi_upddat = getdate()
	where	ibi_itmno = @iid_venitm

	insert into IMITMDATH 
	(	iid_cocde,		iid_venno,		iid_venitm,
		iid_itmseq,		iid_recseq,		iid_itmtyp,
		iid_mode,
		iid_itmsts,		iid_stage,		iid_engdsc,
		iid_chndsc,		iid_lnecde,		iid_catlvl4,
		iid_untcde,		iid_inrqty,		iid_mtrqty,
		iid_inrlcm,		iid_inrwcm,		iid_inrhcm,
		iid_mtrlcm,		iid_mtrwcm,		iid_mtrhcm,
		iid_cft,		iid_conftr,		iid_sapum,
		iid_curcde,		iid_ftycst,		iid_ftyprc,
		iid_ftyprctrm,		iid_prctrm,		iid_trantrm,
		iid_grswgt,		iid_netwgt,		iid_pckitr,
		iid_engdsc_bef,		iid_chndsc_bef,		iid_lnecde_bef,
		iid_catlvl4_bef,	iid_inrlcm_bef,		iid_inrwcm_bef,
		iid_inrhcm_bef,		iid_mtrlcm_bef,		iid_mtrwcm_bef,
		iid_mtrhcm_bef,		iid_cft_bef,		iid_conftr_bef,
		iid_curcde_bef,		iid_ftycst_bef,		iid_ftyprc_bef,
		iid_grswgt_bef,		iid_netwgt_bef,
		iid_pckitr_bef,		iid_creusr,		iid_updusr,
		iid_credat,		iid_upddat,		iid_itmno,
		iid_sysmsg,		iid_xlsfil,		iid_veneml,
		iid_malsts,		iid_chkdat,		iid_prdven,
		iid_wastage,		iid_wastage_bef,
		iid_alsitmno,		iid_alsitmno_bef,
		iid_alscolcde,		iid_alscolcde_bef,
		iid_basprc,		iid_basprc_bef,
		iid_bomprc,		iid_bomprc_bef, 
		iid_curr_bef,		iid_assconftr,		iid_assconftr_bef,
		iid_period,		iid_period_bef,		iid_cstexpdat,
		iid_cstexpdat_bef,	iid_cus1no,
		-- David Yue	2012-09-14	Packing Inner Size, Master Size, Material
		iid_inrsze,		iid_mtrsze,		iid_mat,
		iid_inrsze_bef,		iid_mtrsze_bef,		iid_mat_bef,
		-- David Yue	2012-09-14	Item Factory Temp Flag, Alias Temp Item
		iid_ftytmp,		iid_ftytmp_bef,
		iid_alstmpitmno,	iid_alstmpitmno_bef
	)
	values
	(	@iid_cocde,		@iid_venno,		@iid_venitm ,
		@iid_itmseq,		@iid_recseq,		@iid_itmtyp,
		@iid_mode,
		@iid_itmsts,		@iid_stage,		@iid_engdsc,
		@iid_chndsc,		@iid_lnecde,		@iid_catlvl4,
		@iid_untcde,		@iid_inrqty,		@iid_mtrqty,
		@iid_inrlcm,		@iid_inrwcm,		@iid_inrhcm,
		@iid_mtrlcm,		@iid_mtrwcm,		@iid_mtrhcm,
		@iid_cft,		@iid_conftr,		@iid_sapum,
		@iid_curcde,		@iid_ftycst,		@iid_ftyprc,
		@iid_ftyprctrm,		@iid_prctrm,		@iid_trantrm,
		@iid_grswgt,		@iid_netwgt,		@iid_pckitr,
		@iid_engdsc_bef,	@iid_chndsc_bef,	@iid_lnecde_bef,
		@iid_catlvl4_bef,	@iid_inrlcm_bef,	@iid_inrwcm_bef,
		@iid_inrhcm_bef,	@iid_mtrlcm_bef,	@iid_mtrwcm_bef,
		@iid_mtrhcm_bef,	@iid_cft_bef,		@iid_conftr_bef,
		@iid_curcde_bef,	@iid_ftycst_bef,	@iid_ftyprc_bef,
		@iid_grswgt_bef,	@iid_netwgt_bef,
		@iid_pckitr_bef,	@iid_creusr,		@iid_updusr,
		getdate(),		@iid_credat,		@iid_itmno,
		@iid_sysmsg,		@iid_xlsfil,		@iid_veneml,
		@iid_malsts,		@iid_chkdat,		@iid_prdven,
		@iid_wastage,		@iid_wastage_bef,
		isnull(@iid_alsitmno,''),	isnull(@iid_alsitmno_bef,''),
		isnull(@iid_alscolcde,''),	isnull(@iid_alscolcde_bef,''),
		isnull(@iid_basprc,0),		isnull(@iid_basprc_bef,0),
		isnull(@iid_bomprc,0),		isnull(@iid_bomprc_bef,0),
		isnull(@iid_curr_bef,''),	@iid_assconftr,	@iid_assconftr_bef,
		@iid_period,		@iid_period_bef,	@iid_cstexpdat,
		@iid_cstexpdat_bef,	@iid_cus1no,
		-- David Yue	2012-09-14	Packing Inner Size, Master Size, Material
		isnull(@iid_inrsze,''),		isnull(@iid_mtrsze,''),		isnull(@iid_mat,''),
		isnull(@iid_inrsze_bef,''),	isnull(@iid_mtrsze_bef,''),	isnull(@iid_mat_bef,''),
		-- David Yue	2012-09-14	Item Factory Temp Flag, Alias Temp Item
		isnull(@iid_ftytmp,''),		isnull(@iid_ftytmp_bef,''),
		isnull(@iid_alstmpitmno,''),	isnull(@iid_alstmpitmno_bef,'')
	)

	delete from IMITMDAT
	where	iid_venno = @iid_venno and
		iid_venitm = @iid_venitm and
		iid_itmseq = @iid_itmseq and
		iid_recseq = @iid_recseq

---------------------------------------------------------------------
	
	set @iid_alsitmno = ltrim(rtrim(isnull(@iid_alsitmno ,'')))
	set @iid_alscolcde = ltrim(rtrim(isnull(@iid_alscolcde,'')))

	if isnull(@iid_alsitmno,'') <> '' 
	begin
		if (select count(*) from IMBASINF (nolock) where ibi_itmno = @iid_alsitmno) > 0
		begin
			update	IMBASINF 
			set	ibi_itmsts = 'OLD' , 
				ibi_upddat = getdate(), 
				ibi_updusr = 'EXCEL' , 
				ibi_chndsc = isnull(ibi_chndsc,'') + case when len(isnull(ibi_chndsc,'')) > 0 then
						char(13) + char(10) else '' end + '(refer to ' + @iid_venitm + ')'
			where 	ibi_itmno = @iid_alsitmno and 
				ibi_itmsts <> 'OLD'
		end
		else
		begin
			update	IMBASINF
			set	ibi_rmk = isnull(ibi_rmk,'') + case when len(isnull(ibi_rmk,'')) > 0 then
						char(13) + char(10) else '' end + '(Alias Item: ' + @iid_alsitmno +
						char(13) + char(10) + 'Alias Color: ' + @iid_alscolcde +  ')', 
				ibi_alsitmno = '',
				ibi_alscolcde = '', 
				ibi_upddat = getdate(),
				ibi_updusr = 'EXCEL' 
			where	ibi_itmno = @iid_venitm
		end
	end -- if isnull(@iid_alsitmno,'') <> ''

	set @venitm = @iid_venitm

FETCH NEXT from cur_IMITMDAT INTO 
@iid_cocde,		@iid_venno,		@iid_venitm,
@iid_itmseq,		@iid_recseq,		@iid_mode,
@iid_itmsts,		@iid_stage,		@iid_engdsc,
@iid_chndsc,		@iid_lnecde,		@iid_catlvl4,
@iid_untcde,		@iid_inrqty,		@iid_mtrqty,
@iid_inrlcm,		@iid_inrwcm,		@iid_inrhcm,
@iid_mtrlcm,		@iid_mtrwcm,		@iid_mtrhcm,
@iid_cft,		@iid_conftr,		@iid_curcde,
@iid_ftycst,		@iid_ftyprc,		@iid_ftyprctrm,
@iid_prctrm,		@iid_trantrm,
@iid_grswgt,		@iid_netwgt,		@iid_pckitr,
@iid_engdsc_bef,	@iid_chndsc_bef,	@iid_lnecde_bef,
@iid_catlvl4_bef,	@iid_inrlcm_bef,	@iid_inrwcm_bef,
@iid_inrhcm_bef,	@iid_mtrlcm_bef,	@iid_mtrwcm_bef,
@iid_mtrhcm_bef,	@iid_cft_bef,		@iid_conftr_bef,
@iid_curcde_bef,	@iid_ftycst_bef,	@iid_ftyprc_bef,
@iid_grswgt_bef,	@iid_netwgt_bef,
@iid_pckitr_bef,	@iid_creusr,		@iid_updusr,
@iid_credat,		@iid_upddat,		@iid_itmno,
@iid_sysmsg,		@iid_xlsfil,		@iid_chkdat,
@iid_veneml,		@iid_malsts,		@iid_prdven,
@iid_bomflg,		@iid_orgdsgvenno,	@iid_moq,
@iid_fcurcde,		@iid_wastage,		@iid_wastage_bef,
@iid_remark,		@iid_remark_bef,	@iid_cusven,
@iid_itmtyp,		@iid_alsitmno,		@iid_alsitmno_bef,
@iid_alscolcde,		@iid_alscolcde_bef,	@iid_basprc,
@iid_basprc_bef,	@iid_bomprc,		@iid_bomprc_bef,
@iid_curr_bef,		@iid_assconftr_bef,	@iid_assconftr,
@iid_period,		@iid_period_bef,	@iid_cstexpdat,
@iid_cstexpdat_bef,	@iid_cus1no,
-- David Yue	2012-09-14	Add Packing Inner Size, Master Size, Material
@iid_inrsze,		@iid_mtrsze,		@iid_mat,
@iid_inrsze_bef,	@iid_mtrsze_bef,	@iid_mat_bef,
-- David Yue	2012-09-14	Add Item Factory Temp Flag, Alias Temp Item
@iid_ftytmp,		@iid_ftytmp_bef,
@iid_alstmpitmno,	@iid_alstmpitmno_bef,	@iid_sapum
END -- FETCH cur_IMITMDAT
CLOSE cur_IMITMDAT
DEALLOCATE cur_IMITMDAT

set nocount off


































GO
GRANT EXECUTE ON [dbo].[sp_IMINSDAT] TO [ERPUSER] AS [dbo]
GO
