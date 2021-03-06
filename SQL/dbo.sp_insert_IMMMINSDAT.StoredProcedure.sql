/****** Object:  StoredProcedure [dbo].[sp_insert_IMMMINSDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMMMINSDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMMMINSDAT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








CREATE PROCEDURE [dbo].[sp_insert_IMMMINSDAT] 
	@cocde  nvarchar(6), 
	@creusr  nvarchar(30) 
AS

DECLARE	-- TEMP
@cbmcft	numeric(13,4),		@fml		nvarchar(300),		@end		int,
@i		int,			@bomcst	numeric(13,4),		@imu_fmlopt	nvarchar(5),
@imu_basprc	numeric(13,4),		@OP		nvarchar(1),		@temp 		numeric(13,4),
@imu_selrat	numeric(16,11),		@imu_buyrat	numeric(16,11),		@bomprc	numeric(13,4),
@imu_itmprc	numeric(13,4),		@imu_fml	nvarchar(300),		@ivi_venno	nvarchar(6),	
@defven	nvarchar(6),		@ventyp	nvarchar(1),		@imu_fmlopt_P	nvarchar(5),	
@imu_fml_P	nvarchar(300),		@imu_ftyprc	numeric(13,4),		@imu_calftyprc	numeric(13,4),
@colcde	nvarchar(30),		@coldsc		nvarchar(300),		@colseq		int,	
@updsts	nvarchar(1),		@imd_basprc	numeric(13,4),		@imd_fmlopt	nvarchar(5),		
@imd_bcurcde	nvarchar(10),		@debug		int




DECLARE	-- IMPCKINF
@ipi_pckseq	int



DECLARE	-- SYCATREL
@ycr_catlvl0	nvarchar(20),		@ycr_catlvl1	nvarchar(20), 		@ycr_catlvl2	nvarchar(20), 
@ycr_catlvl3	nvarchar(20)

DECLARE	-- IMMMITMDAT
@imd_itmno	nvarchar(50),		@imd_venno	nvarchar(6) ,		@imd_prdven	nvarchar(6),
@imd_untcde	nvarchar(6) ,		@imd_mtrqty	int ,			@imd_inrqty 	int,
@imd_itmseq 	int,			@imd_recseq	int ,			@imd_cus1no 	nvarchar(10),
@imd_cus2no 	nvarchar(10),		@imd_lnecde	nvarchar(10) ,		@imd_catlvl4 	nvarchar(20),
@imd_aliasItemNo	nvarchar(50),	@imd_engdsc	nvarchar(800) ,		@imd_chndsc 	nvarchar(1600),
@imd_curcde	nvarchar(10) ,		@imd_mode 	nvarchar(3),		@imd_itmsts 	nvarchar(3),
@imd_fcA	numeric(13,4),		@imd_fcB	numeric(13,4),		@imd_fcC	numeric(13,4),
@imd_fcD	numeric(13,4),		@imd_fctran	numeric(13,4),		@imd_fcpck	numeric(13,4),
@imd_fcttl	numeric(13,4),		@imd_cft	numeric(13,4),		@imd_icA	numeric(13,4),
@imd_icB	numeric(13,4),		@imd_icC	numeric(13,4),		@imd_icD	numeric(13,4),
@imd_ictran	numeric(13,4),		@imd_icpck	numeric(13,4),		@imd_icttl	numeric(13,4),
@imd_hkfmloptA	nvarchar(4),		@imd_hkfmloptB	nvarchar(4),		@imd_hkfmloptC	nvarchar(4),
@imd_hkfmloptD	nvarchar(4),		@imd_hkfmloptT	nvarchar(4),		@imd_hkfmloptP	nvarchar(4),
@imd_ftyfmloptA	nvarchar(4),	@imd_ftyfmloptB	nvarchar(4),		@imd_ftyfmloptC nvarchar(4),
@imd_ftyfmloptD	nvarchar(4),	@imd_ftyfmloptT	nvarchar(4),	@imd_ftyfmloptP	nvarchar(4),
@imd_conftr	int,			@imd_itmtyp		nvarchar(3),
@imd_inrlin 	numeric(13,4),		@imd_inrwin 	numeric(13,4),		@imd_inrhin 	numeric(13,4),
@imd_mtrlin 	numeric(13,4),		@imd_mtrwin 	numeric(13,4),		@imd_mtrhin 	numeric(13,4),
@imd_splitr	nvarchar(800),		@imd_lgtno 	nvarchar(4),		@imd_frtchg 	nvarchar(6),
@imd_dbxlbcst	nvarchar(9), 		@imd_dbxlbcstch 	nvarchar(6),	@imd_ftytmp	nvarchar(4),
@imd_tgtret	numeric(13,4) ,		@imd_pckitr 	nvarchar(800),		@imd_lgtspec 	nvarchar(800),
@imd_stage 	nvarchar(1),		@imd_refresh	nvarchar(2),		@imd_xlsfil	nvarchar(30),
@imd_chkdat	datetime,		@imd_sysmsg	nvarchar(300),		@imd_prctrm	nvarchar(100),
@imd_remark	nvarchar(2000),		@imd_tranhk	numeric(13,4),		@imd_tranfty	numeric(13,4),
@imd_nat	nvarchar(6),		@imd_ccA	numeric(13,4),		@imd_ccB	numeric(13,4),
@imd_ccC	numeric(13,4),		@imd_ccD	numeric(13,4),		@imd_cctran	numeric(13,4),
@imd_ccpck	numeric(13,4),		@imd_calftyprc	numeric(13,4),		@imd_negprc	numeric(13,4),											@imd_std	nvarchar(1),		
@imd_creusr	nvarchar(30),		@imd_updusr	nvarchar(30),		@imd_credat	datetime,		
@imd_upddat	datetime ,		@imd_timstp	timestamp


DECLARE cur_IMMMITMDAT CURSOR
FOR 	SELECT 		imd_itmno,		imd_venno ,		imd_prdven ,
			imd_untcde ,		imd_mtrqty ,		imd_inrqty ,
			imd_itmseq ,		imd_recseq ,		imd_cus1no ,
			imd_cus2no ,		imd_lnecde ,		imd_catlvl4 ,
			imd_aliasItemNo,		imd_engdsc ,		imd_chndsc ,
			imd_curcde ,		imd_mode ,		imd_itmsts ,
			imd_fcA,		imd_fcB,		imd_fcC,
			imd_fcD,		imd_fctran,		imd_fcpck,
			imd_fcttl,		imd_cft,			imd_icA,
			imd_icB,			imd_icC,			imd_icD,
			imd_ictran,		imd_icpck,		imd_icttl,
			imd_hkfmloptA,		imd_hkfmloptB,		imd_hkfmloptC,
			imd_hkfmloptD,		imd_hkfmloptT,		imd_hkfmloptP,
			imd_ftyfmloptA,		imd_ftyfmloptB,		imd_ftyfmloptC,

			imd_ftyfmloptD,		imd_ftyfmloptT,		imd_ftyfmloptP,
			imd_conftr,		imd_itmtyp,		imd_ftytmp,
			imd_inrlin ,		imd_inrwin ,		imd_inrhin ,
			imd_mtrlin ,		imd_mtrwin ,		imd_mtrhin ,
			imd_splitr,		imd_lgtno ,		imd_frtchg ,
			imd_dbxlbcst ,		imd_dbxlbcstch ,	
			imd_tgtret ,		imd_pckitr ,		imd_lgtspec ,
			imd_stage ,		imd_refresh,		imd_xlsfil,
			imd_chkdat,		imd_sysmsg,		imd_prctrm,
			imd_remark,		imd_std,		imd_tranhk,	
			imd_tranfty,		imd_nat,		imd_ccA,
			imd_ccB,		imd_ccC,		imd_ccD,
			imd_cctran,		imd_ccpck,		imd_calftyprc,
			imd_negprc,
			imd_creusr,		imd_updusr,		imd_credat,		
			imd_upddat,		imd_timstp

	FROM 
			IMMMITMDAT	
	WHERE 	
			imd_stage = 'A' and 
			imd_mode = 'NEW' and
			imd_updusr  = @creusr

	ORDER BY imd_itmno, imd_chkdat


OPEN cur_IMMMITMDAT
FETCH NEXT FROM cur_IMMMITMDAT INTO 

	@imd_itmno,		@imd_venno ,		@imd_prdven ,
	@imd_untcde ,		@imd_mtrqty ,		@imd_inrqty ,
	@imd_itmseq ,		@imd_recseq ,		@imd_cus1no ,
	@imd_cus2no ,		@imd_lnecde ,		@imd_catlvl4 ,
	@imd_aliasItemNo,	@imd_engdsc ,		@imd_chndsc ,
	@imd_curcde ,		@imd_mode ,		@imd_itmsts ,
	@imd_fcA,		@imd_fcB,		@imd_fcC,
	@imd_fcD,		@imd_fctran,		@imd_fcpck,
	@imd_fcttl,		@imd_cft,		@imd_icA,
	@imd_icB,		@imd_icC,		@imd_icD,
	@imd_ictran,		@imd_icpck,		@imd_icttl,
	@imd_hkfmloptA,	@imd_hkfmloptB,	@imd_hkfmloptC,
	@imd_hkfmloptD,	@imd_hkfmloptT,	@imd_hkfmloptP,
	@imd_ftyfmloptA,	@imd_ftyfmloptB,	@imd_ftyfmloptC,
	@imd_ftyfmloptD,	@imd_ftyfmloptT,	@imd_ftyfmloptP,
	@imd_conftr,		@imd_itmtyp,		@imd_ftytmp,
	@imd_inrlin ,		@imd_inrwin ,		@imd_inrhin ,
	@imd_mtrlin ,		@imd_mtrwin ,		@imd_mtrhin ,
	@imd_splitr,		@imd_lgtno ,		@imd_frtchg ,
	@imd_dbxlbcst, 		@imd_dbxlbcstch ,		
	@imd_tgtret ,		@imd_pckitr ,		@imd_lgtspec ,
	@imd_stage ,		@imd_refresh,		@imd_xlsfil,
	@imd_chkdat,		@imd_sysmsg,		@imd_prctrm,
	@imd_remark,		@imd_std,		@imd_tranhk,	
	@imd_tranfty,		@imd_nat,		@imd_ccA,
	@imd_ccB,		@imd_ccC,		@imd_ccD,
	@imd_cctran,		@imd_ccpck,		@imd_calftyprc,
	@imd_negprc,
	@imd_creusr,		@imd_updusr,		@imd_credat,		
	@imd_upddat ,		@imd_timstp


	select @cbmcft = isnull(ycf_value,0) from syconftr where ycf_code1 = 'CBM' and ycf_code2 = 'CFT'

	
	WHILE @@fetch_status = 0
	BEGIN
	
	set @defven = ''
	set @ventyp = ''

	select @defven = ibi_venno
	from IMBASINF
	where 
		ibi_itmno = @imd_itmno




	if @defven is not NULL and @defven <> ''
	begin
		if @defven <> @imd_prdven
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

	

--IMBASINF START---------------------------------------------------------------------------------------------------------------------------------------------

		--set @ibi_rmk = left(@ibi_rmk,2000)		
		
		if (select count(*) from IMBASINF where ibi_itmno = @imd_itmno) = 0 
		begin
			set @ycr_catlvl0 = ''
			set @ycr_catlvl1 = ''
			set @ycr_catlvl2 = ''
			set @ycr_catlvl3 = ''
			select 
				@ycr_catlvl0 = ycr_catlvl0, 
				@ycr_catlvl1 = ycr_catlvl1, 
				@ycr_catlvl2 = ycr_catlvl2, 
				@ycr_catlvl3 = ycr_catlvl3
			from
				SYCATREL
			where
				ycr_catlvl4 =  @imd_catlvl4 
	
			insert into IMBASINF
			(	ibi_cocde ,		ibi_itmno ,		ibi_lnecde ,	
				ibi_curcde ,		ibi_catlvl4 ,		ibi_itmsts ,	
				ibi_typ ,			ibi_engdsc ,		ibi_chndsc ,	
				ibi_venno ,		ibi_cusven,
				ibi_cosmth ,		ibi_creusr ,	
				ibi_updusr ,		ibi_credat ,		ibi_upddat,
				ibi_tirtyp,		ibi_orgitm,		ibi_catlvl0,
				ibi_catlvl1,		ibi_catlvl2,		ibi_catlvl3,
				ibi_imgpth,		ibi_hamusa,		ibi_hameur,
				ibi_dtyusa,		ibi_dtyeur,		ibi_rmk,
				ibi_moqctn,		ibi_qty,			ibi_moa,
				ibi_wastage,		ibi_prdtyp,		ibi_ftytmp,
				ibi_prvsts, 		ibi_orgdvenno,		ibi_itmnat,
				ibi_alsitmno,		ibi_alscolcde 		
			)
			values
			(	' ',			@imd_itmno,		@imd_lnecde,
				@imd_curcde,		@imd_catlvl4,		'CMP',
				'REG',			@imd_engdsc,		@imd_chndsc,
				@imd_venno,		@imd_venno,
				' ',			'E-' + @imd_creusr ,
				'E-' + @imd_creusr ,	getdate(),		getdate(),
				'1',			'',			@ycr_catlvl0,
				@ycr_catlvl1,		@ycr_catlvl2,		@ycr_catlvl3,
				'',			'',			'',
				0,			0,			@imd_remark,
				0,			0,			0,
				0,			'',			@imd_ftytmp,			
				'INC',			'',			@imd_nat,
				 @imd_aliasItemNo,	''
			)
		end
		else -- NOT (if (select count(*) from IMBASINF where ibi_itmno = @imd_itmno) = 0 )
		begin

			update 
				IMBASINF 	
			set 	
				ibi_updusr = 'E-' + @imd_creusr ,
				ibi_upddat = getdate(),	
				ibi_itmsts = 
					(case (select count(*) from IMMMITMDAT where 
					 imd_itmno = @imd_itmno and imd_recseq <> @imd_recseq and
					(imd_stage = 'A' or imd_stage = 'R' or imd_stage = 'W')) when 0	then
					@imd_itmsts else ibi_itmsts end),
				ibi_prvsts = 
					(case (select count(*) from IMMMITMDAT where 
					imd_itmno = @imd_itmno and imd_recseq <> @imd_recseq and
					(imd_stage = 'A' or imd_stage = 'R' or imd_stage = 'W')) when 0	then
					@imd_itmsts else ibi_itmsts end),
--					@imd_itmsts else ibi_prvsts end),
				ibi_engdsc = @imd_engdsc,	
				ibi_chndsc = @imd_chndsc,
				ibi_itmnat = @imd_nat
			where	
				ibi_itmno = @imd_itmno and 
				ibi_itmsts = 'HLD' 	
		end
--IMBASINF END------------------------------------------------------------------------------------------------------------------------------------------------

--IMVENINF START---------------------------------------------------------------------------------------------------------------------------------------------
		if (select count(*) from IMVENINF where ivi_ITMNO = @imd_itmno and ivi_venno = @imd_venno)  = 0 
		begin

			insert into IMVENINF
			(	ivi_cocde ,		ivi_itmno ,		ivi_venitm ,
				ivi_venno ,		ivi_def ,			ivi_creusr ,	
				ivi_updusr ,		ivi_credat ,		ivi_upddat ,
				ivi_subcde	)
			values
			(	' ',			@imd_itmno,		@imd_itmno,
				@imd_venno,		'Y',			'E-' + @imd_creusr ,
				'E-' + @imd_creusr, 	getdate(),		getdate(),
				''	
			)
		end

--IMVENINF END---------------------------------------------------------------------------------------------------------------------------------------------

--IMPCKINF START---------------------------------------------------------------------------------------------------------------------------------------------
		if @imd_untcde <> ''
		begin
			if (	select count(*) 
				from IMPCKINF 
				where 	
					ipi_itmno = @imd_itmno and 
					ipi_pckunt = @imd_untcde and 
					ipi_inrqty = @imd_inrqty and 
					ipi_mtrqty = @imd_mtrqty ) = 0 
			begin	
				set  @ipi_pckseq = (select isnull(max(ipi_pckseq),0)  + 1 
						       from IMPCKINF 
						       where ipi_itmno = @imd_itmno)
	
				if @imd_inrhin is null
				begin
					set @imd_inrhin = 0 
				end
				if @imd_inrwin is null
				begin
					set @imd_inrwin = 0 
				end
				if @imd_inrlin is null
				begin
					set @imd_inrlin = 0 
				end	
				if @imd_mtrhin is null
				begin
					set @imd_mtrhin = 0 
				end
				if @imd_mtrwin is null
				begin
					set @imd_mtrwin = 0 
				end
				if @imd_mtrlin is null
				begin
					set @imd_mtrlin = 0 
				end	

				if @imd_cft is null
				begin
					set @imd_cft = 0 
				end	

				insert into IMPCKINF
				(	ipi_cocde ,		ipi_itmno ,		ipi_pckseq ,
					ipi_pckunt ,		ipi_mtrqty ,		ipi_inrqty ,
					ipi_inrhin ,		ipi_inrwin ,		ipi_inrdin ,
					ipi_inrhcm ,		ipi_inrwcm ,		ipi_inrdcm ,
					ipi_mtrhin ,		ipi_mtrwin ,		ipi_mtrdin ,
					ipi_mtrhcm ,		ipi_mtrwcm ,		ipi_mtrdcm ,
					ipi_cft ,			ipi_cbm ,		ipi_grswgt ,
					ipi_netwgt ,		ipi_pckitr ,		ipi_creusr ,
					ipi_updusr ,		ipi_credat ,		ipi_upddat,
					ipi_conftr,		ipi_sappckid,		ipi_cusno		
				)
				values
				(	' ', 			@imd_itmno,		@ipi_pckseq,
					@imd_untcde,		@imd_mtrqty,		@imd_inrqty,
					@imd_inrhin,		@imd_inrwin,		@imd_inrlin,
					@imd_inrhin/2.54,	@imd_inrwin/2.54,	@imd_inrlin/2.54,
					@imd_mtrhin,		@imd_mtrwin,		@imd_mtrlin,
					@imd_mtrhin/2.54,	@imd_mtrwin/2.54,	@imd_mtrlin/2.54,
					@imd_cft,		isnull(@imd_cft*@cbmcft,0),	0,	
					0,			@imd_pckitr,		'E-' + @imd_creusr ,
					'E-' + @imd_creusr ,	getdate(),		getdate() , 
					@imd_conftr,		'',			@imd_cus1no
				)
				
				if @ipi_pckseq = 1 
				begin
					insert into IMVENPCK
					(	ivp_cocde,		ivp_itmno,		ivp_pckseq,
						ivp_venno,		ivp_relatn,		ivp_creusr,
						ivp_updusr,		ivp_credat,		ivp_upddat		)
					values
					(	' ',			@imd_itmno,		@ipi_pckseq,
						@imd_venno,		'Yes',			'E-' + @imd_creusr ,
						'E-' + @imd_creusr ,	getdate(),		getdate()		
					)		
				end
				else
				begin
					insert into IMVENPCK
					(	ivp_cocde,		ivp_itmno,		ivp_pckseq,
						ivp_venno,		ivp_relatn,		ivp_creusr,
						ivp_updusr,		ivp_credat,		ivp_upddat		)
					select  
						' ',			@imd_itmno,		@ipi_pckseq,
						ivi_venno,		'Yes',			'E-' + @creusr ,
						'E-' + @imd_creusr,	getdate(),		getdate()
					 from 	IMVENINF
					where 	
						ivi_itmno = @imd_itmno
	
				end
			end
			else
			begin
				set @ipi_pckseq = (select ipi_pckseq from IMPCKINF where 	
					ipi_itmno = @imd_itmno and 
					ipi_pckunt = @imd_untcde and 
					ipi_inrqty = @imd_inrqty and 
					ipi_mtrqty = @imd_mtrqty )  
			end
		end

--IMPCKINF END---------------------------------------------------------------------------------------------------------------------------------------------

--IMMRKUP START------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		set @bomcst = 0
		set @bomprc = 0
		set @imu_selrat  = 0
		set @imu_buyrat = 0

--------------------------------------------------
------------ For PV = Dv Start ------------------
--------------------------------------------------


		if ltrim(rtrim(@imd_lnecde)) <> '' and @ventyp <> 'P' 
		begin


			select @imu_fmlopt = yaf_fmlopt, @fml = yaf_fml from SYCATFML 
			where 	
				yaf_lnecde = @imd_lnecde and
				yaf_catcde = @imd_catlvl4

			set @imd_fmlopt = @imu_fmlopt  
	
		
			--Calculate Item Price START---for Design Vendor-----------------------------------------
			SET @fml = LTRIM(RTRIM(@fml))
			SET @i  = 1
	
			set @fml = replace(@fml, ' ','')
	
			if (substring(@fml,1,1) <> '*') and (substring(@fml,1,1)<> '/')
			begin
				set @fml = '*' + @fml
			end
			--- Assign item Price	---
			set @bomcst = 0
			--set @imu_basprc = @imd_ftyprc + @bomcst
			set @imu_itmprc = @imd_icttl + @bomcst	
	
	
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
				begin
					set @end = charindex('/', @fml)
				end
				else if (charindex('/', @fml) = 0) 
				begin
					set @end = charindex('*', @fml)
				end
				else
				begin
					if (charindex('*', @fml) < charindex('/', @fml)) 
					begin
						set @end = charindex('*', @fml)
					end
					else
					begin
						set @end = charindex('/', @fml)
					end
				end
	
				set @temp = substring(@fml, 1, @end -1)
	
				if @OP = '*'
				begin
					set @imu_itmprc = @imu_itmprc * @temp
				end
				else if @OP = '/' 
	
				begin
					set @imu_itmprc = @imu_itmprc / @temp
				end
				
				set @fml = substring(@fml, @end, len(@fml))		
			end
			
			
			select 
				@imu_selrat = ysi_selrat ,
				@imu_buyrat = ysi_buyrat 
			from 
				SYSETINF (nolock)
			where 	
				ysi_typ = '06' and ysi_cde = 'HKD'


			-- Answer plus currency conversion
			if @imd_curcde = 'HKD'
			begin
				set @imu_itmprc = round(@imu_itmprc * @imu_selrat,4)
			end
			else
			begin
				set @imu_itmprc = round(@imu_itmprc,4)	
			end
			set @imd_basprc = @imu_itmprc
			--Calculate Basic Price END
			
			

			if @imd_conftr is NULL
			begin
				set @imd_conftr = 0
			end
	
	
			if @bomprc is NULL
			begin
				set @bomprc = 0
			end
	
			if @imd_fcD is NULL
			begin
				set @imd_fcD = 0
			end
	
			if @imd_icttl is NULL
			begin
				set @imd_icttl = 0
			end
	
			if @imd_fcttl is NULL
			begin
				set @imd_fcttl = 0
			end
	
			if @ipi_pckseq is NULL
			begin
				set @ipi_pckseq = 0
			end
	
			if @imd_cft is NULL
			begin
				set @imd_cft = 0
			end
	
			if @bomcst is NULL 
			begin
				set @bomcst = 0
			end
	
	
			set @imu_basprc = round(@imu_itmprc + @bomprc,4)
			--Calculate Item Price END
	
			if @imu_basprc is NULL
			begin
				set @imu_basprc = 0
			end

			if (select count(*) from IMMRKUP where imu_cocde = ' ' and imu_itmno = @imd_itmno and  imu_typ = @imd_itmtyp and imu_ventyp = 'D' 
				and imu_venno = @imd_venno and imu_prdven = @imd_prdven and imu_pckseq = @ipi_pckseq) = 0 
			begin	
				--for Design Vendor - Start
				if @ipi_pckseq = 1 -- the first packing, must be Design Vendor
				begin
					insert into IMMRKUP
					(	imu_cocde ,	imu_itmno ,	imu_typ ,
						imu_ventyp ,	imu_venno ,	imu_pckseq ,
						imu_pckunt ,	imu_inrqty ,	imu_mtrqty ,
						imu_cft ,		imu_curcde ,	imu_prctrm ,
						imu_relatn ,	imu_fmlopt ,	imu_ftycst ,
						imu_ftyprc ,	imu_calftyprc ,	imu_bcurcde,
						imu_basprc ,	imu_negprc ,	imu_creusr ,
						imu_updusr ,	imu_credat ,	imu_upddat ,
						imu_prdven ,	imu_ttlcst,  	imu_bomcst,
						imu_itmprc,	imu_bomprc,	imu_ftyprctrm, imu_ftybomcst,
						imu_conftr,	imu_std
					)
					values
					--(	@iid_cocde,	@itmno,		@ibi_typ,
					(	' ',		@imd_itmno,	@imd_itmtyp,
						'D',		@imd_venno,	@ipi_pckseq,
						@imd_untcde,	@imd_inrqty,	@imd_mtrqty,
						@imd_cft,			@imd_curcde,	@imd_prctrm,
						'Yes',		@imu_fmlopt,	round(@imd_fcttl,2),	
						round(@imd_icttl,2),	0,	'USD',
						@imu_basprc,	0,		'E-' + @creusr ,
						'E-' + @creusr ,			getdate(),	getdate(),
						@imd_prdven, 	round(@imd_icttl,2),	0,
						@imu_basprc,	0,		@imd_prctrm, 0,
						@imd_conftr,	@imd_std
					)

					--update 
					--	IMMRKUP 
					--set
					--	imu_bcurcde = @iid_fcurcde,
					--	imu_updusr = 'E-' + @creusr 
					--where
						--imu_cocde = @iid_cocde and
					--	imu_itmno = @itmno	and
					--	imu_ventyp = 'D' and 
					--	imu_venno = @iid_venno and
					--	imu_pckunt = @iid_untcde and 
					--	imu_typ = 'BOM'		
				end
				else
				begin
					insert into IMMRKUP
					(	imu_cocde ,	imu_itmno ,	imu_typ ,
						imu_ventyp ,	imu_venno ,	imu_pckseq ,
						imu_pckunt ,	imu_inrqty ,	imu_mtrqty ,
						imu_cft ,		imu_curcde ,	imu_prctrm ,
						imu_relatn ,	imu_fmlopt ,	imu_ftycst ,
						imu_ftyprc ,	imu_calftyprc ,	imu_bcurcde,
						imu_basprc ,	imu_negprc ,	imu_creusr ,
						imu_updusr ,	imu_credat ,	imu_upddat ,
						imu_prdven ,	imu_ttlcst,	imu_bomcst,
						imu_itmprc,	imu_bomprc, 	imu_ftyprctrm,
						imu_ftybomcst,	imu_conftr,	imu_std
					)
					values
					--(  	@iid_cocde,	@itmno,		@ibi_typ,
					(  	' ',	@imd_itmno,		@imd_itmtyp,
						'D',		@imd_venno,	@ipi_pckseq,
						@imd_untcde,	@imd_inrqty,	@imd_mtrqty,
						@imd_cft,	@imd_curcde,	@imd_prctrm,
						'Yes',		@imu_fmlopt,	round(@imd_fcttl,2),
						round(@imd_icttl,2),	0,		'USD',
						@imu_basprc,	0,		'E-' + @creusr ,
						'E-' + @creusr ,	getdate(),	getdate(),
						@imd_prdven, 	round(@imd_icttl,2),	@bomcst,	
						@imu_basprc,	0, 		@imd_prctrm,
						0,		@imd_conftr,	@imd_std
					)
				end
			end


			if (select count(*) from IMMRKUP where imu_cocde = ' ' and imu_itmno = @imd_itmno and  imu_typ = @imd_itmtyp and imu_ventyp = 'P' 
				and imu_venno = @imd_venno and imu_prdven = @imd_prdven and imu_pckseq = @ipi_pckseq) = 0 
			begin	

			--for Production Vendor - Start (DV=PV)
				insert into IMMRKUP
				(	imu_cocde ,		imu_itmno ,		imu_typ ,
					imu_ventyp ,		imu_venno ,		imu_pckseq ,
					imu_prdven,		imu_pckunt,		imu_mtrqty,
					imu_inrqty,		imu_cft,			imu_curcde,
					imu_prctrm,		imu_relatn,		imu_fmlopt,
					imu_ftycst,		imu_ftyprc,		imu_calftyprc,
					imu_bcurcde,		imu_basprc,		imu_negprc,			
					imu_bomcst,		imu_ttlcst,		imu_alsbasprc,
					imu_itmprc,		imu_bomprc,		imu_ftybomcst,
					imu_ftyprctrm,		imu_conftr,		imu_std,
					imu_creusr ,		imu_updusr ,		
					imu_credat ,		imu_upddat
				)
				values
				(	' ',			@imd_itmno,		@imd_itmtyp,
					'P',			@imd_venno,		@ipi_pckseq,
					@imd_prdven,		@imd_untcde,		@imd_mtrqty,
					@imd_inrqty,		@imd_cft,		@imd_curcde,
					@imd_prctrm,		'Yes',			'PDV',
					round(@imd_fcttl,2),	round(@imd_icttl,2),		round(@imd_icttl,2),
					'USD',			@imu_basprc,		0,
					@bomcst,		round(@imd_icttl+@bomcst,2),		0,
					@imu_itmprc,		0,			0,				
					@imd_prctrm,		@imd_conftr,		@imd_std,
					'E-' + @creusr,		'E-' + @creusr,		
					getdate(),		getdate()
				)				 									
			end
		end			
-- Checked
-- Checked
-- Checked

		--***  for  Production  Vendor  only for UCPP

		DECLARE cur_IMMRKUP CURSOR
		FOR 	SELECT 	
				ymf_fmlopt,  	
				yfi_fml,		
				ivi_venno
			FROM 	
				IMVENINF
				LEFT JOIN SYMRKFML ON
					ivi_venno = ymf_prdvenno and 
					ymf_degvenno =@imd_venno and 
					ymf_mkpopt = @imu_fmlopt
				LEFT JOIN SYFMLINF ON
					yfi_fmlopt = ymf_fmlopt 
			WHERE	
				ivi_itmno = @imd_itmno and --ivi_def = 'N' 
				ivi_venno <> @imd_venno

		OPEN cur_IMMRKUP
		FETCH NEXT FROM cur_IMMRKUP INTO 
		@imu_fmlopt,	@imu_fml,	@ivi_venno

		WHILE @@fetch_status = 0
		BEGIN	

			if @imu_fmlopt is NULL or @imu_fmlopt = ''
			begin

				insert into IMMRKUP
				(	imu_cocde ,	imu_itmno ,	imu_typ ,
					imu_ventyp ,	imu_venno ,	imu_pckseq ,
					imu_pckunt ,	imu_inrqty ,	imu_mtrqty ,
					imu_cft ,	imu_curcde ,	imu_prctrm ,
					imu_relatn ,	imu_fmlopt ,	imu_ftycst ,
					imu_ftyprc ,	imu_calftyprc ,	imu_bcurcde,
					imu_basprc ,	imu_negprc ,	imu_creusr ,
					imu_updusr ,	imu_credat ,	imu_upddat ,
					imu_prdven , 	imu_ttlcst,	imu_ftyprctrm,
					imu_ftybomcst,	imu_conftr,	imu_std
				)
				values
				(	' ',		@imd_itmno,	@imd_itmtyp,
					'P',		@imd_venno,	@ipi_pckseq,
					@imd_untcde,	@imd_inrqty,	@imd_mtrqty,
					@imd_cft,	@imd_curcde,	@imd_prctrm,
					'Yes',		'PDV',		0,	
					0,		0,		'USD',
					round(@imu_basprc+@bomprc,4),	0,		'E-' + @creusr ,
					'E-' + @creusr ,	getdate(),		getdate(),
					@ivi_venno,	0,		@imd_prctrm,
					0,		@imd_conftr,	@imd_std
				) 	

			end
			else -- NOT(@imu_fmlopt is NULL or @imu_fmlopt = '')
			begin
--				if @imu_fml is null or @imu_fml = '' and @ibi_typ  <> 'BOM'
				if @imu_fml is null or @imu_fml = ''
				begin
					set @imu_fml = '0'
				end
		
				-- @imu_bcurcde is null
				-- begin
				--	set @imu_bcurcde = ''
				--end
			
				if @imu_selrat is null
				begin
					set @imu_selrat = 0
				end
					
				--Calculate Calculate Factory Price START---for Production Vendor-----------------------------------------
				SET @fml = LTRIM(RTRIM(@imu_fml))
				SET @i  = 1
			
				set @fml = replace(@fml, ' ','')
				if (substring(@fml,1,1) <> '*') and (substring(@fml,1,1)<> '/')
				begin
					set @fml = '*' + @fml
				end
			
				--- Assugn Cal Fty Prc Variable ---
				set @imu_calftyprc = @imu_basprc + @bomprc
				------------------------------------------
			
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
					begin
						set @end = charindex('/', @fml)
					end
					else if (charindex('/', @fml) = 0) 
					begin
						set @end = charindex('*', @fml)
					end
					else
					begin
						if (charindex('*', @fml) < charindex('/', @fml)) 
						begin
							set @end = charindex('*', @fml)
						end
						else
						begin
							set @end = charindex('/', @fml)
						end
					end
		
					set @temp = substring(@fml, 1, @end -1)
					if @OP = '*'
					begin
						set @imu_calftyprc = @imu_calftyprc * @temp
					end
					else if @OP = '/' 
					begin
						set @imu_calftyprc = @imu_calftyprc / @temp
					end
				
					set @fml = substring(@fml, @end, len(@fml))
				end -- while

				-- set @imu_calftyprc = round(@imu_calftyprc / @imu_selrat,4)
				-- Allan Yuen amend the roundup to 2 decimal point  at 2005-02-03

				if @imd_curcde = 'HKD'
				begin
				 	set @imu_calftyprc = round(@imu_calftyprc / @imu_selrat,2)
				end

				--	select @imu_calftyprc, @imu_selrat
				--Calculate Calculate Factory Price END--------------------------------------------

				--select @iba_count = isnull(count(*), 0) from IMFMLHDR where ifh_table = 'IMMRKUP' and ifh_field = 'imu_ftybomcst' and ifh_dv = @iid_venno and ifh_pv = @ivi_venno 
				--if @iba_count = 1
				--begin
				--	set @imu_ftybomcst = @imu_ftybomcst_ftycst
				--end
				--else
				--begin

				--	set @imu_ftybomcst = @imu_ftybomcst_untcst
				--end

				insert into IMMRKUP
				(	imu_cocde ,	imu_itmno ,	imu_typ ,
					imu_ventyp ,	imu_venno ,	imu_pckseq ,
					imu_pckunt ,	imu_inrqty ,	imu_mtrqty ,
					imu_cft ,	imu_curcde ,	imu_prctrm ,
					imu_relatn ,	imu_fmlopt ,	imu_ftycst ,
					imu_ftyprc ,	imu_calftyprc ,	imu_bcurcde,
					imu_basprc ,	imu_negprc ,	imu_creusr ,
					imu_updusr ,	imu_credat ,	imu_upddat ,
					imu_prdven ,	imu_ttlcst,	imu_ftyprctrm,
					imu_ftybomcst,	imu_conftr,	imu_std
				)
				values
				--(	@iid_cocde,	@itmno,		@ibi_typ,
				(	' ',	@imd_itmno,		@imd_itmtyp,
					'P',		@imd_venno,	@ipi_pckseq,
					@imd_untcde,	@imd_inrqty,	@imd_mtrqty,
					@imd_cft,	@imd_curcde,	@imd_prctrm,
					'Yes',		@imu_fmlopt,	0,	
					0,		round(@imu_calftyprc,2),	'USD',
					round(@imu_basprc+@bomprc,4),	0,		'E-' + @creusr ,
					'E-' + @creusr , 	getdate(),		getdate(),
					@ivi_venno,	0,		@imd_prctrm,
					0,		@imd_conftr,	@imd_std	
				) 	
			end

		FETCH NEXT FROM cur_IMMRKUP INTO 
		@imu_fmlopt,	@imu_fml,	@ivi_venno
		END
		CLOSE cur_IMMRKUP
		DEALLOCATE cur_IMMRKUP













--------------------------------------------------
------------ For PV <> Dv Start ------------------
--------------------------------------------------


	if @imd_untcde <> '' and @ventyp = 'P'
	begin

		select 
			@imu_fmlopt = yaf_fmlopt, 
			@imu_fml = yaf_fml 
		from 
			SYCATFML 
		where 	
			yaf_lnecde = @imd_lnecde and
			yaf_catcde = @imd_catlvl4

		set @imd_fmlopt = @imu_fmlopt 

		--select 
		--	@imu_bcurcde = ysi_cde 
		--from 
		--	SYSETINF 
		--where 	
		--	ysi_typ = '06' and 	
		--	ysi_def = 'Y' 	

		select 
			@imu_selrat = ysi_selrat 
		from 
			SYSETINF 
		where 	
		 	ysi_typ = '06' and 	
			ysi_cde = @imd_curcde	
	
		select 	
			@imu_fmlopt_P = ymf_fmlopt, 
			@imu_fml_P = yfi_fml
		from	
			SYMRKFML
			left join SYFMLINF on
			yfi_fmlopt = ymf_fmlopt 
		where	
			ymf_prdvenno = @imd_prdven and
			ymf_degvenno = @imd_venno and 
			ymf_mkpopt = @imu_fmlopt


		if (@imu_fmlopt_P is NULL or @imu_fmlopt_P = '') 
		begin
			insert into IMMRKUP
			(	imu_cocde ,	imu_itmno ,	imu_typ ,
				imu_ventyp ,	imu_venno ,	imu_pckseq ,
				imu_pckunt ,	imu_inrqty ,	imu_mtrqty ,
				imu_cft ,		imu_curcde ,	imu_prctrm ,
				imu_relatn ,	imu_fmlopt ,	imu_ftycst ,
				imu_ftyprc ,	imu_calftyprc ,	imu_bcurcde,
				imu_basprc ,	imu_negprc ,	imu_creusr ,
				imu_updusr ,	imu_credat ,	imu_upddat,
				imu_prdven , 	imu_ttlcst, 	imu_ftyprctrm,
				imu_ftybomcst,	imu_conftr,	imu_std
			)
			values
			(	' ',	@imd_itmno,		@imd_itmtyp,
				'P',		@ivi_venno,	@ipi_pckseq,
				@imd_untcde,	@imd_inrqty,	@imd_mtrqty,
				@imd_cft,	@imd_curcde,	@imd_prctrm,
				'Yes',		'PDV',		0,	
				0,		0,		'USD',
				@imu_basprc + @bomprc,	0,		'E-' + @creusr ,
				'E-' + @creusr ,	getdate(),		getdate(),
				@imd_prdven,	0, 		@imd_prctrm,
				0,		@imd_conftr,	@imd_std
			) 	
		end
		else
		begin
			if @imu_fml_P is null or @imu_fml_P = ''
			begin
				set @imu_fml_P = '0'
			end
		
			--if @imu_bcurcde is null
			--begin
			--	set @imu_bcurcde = ''
			--end
		
			if @imu_selrat is null
			begin
				set @imu_selrat = 0
			end
					
			--Calculate Basic Price START---for Production Vendor-----------------------------------------
			SET @fml = LTRIM(RTRIM(@imu_fml_P))
			SET @i  = 1
		
			set @fml = replace(@fml, ' ','')
			if (substring(@fml,1,1) <> '*') and (substring(@fml,1,1)<> '/')
			begin
				set @fml = '*' + @fml
			end
			--- Assign Item Cost ----
			set @imu_basprc = @imd_icttl + @bomprc
			------------------------------
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
				begin
					set @end = charindex('/', @fml)
				end
				else if (charindex('/', @fml) = 0) 
				begin
					set @end = charindex('*', @fml)
				end
				else
				begin
					if (charindex('*', @fml) < charindex('/', @fml)) 
					begin
						set @end = charindex('*', @fml)
					end
					else
					begin
						set @end = charindex('/', @fml)
					end
				end
		
				set @temp = substring(@fml, 1, @end -1)
				if @OP = '*'
				begin
					set @imu_basprc = @imu_basprc / @temp
				end
				else if @OP = '/' 
				begin
					set @imu_basprc = @imu_basprc * @temp
				end
				
				set @fml = substring(@fml, @end, len(@fml))
			end
			---------------------------------------
			if @imd_curcde = 'HKD'
			begin
				set @imu_basprc = round(@imu_basprc * @imu_selrat,4)
				set @imd_basprc = @imu_basprc
			end	
			---------------------------------------
			--Calculate Basic Price END--------------------------------------------



			--Insert Production Vendor 
			insert into IMMRKUP
			(	imu_cocde ,	imu_itmno ,	imu_typ ,
				imu_ventyp ,	imu_venno ,	imu_pckseq ,
				imu_pckunt ,	imu_inrqty ,	imu_mtrqty ,
				imu_cft ,		imu_curcde ,	imu_prctrm ,
				imu_relatn ,	imu_fmlopt ,	imu_ftycst ,
				imu_ftyprc ,	imu_calftyprc ,	imu_bcurcde,
				imu_basprc ,	imu_negprc ,	imu_creusr ,
				imu_updusr ,	imu_credat ,	imu_upddat,
				imu_prdven ,	imu_ttlcst, 	imu_ftyprctrm,
				imu_ftybomcst,	imu_conftr,	imu_std
			)
			values
			--(	@iid_cocde,	@itmno,		@ibi_typ,
			(	' ',		@imd_itmno,	@imd_itmtyp,
				'P',		@imd_venno,	@ipi_pckseq,
				@imd_untcde,	@imd_inrqty,	@imd_mtrqty,
				@imd_cft,	@imd_curcde,	@imd_prctrm,
				'Yes',		@imu_fmlopt_P,	0,	
				0,		round(@imd_icttl,2),	'USD',
				round(@imu_basprc+ @bomprc,4),	0,	'E-' + @creusr ,
				'E-' + @creusr ,	getdate(),		getdate(),
				@imd_prdven,	0, 		@imd_prctrm,
				0,		@imd_conftr,	@imd_std
			) 	

		end

			if @imu_fml is null or @imu_fml = ''
			begin
				set @imu_fml = '0'
			end
			
			if @imu_selrat is null
			begin
				set @imu_selrat = 0
			end
					
			--Calculate Factory Price START---for Design & Production Vendor-----------------------------------------
			SET @fml = LTRIM(RTRIM(@imu_fml))
			SET @i  = 1
		
			set @fml = replace(@fml, ' ','')
			if (substring(@fml,1,1) <> '*') and (substring(@fml,1,1)<> '/')
			begin
				set @fml = '*' + @fml
			end
			---- Assign Cal Fty Price ----	
			set @imu_ftyprc = @imu_basprc + @bomprc
			----------------------------------					
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
				begin
					set @end = charindex('/', @fml)
				end
				else if (charindex('/', @fml) = 0) 
				begin
					set @end = charindex('*', @fml)
				end
				else
				begin
					if (charindex('*', @fml) < charindex('/', @fml)) 
					begin
						set @end = charindex('*', @fml)
					end
					else
					begin
						set @end = charindex('/', @fml)
					end
				end
		
				set @temp = substring(@fml, 1, @end -1)
				if @OP = '*'
				begin
					set @imu_ftyprc = @imu_ftyprc / @temp
				end
				else if @OP = '/' 
				begin
					set @imu_ftyprc = @imu_ftyprc * @temp
				end
				
				set @fml = substring(@fml, @end, len(@fml))
			end

			-- Allan Yuen Change to 2 decimal point at 2005-02-03
			--set @imu_ftyprc = round(@imu_ftyprc / @imu_selrat,4)
			if @imd_curcde = 'HKD'
			begin
				set @imu_ftyprc = round(@imu_ftyprc / @imu_selrat,2)
			end
			--Insert Design Vendor 
			insert into IMMRKUP
			(	imu_cocde ,	imu_itmno ,	imu_typ ,
				imu_ventyp ,	imu_venno ,	imu_pckseq ,
				imu_pckunt ,	imu_inrqty ,	imu_mtrqty ,
				imu_cft ,	imu_curcde ,	imu_prctrm ,
				imu_relatn ,	imu_fmlopt ,	imu_ftycst ,
				imu_ftyprc ,	imu_calftyprc ,	imu_bcurcde,
				imu_basprc ,	imu_negprc ,	imu_creusr ,
				imu_updusr ,	imu_credat ,	imu_upddat,
				imu_prdven , 	imu_ttlcst,
				imu_bomcst,	imu_itmprc,	imu_bomprc, 
				imu_ftyprctrm, imu_ftybomcst,	imu_conftr,
				imu_std
			)
			values
			--(	@iid_cocde,	@itmno,		@ibi_typ,
			(	' ',		@imd_itmno,	@imd_itmtyp,
				'D',		@imd_venno,	@ipi_pckseq,
				@imd_untcde,	@imd_inrqty,	@imd_mtrqty,
				@imd_cft,	@imd_curcde,	@imd_prctrm,
				'Yes',		@imu_fmlopt,	0,	
				round(@imu_ftyprc,4),	0,	0,
				round(@imu_basprc+@bomprc,4),	0,	'E-' + @creusr ,
				'E-' + @creusr ,	getdate(),		getdate(),
				@imd_prdven ,	round(@imu_ftyprc+@bomcst,4),
				@bomcst,		@imu_basprc,	@bomprc, 
				@imd_prctrm, 	0,		@imd_conftr,
				@imd_std
			)





			--Insert Design Vendor and also is Production Vendor
			insert into IMMRKUP
			(	imu_cocde ,	imu_itmno ,	imu_typ ,
				imu_ventyp ,	imu_venno ,	imu_pckseq ,
				imu_pckunt ,	imu_inrqty ,	imu_mtrqty ,
				imu_cft ,	imu_curcde ,	imu_prctrm ,
				imu_relatn ,	imu_fmlopt ,	imu_ftycst ,
				imu_ftyprc ,	imu_calftyprc ,	imu_bcurcde,
				imu_basprc ,	imu_negprc ,	imu_creusr ,
				imu_updusr ,	imu_credat ,	imu_upddat ,
				imu_prdven ,	imu_ttlcst, 	imu_ftyprctrm,
				imu_ftybomcst,	imu_conftr,	imu_std
			)
			values
			--(  	@iid_cocde,	@itmno,		@ibi_typ,
			(  	' ',	@imd_itmno,		@imd_itmtyp,
				'P',		@imd_venno,	@ipi_pckseq,
				@imd_untcde,	@imd_inrqty,	@imd_mtrqty,
				@imd_cft,		@imd_curcde,	@imd_prctrm,
				'Yes',		'PDV',		0,	
				0,		round(@imu_ftyprc,2),	0,
				round(@imu_basprc+@bomprc,4),	0,		'E-' + @creusr ,
				'E-' + @creusr ,	getdate(),		getdate(),
				@imd_venno,	0,		@imd_prctrm,
				0,		@imd_conftr,	@imd_std
			)
----		
		end





--IMMRKUP END------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--IMCOLINF START----------------------------------------------------------------------------------------------------------

set @colcde = 'N/A'
set @coldsc = 'N/A'
set @colseq = 1


If (select count(*) from IMCOLINF where  icf_itmno = @imd_itmno and icf_colcde = @colcde and icf_colseq = @colseq) = 0
begin
	Insert into IMCOLINF
	(	icf_cocde,	icf_itmno,	icf_colcde,	
		icf_colseq,	icf_vencol,	icf_coldsc,	
		icf_typ,		icf_ucpcde,	icf_eancde,	
		icf_creusr,	icf_updusr,	icf_credat,	
		icf_upddat 	)
	values 
	(	' ', 		@imd_itmno,	@colcde,	
		@colseq,	@colcde,	@coldsc,	
		'',		'',		'',		
		'E-' + @creusr ,	'E-' + @creusr ,	getdate(),	
		getdate()		)
		set @updsts = 'Y'
end

--IMCOLINF END------------------------------------------------------------------------------------------------------------


--IMMRKUPDTL START-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


		--set @debug = 1
		--if @debug = 1
		--begin
		--	print '@imd_bcurcde=' 
		--end


		if (select count(*) from IMMRKUPDTL where imd_cocde = ' ' and imd_itmno = @imd_itmno and  imd_typ = @imd_itmtyp and imd_ventyp = 'D' 
			and imd_venno = @imd_venno and imd_prdven = @imd_prdven and imd_pckseq = @ipi_pckseq 
			and imd_cus1no = @imd_cus1no and imd_cus2no = @imd_cus2no) = 0 

		--set @debug = 1
		--if @debug = 1
		--begin
		--	print 'imd_curcde=' +  CONVERT(VARCHAR(20), @imd_curcde ) 		
			--print '@imd_bcurcde=' 


		--end

		--set @imd_negprc = 0

		begin	
			insert into IMMRKUPDTL
			(	imd_cocde ,		imd_itmno ,		imd_typ ,
				imd_ventyp ,		imd_venno ,		imd_pckseq ,
				imd_prdven,		imd_untcde,		imd_mtrqty,
				imd_inrqty,		imd_cus1no,		imd_cus2no,
				imd_catlvl4,		imd_curcde,		imd_fcA,
				imd_fcB,		imd_fcC,		imd_fcD,
				imd_fctran,		imd_fcpck,		imd_icA,
				imd_icB,			imd_icC,			imd_icD,
				imd_ictran,		imd_icpck,		imd_fm1A,
				imd_fm1B,		imd_fm1C,		imd_fm1D,
				imd_fm1tran,		imd_fm1pck,		imd_fm2A,
				imd_fm2B,		imd_fm2C,		imd_fm2D,
				imd_fm2tran,		imd_fm2pck,		imd_fcttl,
				imd_icttl,		imd_fmlopt,		imd_bcurcde,
				imd_basprc,		imd_lgtno,		imd_frtchg,
				imd_dbxlbcst,		imd_dbxlbcstch,	
				imd_tgtret,		imd_pckitr,		imd_lgtspec,	
				imd_prctrm,		imd_conftr,		imd_ccA,		
				imd_ccB,		imd_ccC,		imd_ccD,
				imd_cctran,		imd_ccpck,		imd_calftyprc,		
				imd_negprc,		imd_tranhk,		imd_tranfty,
				imd_creusr ,		imd_updusr ,		imd_credat ,		
				imd_upddat
			)
			values

			(	'' ,			@imd_itmno ,		@imd_itmtyp ,
				'D' ,			@imd_venno ,		@ipi_pckseq ,
				@imd_prdven,		@imd_untcde,		@imd_mtrqty,
				@imd_inrqty,		@imd_cus1no,		@imd_cus2no,
				@imd_catlvl4,		@imd_curcde,		@imd_fcA,		
				@imd_fcB,		@imd_fcC,		@imd_fcD,
				@imd_fctran,		@imd_fcpck,		@imd_icA,
				@imd_icB,		@imd_icC,		@imd_icD,
				@imd_ictran,		@imd_icpck,		@imd_hkfmloptA,
				@imd_hkfmloptB,	@imd_hkfmloptC,	@imd_hkfmloptD,
				@imd_hkfmloptT,	@imd_hkfmloptP,	@imd_ftyfmloptA,
				@imd_ftyfmloptB,	@imd_ftyfmloptC,	@imd_ftyfmloptD,
				@imd_ftyfmloptT,	@imd_ftyfmloptP,	round(@imd_fcttl,2),
				round(@imd_icttl,2),	@imd_fmlopt,		'USD',
				@imd_basprc,		@imd_lgtno,		@imd_frtchg,
				@imd_dbxlbcst,		@imd_dbxlbcstch,	
				@imd_tgtret,		@imd_pckitr,		@imd_lgtspec,	
				@imd_prctrm,		@imd_conftr,		@imd_ccA,		
				@imd_ccB,		@imd_ccC,		@imd_ccD,
				@imd_cctran,		@imd_ccpck,		@imd_calftyprc,
				@imd_negprc,		@imd_tranhk,		@imd_tranfty,
				'E-' + @creusr,		'E-' + @creusr,		getdate(),
				getdate()
			)
		


		end

--IMMRKUPDTL END-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



insert into IMMMITMDATH 
	(	imd_itmno,		imd_venno ,		imd_prdven ,
		imd_untcde ,		imd_mtrqty ,		imd_inrqty ,
		imd_itmseq ,		imd_recseq ,		imd_cus1no ,
		imd_cus2no ,		imd_lnecde ,		imd_catlvl4 ,
		imd_aliasItemNo,	imd_engdsc ,		imd_chndsc ,
		imd_curcde ,		imd_mode ,		imd_itmsts ,
		imd_fcA,		imd_fcB,		imd_fcC,
		imd_fcD,		imd_fctran,		imd_fcpck,
		imd_fcttl,		imd_cft,			imd_icA,
		imd_icB,			imd_icC,			imd_icD,
		imd_ictran,		imd_icpck,		imd_icttl,
		imd_hkfmloptA,		imd_hkfmloptB,		imd_hkfmloptC,
		imd_hkfmloptD,		imd_hkfmloptT,		imd_hkfmloptP,
		imd_ftyfmloptA,		imd_ftyfmloptB,		imd_ftyfmloptC,
		imd_ftyfmloptD,		imd_ftyfmloptT,		imd_ftyfmloptP,
		imd_conftr,		imd_itmtyp,
		imd_inrlin ,		imd_inrwin ,		imd_inrhin ,
		imd_mtrlin ,		imd_mtrwin ,		imd_mtrhin ,
		imd_splitr,		imd_lgtno ,		imd_frtchg ,
		imd_dbxlbcst ,		imd_dbxlbcstch ,		imd_ftytmp,
		imd_tgtret ,		imd_pckitr ,		imd_lgtspec ,
		imd_stage ,		imd_refresh,		imd_xlsfil,

		imd_chkdat,		imd_sysmsg,		imd_prctrm,
		imd_remark,		imd_std,		imd_tranhk,	
		imd_tranfty,		imd_nat,		imd_ccA,
		imd_ccB,		imd_ccC,		imd_ccD,
		imd_cctran,		imd_ccpck,		imd_calftyprc,
		imd_negprc,	
		imd_creusr,		imd_updusr,		imd_credat,		
		imd_upddat		
	)
	values
	(
		@imd_itmno,		@imd_venno ,		@imd_prdven ,
		@imd_untcde ,		@imd_mtrqty ,		@imd_inrqty ,
		@imd_itmseq ,		@imd_recseq ,		@imd_cus1no ,
		@imd_cus2no ,		@imd_lnecde ,		@imd_catlvl4 ,
		@imd_aliasItemNo,	@imd_engdsc ,		@imd_chndsc ,
		@imd_curcde ,		@imd_mode ,		@imd_itmsts ,
		@imd_fcA,		@imd_fcB,		@imd_fcC,
		@imd_fcD,		@imd_fctran,		@imd_fcpck,
		round(@imd_fcttl,2),	@imd_cft,		@imd_icA,
		@imd_icB,		@imd_icC,		@imd_icD,
		@imd_ictran,		@imd_icpck,		round(@imd_icttl,2),
		@imd_hkfmloptA,	@imd_hkfmloptB,	@imd_hkfmloptC,
		@imd_hkfmloptD,	@imd_hkfmloptT,	@imd_hkfmloptP,
		@imd_ftyfmloptA,	@imd_ftyfmloptB,	@imd_ftyfmloptC,
		@imd_ftyfmloptD,	@imd_ftyfmloptT,	@imd_ftyfmloptP,
		@imd_conftr,		@imd_itmtyp,
		@imd_inrlin ,		@imd_inrwin ,		@imd_inrhin ,
		@imd_mtrlin ,		@imd_mtrwin ,		@imd_mtrhin ,
		@imd_splitr,		@imd_lgtno ,		@imd_frtchg ,
		@imd_dbxlbcst, 		@imd_dbxlbcstch ,	@imd_ftytmp,
		@imd_tgtret ,		@imd_pckitr ,		@imd_lgtspec ,
		@imd_stage ,		@imd_refresh,		@imd_xlsfil,
		@imd_chkdat,		@imd_sysmsg,		@imd_prctrm,
		@imd_remark,		@imd_std,		@imd_tranhk,	
		@imd_tranfty,		@imd_nat,		@imd_ccA,
		@imd_ccB,		@imd_ccC,		@imd_ccD,
		@imd_cctran,		@imd_ccpck,		@imd_calftyprc,
		@imd_negprc,
		@imd_creusr,		@imd_updusr,		@imd_credat,		
		@imd_upddat 		
	)


delete from IMMMITMDAT where 	imd_itmno = @imd_itmno and imd_venno = @imd_venno and imd_prdven = @imd_prdven and
				imd_untcde = @imd_untcde and imd_mtrqty = @imd_mtrqty and
				imd_inrqty = @imd_inrqty and imd_mtrqty = @imd_mtrqty and
				imd_itmseq = @imd_itmseq and imd_recseq = @imd_recseq and
				imd_stage = 'A' and imd_mode = 'NEW'

FETCH NEXT FROM cur_IMMMITMDAT INTO 

	@imd_itmno,		@imd_venno ,		@imd_prdven ,
	@imd_untcde ,		@imd_mtrqty ,		@imd_inrqty ,
	@imd_itmseq ,		@imd_recseq ,		@imd_cus1no ,
	@imd_cus2no ,		@imd_lnecde ,		@imd_catlvl4 ,
	@imd_aliasItemNo,	@imd_engdsc ,		@imd_chndsc ,
	@imd_curcde ,		@imd_mode ,		@imd_itmsts ,
	@imd_fcA,		@imd_fcB,		@imd_fcC,
	@imd_fcD,		@imd_fctran,		@imd_fcpck,
	@imd_fcttl,		@imd_cft,		@imd_icA,
	@imd_icB,		@imd_icC,		@imd_icD,
	@imd_ictran,		@imd_icpck,		@imd_icttl,
	@imd_hkfmloptA,	@imd_hkfmloptB,	@imd_hkfmloptC,
	@imd_hkfmloptD,	@imd_hkfmloptT,	@imd_hkfmloptP,
	@imd_ftyfmloptA,	@imd_ftyfmloptB,	@imd_ftyfmloptC,
	@imd_ftyfmloptD,	@imd_ftyfmloptT,	@imd_ftyfmloptP,
	@imd_conftr,		@imd_itmtyp,		@imd_ftytmp,
	@imd_inrlin ,		@imd_inrwin ,		@imd_inrhin ,
	@imd_mtrlin ,		@imd_mtrwin ,		@imd_mtrhin ,
	@imd_splitr,		@imd_lgtno ,		@imd_frtchg ,
	@imd_dbxlbcst, 		@imd_dbxlbcstch ,		
	@imd_tgtret ,		@imd_pckitr ,		@imd_lgtspec ,
	@imd_stage ,		@imd_refresh,		@imd_xlsfil,
	@imd_chkdat,		@imd_sysmsg,		@imd_prctrm,
	@imd_remark,		@imd_std,		@imd_tranhk,	
	@imd_tranfty,		@imd_nat,		@imd_ccA,
	@imd_ccB,		@imd_ccC,		@imd_ccD,
	@imd_cctran,		@imd_ccpck,		@imd_calftyprc,
	@imd_negprc,
	@imd_creusr,		@imd_updusr,		@imd_credat,		
	@imd_upddat ,		@imd_timstp




END
CLOSE cur_IMMMITMDAT
DEALLOCATE cur_IMMMITMDAT










GO
GRANT EXECUTE ON [dbo].[sp_insert_IMMMINSDAT] TO [ERPUSER] AS [dbo]
GO
