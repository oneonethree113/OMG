/****** Object:  StoredProcedure [dbo].[sp_update_QUOTNDTL_bak]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_QUOTNDTL_bak]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_QUOTNDTL_bak]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/*	Author : Tommy Ho	*/

CREATE PROCEDURE [dbo].[sp_update_QUOTNDTL_bak] 

@qud_cocde	nvarchar(6) ,	@qud_qutno 	nvarchar(20),	@qud_qutseq 	int,
@qud_itmno 	nvarchar(20),	@qud_itmsts 	nvarchar(4),	@qud_itmdsc 	nvarchar(800),
@qud_hstref 	nvarchar(20),	@qud_colcde 	nvarchar(30),	@qud_cuscol 	nvarchar(30),
@qud_coldsc 	nvarchar(200),	@qud_pckseq 	int,		@qud_untcde 	nvarchar(6),
@qud_inrqty 	int,		@qud_mtrqty 	int,		@qud_cft 		numeric(11,4),
@qud_curcde 	nvarchar(6),	@qud_cus1sp 	numeric(13,4),	@qud_cus2sp 	numeric(13,4),
@qud_cus1dp 	numeric(13,4),	@qud_cus2dp 	numeric(13,4),	@qud_onetim 	nvarchar(1),
@qud_discnt 	numeric(6,3),	@qud_moq 	int,		@qud_moa 	numeric(11,4),
@qud_smpqty 	int,		@qud_hrmcde 	nvarchar(12),	@qud_dtyrat 	numeric(6,3),
@qud_dept 	nvarchar(20),	@qud_cususd 	numeric(13,4),	@qud_cuscad 	numeric(13,4),
@qud_venno 	nvarchar(6),	@qud_venitm 	nvarchar(20),	@qud_ftyprc 	numeric(13,4),
@qud_note 	nvarchar(300),	@qud_image 	nvarchar(1),	@qud_inrdin 	numeric(11,4),
@qud_inrwin 	numeric(11,4),	@qud_inrhin 	numeric(11,4),	@qud_mtrdin 	numeric(11,4),
@qud_mtrwin 	numeric(11,4),	@qud_mtrhin 	numeric(11,4),	@qud_inrdcm 	numeric(11,4),
@qud_inrwcm 	numeric(11,4),	@qud_inrhcm 	numeric(11,4),	@qud_mtrdcm 	numeric(11,4),
@qud_mtrwcm 	numeric(11,4),	@qud_mtrhcm 	numeric(11,4),	@qud_grswgt 	numeric(6,3),
@qud_netwgt 	numeric(6,3),	@qud_cosmth 	nvarchar(50),	@qud_smpprc	numeric(13,4),
@qud_cusitm	nvarchar(20),	@cus1no		nvarchar(6),	@cus1na		nvarchar(20),
@cus2no		nvarchar(6),
@cus2na		nvarchar(20),	@qud_prcsec	nvarchar(3),	@qud_grsmgn	numeric(6,3),	
@qud_basprc	numeric(13,4),	@qud_tbm		nvarchar(1),	@qud_tbmsts	nvarchar(3),	
@rvsdat		datetime,		@qud_apprve	nvarchar(1),	@qud_pckitr	nvarchar(300),	
@qud_stkqty	int,		@qud_cusqty	int,		@qud_smpunt	nvarchar(6),	
@qud_qutitmsts	nvarchar(10),	@qud_fcurcde	nvarchar(6),	@qud_creusr	nvarchar(30)


AS

declare 	@cid_seqno  	int

update 	QUOTNDTL	
set	qud_itmno =  @qud_itmno,	qud_itmsts = @qud_itmsts ,	qud_itmdsc = @qud_itmdsc,
	qud_hstref = @qud_hstref,	qud_colcde = @qud_colcde,	qud_cuscol = @qud_cuscol,
	qud_coldsc = @qud_coldsc,	qud_pckseq = @qud_pckseq,	qud_untcde = @qud_untcde,
	qud_inrqty = @qud_inrqty ,	qud_mtrqty = @qud_mtrqty,	qud_cft = @qud_cft,
	qud_curcde = @qud_curcde ,	qud_cus1sp = @qud_cus1sp,	qud_cus2sp = @qud_cus2sp,
	qud_cus1dp = @qud_cus1dp,	qud_cus2dp = @qud_cus2dp,	qud_onetim = @qud_onetim,
	qud_discnt = @qud_discnt,	qud_moq = @qud_moq,	qud_moa = @qud_moa,
	qud_smpqty = @qud_smpqty,	qud_hrmcde = @qud_hrmcde,	qud_dtyrat = @qud_dtyrat,
	qud_dept = @qud_dept,	qud_cususd = @qud_cususd,	qud_cuscad = @qud_cuscad,
	qud_venno = @qud_venno,	qud_venitm = @qud_venitm,	qud_ftyprc = @qud_ftyprc,
	qud_note = @qud_note,	qud_image = @qud_image,	qud_inrdin = @qud_inrdin,
	qud_inrwin = @qud_inrwin,	qud_inrhin = @qud_inrhin ,	qud_mtrdin = @qud_mtrdin,
	qud_mtrwin = @qud_mtrwin,	qud_mtrhin = @qud_mtrhin,	qud_inrdcm = @qud_inrdcm,
	qud_inrwcm = @qud_inrwcm,	qud_inrhcm = @qud_inrhcm,	qud_mtrdcm = @qud_mtrdcm,
	qud_mtrwcm = @qud_mtrwcm,	qud_mtrhcm = @qud_mtrhcm,	qud_grswgt = @qud_grswgt,
	qud_netwgt = @qud_netwgt,	qud_cosmth = @qud_cosmth,	qud_updusr = @qud_creusr,	
	qud_upddat = getdate(),	qud_smpprc = @qud_smpprc,	qud_cusitm = @qud_cusitm,
	qud_prcsec = @qud_prcsec,	qud_grsmgn = @qud_grsmgn,	qud_basprc = @qud_basprc,
	qud_tbm = @qud_tbm,	qud_tbmsts = @qud_tbmsts,	qud_apprve = @qud_apprve,
	qud_pckitr = @qud_pckitr,	qud_stkqty = @qud_stkqty,	qud_cusqty = @qud_cusqty,
	qud_smpunt = @qud_smpunt,	qud_qutitmsts = @qud_qutitmsts,	qud_fcurcde = @qud_fcurcde
where 	qud_cocde = @qud_cocde	and 	qud_qutno = @qud_qutno	and
	qud_qutseq = @qud_qutseq	--and 	qud_itmno = @qud_itmno


-- Insert into Customer Item History Summary Information
if @qud_tbm = 'N' and @qud_qutitmsts = 'COMPLETE' and (@qud_apprve = '' or @qud_apprve = 'Y')
begin

	if @qud_onetim = 'N' 
	begin
		if (select count(*) from CUITMSUM where cis_cocde = @qud_cocde and cis_cusno = @cus1no and 
						cis_seccus = @cus2no and cis_itmno = @qud_itmno and 
						cis_colcde = @qud_colcde and cis_untcde = @qud_untcde and
						cis_inrqty = @qud_inrqty and cis_mtrqty = @qud_mtrqty) = 0
		begin
			insert into [CUITMSUM]			(
				cis_cocde ,	cis_cusno ,	cis_itmno ,
				cis_itmdsc ,	cis_cusitm ,	cis_colcde ,
				cis_coldsc ,	cis_cuscol ,	cis_untcde ,
				cis_inrqty ,	cis_mtrqty ,	cis_cft ,
				cis_cbm ,		cis_refdoc ,	cis_docdat ,
				cis_cussku ,	cis_ordqty ,	cis_curcde ,
				cis_selprc ,	cis_hrmcde ,	cis_dtyrat ,
				cis_dept ,		cis_typcode ,	cis_code1 ,	
				cis_code2 ,	cis_code3 ,	cis_cususd ,
				cis_cuscad ,	cis_inrdin ,	cis_inrwin ,
				cis_inrhin ,	cis_mtrdin ,	cis_mtrwin ,
				cis_mtrhin ,	cis_inrdcm ,	cis_inrwcm ,
				cis_inrhcm ,	cis_mtrdcm ,	cis_mtrwcm ,
				cis_mtrhcm ,	cis_creusr ,	cis_updusr ,
				cis_credat ,	cis_upddat ,	cis_pckitr ,
				cis_seccus ,	cis_secsna
			)
			values
			(
				@qud_cocde,	@cus1no,		@qud_itmno,
				@qud_itmdsc,	@qud_cusitm,	@qud_colcde,
				@qud_coldsc,	@qud_cuscol,	@qud_untcde,
				@qud_inrqty,	@qud_mtrqty,	@qud_cft,
				@qud_cft/35.3356,	@qud_qutno,	@rvsdat,
				'',		0,		@qud_curcde,
				@qud_cus1dp,	@qud_hrmcde,	@qud_dtyrat,
				@qud_dept,	'',		'',		
				'',		'',		@qud_cususd,
				@qud_cuscad,	@qud_inrdin,	@qud_inrwin,
				@qud_inrhin,	@qud_mtrdin,	@qud_mtrwin,
				@qud_mtrhin,	@qud_inrdcm,	@qud_inrwcm,
				@qud_inrhcm,	@qud_mtrdcm,	@qud_mtrwcm,
				@qud_mtrhcm,	@qud_creusr,	@qud_creusr,
				getdate(),		getdate(),		@qud_pckitr,
				@cus2no, 		@cus2na
			)
		end
		else
		begin	
			update 	CUITMSUM 	set 	cis_itmdsc = @qud_itmdsc, 	cis_cusitm = @qud_cusitm,
							cis_coldsc = @qud_coldsc,	cis_cuscol = @qud_cuscol,
							cis_cft = @qud_cft,		cis_cbm = @qud_cft/35.3356,
							cis_refdoc = @qud_qutno,	cis_curcde = @qud_curcde,
							cis_selprc = @qud_cus1dp, 	cis_hrmcde = @qud_hrmcde,
							cis_dtyrat = @qud_dtyrat,	cis_dept = @qud_dept,
							cis_cususd = @qud_cususd,	cis_cuscad = @qud_cuscad,
							cis_inrdin = @qud_inrdin,	cis_inrwin = @qud_inrwin,
							cis_inrhin = @qud_inrhin, 	cis_mtrdin = @qud_mtrdin,
							cis_mtrwin = @qud_mtrwin,	cis_mtrhin = @qud_mtrhin,
							cis_inrdcm = @qud_inrdcm,	cis_inrwcm = @qud_inrwcm,
							cis_inrhcm = @qud_inrhcm,	cis_mtrdcm = @qud_mtrdcm,
							cis_mtrwcm = @qud_mtrwcm,	cis_mtrhcm = @qud_mtrhcm,
							cis_updusr = @qud_creusr,	cis_upddat = getdate(),
							cis_docdat = @rvsdat,		cis_pckitr = @qud_pckitr
						where	cis_cocde = @qud_cocde and cis_cusno = @cus1no and 
							cis_seccus = @cus2no and cis_itmno = @qud_itmno and
							cis_colcde = @qud_colcde and cis_untcde = @qud_untcde and 
							cis_inrqty = @qud_inrqty and cis_mtrqty = @qud_mtrqty
		end
	end
end	
	--Insert into Customer Item History Detail Information
		
		Set  @cid_seqno = 	(Select isnull(max(cid_seqno),0)  + 1 from CUITMDTL 
				 where 	cid_cocde = @qud_cocde and cid_cusno = @cus1no and
					cid_seccus = @cus2no and cid_itmno = @qud_itmno and 
					cid_colcde = @qud_colcde and cid_inrqty = @qud_inrqty and 
					cid_untcde = @qud_untcde)
		
		insert into [CUITMDTL]		(
			cid_cocde ,	cid_cusno ,	cid_seqno ,
			cid_itmno ,	cid_itmdsc ,	cid_cusitm ,
			cid_colcde ,	cid_coldsc ,	cid_cuscol ,
			cid_untcde ,	cid_inrqty ,	cid_mtrqty ,
			cid_cft ,		cid_cbm ,		cid_refdoc ,
			cid_docdat ,	cid_cussku ,	cid_ordqty ,
			cid_curcde ,	cid_selprc ,	cid_hrmcde ,
			cid_dtyrat ,	cid_dept ,		cid_typcode ,
			cid_code1 ,	cid_code2 ,	cid_code3 ,
			cid_cususd ,	cid_cuscad ,	cid_inrdin ,
			cid_inrwin ,	cid_inrhin ,	cid_mtrdin ,
			cid_mtrwin ,	cid_mtrhin ,	cid_inrdcm ,
			cid_inrwcm ,	cid_inrhcm ,	cid_mtrdcm ,
			cid_mtrwcm ,	cid_mtrhcm ,	cid_onetim,
			cid_creusr ,	cid_updusr ,	cid_credat ,	
			cid_upddat ,	cid_pckitr ,	cid_seccus ,
			cid_secsna
		) 
		values
		(
			@qud_cocde,	@cus1no,		@cid_seqno,
			@qud_itmno,	@qud_itmdsc,	@qud_cusitm,
			@qud_colcde,	@qud_coldsc,	@qud_cuscol,
			@qud_untcde,	@qud_inrqty,	@qud_mtrqty,
			@qud_cft,		@qud_cft/35.3356,	@qud_qutno,
			@rvsdat,		'',		0,
			@qud_curcde,	@qud_cus1dp,	@qud_hrmcde,
			@qud_dtyrat,	@qud_dept,	'',
			'',		'',		'',
			@qud_cususd,	@qud_cuscad,	@qud_inrdin,
			@qud_inrwin,	@qud_inrhin,	@qud_mtrdin,
			@qud_mtrwin,	@qud_mtrhin,	@qud_inrdcm,
			@qud_inrwcm,	@qud_inrhcm,	@qud_mtrdcm,
			@qud_mtrwcm,	@qud_mtrhcm,	@qud_onetim,
			@qud_creusr,	@qud_creusr,	getdate(),		
			getdate(),		@qud_pckitr,	@cus2no,
			@cus2na
		)



GO
GRANT EXECUTE ON [dbo].[sp_update_QUOTNDTL_bak] TO [ERPUSER] AS [dbo]
GO
