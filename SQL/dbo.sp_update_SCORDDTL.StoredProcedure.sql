/****** Object:  StoredProcedure [dbo].[sp_update_SCORDDTL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SCORDDTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SCORDDTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_update_SCORDDTL]

@sod_cocde	nvarchar(6),	@sod_ordno	nvarchar(20),	@sod_ordseq	int,	
@sod_venno	nvarchar(6),	@sod_fcurcde	nvarchar(6),	@sod_ftycst	numeric(13,4),
@sod_ftyprc	numeric(13,4),	@sod_updpo	nvarchar(1),	@sod_chgfty	nvarchar(1),
@sod_itmno	nvarchar(20),	@sod_itmtyp	nvarchar(4),	@sod_itmdsc	nvarchar(800),
@sod_colcde	nvarchar(30),	@sod_cuscol	nvarchar(30),	@sod_coldsc	nvarchar(300),
@sod_qutno 	nvarchar(20),	@sod_refdat	datetime,	@sod_cusitm	nvarchar(20),
@sod_cussku	nvarchar(20),	@sod_resppo	nvarchar(20),	@sod_cuspo	nvarchar(20),
@sod_ordqty	int,		@sod_discnt	numeric(6,3),	@sod_oneprc	nvarchar(1),
@sod_untprc	numeric(13,4),	@sod_selprc	numeric(13,4),	@sod_hrmcde	nvarchar(12),
@sod_dtyrat	numeric(6,3),	@sod_dept	nvarchar(20),	@sod_typcode	nvarchar(1),	
@sod_code1	nvarchar(25),	@sod_code2	nvarchar(25),	@sod_code3	nvarchar(25),
@sod_cususdcur	nvarchar(6),	@sod_cususd	numeric(13,4),	@sod_cuscadcur	nvarchar(6),
@sod_cuscad	numeric(13,4),	@sod_inrdin	numeric(11,4),	@sod_inrwin	numeric(11,4),
@sod_inrhin	numeric(11,4),	@sod_mtrdin	numeric(11,4),	@sod_mtrwin	numeric(11,4),
@sod_mtrhin	numeric(11,4),	@sod_inrdcm	numeric(11,4),	@sod_inrwcm	numeric(11,4),
@sod_inrhcm	numeric(11,4),	@sod_mtrdcm	numeric(11,4),	@sod_mtrwcm	numeric(11,4),
@sod_mtrhcm	numeric(11,4),	@sod_shpstr	datetime,	@sod_shpend	datetime,
@sod_candat	datetime,	@sod_posstr	datetime,	@sod_posend	datetime,
@sod_poscan	datetime,	@sod_ctnstr	int,		@sod_ctnend	int,
@sod_ttlctn	int,		@sod_rmk 	nvarchar(600),	@sod_pormk	nvarchar(600),	
@cis_cusno	nvarchar(6),	@cis_seccus	nvarchar(6),	@sod_pckunt	nvarchar(6),	
@sod_inrctn	int,		@sod_mtrctn	int,		@sod_cft	numeric(11,4),
@sod_cbm	numeric(11,4),	@sod_curcde	nvarchar(6),	@sod_subcde	nvarchar(10),
@sod_ftyunt	nvarchar(6),	@sod_venitm	nvarchar(20),	@sod_itmprc	numeric(13,4),	
@sod_basprc	numeric(13, 4),	@sod_pckitr	nvarchar(600),	@sod_clmno	nvarchar(60),
@sod_moq	int,		@sod_moa	numeric(11,4),	@sod_apprve	nvarchar(1),
@status		nvarchar(6),	@closeout	nvarchar(1),	@replace	nvarchar(1),
@sod_cusven	varchar(6),	@sod_cussub	varchar(10),	@sod_pjobno	varchar(20),
@sod_seccusitm	varchar(20),	@sod_orgmoqchg	numeric(6,3),	@sod_moqchg	numeric(6,3),
@sod_netuntprc	numeric(13,4),	@sod_bomcst	numeric(13,4),	@sod_ztnvbeln	nvarchar(10),	
@sod_ztnposnr	nvarchar(6),	@sod_zorvbeln	nvarchar(10),	@sod_zorposnr	nvarchar(6),	
@sod_conftr	numeric(9),	@sod_contopc	nvarchar(1),	@sod_pcprc	numeric(13,4),	
@sod_custum	nvarchar(6),	@sod_dv		nvarchar(50),	@sod_dvftycst	numeric(13,4),	
@sod_dvftyprc	numeric(13,4),	@sod_dvbomcst	numeric(13,4),	@sod_dvfcurcde	nvarchar(6),	
@sod_dvftyunt	nvarchar(6),	@sod_tradeven	nvarchar(6),	@sod_examven	nvarchar(6),	
@sod_cusstyno	nvarchar(30),	@sod_moqunttyp	nvarchar(6),	@sod_qutdat	datetime,	
@sod_dvitmcst	numeric(13,4),	@sod_itmcstcur	nvarchar(6),	@sod_imqutdat	datetime,	
@sod_prcgrp	nvarchar(30),	@sod_cus1no	nvarchar(6),	@sod_cus2no	nvarchar(6),	
@sod_hkprctrm	nvarchar(10),	@sod_ftyprctrm	nvarchar(10),	@sod_trantrm	nvarchar(10),	
@sod_effdat	datetime,	@sod_expdat	datetime,	@sod_toordno	nvarchar(30),	
@sod_toordseq	int,		@old_toordno	nvarchar(30),	@old_toordseq	int,	
@old_ordqty	int,		@sod_year	nvarchar(6), 	@sod_season	nvarchar(50),	
@sod_effcpo	nvarchar(1),	@markup	numeric(13,4),	@mumin	numeric(13,4),
@mrkprc	numeric(13,4),	@muminprc	numeric(13,4),	@commsn	numeric(13,4),
@itmcom	numeric(13,4),	@pckcst	numeric(13,4),	@stdprc	numeric(13,4),
@sod_name_f1 nvarchar(150),
@sod_dsc_f1 nvarchar(150),
@sod_name_f2 nvarchar(150),
@sod_dsc_f2 nvarchar(150),
@sod_name_f3 nvarchar(150),
@sod_dsc_f3 nvarchar(150),
@sod_moqmoaflg char(1),
@sod_onetimeflg char(1),
@sod_belprcflg char(1),
@sod_chgftycstflg char(1),
@sod_chguntprcflg char(1),
@sod_untprc_org numeric(13,4),
@sod_itmchidsc nvarchar(800),
@sod_dtlttlctn int,
@creusr		nvarchar(30)


AS

declare @cid_seqno int
declare @ItmVenTyp char(1)

-- *** Data for insert CUITMPRCDTL Start *** --
declare @seq_num_cuitmprcdtl as int
declare @cis_credat as datetime set @cis_credat = getdate()
declare @cis_cussna as nvarchar(20)
declare @cis_secsna as nvarchar(20)
declare @sod_tirtyp as char(1)
declare @tmp as int
declare @soh_verno as int
declare @flg_cuitmprcdtl as char(1)
-- *** Data for insert CUITMPRCDTL End *** --

BEGIN

--- Get Customer Name For Primary and Secondary ---
if @cis_cusno <> ''
	select @cis_cussna = cbi_cussna from CUBASINF where cbi_cusno = @cis_cusno
	
if @cis_seccus <> ''
	select @cis_secsna = cbi_cussna from CUBASINF where cbi_cusno = @cis_seccus

---Get Data for CUITMPRCDTL ---
select @sod_tirtyp = sod_tirtyp 
from SCORDDTL 
where
	sod_cocde = @sod_cocde	and
	sod_ordno = @sod_ordno	and
	sod_ordseq = @sod_ordseq
	
--Get SC version no
select @soh_verno = soh_verno from SCORDHDR where soh_cocde = @sod_cocde and soh_ordno = @sod_ordno


update	SCORDDTL
set	sod_updpo = @sod_updpo,
	sod_chgfty = @sod_chgfty,
	sod_itmno = @sod_itmno,
	sod_itmtyp = @sod_itmtyp,
	sod_itmdsc = rtrim(ltrim(@sod_itmdsc)),
	sod_colcde = @sod_colcde,
	sod_cuscol = rtrim(ltrim(@sod_cuscol)),
	sod_coldsc = rtrim(ltrim(@sod_coldsc)),
	sod_cft = @sod_cft,
	sod_cbm = @sod_cbm,
	sod_cusitm = rtrim(ltrim(@sod_cusitm)),
	sod_cussku = @sod_cussku,
	sod_resppo = @sod_resppo,
	sod_cuspo = @sod_cuspo,
	sod_ordqty = @sod_ordqty,
	sod_discnt = @sod_discnt,
	sod_oneprc = @sod_oneprc,
	sod_curcde = @sod_curcde,
	sod_untprc = @sod_untprc,
	sod_selprc = @sod_selprc,
	sod_hrmcde = @sod_hrmcde,
	sod_dtyrat = @sod_dtyrat,
	sod_dept = @sod_dept,
	sod_typcode = @sod_typcode,
	sod_code1 = @sod_code1,
	sod_code2 = @sod_code2,
	sod_code3 = @sod_code3,
	sod_cususdcur = @sod_cususdcur,
	sod_cususd = @sod_cususd,
	sod_cuscadcur = @sod_cuscadcur,
	sod_cuscad = @sod_cuscad,
	sod_inrdin = @sod_inrdin,
	sod_inrwin = @sod_inrwin,
	sod_inrhin = @sod_inrhin,
	sod_mtrdin = @sod_mtrdin,
	sod_mtrwin = @sod_mtrwin,
	sod_mtrhin = @sod_mtrhin,
	sod_inrdcm = @sod_inrdcm,
	sod_inrwcm = @sod_inrwcm,
	sod_inrhcm = @sod_inrhcm,
	sod_mtrdcm = @sod_mtrdcm,
	sod_mtrwcm = @sod_mtrwcm,
	sod_mtrhcm = @sod_mtrhcm,
	sod_shpstr = @sod_shpstr,
	sod_shpend = @sod_shpend,
	sod_candat = @sod_candat,
	sod_posstr = @sod_posstr,
	sod_posend = @sod_posend,
	sod_poscan = @sod_poscan,
	sod_ctnstr = @sod_ctnstr,
	sod_ctnend = @sod_ctnend,
	sod_ttlctn = @sod_ttlctn,
	sod_rmk = @sod_rmk,
	sod_pormk = @sod_pormk,
	sod_subcde = @sod_subcde,
	sod_ftyunt = @sod_ftyunt,
	sod_venitm= @sod_venitm,
	sod_itmprc = @sod_itmprc,
	sod_basprc = @sod_basprc,
	sod_pckitr = @sod_pckitr,
	sod_clmno = @sod_clmno,
	sod_moq = @sod_moq,
	sod_moa = @sod_moa,
	sod_apprve = @sod_apprve,
	sod_updusr = @creusr,
	sod_upddat = getdate(),
	sod_orgmoqchg  = @sod_orgmoqchg,
	sod_moqchg  = @sod_moqchg, 
	sod_netuntprc  = @sod_netuntprc,  
	sod_bomcst = @sod_bomcst,
	sod_cussub  = @sod_cussub,
	sod_pjobno  = @sod_pjobno,
	sod_seccusitm  = @sod_seccusitm,
	sod_ztnvbeln = @sod_ztnvbeln,
	sod_ztnposnr  = @sod_ztnposnr,
	sod_conftr = @sod_conftr,
	sod_contopc =  @sod_contopc,
	sod_pcprc = @sod_pcprc,
	sod_custum = @sod_custum,
	sod_prcgrp = @sod_prcgrp,
	sod_cus1no = @sod_cus1no,
	sod_cus2no = @sod_cus2no,
	sod_hkprctrm = @sod_hkprctrm,
	sod_ftyprctrm = @sod_ftyprctrm,
	sod_trantrm = @sod_trantrm,
	sod_effdat = @sod_effdat,
	sod_expdat = @sod_expdat,
	sod_qutdat = @sod_qutdat,
	sod_imqutdat = @sod_imqutdat,
	sod_dv = @sod_dv,
	sod_dvftycst = @sod_dvftycst,
	sod_dvftyprc = @sod_dvftyprc,
	sod_dvbomcst = @sod_dvbomcst,
	sod_dvfcurcde = @sod_dvfcurcde,
	sod_dvftyunt = @sod_dvftyunt,
	sod_venno = @sod_venno,
	sod_fcurcde = @sod_fcurcde,
	sod_ftycst = @sod_ftycst,
	sod_ftyprc = @sod_ftyprc,
	sod_cusven  = @sod_cusven,
	sod_tradeven = @sod_tradeven,
	sod_examven = @sod_examven,
	sod_cusstyno = @sod_cusstyno,
	sod_moqunttyp = @sod_moqunttyp,
	sod_itmcstcur = @sod_itmcstcur,
	sod_dvitmcst = @sod_dvitmcst,
	sod_tordno = @sod_toordno,
	sod_tordseq = @sod_toordseq,
	sod_year = @sod_year,
	sod_season = @sod_season,
	sod_effcpo = @sod_effcpo,
	sod_markup = @markup,
	sod_mumin = @mumin,
	sod_mrkprc = @mrkprc,
	sod_muminprc = @muminprc,
	sod_commsn = @commsn,
	sod_itmcom = @itmcom,
	sod_pckcst = @pckcst,
	sod_stdprc = @stdprc,
	sod_name_f1 = @sod_name_f1,
	sod_dsc_f1 = @sod_dsc_f1,
	sod_name_f2 = @sod_name_f2,
	sod_dsc_f2 = @sod_dsc_f2,
	sod_name_f3 = @sod_name_f3,
	sod_dsc_f3 = @sod_dsc_f3,
	sod_moqmoaflg = @sod_moqmoaflg,
	sod_onetimeflg = @sod_onetimeflg,
	sod_belprcflg = @sod_belprcflg,
	sod_chgftycstflg = @sod_chgftycstflg,
	sod_chguntprcflg = @sod_chguntprcflg,
	sod_untprc_org = @sod_untprc_org,
	sod_scupdusr = @creusr,
	sod_itmchidsc = @sod_itmchidsc,
	sod_dtlttlctn = @sod_dtlttlctn
where	sod_cocde = @sod_cocde	and
	sod_ordno = @sod_ordno	and
	sod_ordseq = @sod_ordseq

-- Check if TO Matching update is required


if @old_toordno <> @sod_toordno or @old_toordseq <> @sod_toordseq or @old_ordqty <> @sod_ordqty
begin
	if (select count(*) from TOORDHDR (nolock) where toh_toordno = @sod_toordno and toh_ordsts <> 'CLO') > 0
	begin
		if @old_toordno = ''
		begin
			-- Update TO Matching
			update	TOITMDTL
			set	tid_ordno = @sod_ordno,
				tid_ordseq = @sod_ordseq,
				tid_soqty = tid_soqty + @sod_ordqty,
				tid_osqty = tid_toqty - tid_soqty - @sod_ordqty,
				tid_updusr = left(@creusr, 30),
				tid_upddat = getdate()
			where	tid_toordno = @sod_toordno and
				tid_toordseq = @sod_toordseq
	
			update	TOITMSUM
			set	tis_soqty = tid_soqty,
				tis_osqty = tis_toqty - tid_soqty
			from	TOITMSUM
				join TOITMDTL (nolock) on
					tid_cocde = tis_cocde and
					tid_cus1no = tis_cus1no and
					tid_cus2no = tis_cus2no and
					tid_year = tis_year and
					tid_itmtyp = tis_itmtyp and
					tid_assitm = tis_assitm and
					tid_itmno = tis_itmno and
					tid_tmpitmno = tis_tmpitmno and
					tid_venno = tis_venno and
					tid_venitmno = tis_ventimno and
					tid_pckunt = tis_pckunt
			where	tid_toordno = @sod_toordno and
				tid_toordseq = @sod_toordseq
		end
		else if @old_toordno <> @sod_toordno or @old_toordseq <> @sod_ordseq
		begin
			-- Remove old TO Matching
			update	TOITMDTL
			set	tid_ordno = '',
				tid_ordseq = 0,
				tid_soqty = tid_soqty - @old_ordqty,
				tid_osqty = tid_toqty - tid_soqty + @old_ordqty,
				tid_updusr = left(@creusr, 30),
				tid_upddat = getdate()
			where	tid_toordno = @old_toordno and
				tid_toordseq = @old_toordseq
			
			update	TOITMSUM
			set	tis_soqty = tid_soqty,
				tis_osqty = tis_toqty - tid_soqty
			from	TOITMSUM
				join TOITMDTL (nolock) on
					tid_cocde = tis_cocde and
					tid_cus1no = tis_cus1no and
					tid_cus2no = tis_cus2no and
					tid_year = tis_year and
					tid_itmtyp = tis_itmtyp and
					tid_assitm = tis_assitm and
					tid_itmno = tis_itmno and
					tid_tmpitmno = tis_tmpitmno and
					tid_venno = tis_venno and
					tid_venitmno = tis_ventimno and
					tid_pckunt = tis_pckunt
			where	tid_toordno = @old_toordno and
				tid_toordseq = @old_toordseq
	
			-- Update new TO Matching
			update	TOITMDTL
			set	tid_ordno = @sod_ordno,
				tid_ordseq = @sod_ordseq,
				tid_soqty = tid_soqty + @sod_ordqty,
				tid_osqty = tid_toqty - tid_soqty - @sod_ordqty,
				tid_updusr = left(@creusr, 30),
				tid_upddat = getdate()
			where	tid_toordno = @sod_toordno and
				tid_toordseq = @sod_toordseq
	
			update	TOITMSUM
			set	tis_soqty = tid_soqty,
				tis_osqty = tis_toqty - tid_soqty
			from	TOITMSUM
				join TOITMDTL (nolock) on
					tid_cocde = tis_cocde and
					tid_cus1no = tis_cus1no and
					tid_cus2no = tis_cus2no and
					tid_year = tis_year and
					tid_itmtyp = tis_itmtyp and
					tid_assitm = tis_assitm and
					tid_itmno = tis_itmno and
					tid_tmpitmno = tis_tmpitmno and
					tid_venno = tis_venno and
					tid_venitmno = tis_ventimno and
					tid_pckunt = tis_pckunt
			where	tid_toordno = @sod_toordno and
				tid_toordseq = @sod_toordseq
		end
		else if @old_ordqty <> @sod_ordqty
		begin
			-- Update new TO Matching
			update	TOITMDTL
			set	tid_ordno = @sod_ordno,
				tid_ordseq = @sod_ordseq,
				tid_soqty = tid_soqty + (@sod_ordqty - @old_ordqty),
				tid_osqty = tid_toqty - tid_soqty - (@sod_ordqty - @old_ordqty),
				tid_updusr = left(@creusr, 30),
				tid_upddat = getdate()
			where	tid_toordno = @sod_toordno and
				tid_toordseq = @sod_toordseq
	
			update	TOITMSUM
			set	tis_soqty = tid_soqty,
				tis_osqty = tis_toqty - tid_soqty
			from	TOITMSUM
				join TOITMDTL (nolock) on
					tid_cocde = tis_cocde and
					tid_cus1no = tis_cus1no and
					tid_cus2no = tis_cus2no and
					tid_year = tis_year and
					tid_itmtyp = tis_itmtyp and
					tid_assitm = tis_assitm and
					tid_itmno = tis_itmno and
					tid_tmpitmno = tis_tmpitmno and
					tid_venno = tis_venno and
					tid_venitmno = tis_ventimno and
					tid_pckunt = tis_pckunt
			where	tid_toordno = @sod_toordno and
				tid_toordseq = @sod_toordseq
		end
	end
end


--- Get Item Vendor Type ---
select	@itmventyp = isnull(vbi_ventyp,'')
from	IMBASINF (nolock)
	left join VNBASINF (nolock) on
		vbi_venno = ibi_venno
where	ibi_itmno = @sod_itmno
/*
set @Itmventyp = isnull(        (	select	VBI_VENTYP	 
			from	IMBASINF (NOLOCK) 
			left join	VNBASINF (NOLOCK) on VBI_VENNO = IBI_VENNO
			where	IBI_ITMNO = @sod_itmno	and
				VBI_VENTYP IS NOT NULL),' ')
*/

-- Insert into Customer Item History Summary Information
if @sod_oneprc = 'N' and (@status = 'ACT' or @sod_apprve <> 'W') and @closeout ='N' and @replace ='N'
begin
	if @sod_oneprc = 'N' and (@status = 'ACT' or @sod_apprve <> 'W')
	begin
		if @cis_seccus <> '' 
		begin
		
			
			if (	select	count(*)
				from	CUITMHIS (nolock)
				where	cis_cusno in (	select	cbi_cusno
							from	CUBASINF (nolock)
							where	cbi_cusno = @cis_cusno or
								cbi_cusali = @cis_cusno
							UNION
							select	cbi_cusali
							from	CUBASINF (nolock)
							where	cbi_cusno = @cis_cusno)	and
					cis_seccus in (	select	cbi_cusno
							from	CUBASINF (nolock)
							where	(cbi_cusali = @cis_seccus or
								 cbi_cusno = @cis_seccus) and
								cbi_cusno <> ''
							UNION
							select	cbi_cusali
							from	CUBASINF (nolock)
							where	cbi_cusno = @cis_seccus and
								cbi_cusali  <> '') and
					cis_itmno in (	select	ibi.ibi_itmno
							from	IMBASINF ibi (nolock)
								left join imbasinf als on ibi.ibi_alsitmno = als.ibi_itmno 
							where	ibi.ibi_itmno = @sod_itmno or
								(ibi.ibi_alsitmno = @sod_itmno and
								 isnull(als.ibi_itmsts,'') <> 'OLD')
							UNION
							select	ibi.ibi_alsitmno
							from	imbasinf ibi
							left join	imbasinf als on ibi.ibi_alsitmno = als.ibi_itmno 
							where	ibi.ibi_itmno = @sod_itmno	and
								isnull(als.ibi_itmsts,'') <> 'OLD') and
					cis_colcde = @sod_colcde and
					cis_untcde = @sod_pckunt and
					cis_inrqty = @sod_inrctn and
					cis_mtrqty = @sod_mtrctn and
					--cis_conftr = @sod_conftr and
					cis_hkprctrm = @sod_hkprctrm and
					cis_ftyprctrm = @sod_ftyprctrm and
					cis_trantrm = @sod_trantrm and
					cis_venno = @sod_dv
			) > 0
			begin
				update	CUITMHIS
				set	cis_itmno = @sod_itmno,
					cis_itmdsc = @sod_itmdsc,
				 	cis_cusitm = @sod_cusitm,
					cis_coldsc = @sod_coldsc,
					cis_cuscol = @sod_cuscol,
					cis_cft = @sod_cft,
					cis_cbm = @sod_cbm,
					cis_prdven = @sod_venno,
					cis_cusven = @sod_cusven,
					cis_tradeven = @sod_tradeven,
					cis_examven = @sod_examven,
					cis_refdoc = @sod_ordno,
					cis_docdat  = getdate(),
					cis_cussku = @sod_cussku,
					cis_ordqty = @sod_ordqty,
					cis_moqchg = @sod_moqchg,
					cis_hrmcde = @sod_hrmcde,
					cis_dtyrat = @sod_dtyrat,
					cis_dept = @sod_dept,
					cis_typcode = @sod_typcode,
					cis_code1  = @sod_code1,
					cis_code2  = @sod_code2,
					cis_code3  = @sod_code3,
					cis_cususdcur = @sod_cususdcur,
					cis_cususd = @sod_cususd,
					cis_cuscadcur = @sod_cuscadcur,
					cis_cuscad = @sod_cuscad,
					cis_inrdin = @sod_inrdin,
					cis_inrwin = @sod_inrwin,
					cis_inrhin = @sod_inrhin,
				 	cis_mtrdin = @sod_mtrdin,
					cis_mtrwin = @sod_mtrwin,
					cis_mtrhin = @sod_mtrhin,
					cis_inrdcm = @sod_inrdcm,
					cis_inrwcm = @sod_inrwcm,
					cis_inrhcm = @sod_inrhcm,
					cis_mtrdcm = @sod_mtrdcm,
					cis_mtrwcm = @sod_mtrwcm,
					cis_mtrhcm = @sod_mtrhcm,
					cis_pckitr = @sod_pckitr,
					cis_itmventyp = @itmventyp,
					cis_ftytmpitm = '',
					cis_cusstyno = @sod_cusstyno,
					cis_year = @sod_year,
					cis_season = @sod_season,
					cis_name_f1 = @sod_name_f1,
					cis_dsc_f1 = @sod_dsc_f1,
					cis_name_f2 = @sod_name_f2,
					cis_dsc_f2 = @sod_dsc_f2,
					cis_name_f3 = @sod_name_f3,
					cis_dsc_f3 = @sod_dsc_f3,
					cis_itmchidsc = @sod_itmchidsc,
					cis_dtlttlctn = @sod_dtlttlctn,
					cis_updusr = @creusr,
					cis_upddat = getdate()	
				where	cis_cusno in (	select	cbi_cusno
							from	CUBASINF (nolock)
							where	cbi_cusno = @cis_cusno or
								cbi_cusali = @cis_cusno
							UNION
							select	cbi_cusali
							from	CUBASINF (nolock)
							where	cbi_cusno = @cis_cusno)	and
					cis_seccus in (	select	cbi_cusno
							from	CUBASINF (nolock)
							where	(cbi_cusali = @cis_seccus or
								 cbi_cusno = @cis_seccus) and
								cbi_cusno <> ''
							UNION
							select	cbi_cusali
							from	CUBASINF (nolock)
							where	cbi_cusno = @cis_seccus and
								cbi_cusali  <> '') and
					cis_itmno in (	select	ibi.ibi_itmno
							from	IMBASINF ibi (nolock)
								left join imbasinf als on ibi.ibi_alsitmno = als.ibi_itmno 
							where	ibi.ibi_itmno = @sod_itmno or
								(ibi.ibi_alsitmno = @sod_itmno and
								 isnull(als.ibi_itmsts,'') <> 'OLD')
							UNION
							select	ibi.ibi_alsitmno
							from	imbasinf ibi
							left join	imbasinf als on ibi.ibi_alsitmno = als.ibi_itmno 
							where	ibi.ibi_itmno = @sod_itmno	and
								isnull(als.ibi_itmsts,'') <> 'OLD') and
					cis_colcde = @sod_colcde and
					cis_untcde = @sod_pckunt and
					cis_inrqty = @sod_inrctn and
					cis_mtrqty = @sod_mtrctn and
					--cis_conftr = @sod_conftr and
					cis_hkprctrm = @sod_hkprctrm and
					cis_ftyprctrm = @sod_ftyprctrm and
					cis_trantrm = @sod_trantrm and
					cis_venno = @sod_dv
				
			end
			

		end
		else
		begin
			
			if (	select	count(*)
				from	CUITMHIS (nolock)
				where	cis_cusno in (	select	cbi_cusno
							from	CUBASINF (nolock)
							where	cbi_cusno = @cis_cusno or
								cbi_cusali = @cis_cusno
							UNION
							select	cbi_cusali
							from	CUBASINF (nolock)
							where	cbi_cusno = @cis_cusno)	and
					cis_seccus = @cis_seccus and
					cis_itmno in (	select	ibi.ibi_itmno
							from	IMBASINF ibi (nolock)
								left join imbasinf als on ibi.ibi_alsitmno = als.ibi_itmno 
							where	ibi.ibi_itmno = @sod_itmno or
								(ibi.ibi_alsitmno = @sod_itmno and
								 isnull(als.ibi_itmsts,'') <> 'OLD')
							UNION
							select	ibi.ibi_alsitmno
							from	imbasinf ibi
							left join	imbasinf als on ibi.ibi_alsitmno = als.ibi_itmno 
							where	ibi.ibi_itmno = @sod_itmno	and
								isnull(als.ibi_itmsts,'') <> 'OLD') and
					cis_colcde = @sod_colcde and
					cis_untcde = @sod_pckunt and
					cis_inrqty = @sod_inrctn and
					cis_mtrqty = @sod_mtrctn and
					--cis_conftr = @sod_conftr and
					cis_hkprctrm = @sod_hkprctrm and
					cis_ftyprctrm = @sod_ftyprctrm and
					cis_trantrm = @sod_trantrm and
					cis_venno = @sod_dv
			) > 0
			begin
				update	CUITMHIS
				set	cis_itmno = @sod_itmno,
					cis_itmdsc = @sod_itmdsc,
				 	cis_cusitm = @sod_cusitm,
					cis_coldsc = @sod_coldsc,
					cis_cuscol = @sod_cuscol,
					cis_cft = @sod_cft,
					cis_cbm = @sod_cbm,
					cis_prdven = @sod_venno,
					cis_cusven = @sod_cusven,
					cis_tradeven = @sod_tradeven,
					cis_examven = @sod_examven,
					cis_refdoc = @sod_ordno,
					cis_docdat  = getdate(),
					cis_cussku = @sod_cussku,
					cis_ordqty = @sod_ordqty,
					cis_moqchg = @sod_moqchg,
					cis_hrmcde = @sod_hrmcde,
					cis_dtyrat = @sod_dtyrat,
					cis_dept = @sod_dept,
					cis_typcode = @sod_typcode,
					cis_code1  = @sod_code1,
					cis_code2  = @sod_code2,
					cis_code3  = @sod_code3,
					cis_cususdcur = @sod_cususdcur,
					cis_cususd = @sod_cususd,
					cis_cuscadcur = @sod_cuscadcur,
					cis_cuscad = @sod_cuscad,
					cis_inrdin = @sod_inrdin,
					cis_inrwin = @sod_inrwin,
					cis_inrhin = @sod_inrhin,
				 	cis_mtrdin = @sod_mtrdin,
					cis_mtrwin = @sod_mtrwin,
					cis_mtrhin = @sod_mtrhin,
					cis_inrdcm = @sod_inrdcm,
					cis_inrwcm = @sod_inrwcm,
					cis_inrhcm = @sod_inrhcm,
					cis_mtrdcm = @sod_mtrdcm,
					cis_mtrwcm = @sod_mtrwcm,
					cis_mtrhcm = @sod_mtrhcm,
					cis_pckitr = @sod_pckitr,
					cis_itmventyp = @itmventyp,
					cis_ftytmpitm = '',
					cis_cusstyno = @sod_cusstyno,
					cis_year = @sod_year,
					cis_season = @sod_season,
					cis_name_f1 = @sod_name_f1,
					cis_dsc_f1 = @sod_dsc_f1,
					cis_name_f2 = @sod_name_f2,
					cis_dsc_f2 = @sod_dsc_f2,
					cis_name_f3 = @sod_name_f3,
					cis_dsc_f3 = @sod_dsc_f3,
					cis_itmchidsc = @sod_itmchidsc,
					cis_dtlttlctn = @sod_dtlttlctn,
					cis_updusr = @creusr,
					cis_upddat = getdate()	
				where	cis_cusno in (	select	cbi_cusno
							from	CUBASINF (nolock)
							where	cbi_cusno = @cis_cusno or
								cbi_cusali = @cis_cusno
							UNION
							select	cbi_cusali
							from	CUBASINF (nolock)
							where	cbi_cusno = @cis_cusno)	and
					cis_seccus = @cis_seccus and
					cis_itmno in (	select	ibi.ibi_itmno
							from	IMBASINF ibi (nolock)
								left join imbasinf als on ibi.ibi_alsitmno = als.ibi_itmno 
							where	ibi.ibi_itmno = @sod_itmno or
								(ibi.ibi_alsitmno = @sod_itmno and
								 isnull(als.ibi_itmsts,'') <> 'OLD')
							UNION
							select	ibi.ibi_alsitmno
							from	imbasinf ibi
							left join	imbasinf als on ibi.ibi_alsitmno = als.ibi_itmno 
							where	ibi.ibi_itmno = @sod_itmno	and
								isnull(als.ibi_itmsts,'') <> 'OLD') and
					cis_colcde = @sod_colcde and
					cis_untcde = @sod_pckunt and
					cis_inrqty = @sod_inrctn and
					cis_mtrqty = @sod_mtrctn and
					--cis_conftr = @sod_conftr and
					cis_hkprctrm = @sod_hkprctrm and
					cis_ftyprctrm = @sod_ftyprctrm and
					cis_trantrm = @sod_trantrm and
					cis_venno = @sod_dv
				
			end
			
		end
		--orig place
			
	end
end

	if @soh_verno > 1 and @status = 'ACT' and @sod_apprve <> 'W' and @closeout = 'N' and @replace = 'N'
		set @flg_cuitmprcdtl = 'Y'
	else
		set @flg_cuitmprcdtl = 'N'
		
	if @flg_cuitmprcdtl = 'Y'
	begin
		Set  @seq_num_cuitmprcdtl = (	select	isnull(max(cid_seqnum),0) + 1
		from	CUITMPRCDTL
		where	
			cid_cusno = @cis_cusno and
			cid_seccus = @cis_seccus and
			cid_itmno = @sod_itmno and
			cid_colcde = @sod_colcde and
			cid_untcde = @sod_pckunt and
			cid_conftr = @sod_conftr and
			cid_inrqty = @sod_inrctn and
			cid_mtrqty = @sod_mtrctn and
			cid_hkprctrm = @sod_hkprctrm and
			cid_ftyprctrm = @sod_ftyprctrm and
			cid_trantrm = @sod_trantrm	
			)

			
		if @sod_apprve = ''
			set @sod_apprve = 'N'
		
		--Query about CUITMPRCDTL Start
		insert into CUITMPRCDTL(
			cid_cocde, cid_cusno, cid_seccus, cid_itmno,
			cid_colcde, cid_untcde, cid_conftr, cid_inrqty,
			cid_mtrqty, cid_hkprctrm, cid_ftyprctrm, cid_trantrm,
		
			cid_seqnum, cid_refdoc, cid_refseq, cid_docdat, cid_apvsts,
			--Data Part Start
			cis_cussna, cis_secsna,
			cis_itmdsc, cis_coldsc, cis_cuscol, cis_cussku, cid_cusitm, cid_cusstyno,
			cis_venno, cis_prdven, cis_cusven, cis_tradeven, cis_examven,
			
			cis_ordqty, cis_untprc, cis_oneprc, 
			cis_hrmcde, cis_dtyrat, cis_dept, cis_typcode,
			cis_code1, cis_code2, cis_code3,
			
			cis_cususdcur, cis_cususd, cis_cuscadcur, cis_cuscad,
			
			cis_inrdin, cis_inrwin, cis_inrhin, cis_mtrdin, cis_mtrwin, cis_mtrhin, 
			cis_inrdcm, cis_inrwcm, cis_inrhcm, cis_mtrdcm, cis_mtrwcm, cis_mtrhcm,
			cis_cft, cis_cbm ,cis_pckitr,
			
			cis_itmventyp, cis_tirtyp, cis_moqunttyp, cis_moq, cis_moacur, cis_moa,
			cis_year, cis_season,
			cis_contopc, cis_pcprc,cis_itmchidsc,cis_dtlttlctn,
			
			cid_effdat, cid_expdat, cid_cus1no, cid_cus2no,
			cip_fcurcde, cip_ftycst, cip_bomcst, cip_ftyprc,
			cip_curcde, cip_basprc, cip_markup, cip_mrkprc, 
			cip_pckcst, cip_commsn, cip_itmcom, cip_stdprc, 
			cip_mumin, cip_muminprc, cip_discnt,
			cip_qutdat,
			
			
			cid_mode,
			cid_scref, 
			cid_creusr, cid_updusr, cid_credat, cid_upddat
		)
		values(
			'', @cis_cusno, @cis_seccus, @sod_itmno,
			@sod_colcde, @sod_pckunt, @sod_conftr, @sod_inrctn,
			@sod_mtrctn, @sod_hkprctrm, @sod_ftyprctrm, @sod_trantrm,
			
			@seq_num_cuitmprcdtl, @sod_ordno, @sod_ordseq, getdate(), @sod_apprve, -- cid_docdat
			@cis_cussna, @cis_secsna,
			
			@sod_itmdsc, @sod_coldsc, @sod_cuscol, @sod_cussku, @sod_cusitm, @sod_cusstyno, 
			@sod_dv, @sod_venno, @sod_cusven, @sod_tradeven, @sod_examven,
			
			@sod_ordqty, @sod_untprc, @sod_oneprc,
			@sod_hrmcde, @sod_dtyrat, @sod_dept, @sod_typcode, 
			@sod_code1, @sod_code2, @sod_code3, 
			
			@sod_cususdcur, @sod_cususd, @sod_cuscadcur, @sod_cuscad,
			
			@sod_inrdin, @sod_inrwin, @sod_inrhin, @sod_mtrdin, @sod_mtrwin, @sod_mtrhin, 
			@sod_inrdcm, @sod_inrwcm, @sod_inrhcm, @sod_mtrdcm, @sod_mtrwcm, @sod_mtrhcm,
			@sod_cft, @sod_cbm, @sod_pckitr,
			
			@itmventyp, @sod_tirtyp, @sod_moqunttyp, @sod_moq, @sod_curcde, @sod_moa, 
			@sod_year, @sod_season,
			@sod_contopc, @sod_pcprc, @sod_itmchidsc, @sod_dtlttlctn,
			
			@sod_effdat, @sod_expdat, @sod_cus1no, @sod_cus2no,
			@sod_fcurcde, 0, @sod_bomcst, @sod_ftyprc, --@sod_ftycst
			@sod_curcde, @sod_basprc, @markup, @mrkprc, 
			@pckcst, @commsn, @itmcom, @stdprc, 
			@mumin, @muminprc, @sod_discnt, 
			@sod_qutdat,
			
			'SU',
			@sod_qutno, 
			@creusr, @creusr, @cis_credat, @cis_credat
			
		)
		--Query about CUITMPRCDTL End	
	END
	
END

GO
GRANT EXECUTE ON [dbo].[sp_update_SCORDDTL] TO [ERPUSER] AS [dbo]
GO
