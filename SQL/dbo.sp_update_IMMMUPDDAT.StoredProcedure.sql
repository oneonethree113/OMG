/****** Object:  StoredProcedure [dbo].[sp_update_IMMMUPDDAT]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_update_IMMMUPDDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_update_IMMMUPDDAT]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO








/*
=========================================================
Program ID	: sp_update_IMMMUPDDAT
Description   	: 
Programmer  	: Frankie Cheung
Create Date   	:
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      	Initial  		Description                          
=========================================================    
*/

CREATE PROCEDURE [dbo].[sp_update_IMMMUPDDAT] 
	@cocde  nvarchar(6), 
	@creusr  nvarchar(30) 
AS


DECLARE	-- TEMP
@cbmcft	numeric(13,4),		@fml		nvarchar(300),		@end		int,
@i		int,			@bomcst	numeric(13,4),		@imu_fmlopt	nvarchar(5),
@imu_basprc	numeric(13,4),		@OP		nvarchar(1),		@temp 		numeric(13,4),
@imu_selrat	numeric(16,11),		@imu_buyrat	numeric(16,11),		@bomprc	numeric(13,4),
@debug	int,				@imu_bcurcde	nvarchar(6),		@imu_itmprc	numeric(13,4),
@imu_bomprc	numeric(13,4),		@imu_fml	nvarchar(300),		@ivi_venno       	nvarchar(6),
@imu_calftyprc  numeric(13,4),		@ventyp	nvarchar(1),		@imu_fmlopt_P	nvarchar(5),
@imu_fml_P	nvarchar(300),		@imu_ftyprc	numeric(13,4),		@have_alsitmno	nvarchar(50),
@imd_fmlopt	nvarchar(10),		@imd_basprc	numeric(13,4)					



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
@imd_hkfmloptA	nvarchar(4),	@imd_hkfmloptB	nvarchar(4),	@imd_hkfmloptC	nvarchar(4),
@imd_hkfmloptD	nvarchar(4),	@imd_hkfmloptT	nvarchar(4),	@imd_hkfmloptP	nvarchar(4),
@imd_ftyfmloptA	nvarchar(4),	@imd_ftyfmloptB	nvarchar(4),	@imd_ftyfmloptC	nvarchar(4),
@imd_ftyfmloptD	nvarchar(4),	@imd_ftyfmloptT	nvarchar(4),	@imd_ftyfmloptP	nvarchar(4),
@imd_conftr	int,			@imd_itmtyp		nvarchar(3),
@imd_inrlin 	numeric(13,4),		@imd_inrwin 	numeric(13,4),		@imd_inrhin 	numeric(13,4),
@imd_mtrlin 	numeric(13,4),		@imd_mtrwin 	numeric(13,4),		@imd_mtrhin 	numeric(13,4),
@imd_splitr	nvarchar(800),		@imd_lgtno 	nvarchar(4),		@imd_frtchg 	nvarchar(6),
@imd_dbxlbcst	nvarchar(9), 		@imd_dbxlbcstch 	nvarchar(6),	@imd_ftytmp	nvarchar(4),
@imd_tgtret	numeric(13,4) ,		@imd_pckitr 	nvarchar(800),		@imd_lgtspec 	nvarchar(800),
@imd_stage 	nvarchar(1),		@imd_refresh	nvarchar(2),		@imd_xlsfil	nvarchar(30),
@imd_chkdat	datetime,		@imd_sysmsg	nvarchar(300),		@imd_prctrm	nvarchar(100),
@imd_remark	nvarchar(2000),		@imd_std	nvarchar(1),		@imd_tranhk	numeric(13,4),
@imd_tranfty	numeric(13,4),		@imd_nat	nvarchar(6),		@imd_ccA	numeric(13,4),		
@imd_ccB	numeric(13,4),		@imd_ccC	numeric(13,4),		@imd_ccD	numeric(13,4),		
@imd_cctran	numeric(13,4),		@imd_ccpck	numeric(13,4),		@imd_calftyprc	numeric(13,4),		
@imd_negprc	numeric(13,4),		@imd_creusr	nvarchar(30),		@imd_updusr	nvarchar(30),		
@imd_credat	datetime,		@imd_upddat	datetime ,		@imd_timstp	timestamp




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
			imd_negprc,		imd_creusr,		imd_updusr,
			imd_credat,		imd_upddat ,		imd_timstp
	FROM 	
		IMMMITMDAT	
	WHERE 	
		imd_stage = 'A' and imd_mode = 'UPD' and  imd_updusr  = @creusr  
	ORDER BY 
		 imd_itmno, imd_chkdat


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
	@imd_negprc,		@imd_creusr,		@imd_updusr,
	@imd_credat,		@imd_upddat ,		@imd_timstp

select @cbmcft = isnull(ycf_value,0) from syconftr where ycf_code1 = 'CBM' and ycf_code2 = 'CFT'

WHILE @@fetch_status = 0
BEGIN

--IMBASINF - Start ------------------------------------------------------------------------------------------------------------
	
	select    @ycr_catlvl0 = ycr_catlvl0, 
		@ycr_catlvl1 = ycr_catlvl1, 
		@ycr_catlvl2 = ycr_catlvl2, 
		@ycr_catlvl3 = ycr_catlvl3
	from
		SYCATREL
	where
		ycr_catlvl4 =  @imd_catlvl4 

	select @have_alsitmno = ibi_alsitmno from IMBASINF where ibi_itmno = @imd_itmno 

	if len(ltrim(rtrim(@have_alsitmno))) <> 0
	begin
		update 
			IMBASINF 	
		set 	
			ibi_itmsts = 'CMP',			ibi_curcde = @imd_curcde,		ibi_catlvl0 = @ycr_catlvl0,
			ibi_catlvl1 = isnull(@ycr_catlvl1,''),	ibi_catlvl2 = isnull(@ycr_catlvl2,''),	ibi_catlvl3 = isnull(@ycr_catlvl3,''),	
			ibi_catlvl4 = isnull(@imd_catlvl4,''),	ibi_typ = @imd_itmtyp,			ibi_engdsc =@imd_engdsc, 			
			ibi_chndsc = isnull(@imd_chndsc,''),	ibi_venno = @imd_venno,		ibi_cusven = @imd_venno,
			ibi_itmnat = isnull(@imd_nat,''),		ibi_updusr =  'E-' + @creusr ,		ibi_upddat = getdate() ,	
			ibi_rmk = left(@imd_remark ,2000) ,	ibi_lnecde = isnull(@imd_lnecde,'') 
		where 	
			ibi_itmno = @imd_itmno 		
	end
	else
	begin
		update 
			IMBASINF 	
		set 	
			ibi_itmsts = 'CMP',			ibi_curcde = @imd_curcde,		ibi_catlvl0 = @ycr_catlvl0,
			ibi_catlvl1 = isnull(@ycr_catlvl1,''),	ibi_catlvl2 = isnull(@ycr_catlvl2,''),	ibi_catlvl3 = isnull(@ycr_catlvl3,''),	
			ibi_catlvl4 = isnull(@imd_catlvl4,''),	ibi_typ = @imd_itmtyp,			ibi_engdsc =@imd_engdsc, 			
			ibi_chndsc = isnull(@imd_chndsc,''),	ibi_venno = @imd_venno,		ibi_cusven = @imd_venno,
			ibi_alsitmno = isnull(@imd_aliasItemNo,''), ibi_itmnat = isnull(@imd_nat,''),		ibi_updusr =  'E-' + @creusr ,		ibi_upddat = getdate() ,	
			ibi_rmk = left(@imd_remark ,2000) ,	ibi_lnecde = isnull(@imd_lnecde,'') 
		where 	
			ibi_itmno = @imd_itmno 
	end	

--IMBASINF - End ------------------------------------------------------------------------------------------------------------

--IMPCKINF - START ------------------------------------------------------------------------------------------------------------



	update 
		IMPCKINF 
	set	
		ipi_inrhin = isnull(@imd_inrhin,0),		
		ipi_inrwin = isnull(@imd_inrwin,0),
		ipi_inrdin = isnull(@imd_inrlin,0),		
		ipi_inrhcm = isnull(round(@imd_inrhin/2.54,4),0),
		ipi_inrwcm = isnull(round(@imd_inrwin/2.54,4),0),	
		ipi_inrdcm = isnull(round(@imd_inrlin/2.54,4),0),
		ipi_mtrhin = isnull(@imd_mtrhin,0),		
		ipi_mtrwin = isnull(@imd_mtrwin,0),
		ipi_mtrdin = isnull(@imd_mtrlin,0),		
		ipi_mtrhcm = isnull(round(@imd_mtrhin/2.54,4),0),
		ipi_mtrwcm = isnull(round(@imd_mtrwin/2.54,4),0),	
		ipi_mtrdcm = isnull(round(@imd_mtrlin/2.54,4),0),
		ipi_cft = isnull(@imd_cft,0),			
		ipi_cbm = isnull(@imd_cft*@cbmcft,0),
		ipi_cusno = @imd_cus1no,
		ipi_updusr = 'E-' + @creusr,
		ipi_upddat = getdate(),
		ipi_conftr = @imd_conftr
	where	
		ipi_itmno = @imd_itmno and
		ipi_pckunt = @imd_untcde and 	
		ipi_inrqty = @imd_inrqty and	
 		ipi_mtrqty = @imd_mtrqty


	Select @ipi_pckseq = ipi_pckseq From IMPCKINF Where ipi_itmno = @imd_itmno and 
			ipi_pckunt =  @imd_untcde  and 
			ipi_inrqty =  @imd_inrqty  and 
			ipi_mtrqty = @imd_mtrqty 
/*
	set @ipi_pckseq = "Select ipi_pckseq From IMPCKINF 
			Where ipi_itmno = ' + @imd_itmno + ' and 
			ipi_pckunt = ' + @imd_untcde + ' and 
			ipi_inrqty = ' + @imd_inrqty + ' and 
			ipi_mtrqty = ' + @imd_mtrqty + '"

	EXEC( @ipi_pckseq ) 
*/

--IMPCKINF - End ------------------------------------------------------------------------------------------------------------

--IMMRKUP -Start ------------------------------------------------------------------------------------------------------------

		if @imd_prdven <> (select ibi_venno from IMBASINF where ibi_itmno = @imd_itmno)
		begin
			set @ventyp = 'P'
		end
		else
		begin
			set @ventyp = 'D'
		end



	if @imd_untcde <> ''  and @ventyp = 'D'
	begin
		select @imu_fmlopt = yaf_fmlopt, @fml = yaf_fml from SYCATFML 
		where 	
			yaf_lnecde = @imd_lnecde and
			yaf_catcde = @imd_catlvl4

			
		select 
			@imu_bcurcde = ysi_cde 
		from 
			SYSETINF 
		where 	
			ysi_typ = '06' and 
			ysi_def = 'Y' 	

		set @imd_fmlopt = @imu_fmlopt

		-----------------------------------

		select 
			@imu_selrat = ysi_selrat 
		from 
			SYSETINF 
		where 	
			ysi_typ = '06' and 
			ysi_cde = @imd_curcde	

		if @fml is null or @fml = ''
		begin
			set @fml = '0'
		end
	
		if @imu_bcurcde is null
		begin
			set @imu_bcurcde = ''
		end

		if @imu_selrat is null
		begin
			set @imu_selrat = 0
		end


		--Calculate Basic Price START---for Design Vendor-----------------------------------------
		SET @fml = LTRIM(RTRIM(@fml))
		SET @i  = 1

		set @fml = replace(@fml, ' ','')

		if (substring(@fml,1,1) <> '*') and (substring(@fml,1,1)<> '/')
		begin
			set @fml = '*' + @fml
		end
		--- Assign Basic Price	---
		-- set @bomcst = 0
		--set @imu_basprc = @imd_ftyprc + @bomcst
		set @imu_basprc = @imd_icttl


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
				set @imu_basprc = @imu_basprc * @temp
			end
			else if @OP = '/' 

			begin
				set @imu_basprc = @imu_basprc / @temp
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

		--- Answer plus currency conversion
		if @imd_curcde = 'HKD'
		begin
			set @imu_itmprc = round(@imu_basprc * @imu_selrat,4)
		end
		else
		begin
			set @imu_itmprc = round(@imu_basprc,4)
		end
		set @imd_basprc = @imu_itmprc
		
		--Calculate Basic Price END--------------------------------------------
		

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

		if @imu_basprc is NULL
		begin
			set @imu_basprc = 0
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

		if @imu_basprc is NULL
		begin
			set @imu_basprc = 0
		end

		--- Calculate Basic Price ---		
		set @imu_basprc =  round(@imu_itmprc + @bomprc,4)
		set @imd_basprc = @imu_basprc

		--- For Design Vendor
		-----Update Design Vendor	

		update 
			IMMRKUP 
		set	
			imu_cft = @imd_cft,
			imu_curcde = @imd_curcde,
			imu_prctrm = @imd_prctrm,						
			imu_ftyprctrm = @imd_prctrm,
			imu_ftycst = round(@imd_fcttl,2),	--- Fty Cost
			imu_ftyprc = round(@imd_icttl,2), 	--- Item Cost
			imu_bomcst = 1,  			--- BOM Cost
			imu_ttlcst = round(@imd_icttl,2),  	--- Total Cost
			------
			imu_fmlopt = @imu_fmlopt,	 	--- Formula
			imu_bcurcde = @imu_bcurcde,	
			imu_itmprc = round(@imu_itmprc,4),	--- Item Price
			imu_bomprc = round(@imu_bomprc,4),	--- BOM Price
			imu_basprc = round(@imu_basprc,4),	--- Total Price
			imu_alsbasprc = 0,
			imu_ftybomcst = 0,
			imu_updusr = 'E-' + @creusr,
			imu_upddat = getdate()
		where 	
			imu_itmno = @imd_itmno and
			imu_ventyp = 'D' and
			imu_venno = @imd_venno and
			imu_pckunt = @imd_untcde and 
			imu_inrqty = @imd_inrqty and
			imu_mtrqty = @imd_mtrqty and 
			imu_prdven = @imd_prdven	



		--for Production Vendor 


		update 
			IMMRKUP 
		set	
			imu_cft = @imd_cft,
			imu_curcde = @imd_curcde,
			imu_prctrm = @imd_prctrm,
			imu_ftyprctrm = @imd_prctrm,
			imu_bomprc = 0,
			imu_bomcst = 0,
			imu_fmlopt = 'PDV',
			imu_calftyprc =  round(@imd_icttl,2),  	
			imu_negprc = 0,
			--imu_negprc = round(@imd_calftyprc,2),  --- calftyprc of customer specific	
			imu_bcurcde = 'USD',						
			imu_basprc = round(@imu_basprc,4),	--- Total Price
			imu_alsbasprc = 0,
			imu_ftybomcst = 0,
			imu_updusr = 'E-' + @creusr,
			imu_upddat = getdate()
		where 	
			imu_itmno = @imd_itmno and
			imu_ventyp = 'P' and
			imu_venno = @imd_venno and
			imu_pckunt = @imd_untcde and
		 	imu_inrqty = @imd_inrqty and
			imu_mtrqty = @imd_mtrqty and
		 	imu_prdven = @imd_prdven		


		--***  for  Production  Vendor  only for UCPP

		DECLARE cur_IMMRKUP CURSOR
		FOR 	
			SELECT 	
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
				ivi_itmno = @imd_itmno and 
				ivi_venno <> @imd_venno

		OPEN cur_IMMRKUP
		FETCH NEXT FROM cur_IMMRKUP INTO 
		@imu_fmlopt,	@imu_fml,	@ivi_venno

		WHILE @@fetch_status = 0
		BEGIN	

		if @imu_fmlopt is NULL or @imu_fmlopt = ''
		begin
			update	IMMRKUP 
				set	
					imu_cft = @imd_cft,
					imu_curcde = @imd_curcde,
					imu_prctrm = @imd_prctrm,
					-- Lester Wu 2006-01-21 , Factory Price Term-
					imu_ftyprctrm = @imd_prctrm,
					-------------------------------------------							
					imu_fmlopt = 'PDV',
	
					imu_ftycst = 0,	  		--- Fty Cost
					imu_ftyprc = 0, 			--- Item Cost
					imu_bomcst = 0,	  		--- BOM Cost
					imu_ttlcst = 0,  			--- Total Cost
					------
					imu_bcurcde = 'USD',	
					imu_itmprc = 0,			--- Item Price
					imu_bomprc = 0,			--- BOM Price

					imu_basprc = round(@imu_basprc,4),	--- Total Price
					imu_alsbasprc = 0,
					imu_calftyprc = 0, 			--- Calculate Fty Prc
					imu_negprc = 0,
					-----------------------------------------							
					imu_updusr = 'E-' + @creusr,
					imu_upddat = getdate()
				where 	
					imu_itmno = @imd_itmno and
					imu_ventyp = 'P' and
					imu_venno = @imd_venno and
					imu_pckunt = @imd_untcde and
					imu_inrqty = @imd_inrqty and
					imu_mtrqty = @imd_mtrqty and
				 	imu_prdven = @imd_prdven

				--- Set Item Status to INC if formula option not found !!
				update 
					IMBASINF 
				set 	
					ibi_itmsts = 'INC'
				where
					ibi_itmno = @imd_itmno
				------------------------------------------------------------	
		end
		else
		begin
			if @imu_fml is null or @imu_fml = ''
			begin
				set @imu_fml = '0'
			end
		
			if @imu_bcurcde is null
			begin
				set @imu_bcurcde = ''
			end
		
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
			---- Assign Calculate Fty Price ----	
			set @imu_calftyprc = @imu_basprc
			-----------------------------------------
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
					---- Calculate Fty Prc ---
					set @imu_calftyprc = @imu_calftyprc * @temp
				end

				else if @OP = '/' 
				begin
					---- Calculate Fty Prc ---
					set @imu_calftyprc = @imu_calftyprc / @temp
				end
				
				set @fml = substring(@fml, @end, len(@fml))
			end
			---- Calculate Total Calculate Fty Prc ---
			-- Amend the roundup method to decimal point 2 at 2005-02-03
			-- set @imu_calftyprc = round(@imu_calftyprc / @imu_selrat,4)
			if @imd_curcde = 'HKD'
			begin
				set @imu_calftyprc = round(@imu_calftyprc / @imu_selrat,2)
			end


		--Calculate Calculate Factory Price END--------------------------------------------

		             	update 
					IMMRKUP 
				set	
					imu_cft = @imd_cft,			
					imu_curcde = @imd_curcde,
					imu_prctrm = @imd_prctrm,		
					imu_ftyprctrm = @imd_prctrm,
					-------------------------------------------							

					imu_fmlopt = @imu_fmlopt,
					imu_calftyprc = round(@imu_calftyprc,2),
					imu_negprc = 0,
					imu_ftyprc = 0,
					imu_ftycst = 0,
					imu_ttlcst = 0, 
					imu_bcurcde = 'USD',	
					imu_basprc = round(@imu_basprc,4),
					imu_alsbasprc = 0,
					imu_ftybomcst = 0,
					imu_updusr = 'E-' + @creusr,
					imu_upddat = getdate()
				where 	
					imu_itmno = @imd_itmno and
					imu_ventyp = 'P' and 
					imu_venno = @imd_venno and
					imu_pckunt = @imd_untcde and
			 		imu_inrqty = @imd_inrqty and
					imu_mtrqty = @imd_mtrqty and 
					imu_prdven = @ivi_venno
		end

		FETCH NEXT FROM cur_IMMRKUP INTO 
		@imu_fmlopt,	@imu_fml,	@ivi_venno
		END
		CLOSE cur_IMMRKUP
		DEALLOCATE cur_IMMRKUP
	end


--for Production Vendor-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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

			select 
				@imu_bcurcde = ysi_cde 
			from 
				SYSETINF 
			where 	
			 	ysi_typ = '06' and
			 	ysi_def = 'Y' 	
			------------------------------
			select 
				@imu_selrat = ysi_selrat 
			from 
				SYSETINF 
			where 	
			 	ysi_typ = '06' and
				ysi_cde = @imd_curcde	
			---------------------------------			
			select 	
				@imu_fmlopt_P = ymf_fmlopt, 
				@imu_fml_P = yfi_fml
			from	SYMRKFML
			left join SYFMLINF on
				yfi_fmlopt = ymf_fmlopt 
			where	
				ymf_prdvenno = @imd_prdven and
				ymf_degvenno =@imd_venno and 
				ymf_mkpopt = @imu_fmlopt


				if (@imu_fmlopt_P is NULL or @imu_fmlopt_P = '') 
				begin
				             	update 
							IMMRKUP 
						set	
							imu_cft = @imd_cft,			
							imu_curcde = @imd_curcde,
							imu_prctrm = @imd_prctrm,		
							-- Lester Wu 2006-01-21 , Factory Price Term-
							imu_ftyprctrm = @imd_prctrm,
							-------------------------------------------							
							imu_fmlopt = 'PDV',
							imu_calftyprc = 0, 			
							imu_ftyprc = 0,
				 			imu_ftycst = 0,
							imu_ttlcst = 0, 			
							imu_negprc = 0,
							imu_bcurcde = 'USD',	
							imu_basprc = round(@imu_basprc,4),
							imu_alsbasprc = 0,
							imu_updusr =  'E-' + @creusr,
							imu_upddat = getdate()
						where 	
							imu_itmno = @imd_itmno and
							imu_ventyp = 'P' and
							imu_venno = @imd_venno and
							imu_pckunt = @imd_untcde and
						 	imu_inrqty = @imd_inrqty and
							imu_mtrqty = @imd_mtrqty and
							imu_prdven = @imd_prdven

						--- Set Item Status to INC if formula option not found !!
						update 
							IMBASINF 
						set 	
							ibi_itmsts = 'INC'
						where
							ibi_itmno = @imd_itmno
						------------------------------------------------------------

	 

				end
				else
				begin




					if @imu_fml_P is null or @imu_fml_P = ''
					begin
						set @imu_fml_P = '0'
					end
						
					if @imu_bcurcde is null
					begin
						set @imu_bcurcde = ''
					end
						
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
				
					--- Assign Basic Price ---							
					--set @imu_basprc = @iid_ftyprc
					set @imu_basprc = @imd_icttl  	
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
							set @imu_basprc = round(@imu_basprc / @temp,4)


						end
						else if @OP = '/' 
						begin
							set @imu_basprc = round(@imu_basprc * @temp,4)
						end
					

						set @fml = substring(@fml, @end, len(@fml))
					end

					--- Calculate Total Basic Price ----
					--set @imu_basprc = round(@imu_basprc * @imu_selrat,4)
					--set @imu_alsbasprc = (@imu_basprc / 0.97) * 1.15
					if @imd_curcde = 'HKD'
					begin					
						 set @imu_basprc = round(@imu_basprc * @imu_selrat,4)
					end
					set @imd_basprc = @imu_basprc

	
					--Calculate Basic Price END--------------------------------------------

					--Update Production Vendor 
				             	update 
							IMMRKUP 
						set	
							imu_cft = @imd_cft,
							imu_curcde = @imd_curcde,
							imu_prctrm = @imd_prctrm,
							-- Lester Wu 2006-01-21 , Factory Price Term-
							imu_ftyprctrm = @imd_prctrm,
							-------------------------------------------							
							imu_fmlopt = @imu_fmlopt_P,
							imu_ftycst = 0,
							imu_ftyprc = 0, 
							imu_ttlcst = 0,
							imu_calftyprc = @imd_icttl,
							imu_negprc = 0,
							imu_bcurcde = 'USD',	
							imu_basprc = @imu_basprc,
							imu_alsbasprc = 0,
							imu_ftybomcst = 0,
							imu_updusr = 'E-' + @creusr,
							imu_upddat = getdate()
						where 	
							imu_itmno = @imd_itmno and
							imu_ventyp = 'P' and
							imu_venno = @imd_venno and
							imu_pckunt = @imd_untcde and
						 	imu_inrqty = @imd_inrqty and
							imu_mtrqty = @imd_mtrqty and
						 	imu_prdven = @imd_prdven	
				end
		
					if @imu_fml is null or @imu_fml = ''
					begin
						set @imu_fml = '0'
					end
						
					if @imu_bcurcde is null
					begin
						set @imu_bcurcde = ''
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
										
					--- Assign Basic Price ---	
					-- No need to change, @imu_basprc is already calculated						
					set @imu_ftyprc = @imu_basprc
					-----------------------------
				
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
							set @imu_ftyprc = round(@imu_ftyprc / @temp,4)
						end
						else if @OP = '/' 
						begin
							set @imu_ftyprc = round(@imu_ftyprc * @temp,4)
						end
								
						set @fml = substring(@fml, @end, len(@fml))
					end
					
					if @imd_curcde = 'HKD'
					begin		
						set @imu_ftyprc = round(@imu_ftyprc / @imu_selrat,4)		
					end

					--Insert Design Vendor 
					update 
						IMMRKUP 
					set	
						imu_cft = @imd_cft,			
						imu_curcde = @imd_curcde,
						imu_prctrm = @imd_prctrm,
						-- Lester Wu 2006-01-21 , Factory Price Term-
						imu_ftyprctrm = @imd_prctrm,
						-------------------------------------------							
						imu_fmlopt = @imu_fmlopt,
						imu_ftycst = 0,			
						imu_ftyprc = round(@imu_ftyprc, 4),
						imu_ttlcst = round(@imu_ftyprc, 4),
						imu_calftyprc = 0, 			
						imu_negprc = 0,
						imu_bcurcde = @imu_bcurcde,	
						imu_basprc = round(@imu_basprc,4),
						imu_alsbasprc = 0,
						imu_ftybomcst = 0,
						imu_updusr = 'E-' + @creusr,
						imu_upddat = getdate()
					where 	
						imu_itmno = @imd_itmno and
						imu_ventyp = 'D' and
						imu_venno = @imd_venno and
						imu_pckunt = @imd_untcde and
					 	imu_inrqty = @imd_inrqty and
						imu_mtrqty = @imd_mtrqty and
					 	imu_prdven = @imd_prdven
	

					--Insert Design Vendor and also is Production Vendor
					update 
						IMMRKUP 
					set	
						imu_cft = @imd_cft,			
						imu_curcde = @imd_curcde,
						imu_prctrm = @imd_prctrm,		
						-- Lester Wu 2006-01-21 , Factory Price Term-
						imu_ftyprctrm = @imd_prctrm,
						-------------------------------------------							
						imu_fmlopt = 'PDV',
						imu_ftycst = 0,			
						imu_ftyprc = 0, 
						imu_ttlcst = 0,
						imu_calftyprc = round(@imu_ftyprc,2), 	
						imu_negprc = 0,
						imu_bcurcde = @imu_bcurcde,	
						imu_basprc = round(@imu_basprc,4),
						imu_alsbasprc = 0,
						imu_ftybomcst = 0,
						imu_updusr = 'E-' + @creusr,
						imu_upddat = getdate()
					where 	
						imu_itmno = @imd_itmno and
						imu_ventyp = 'P' and
						imu_venno = @imd_venno and
						imu_pckunt = @imd_untcde and 	
						imu_inrqty = @imd_inrqty and
						imu_mtrqty = @imd_mtrqty and
					 	imu_prdven = @imd_venno
		
					DECLARE cur_IMMRKUP CURSOR
					FOR 	
						SELECT 	
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
							ivi_itmno = @imd_itmno and 
							ivi_venno <> @imd_venno and
							ivi_venno <> @imd_prdven
		
					OPEN cur_IMMRKUP
					FETCH NEXT FROM cur_IMMRKUP INTO 
					@imu_fmlopt,	@imu_fml,	@ivi_venno					

					WHILE @@fetch_status = 0
					BEGIN	

		
					if @imu_fmlopt is NULL or @imu_fmlopt = ''
					begin

						update 
							IMMRKUP 
						set	
							imu_cft = @imd_cft,			
							imu_curcde = @imd_curcde,
							imu_prctrm = @imd_prctrm,		
							-- Lester Wu 2006-01-21 , Factory Price Term-
							imu_ftyprctrm = @imd_prctrm,
							-------------------------------------------							
							imu_fmlopt = 'PDV',
							imu_calftyprc = 0, 			
							imu_ftyprc = 0,
							imu_ttlcst = 0,
					 		imu_ftycst = 0, 			
							imu_negprc = 0,
							imu_bcurcde = @imu_bcurcde,	
							imu_basprc = round(@imu_basprc,4),
							imu_alsbasprc = 0,
							imu_ftybomcst = 0,			
							imu_updusr = 'E-' + @creusr,
							imu_upddat = getdate()
						where 	
							imu_itmno = @imd_itmno and
							imu_ventyp = 'P' and	
							imu_venno = @ivi_venno 	and
							imu_pckunt = @imd_untcde and 	
							imu_inrqty = @imd_inrqty and
							imu_mtrqty = @imd_mtrqty and
						 	imu_prdven = @ivi_venno


						--- Set Item Status to INC if formula option not found !!
						update 
							IMBASINF 

						set 	
							ibi_itmsts = 'INC'
						where
							ibi_itmno = @imd_itmno
						------------------------------------------------------------



					end
					else
					begin
						if @imu_fml is null or @imu_fml = ''
						begin
							set @imu_fml = '0'
						end
							
						if @imu_bcurcde is null
						begin
							set @imu_bcurcde = ''
						end
							
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
									
						set @imu_calftyprc = @imu_basprc
							
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
								set @imu_calftyprc = round(@imu_calftyprc * @temp,4)
							end
							else if @OP = '/' 
							begin
								set @imu_calftyprc = round(@imu_calftyprc / @temp,4)
							end
									
							set @fml = substring(@fml, @end, len(@fml))
						end

						-- Allan Yuen amend the roundup method to decimal point 2 at 2005-02-03			
						--set @imu_calftyprc = round(@imu_calftyprc / @imu_selrat,4)
						if @imd_curcde = 'HKD'
						begin
							set @imu_calftyprc = round(@imu_calftyprc / @imu_selrat,2)
						end	
						
		
						--Calculate Factory Price for Production Vendor END--------------------------------------------

		
						update 
							IMMRKUP 
						set	
							imu_cft = @imd_cft,			
							imu_curcde = @imd_curcde,
							imu_prctrm = @imd_prctrm,	
							-- Lester Wu 2006-01-21 , Factory Price Term-
							imu_ftyprctrm = @imd_prctrm,
							-------------------------------------------							
							imu_fmlopt = @imu_fmlopt,

							imu_ftyprc = 0, 	
							imu_ttlcst = 0,		
							imu_calftyprc = round(@imu_calftyprc,4),
							imu_ftycst = 0, 			
							imu_negprc = 0,
							imu_bcurcde = @imu_bcurcde,	
							imu_basprc = round(@imu_basprc,4),
							imu_alsbasprc = 0,
							imu_ftybomcst = 0,
							imu_updusr = 'E-' + @creusr,
							imu_upddat = getdate()
						where 	
							imu_itmno = @imd_itmno and
							imu_ventyp = 'P' and
							imu_venno = @ivi_venno and
							imu_pckunt = @imd_untcde and
						 	imu_inrqty = @imd_inrqty and
							imu_mtrqty = @imd_mtrqty and
						 	imu_prdven = @ivi_venno

					end
		
					FETCH NEXT FROM cur_IMMRKUP INTO 
					@imu_fmlopt,	@imu_fml,	@ivi_venno
					END
					CLOSE cur_IMMRKUP
					DEALLOCATE cur_IMMRKUP
			end


	

--IMMRKUP -End ------------------------------------------------------------------------------------------------------------

--IMMRKUPDTL -Start ------------------------------------------------------------------------------------------------------------

		-- Don't record negotiation price to customer specific (4 Dec., 2008)
		-- set @imd_negprc = 0		
		

		if (select count(*) from IMMRKUPDTL where imd_cocde = ' ' and imd_itmno = @imd_itmno and  imd_typ = @imd_itmtyp and imd_ventyp = 'D' 
			and imd_venno = @imd_venno and imd_prdven = @imd_prdven and imd_pckseq = @ipi_pckseq 
			and imd_cus1no = @imd_cus1no and imd_cus2no = @imd_cus2no) = 0 

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
				imd_dbxlbcst,		imd_dbxlbcstch,		imd_tgtret,		
				imd_pckitr,		imd_lgtspec,		imd_prctrm,		
				imd_conftr,		imd_tranhk,		imd_tranfty,		
				imd_ccA,		imd_ccB,		imd_ccC,
				imd_ccD,		imd_cctran,		imd_ccpck,
				imd_calftyprc,		imd_negprc,		imd_creusr,
				imd_updusr ,		imd_credat ,		imd_upddat
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
				@imd_dbxlbcst,		@imd_dbxlbcstch,	@imd_tgtret,		
				@imd_pckitr,		@imd_lgtspec,		@imd_prctrm,		
				@imd_conftr,		@imd_tranhk,		@imd_tranfty,		
				@imd_ccA,		@imd_ccB,		@imd_ccC,		
				@imd_ccD,		@imd_cctran,		@imd_ccpck,		
				@imd_calftyprc,		@imd_negprc,		'E-' + @creusr,		
				'E-' + @creusr,		getdate(),		getdate()
			)
		end
		else
		begin
		update 
			IMMRKUPDTL 
		set	
			imd_cus1no = @imd_cus1no,		imd_cus2no = isnull(@imd_cus2no,''),		imd_catlvl4 = @imd_catlvl4,	
			imd_curcde = @imd_curcde,
			imd_fcA = @imd_fcA,			imd_fcB = @imd_fcB,				imd_fcC = @imd_fcC,
			imd_fcD = @imd_fcD,			imd_fctran = @imd_fctran,			imd_fcpck = @imd_fcpck,
			imd_icA = @imd_icA,			imd_icB = @imd_icB,				imd_icC = @imd_icC,
			imd_icD = @imd_icD,			imd_ictran = @imd_ictran,			imd_icpck = @imd_icpck,
			imd_fm1A = @imd_hkfmloptA,		imd_fm1B = @imd_hkfmloptB,			imd_fm1C = @imd_hkfmloptC,	
			imd_fm1D = @imd_hkfmloptD,		imd_fm1tran = @imd_hkfmloptT,			imd_fm1pck = @imd_hkfmloptP
	,		imd_fm2A = @imd_ftyfmloptA,		imd_fm2B = @imd_ftyfmloptB,			imd_fm2C = @imd_ftyfmloptC,
			imd_fm2D = @imd_ftyfmloptD,		imd_fm2tran = @imd_ftyfmloptT,			imd_fm2pck = @imd_ftyfmloptP,
			imd_fcttl = round(@imd_fcttl,2),		imd_icttl = round(@imd_icttl,2),			imd_fmlopt = @imd_fmlopt,
			imd_bcurcde = 'USD',			imd_basprc = @imd_basprc,			imd_lgtno = @imd_lgtno,
			imd_frtchg = @imd_frtchg,		imd_dbxlbcst = @imd_dbxlbcst,			imd_dbxlbcstch = @imd_dbxlbcstch,
			imd_tgtret = @imd_tgtret,		imd_pckitr = @imd_pckitr,			imd_lgtspec = @imd_lgtspec,		
			imd_prctrm = @imd_prctrm,		imd_conftr = @imd_conftr,			imd_tranhk = @imd_tranhk,		
			imd_tranfty = @imd_tranfty,		imd_ccA = @imd_ccA,				imd_ccB = @imd_ccB,
			imd_ccC = @imd_ccC,			imd_ccD = @imd_ccD,				imd_cctran = @imd_cctran,
			imd_ccpck = @imd_ccpck,		imd_calftyprc = @imd_calftyprc,			imd_negprc = @imd_negprc,	
			imd_updusr ='E-' + @creusr, 		imd_upddat = getdate()

		where 	
			imd_itmno = @imd_itmno and
			imd_ventyp = 'D'  and
			imd_venno = @imd_venno and
			imd_prdven = @imd_prdven and	
			imd_untcde = @imd_untcde and 
			imd_inrqty = @imd_inrqty and
			imd_mtrqty = @imd_mtrqty and
			imd_cus1no = @imd_cus1no and 
			imd_cus2no = @imd_cus2no
		end
		




--IMMRKUPDTL - End ------------------------------------------------------------------------------------------------------------

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
			imd_negprc,		imd_creusr,		imd_updusr,		
			imd_credat,		imd_upddat		
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
			@imd_negprc,		@imd_creusr,		@imd_updusr,		
			@imd_credat,		@imd_upddat 		
		)


	delete from IMMMITMDAT where imd_itmno = @imd_itmno and imd_venno = @imd_venno and imd_prdven = @imd_prdven and
					imd_untcde = @imd_untcde and imd_mtrqty = @imd_mtrqty and
					imd_inrqty = @imd_inrqty and imd_mtrqty = @imd_mtrqty and
					imd_itmseq = @imd_itmseq and imd_recseq = @imd_recseq and
					imd_stage = 'A' and imd_mode = 'UPD'


-----------------------------------
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
	@imd_negprc,		@imd_creusr,		@imd_updusr,
	@imd_credat,		@imd_upddat,		@imd_timstp
END
CLOSE cur_IMMMITMDAT
DEALLOCATE cur_IMMMITMDAT









GO
GRANT EXECUTE ON [dbo].[sp_update_IMMMUPDDAT] TO [ERPUSER] AS [dbo]
GO
