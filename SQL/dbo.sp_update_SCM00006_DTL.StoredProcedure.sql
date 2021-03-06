/****** Object:  StoredProcedure [dbo].[sp_update_SCM00006_DTL]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_SCM00006_DTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_SCM00006_DTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  procedure [dbo].[sp_update_SCM00006_DTL]
@cocde	varchar(6),
@ordno	varchar(20),
@ordseq int,
@action	varchar(6),
@sod_moqmoaflg char(1),
@sod_onetimeflg char(1),
@sod_belprcflg char(1),
@sod_chgftycstflg char(1),
@sod_chguntprcflg char(1),
@creusr	varchar(30)

as
/*
update	SCORDDTL
set	sod_apprve = ltrim(rtrim(@action)),
	sod_updusr = left(ltrim(rtrim('A-' + @creusr)),12),
	sod_upddat = getdate()
where	sod_ordno = @ordno and
	sod_ordseq = @ordseq
*/
update	SCORDDTL
set	sod_moqmoaflg = @sod_moqmoaflg,
	sod_onetimeflg = @sod_onetimeflg,
	sod_belprcflg = @sod_belprcflg,
	sod_chgftycstflg = @sod_chgftycstflg,
	sod_chguntprcflg = @sod_chguntprcflg,
	sod_updusr = left(ltrim(rtrim('A-' + @creusr)),30),
	sod_upddat = getdate()
where	sod_ordno = @ordno and
	sod_ordseq = @ordseq


if (select count(*) from SCORDDTL (nolock) where sod_cocde = @cocde and sod_ordno = @ordno and sod_ordseq = @ordseq) > 0 
	and (select count(*) from SCORDHDR (nolock) where soh_cocde = @cocde and
	soh_ordno = @ordno and soh_canflg <> 'Y') > 0
begin
	declare
	@soh_cus1no	varchar(6),
	@soh_cus2no	varchar(6),
	@itmventyp	varchar(1)

	declare
	@sod_itmno	nvarchar(20),
	@sod_colcde	nvarchar(30),
	@sod_pckunt	nvarchar(6),
	@sod_inrctn	int,
	@sod_mtrctn	int,
	@sod_hkprctrm	nvarchar(10),
	@sod_ftyprctrm	nvarchar(10),
	@sod_trantrm	nvarchar(10),
	@sod_dv		nvarchar(6),
	@sod_itmdsc	nvarchar(800),
	@sod_coldsc	nvarchar(300),
	@sod_cuscol	nvarchar(30),
	@sod_cusitm	nvarchar(20),
	@sod_cft	numeric(11,4),
	@sod_cbm	numeric(11,4),
	@sod_venno	varchar(6),
	@sod_cusven	varchar(6),
	@sod_tradeven	varchar(6),
	@sod_examven	varchar(6),
	@sod_cussku	nvarchar(20),
	@sod_ordqty	int,
	@sod_moqchg	numeric(6,3),
	@sod_hrmcde	nvarchar(12),
	@sod_typcode	nvarchar(1),	
	@sod_code1	nvarchar(25),
	@sod_code2	nvarchar(25),
	@sod_code3	nvarchar(25),
	@sod_dtyrat	numeric(6,3),
	@sod_dept	nvarchar(20),
	@sod_cususdcur	nvarchar(6),
	@sod_cususd	numeric(13,4),
	@sod_cuscadcur	nvarchar(6),
	@sod_cuscad	numeric(13,4),
	@sod_inrdin	numeric(11,4),
	@sod_inrwin	numeric(11,4),
	@sod_inrhin	numeric(11,4),	
	@sod_mtrdin	numeric(11,4),
	@sod_mtrwin	numeric(11,4),
	@sod_mtrhin	numeric(11,4),
	@sod_inrdcm	numeric(11,4),
	@sod_inrwcm	numeric(11,4),
	@sod_inrhcm	numeric(11,4),
	@sod_mtrdcm	numeric(11,4),
	@sod_mtrwcm	numeric(11,4),
	@sod_mtrhcm 	numeric(11,4),
	@sod_pckitr	nvarchar(300),
	@sod_cusstyno	nvarchar(30),
	@sod_season	nvarchar(30),
	@sod_year	nvarchar(4),
	
-- *** Data for insert CUITMPRCDTL Start *** --
	@sod_conftr numeric(9),
	@seq_num_cuitmprcdtl int,
	@cis_cussna nvarchar(20),
	@cis_secsna nvarchar(20), 
	
	@sod_tirtyp char(1), 
	@sod_moqunttyp nvarchar(30), 
	@sod_moq int, 
	@sod_moa int,
	@sod_contopc nvarchar(1), 
	@sod_pcprc numeric(13,4),
	@sod_effdat	datetime,
	@sod_expdat	datetime,
	
	@sod_prckey1 nvarchar(6),
	@sod_prckey2 nvarchar(6),
	@sod_qutno nvarchar(20),
	@sod_untprc numeric(13,4),
	@sod_qutdat datetime,
	
	@sod_fcurcde nvarchar(6),
	@sod_ftycst	numeric(13,4),
	@sod_bomcst	numeric(13,4),
	@sod_ftyprc	numeric(13,4),
	@sod_curcde	nvarchar(6),
	@sod_basprc	numeric(13,4),
	@markup	numeric(13,4),
	@mrkprc	numeric(13,4),
	@pckcst	numeric(13,4),
	@commsn	numeric(13,4),
	@itmcom	numeric(13,4),
	@stdprc	numeric(13,4),
	@mumin	numeric(13,4),
	@muminprc	numeric(13,4),
	@sod_discnt	numeric(6,3),

	@soh_verno int,
	@soh_clsout char(1),
	@soh_rplmnt char(1),
	@flg_cuitmprcdtl char(1),
	@sod_oneprc nvarchar(1)
-- *** Data for insert CUITMPRCDTL End *** --	

	
	select	@soh_cus1no = soh_cus1no,
		@soh_cus2no = soh_cus2no,
		@soh_verno = soh_verno,
		@soh_clsout = soh_clsout,
		@soh_rplmnt = soh_rplmnt
	from	SCORDHDR (nolock)
	where	soh_cocde = @cocde and
		soh_ordno = @ordno
		
--- Get Customer Name for Primary and Secondary ---
	if @soh_cus1no <> ''
		select @cis_cussna = cbi_cussna from CUBASINF where cbi_cusno = @soh_cus1no
	else
		select @cis_cussna = ''
	
	if @soh_cus2no <> ''
		select @cis_secsna = cbi_cussna from CUBASINF where cbi_cusno = @soh_cus2no
	else
		select @cis_secsna = ''
	
	
	select	@sod_itmno = sod_itmno,
		@sod_colcde = sod_colcde,
		@sod_pckunt = sod_pckunt,
		@sod_inrctn = sod_inrctn,
		@sod_mtrctn = sod_mtrctn,
		@sod_hkprctrm = sod_hkprctrm,
		@sod_ftyprctrm = sod_ftyprctrm,
		@sod_trantrm = sod_trantrm,
		@sod_dv	= sod_dv,
		@sod_itmdsc = sod_itmdsc,
		@sod_coldsc = sod_coldsc,
		@sod_cuscol = sod_cuscol,
		@sod_cusitm = sod_cusitm,
		@sod_cft = sod_cft,
		@sod_cbm = sod_cbm,
		@sod_venno = sod_venno,
		@sod_cusven = sod_cusven,
		@sod_tradeven = sod_tradeven,
		@sod_examven = sod_examven,
		@sod_cussku = sod_cussku,
		@sod_ordqty = sod_ordqty,
		@sod_moqchg = sod_moqchg,
		@sod_hrmcde = sod_hrmcde,
		@sod_typcode = sod_typcode,	
		@sod_code1 = sod_code1,
		@sod_code2 = sod_code2,
		@sod_code3 = sod_code3,
		@sod_dtyrat = sod_dtyrat,
		@sod_dept = sod_dept,
		@sod_cususdcur = sod_cususdcur,
		@sod_cususd = sod_cususd,
		@sod_cuscadcur = sod_cuscadcur,
		@sod_cuscad = sod_cuscad,
		@sod_inrdin = sod_inrdin,
		@sod_inrwin = sod_inrwin,
		@sod_inrhin = sod_inrhin,
		@sod_mtrdin = sod_mtrdin,
		@sod_mtrwin = sod_mtrwin,
		@sod_mtrhin = sod_mtrhin,
		@sod_inrdcm = sod_inrdcm,
		@sod_inrwcm = sod_inrwcm,
		@sod_inrhcm = sod_inrhcm,
		@sod_mtrdcm = sod_mtrdcm,
		@sod_mtrwcm = sod_mtrwcm,
		@sod_mtrhcm = sod_mtrhcm,
		@sod_pckitr = sod_pckitr,
		@sod_cusstyno = sod_cusstyno,
		@sod_season = sod_season,
		@sod_year = sod_year,
		
		@sod_conftr = sod_conftr,
		@sod_tirtyp = sod_tirtyp, 
		@sod_moqunttyp = sod_moqunttyp, 
		@sod_moq = sod_moq, 
		@sod_moa = sod_moa,
		@sod_contopc = sod_contopc, 
		@sod_pcprc = sod_pcprc,
		
		@sod_effdat = sod_effdat,
		@sod_expdat = sod_expdat, 
		@sod_prckey1 = sod_cus1no,
		@sod_prckey2 = sod_cus2no,
		@sod_qutno = sod_qutno,
		@sod_untprc = sod_untprc,
		@sod_qutdat = sod_qutdat,
		
		@sod_fcurcde = sod_fcurcde, 
		@sod_ftycst = sod_ftycst,
		@sod_bomcst = sod_bomcst, 
		@sod_ftyprc = sod_ftyprc,
		@sod_curcde = sod_curcde, 
		@sod_basprc = sod_basprc, 
		@markup = sod_markup, 
		@mrkprc = sod_mrkprc, 
		@pckcst = sod_pckcst, 
		@commsn = sod_commsn, 
		@itmcom = sod_itmcom, 
		@stdprc = sod_stdprc, 
		@mumin = sod_mumin, 
		@muminprc = sod_muminprc, 
		@sod_discnt = sod_discnt,
		@sod_oneprc = sod_oneprc
			
	from	SCORDDTL (nolock)
	where	sod_cocde = @cocde and
		sod_ordno = @ordno and
		sod_ordseq = @ordseq

	-- Get Item Vendor Type --
	select	@itmventyp = isnull(vbi_ventyp,'')
	from	IMBASINF (nolock)
		left join VNBASINF (nolock) on
			vbi_venno = ibi_venno
	where	ibi_itmno = @sod_itmno

	if @sod_oneprc = 'N'
	begin
		if @soh_cus2no <> '' 
		begin
			if (	select	count(*)
				from	CUITMHIS (nolock)
				where	cis_cusno in (	select	cbi_cusno
							from	CUBASINF (nolock)
							where	cbi_cusno = @soh_cus1no or
								cbi_cusali = @soh_cus1no
							UNION
							select	cbi_cusali
							from	CUBASINF (nolock)
							where	cbi_cusno = @soh_cus1no)	and
					cis_seccus in (	select	cbi_cusno
							from	CUBASINF (nolock)
							where	(cbi_cusali = @soh_cus2no or
								 cbi_cusno = @soh_cus2no) and
								cbi_cusno <> ''
							UNION
							select	cbi_cusali
							from	CUBASINF (nolock)
							where	cbi_cusno = @soh_cus2no and
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
					cis_refdoc = @ordno,
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
					cis_updusr = @creusr,
					cis_upddat = getdate()	
				where	cis_cusno in (	select	cbi_cusno
							from	CUBASINF (nolock)
							where	cbi_cusno = @soh_cus1no or
								cbi_cusali = @soh_cus1no
							UNION
							select	cbi_cusali
							from	CUBASINF (nolock)
							where	cbi_cusno = @soh_cus1no)	and
					cis_seccus in (	select	cbi_cusno
							from	CUBASINF (nolock)
							where	(cbi_cusali = @soh_cus2no or
								 cbi_cusno = @soh_cus2no) and
								cbi_cusno <> ''
							UNION
							select	cbi_cusali
							from	CUBASINF (nolock)
							where	cbi_cusno = @soh_cus2no and
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
							where	cbi_cusno = @soh_cus1no or
								cbi_cusali = @soh_cus1no
							UNION
							select	cbi_cusali
							from	CUBASINF (nolock)
							where	cbi_cusno = @soh_cus1no)	and
					cis_seccus = @soh_cus2no and
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
					cis_refdoc = @ordno,
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
					cis_updusr = @creusr,
					cis_upddat = getdate()	
				where	cis_cusno in (	select	cbi_cusno
							from	CUBASINF (nolock)
							where	cbi_cusno = @soh_cus1no or
								cbi_cusali = @soh_cus1no
							UNION
							select	cbi_cusali
							from	CUBASINF (nolock)
							where	cbi_cusno = @soh_cus1no)	and
					cis_seccus = @soh_cus2no and
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
	end
		
	if @soh_verno > 1 and @soh_clsout = 'N' and @soh_rplmnt = 'N'
		set @flg_cuitmprcdtl = 'Y'
	else
		set @flg_cuitmprcdtl = 'N'
		
	
	if @flg_cuitmprcdtl = 'Y'
	begin
		Set  @seq_num_cuitmprcdtl = (	select	isnull(max(cid_seqnum),0) + 1
		from	CUITMPRCDTL
		where	
			cid_cusno = @soh_cus1no and
			cid_seccus = @soh_cus2no and
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
				cis_cft, cis_cbm, cis_pckitr,
				
				cis_itmventyp, cis_tirtyp, cis_moqunttyp, cis_moq, cis_moacur, cis_moa,
				cis_year, cis_season, 
				cis_contopc, cis_pcprc,
				
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
				'', @soh_cus1no, @soh_cus2no, @sod_itmno,
				@sod_colcde, @sod_pckunt, @sod_conftr, @sod_inrctn,
				@sod_mtrctn, @sod_hkprctrm, @sod_ftyprctrm, @sod_trantrm,
				
				@seq_num_cuitmprcdtl, @ordno, @ordseq, getdate(), ltrim(rtrim(@action)), -- cid_docdat
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
				@sod_contopc, @sod_pcprc,
				
				@sod_effdat, @sod_expdat, @sod_prckey1, @sod_prckey2,
				@sod_fcurcde, 0, @sod_bomcst, @sod_ftyprc, --@sod_ftycst
				@sod_curcde, @sod_basprc, @markup, @mrkprc, 
				@pckcst, @commsn, @itmcom, @stdprc, 
				@mumin, @muminprc, @sod_discnt, 		
				@sod_qutdat,
				
				'SA',
				@sod_qutno,
				@creusr, @creusr, getdate(), getdate() 
				
			)
		--Query about CUITMPRCDTL End
	end
	
	
end





GO
GRANT EXECUTE ON [dbo].[sp_update_SCM00006_DTL] TO [ERPUSER] AS [dbo]
GO
