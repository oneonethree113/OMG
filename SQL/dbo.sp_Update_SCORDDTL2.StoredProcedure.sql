/****** Object:  StoredProcedure [dbo].[sp_Update_SCORDDTL2]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_Update_SCORDDTL2]
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_SCORDDTL2]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO




/************************************************************************
Author:		Carlos Lui
Date:		05 Jul, 2012
Description:	Update data From SCORDDTL
Parameter:		1. Company
		2. SC No.	
************************************************************************
 Modification History                                    
=========================================================
 Date      		Initial  		Description                          
=========================================================

*/


CREATE procedure [dbo].[sp_Update_SCORDDTL2]
                                                                                                                                                                                                                                                                 
@sod_cocde nvarchar(6),	@sod_ordno nvarchar(20),	@sod_ordseq int,		
@sod_venno nvarchar(6),	@sod_fcurcde nvarchar(6),	@sod_ftycst numeric(13,4),
@sod_ftyprc numeric(13,4),	@sod_updpo nvarchar(1),	@sod_chgfty nvarchar(1),
@sod_itmno nvarchar(20),	@sod_itmtyp nvarchar(4),	@sod_itmdsc nvarchar(800),
@sod_colcde nvarchar(30),	@sod_cuscol nvarchar(30),	@sod_coldsc nvarchar(300),
@sod_qutno nvarchar(20),	@sod_refdat datetime,		@sod_cusitm nvarchar(20),
@sod_cussku nvarchar(20),	@sod_resppo nvarchar(20),	@sod_cuspo nvarchar(20),
@sod_ordqty int,		@sod_discnt numeric(6,3),	@sod_oneprc nvarchar(1),
@sod_untprc numeric(13,4),	@sod_selprc numeric(13,4),	@sod_hrmcde nvarchar(12),
@sod_dtyrat numeric(6,3),	@sod_dept nvarchar(20),	@sod_typcode nvarchar(1),	
@sod_code1 nvarchar(25),	@sod_code2 nvarchar(25),	@sod_code3 nvarchar(25),
@sod_cususd numeric(13,4),	@sod_cuscad numeric(13,4),	@sod_inrdin numeric(11,4),
@sod_inrwin numeric(11,4),	@sod_inrhin numeric(11,4),	@sod_mtrdin numeric(11,4),
@sod_mtrwin numeric(11,4),	@sod_mtrhin numeric(11,4),	@sod_inrdcm numeric(11,4),
@sod_inrwcm numeric(11,4),	@sod_inrhcm numeric(11,4),	@sod_mtrdcm numeric(11,4),
@sod_mtrwcm numeric(11,4),	@sod_mtrhcm numeric(11,4),	@sod_shpstr datetime,
@sod_shpend datetime,	@sod_candat datetime,		@sod_ctnstr int,
@sod_ctnend int,		@sod_ttlctn int,		@sod_rmk nvarchar(300),
@cusno nvarchar(6),		@sod_pckunt nvarchar(6),	@sod_inrctn int,
@sod_mtrctn int,		@sod_cft numeric(11,4),	@sod_cbm numeric(11,4),
@sod_curcde nvarchar(6),      	@sod_subcde nvarchar(10),	@sod_ftyunt nvarchar(6),
@sod_venitm nvarchar(20),	@sod_itmprc numeric(13,4),	@sod_pckitr nvarchar(300),
@sod_clmno nvarchar(30),	@sod_moq int,		@sod_moa numeric(11,4),
@sod_apprve nvarchar(1),	@seccus nvarchar(6),		@status nvarchar(6),
@closeout nvarchar(1),		@replace nvarchar(1),		@sod_updusr nvarchar(30),
@sod_cusven varchar(6),	@sod_cussub varchar(10),	@sod_pjobno varchar(20),
@sod_seccusitm varchar(20),	@sod_orgmoqchg numeric(6,3),	@sod_moqchg numeric(6,3),
@sod_netuntprc numeric(13,4),	@sod_bomcst numeric(13,4),	@sod_ztnvbeln nvarchar(10),
@sod_ztnposnr nvarchar(6),	@sod_zorvbeln nvarchar(10),	@sod_zorposnr nvarchar(6),
@sod_conftr numeric(9),	@sod_contopc nvarchar(1),	@sod_pcprc numeric(13,4),
@sod_custum nvarchar(6),	@sod_dv nvarchar(50),	@sod_dvftycst numeric(13,4),
@sod_dvftyprc numeric(13,4),	@sod_dvbomcst numeric(13,4),	@sod_dvfcurcde nvarchar(6),	
@sod_dvftyunt nvarchar(6),	@sod_cusstyno nvarchar(30),	@sod_moqunttyp nvarchar(6),
@sod_qutdat datetime,		@sod_dvitmcst numeric(13,4),	@sod_itmcstcur nvarchar(6),
@sod_imqutdat datetime,	@sod_cus1no nvarchar(6),	@sod_cus2no nvarchar(6),
@sod_hkprctrm nvarchar(10),	@sod_ftyprctrm nvarchar(10),	@sod_trantrm nvarchar(10),
@sod_effdat datetime,		@sod_expdat datetime,		@endsignal nvarchar(1)

AS

declare @cid_seqno int
declare @ItmVenTyp char(1)

begin
	update	SCORDDTL
	set	sod_updpo = @sod_updpo,	sod_chgfty = @sod_chgfty,	sod_itmno = @sod_itmno,
		sod_itmtyp = @sod_itmtyp,	sod_itmdsc = rtrim(ltrim(@sod_itmdsc)),
								sod_colcde = @sod_colcde,
		sod_cuscol = rtrim(ltrim(@sod_cuscol)),
					sod_coldsc = rtrim(ltrim(@sod_coldsc)),
								sod_cft = @sod_cft,
		sod_cbm = @sod_cbm,	sod_cusitm = rtrim(ltrim(@sod_cusitm)),
								sod_cussku = @sod_cussku,
		sod_resppo = @sod_resppo,	sod_cuspo = @sod_cuspo,	sod_ordqty = @sod_ordqty,
		sod_discnt = @sod_discnt,	sod_oneprc = @sod_oneprc,	sod_curcde = @sod_curcde,
		sod_untprc = @sod_untprc,	sod_selprc = @sod_selprc,	sod_hrmcde = @sod_hrmcde,
		sod_dtyrat = @sod_dtyrat,	sod_dept = @sod_dept,	sod_typcode = @sod_typcode,
		sod_code1 = @sod_code1,	sod_code2 = @sod_code2,	sod_code3 = @sod_code3,
		sod_cususd = @sod_cususd,	sod_cuscad = @sod_cuscad,	sod_inrdin = @sod_inrdin,
		sod_inrwin = @sod_inrwin,	sod_inrhin = @sod_inrhin,	sod_mtrdin = @sod_mtrdin,
		sod_mtrwin = @sod_mtrwin,	sod_mtrhin = @sod_mtrhin,	sod_inrdcm = @sod_inrdcm,
		sod_inrwcm = @sod_inrwcm,	sod_inrhcm = @sod_inrhcm,	sod_mtrdcm = @sod_mtrdcm,
		sod_mtrwcm = @sod_mtrwcm,	sod_mtrhcm = @sod_mtrhcm,	sod_shpstr = @sod_shpstr,
		sod_shpend = @sod_shpend,	sod_candat = @sod_candat,	sod_ctnstr = @sod_ctnstr,
		sod_ctnend = @sod_ctnend,	sod_ttlctn = @sod_ttlctn,	sod_rmk = @sod_rmk,
		sod_venno = @sod_Venno,	sod_fcurcde = @sod_fcurcde,	sod_ftycst = @sod_ftycst,
		sod_ftyprc = @sod_ftyprc,	sod_subcde = @sod_subcde,	sod_ftyunt = @sod_ftyunt,
		sod_venitm= @sod_venitm,	sod_itmprc = @sod_itmprc,	sod_pckitr = @sod_pckitr,
		sod_clmno =@sod_clmno,	sod_moq =@sod_moq,	sod_moa = @sod_moa,
		sod_apprve = @sod_apprve,	sod_updusr = @sod_updusr,	sod_upddat = getdate(),
		sod_orgmoqchg  = @sod_orgmoqchg,
					sod_moqchg  = @sod_moqchg, 	sod_netuntprc  = @sod_netuntprc,  
		sod_bomcst = @sod_bomcst,	sod_cusven  = @sod_cusven,	sod_cussub  = @sod_cussub,
		sod_pjobno  = @sod_pjobno,	sod_seccusitm  = @sod_seccusitm,
								sod_ztnvbeln = @sod_ztnvbeln,
		sod_ztnposnr  = @sod_ztnposnr,	sod_conftr = @sod_conftr,	sod_contopc =  @sod_contopc,
		sod_pcprc = @sod_pcprc,	sod_custum = @sod_custum,	sod_dv = @sod_dv,
		sod_dvftycst = @sod_dvftycst,	sod_dvftyprc = @sod_dvftyprc,	sod_dvbomcst = @sod_dvbomcst,
		sod_dvfcurcde = @sod_dvfcurcde,	sod_dvftyunt = @sod_dvftyunt,	sod_cusstyno = @sod_cusstyno,
		sod_moqunttyp = @sod_moqunttyp,
					sod_qutdat = @sod_qutdat,	sod_imqutdat = @sod_imqutdat,
		sod_itmcstcur = @sod_itmcstcur,	sod_dvitmcst = @sod_dvitmcst
	where	sod_cocde = @sod_cocde	and
		sod_ordno = @sod_ordno	and
		sod_ordseq = @sod_ordseq
	
	--- Get Item Vendor Type ---
	set @Itmventyp = isnull(        (	select	VBI_VENTYP	 
				from	IMBASINF (NOLOCK) 
				left join	VNBASINF (NOLOCK) on VBI_VENNO = IBI_VENNO
				where	IBI_ITMNO = @sod_itmno	and
					VBI_VENTYP IS NOT NULL),' ')
	
	-- Insert into Customer Item History Summary Information
	if @sod_oneprc = 'N' and @status ='ACT' and @closeout ='N' and @replace= 'N'
	begin
		if @sod_oneprc = 'N' and @status ='ACT'
		begin
			if @seccus  <> '' 
			begin
				if (	select	count(1)
					from	CUITMSUM
					where	cis_cusno in (	select	cbi_cusno
								from	cubasinf
								where	cbi_cusno = @cusno		or
									cbi_cusali = @cusno
								union
								select	cbi_cusali
								from	cubasinf
								where	cbi_cusno = @cusno)			and
						cis_seccus in (	select	cbi_cusno
								from	cubasinf (nolock)
								where	(cbi_cusali = @seccus or
									 cbi_cusno = @seccus)		and
									cbi_cusno <> ''
								union
								select	cbi_cusali
								from	cubasinf (nolock)
								where	cbi_cusno = @seccus		and
									cbi_cusali  <> '')			and
						cis_itmno in (	select	ibi.ibi_itmno
								from	imbasinf ibi
								left join	imbasinf als on ibi.ibi_alsitmno = als.ibi_itmno 
								where	ibi.ibi_itmno = @sod_itmno	or
									(ibi.ibi_alsitmno = @sod_itmno and
									 isnull(als.ibi_itmsts,'') <> 'OLD')
								union
								select	ibi.ibi_alsitmno
								from	imbasinf ibi
								left join	imbasinf als on ibi.ibi_alsitmno = als.ibi_itmno 
								where	ibi.ibi_itmno = @sod_itmno	and
									isnull(als.ibi_itmsts,'') <> 'OLD')		and
						cis_colcde = @sod_colcde					and
						cis_untcde = @sod_pckunt					and
						cis_inrqty = @sod_inrctn					and
						cis_conftr = @sod_conftr					and
						cis_mtrqty = @sod_mtrctn) = 0
					begin
						insert into	CUITMSUM
							(cis_cocde,		cis_cusno,		cis_seccus,
							 cis_itmno,		cis_itmdsc,		cis_cusitm,
							 cis_colcde,		cis_coldsc,		cis_cuscol,
							 cis_untcde,	cis_inrqty,		cis_mtrqty,
							 cis_cft,		cis_cbm,		cis_refdoc,
							 cis_docdat,	cis_cussku,		cis_ordqty,
							 cis_curcde,	cis_selprc,		cis_hrmcde,
							 cis_dtyrat,		cis_dept,		cis_typcode,
							 cis_code1,		cis_code2,		cis_code3,
							 cis_cususd,	cis_cuscad,		cis_inrdin,
							 cis_inrwin,	cis_inrhin,		cis_mtrdin,
							 cis_mtrwin,	cis_mtrhin,		cis_inrdcm,
							 cis_inrwcm,	cis_inrhcm,	cis_mtrdcm,
							 cis_mtrwcm,	cis_mtrhcm,	cis_creusr,
							 cis_updusr,	cis_pckitr,		cis_credat,
							 cis_upddat,	cis_fcurcde,	cis_ftyprc,
							 cis_ftycst,		cis_netselprc,	cis_moqchg,
							 cis_itmventyp,	cis_conftr,		cis_cusstyno,
							 cis_ftytmpitm,	cis_cus1no,	cis_cus2no,
							 cis_hkprctrm,	cis_ftyprctrm,	cis_trantrm,
							 cis_effdat,		cis_expdat)
						values	(' ',		@cusno,		@seccus,
							 @sod_itmno,	@sod_itmdsc,	@sod_cusitm,
							 @sod_colcde,	@sod_coldsc,	@sod_cuscol,
							 @sod_pckunt,	@sod_inrctn,	@sod_mtrctn,
							 @sod_cft,		@sod_cbm,	@sod_ordno,
							 getdate(),		@sod_cussku,	@sod_ordqty,
							 @sod_curcde,	@sod_untprc,	@sod_hrmcde,
							 @sod_dtyrat,	@sod_dept,	@sod_typcode,
							 @sod_code1,	@sod_code2,	@sod_code3,
							 @sod_cususd,	@sod_cuscad,	@sod_inrdin,
							 @sod_inrwin,	@sod_inrhin,	@sod_mtrdin,
							 @sod_mtrwin,	@sod_mtrhin,	@sod_inrdcm,
							 @sod_inrwcm,	@sod_inrhcm,	@sod_mtrdcm,
							 @sod_mtrwcm,	@sod_mtrhcm,	@sod_updusr,
							 @sod_updusr,	@sod_pckitr,	getdate(),
							 getdate(),		@sod_fcurcde,	@sod_ftyprc,
							 @sod_ftycst,	@sod_netuntprc,	@sod_moqchg,
							 @itmventyp,	@sod_conftr,	@sod_cusstyno,
							 '',		@sod_cus1no,	@sod_cus2no,
							 @sod_hkprctrm,	@sod_ftyprctrm,	@sod_trantrm,
							 @sod_effdat,	@sod_expdat)
					end
					else
					begin	
						update 	CUITMSUM 	
						set 	cis_itmno = @sod_itmno,	cis_itmdsc = @sod_itmdsc, 	cis_cusitm = @sod_cusitm,
							cis_coldsc = @sod_coldsc,	cis_cuscol = @sod_cuscol,	cis_cft = @sod_cft,
							cis_cbm = @sod_cbm,		cis_typcode = @sod_typcode,	cis_code1  = @sod_code1,
							cis_code2  = @sod_code2,	cis_code3  = @sod_code3,	cis_fcurcde = @sod_fcurcde,
							cis_ftycst = @sod_ftycst,	cis_ftyprc = @sod_ftyprc,	cis_refdoc = @sod_ordno,
							cis_curcde = @sod_curcde,	cis_ordqty = @sod_ordqty,	cis_docdat  = getdate(),
							cis_hrmcde = @sod_hrmcde,	cis_dtyrat = @sod_dtyrat,	cis_dept = @sod_dept,
							cis_cususd = @sod_cususd,	cis_cuscad = @sod_cuscad,	cis_inrdin = @sod_inrdin,
							cis_inrwin = @sod_inrwin,	cis_inrhin = @sod_inrhin, 	cis_mtrdin = @sod_mtrdin,
							cis_mtrwin = @sod_mtrwin,	cis_mtrhin = @sod_mtrhin,	cis_inrdcm = @sod_inrdcm,
							cis_inrwcm = @sod_inrwcm,	cis_inrhcm = @sod_inrhcm,	cis_mtrdcm = @sod_mtrdcm,
							cis_mtrwcm = @sod_mtrwcm,	cis_mtrhcm = @sod_mtrhcm,	cis_pckitr = @sod_pckitr,
							cis_updusr = @sod_updusr,	cis_upddat = getdate(),		cis_moqchg=@sod_moqchg,
							cis_itmventyp = @itmventyp,	cis_cusstyno = @sod_cusstyno,	cis_ftytmpitm = ''	
						where	cis_cusno in (	select	cbi_cusno
									from	cubasinf
									where	cbi_cusno = @cusno		or
										cbi_cusali = @cusno
									union
									select	cbi_cusali
									from	cubasinf
									where	cbi_cusno = @cusno)			and
							cis_seccus in (	select	cbi_cusno
									from	cubasinf (nolock)
									where	(cbi_cusali = @seccus or
										 cbi_cusno = @seccus)		and
										cbi_cusno <> ''
									union
									select	cbi_cusali
									from	cubasinf (nolock)
									where	cbi_cusno = @seccus		and
										cbi_cusali  <> '')			and
							cis_itmno in (	select	ibi.ibi_itmno
									from	imbasinf ibi
									left join	imbasinf als on ibi.ibi_alsitmno = als.ibi_itmno 
									where	ibi.ibi_itmno = @sod_itmno	or
										(ibi.ibi_alsitmno = @sod_itmno and
										isnull(als.ibi_itmsts,'') <> 'OLD')
									union
									select	ibi.ibi_alsitmno
									from	imbasinf ibi
									left join	imbasinf als on ibi.ibi_alsitmno = als.ibi_itmno 
									where	ibi.ibi_itmno = @sod_itmno	and
										isnull(als.ibi_itmsts,'') <> 'OLD')		and
							cis_colcde = @sod_colcde					and
							cis_untcde = @sod_pckunt					and
							cis_inrqty = @sod_inrctn					and
							cis_conftr  = @sod_conftr					and
							cis_mtrqty = @sod_mtrctn
					end
				end
				else
				begin
				if (	select	count(1) 
					from	CUITMSUM 
					where	cis_cusno in (	select	cbi_cusno
								from	cubasinf
								where	cbi_cusno = @cusno		or
									cbi_cusali = @cusno
								union
								select	cbi_cusali
								from	cubasinf
								where	cbi_cusno = @cusno)			and
						cis_seccus = @seccus						and
						cis_itmno in (	select	ibi.ibi_itmno
								from	imbasinf ibi
								left join	imbasinf als on ibi.ibi_alsitmno = als.ibi_itmno 
								where	ibi.ibi_itmno = @sod_itmno	or
									(ibi.ibi_alsitmno = @sod_itmno and
									 isnull(als.ibi_itmsts,'') <> 'OLD')
								union
								select	ibi.ibi_alsitmno
								from	imbasinf ibi
								left join	imbasinf als on ibi.ibi_alsitmno = als.ibi_itmno 
								where	ibi.ibi_itmno = @sod_itmno	and
									isnull(als.ibi_itmsts,'') <> 'OLD')		and
						cis_colcde = @sod_colcde					and
						cis_untcde = @sod_pckunt					and
						cis_inrqty = @sod_inrctn					and
						cis_conftr = @sod_conftr					and
						cis_mtrqty = @sod_mtrctn) = 0
					begin
					insert into CUITMSUM
						(cis_cocde,		cis_cusno,		cis_seccus,
						 cis_itmno,		cis_itmdsc,		cis_cusitm,
						 cis_colcde,		cis_coldsc,		cis_cuscol,
						 cis_untcde,	cis_inrqty,		cis_mtrqty,
						 cis_cft,		cis_cbm,		cis_refdoc,
						 cis_docdat,	cis_cussku,		cis_ordqty,
						 cis_curcde,	cis_selprc,		cis_hrmcde,
						 cis_dtyrat,		cis_dept,		cis_typcode,
						 cis_code1,		cis_code2,		cis_code3,
						 cis_cususd,	cis_cuscad,		cis_inrdin,
						 cis_inrwin,	cis_inrhin,		cis_mtrdin,
						 cis_mtrwin,	cis_mtrhin,		cis_inrdcm,
						 cis_inrwcm,	cis_inrhcm,	cis_mtrdcm,
						 cis_mtrwcm,	cis_mtrhcm,	cis_creusr,
						 cis_updusr,	cis_pckitr,		cis_credat,
						 cis_upddat,	cis_fcurcde,	cis_ftyprc,
						 cis_ftycst,		cis_netselprc,	cis_moqchg,
						 cis_itmventyp,	cis_conftr,		cis_cusstyno,
						 cis_ftytmpitm,	cis_cus1no,	cis_cus2no,
						 cis_hkprctrm,	cis_ftyprctrm,	cis_trantrm,
						 cis_effdat,		cis_expdat)
					values	(' ',		@cusno,		@seccus,
						 @sod_itmno,	@sod_itmdsc,	@sod_cusitm,
						 @sod_colcde,	@sod_coldsc,	@sod_cuscol,
						 @sod_pckunt,	@sod_inrctn,	@sod_mtrctn,
						 @sod_cft,		@sod_cbm,	@sod_ordno,
						 getdate(),		@sod_cussku,	@sod_ordqty,
						 @sod_curcde,	@sod_untprc,	@sod_hrmcde,
						 @sod_dtyrat,	@sod_dept,	@sod_typcode,
						 @sod_code1,	@sod_code2,	@sod_code3,
						 @sod_cususd,	@sod_cuscad,	@sod_inrdin,
						 @sod_inrwin,	@sod_inrhin,	@sod_mtrdin,
						 @sod_mtrwin,	@sod_mtrhin,	@sod_inrdcm,
						 @sod_inrwcm,	@sod_inrhcm,	@sod_mtrdcm,
						 @sod_mtrwcm,	@sod_mtrhcm,	@sod_updusr,
						 @sod_updusr,	@sod_pckitr,	getdate(),
						 getdate(),		@sod_fcurcde,	@sod_ftyprc,
						 @sod_ftycst,	@sod_netuntprc,	@sod_moqchg,
						 @itmventyp,	@sod_conftr,	@sod_cusstyno,
						 '',		@sod_cus1no,	@sod_cus2no,
						 @sod_hkprctrm,	@sod_ftyprctrm,	@sod_trantrm,
						 @sod_effdat,	@sod_expdat)
					end
					else
					begin	
					update 	CUITMSUM 	
					set 	cis_itmno = @sod_itmno,	cis_itmdsc = @sod_itmdsc, 	cis_cusitm = @sod_cusitm,
						cis_coldsc = @sod_coldsc,	cis_cuscol = @sod_cuscol,	cis_cft = @sod_cft,
						cis_cbm = @sod_cbm,		cis_fcurcde = @sod_fcurcde,	cis_ftycst = @sod_ftycst,
						cis_ftyprc = @sod_ftyprc,	cis_typcode = @sod_typcode,	cis_code1  = @sod_code1,
						cis_code2  = @sod_code2,	cis_code3  = @sod_code3,	cis_refdoc = @sod_ordno,
						cis_curcde = @sod_curcde,	cis_ordqty = @sod_ordqty,	cis_docdat  = getdate(),
						cis_hrmcde = @sod_hrmcde,	cis_dtyrat = @sod_dtyrat,	cis_dept = @sod_dept,
						cis_cususd = @sod_cususd,	cis_cuscad = @sod_cuscad,	cis_inrdin = @sod_inrdin,
						cis_inrwin = @sod_inrwin,	cis_inrhin = @sod_inrhin, 	cis_mtrdin = @sod_mtrdin,
						cis_mtrwin = @sod_mtrwin,	cis_mtrhin = @sod_mtrhin,	cis_inrdcm = @sod_inrdcm,
						cis_inrwcm = @sod_inrwcm,	cis_inrhcm = @sod_inrhcm,	cis_mtrdcm = @sod_mtrdcm,
						cis_mtrwcm = @sod_mtrwcm,	cis_mtrhcm = @sod_mtrhcm,	cis_pckitr = @sod_pckitr,
						cis_updusr = @sod_updusr,	cis_upddat = getdate(),		cis_moqchg = @sod_moqchg,
						cis_itmventyp=@itmventyp,	cis_cusstyno = @sod_cusstyno,	cis_ftytmpitm = '',
						cis_cus1no = @sod_cus1no,	cis_cus2no = @sod_cus2no,	cis_hkprctrm = @sod_hkprctrm,
						cis_ftyprctrm = @sod_ftyprctrm,	cis_trantrm = @sod_trantrm,	cis_effdat = @sod_effdat,
						cis_expdat = @sod_expdat
					where	cis_cusno in (	select	cbi_cusno
								from	cubasinf
								where	cbi_cusno = @cusno		or
									cbi_cusali = @cusno
								union
								select	cbi_cusali
								from	cubasinf
								where	cbi_cusno = @cusno)			and
						cis_seccus = @seccus						and
						cis_itmno in (	select	ibi.ibi_itmno
								from	imbasinf ibi
								left join	imbasinf als on ibi.ibi_alsitmno = als.ibi_itmno 
								where	ibi.ibi_itmno = @sod_itmno	or
									(ibi.ibi_alsitmno = @sod_itmno and
									 isnull(als.ibi_itmsts,'') <> 'OLD')
								union
								select	ibi.ibi_alsitmno
								from	imbasinf ibi
								left join	imbasinf als on ibi.ibi_alsitmno = als.ibi_itmno 
								where	ibi.ibi_itmno = @sod_itmno	and
									isnull(als.ibi_itmsts,'') <> 'OLD')		and
						cis_colcde = @sod_colcde					and
						cis_untcde = @sod_pckunt					and
						cis_inrqty = @sod_inrctn					and
						cis_conftr = @sod_conftr					and
						cis_mtrqty = @sod_mtrctn
				end
			end	
		end
	end

	--Insert into Customer Item History Detail Information
	if (@status ='ACT' or @status ='CAN') and @closeout ='N' and @replace ='N'
	begin
		set @cid_seqno = (	select	isnull(max(cid_seqno),0) + 1
				from	CUITMDTL 
				where 	cid_cocde = @sod_cocde	and
					cid_cusno = @cusno		and
					cid_seccus = @seccus		and
				 	cid_itmno = @sod_itmno	and
					cid_colcde = @sod_colcde	and
					cid_inrqty = @sod_inrctn	and
					cid_untcde = @sod_pckunt	and
					cid_conftr = @sod_conftr) 
		
		insert into	CUITMDTL
			(cid_cocde,		cid_cusno,		cid_seccus,
			 cid_seqno,		cid_itmno,		cid_itmdsc,
			 cid_cusitm,	cid_colcde,		cid_coldsc,
			 cid_cuscol,	cid_untcde,		cid_inrqty,
			 cid_mtrqty,	cid_cft,		cid_cbm,
			 cid_refdoc,	cid_docdat,		cid_cussku,
			 cid_ordqty,	cid_curcde,		cid_selprc,
			 cid_hrmcde,	cid_dtyrat,		cid_dept,
			 cid_typcode,	cid_code1,		cid_code2,
			 cid_code3,		cid_cususd,	cid_cuscad,
			 cid_inrdin,		cid_inrwin,		cid_inrhin,
			 cid_mtrdin,	cid_mtrwin,	cid_mtrhin,
			 cid_inrdcm,	cid_inrwcm,	cid_inrhcm,
			 cid_mtrdcm,	cid_mtrwcm,	cid_mtrhcm,
			 cid_onetim,	cid_creusr,		cid_updusr,
			 cid_credat,		cid_pckitr,		cid_upddat,
			 cid_fcurcde,	cid_ftyprc,		cid_ftycst,
			 cid_netselprc,	cid_moqchg,	cid_itmventyp,
			 cid_conftr,		cid_contopc,	cid_pcprc,
			 cid_cusstyno,	cid_ftytmpitm,	cid_cus1no,
			 cid_cus2no,	cid_hkprctrm,	cid_ftyprctrm,
			 cid_trantrm,	cid_effdat,		cid_expdat)
		values	(@sod_cocde,	@cusno,		@seccus,
			 @cid_seqno,	@sod_itmno,	@sod_itmdsc,
			 @sod_cusitm,	@sod_colcde,	@sod_coldsc,
			 @sod_cuscol,	@sod_pckunt,	@sod_inrctn,
			 @sod_mtrctn,	@sod_cft,		@sod_cbm,
			 @sod_ordno,	getdate(),		@sod_cussku,
			 @sod_ordqty,	@sod_curcde,	@sod_untprc,
			 @sod_hrmcde,	@sod_dtyrat,	@sod_dept,
			 @sod_typcode,	@sod_code1,	@sod_code2,
			 @sod_code3,	@sod_cususd,	@sod_cuscad,
			 @sod_inrdin,	@sod_inrwin,	@sod_inrhin,
			 @sod_mtrdin,	@sod_mtrwin,	@sod_mtrhin,
			 @sod_inrdcm,	@sod_inrwcm,	@sod_inrhcm,
			 @sod_mtrdcm,	@sod_mtrwcm,	@sod_mtrhcm,
			 @sod_oneprc,	@sod_updusr,	@sod_updusr,
			 getdate(),		@sod_pckitr,	getdate(),
			 @sod_fcurcde,	@sod_ftyprc,	@sod_ftycst,
			 @sod_netuntprc,	@sod_moqchg,	@itmventyp,
			 @sod_conftr,	@sod_contopc,	@sod_pcprc,
			 @sod_cusstyno,	'',		@sod_cus1no,
			 @sod_cus2no,	@sod_hkprctrm,	@sod_ftyprctrm,
			 @sod_trantrm,	@sod_effdat,	@sod_expdat)
	end
end






GO
GRANT EXECUTE ON [dbo].[sp_Update_SCORDDTL2] TO [ERPUSER] AS [dbo]
GO
