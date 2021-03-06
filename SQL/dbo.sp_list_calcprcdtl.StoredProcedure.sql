/****** Object:  StoredProcedure [dbo].[sp_list_calcprcdtl]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_calcprcdtl]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_calcprcdtl]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[sp_list_calcprcdtl]

@imd_cocde nvarchar(10),
@imd_cus1no  nvarchar(10), 
@imd_cus2no nvarchar(10),     
@imd_catlvl4 nvarchar(20),
@imd_lnecde nvarchar(10),
@imd_fcA numeric(13,4), 
@imd_fcB numeric(13,4),      
@imd_fcC numeric(13,4), 
@imd_fcD numeric(13,4), 
@imd_fctran numeric(13,4), 
@imd_fcpck numeric(13,4),      
@imd_fcttl numeric(13,4)




AS

declare 
@icA numeric(13,4), 
@icB numeric(13,4),      
@icC numeric(13,4), 
@icD numeric(13,4),
@ictran numeric(13,4), 
@icpck numeric(13,4),      
@icttl numeric(13,4),
@fcttl numeric(13,4), 
@hkmuA nvarchar(4),
@hkmuB nvarchar(4),
@hkmuC nvarchar(4),
@hkmuD nvarchar(4),
@hkmuTran nvarchar(4),
@hkmuPck nvarchar(4),
@ccA numeric(13,4),
@ccB numeric(13,4),
@ccC numeric(13,4),
@ccD numeric(13,4),
@cctran numeric(13,4),
@ccpck numeric(13,4),
@calftyprc numeric(13,4),
@ftymuA nvarchar(4),
@ftymuB nvarchar(4),
@ftymuC nvarchar(4),
@ftymuD nvarchar(4),
@ftymuTran nvarchar(4),
@ftymuPck nvarchar(4),
@bpfml nvarchar(30),
@bpfmlopt nvarchar(4),
@imd_basprc numeric(13,4),
@debug	int


BEGIN


	if @imd_cus2no is null
	begin
	   set @imd_cus2no =''
	end	
	
	if @imd_lnecde is null
	begin
	   set @imd_lnecde =''
	end


	if @imd_fcA is null
	begin
	   set @imd_fcA = 0
	end
	
	if @imd_fcB is null
	begin
	   set @imd_fcB = 0
	end
	
	if @imd_fcC is null
	begin
	   set @imd_fcC = 0
	end
	
	if @imd_fcD is null
	begin
	   set @imd_fcD = 0
	end
	
	if @imd_fctran is null
	begin
	   set @imd_fctran = 0
	end
	
	if @imd_fcpck is null
	begin
	   set @imd_fcpck = 0
	end



            --fcTran = tranHK * cft / mtrqty

	
	exec sp_select_PRCDTL @imd_fcA, @imd_fcB, @imd_fcC, @imd_fcD, @imd_fcTran, @imd_fcPck, @imd_fcttl, @imd_cus1no, @imd_cus2no, @imd_catlvl4,
	@icA = @icA output, @icB = @icB output, @icC = @icC output, @icD = @icD output, @ictran = @ictran output, @icPck = @icPck output, @icTtl = @icTtl output,
	@hkmuA = @hkmuA output, @hkmuB = @hkmuB output, @hkmuC = @hkmuC output, @hkmuD = @hkmuD output, @hkmuTran = @hkmuTran output, @hkmuPck = @hkmuPck output,
	@ftymuA = @ftymuA output, @ftymuB = @ftymuB output, @ftymuC = @ftymuC output, @ftymuD = @ftymuD output, @ftymuTran = @ftymuTran output, @ftymuPck = @ftymuPck output,
	@ccA = @ccA output, @ccB = @ccB output, @ccC = @ccC output, @ccD = @ccD output, @ccTran = @ccTran output, @ccPck = @ccPck output,  @calftyprc = @calftyprc output

	--set @debug = 1
	--if @debug = 1
	--begin
	--	print '@icPck=' +  CONVERT(VARCHAR(20), @imd_fcPck ) 
	--	print '@ftymuP=' +  CONVERT(VARCHAR(20), @ftymuPck ) 
	--	print '@hkmuP=' +  CONVERT(VARCHAR(20), @hkmuPck ) 
	--	print '@icPck=' +  CONVERT(VARCHAR(20), @icPck ) 
	--end
	
	exec sp_calc_basprc @imd_catlvl4, @imd_lnecde, @icTtl, @imd_fcD,@imd_basprc output

	exec sp_get_bpmrkup @imd_catlvl4, @imd_lnecde, @bpfmlopt output, @bpfml output

	set @imd_fcttl = @imd_fcA + @imd_fcB + @imd_fcC + @imd_fcD + @imd_fcpck


	select @icA as 'prca' , @icB as 'prcb', @icC as 'prcc', @icD as 'prcd', @ictran as 'prctran', @icPck as 'prcpck', @icttl as 'prcttl',
		@ccA as 'ccA', @ccB as 'ccB', @ccC as 'ccC', @ccD as 'ccD', @ccTran as 'ccTran', @ccPck as 'ccPck',	 
		@imd_basprc as 'basprc', @bpfmlopt as 'bpfmlopt', @bpfml as 'bpfml', @calftyprc as 'calftyprc', @imd_fcttl as 'fcttl' 


END




GO
GRANT EXECUTE ON [dbo].[sp_list_calcprcdtl] TO [ERPUSER] AS [dbo]
GO
