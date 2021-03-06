/****** Object:  StoredProcedure [dbo].[sp_IMMMITMDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_IMMMITMDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_IMMMITMDAT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[sp_IMMMITMDAT] 


@imd_venno nvarchar(6),
@imd_prdven nvarchar(6),
@imd_cus1no  nvarchar(10), 
@imd_cus2no nvarchar(10),     
@imd_catlvl4 nvarchar(20),
@imd_lnecde nvarchar(10),
@imd_itmno nvarchar(50),
@imd_aliasItemNo nvarchar(50),
@imd_curcde nvarchar(6),
@imd_itmseq int,
@imd_engdsc nvarchar (800),
@imd_chndsc nvarchar (1600),
@imd_itmtyp nvarchar(3),
@imd_fcA numeric(13,4), 
@imd_fcB numeric(13,4),      
@imd_fcC numeric(13,4), 
@imd_fcD numeric(13,4), 
@imd_fctran numeric(13,4), 
@imd_fcpck numeric(13,4),      
@imd_fcttl numeric(13,4), 
@imd_inrqty int,  
@imd_mtrqty int,      
@imd_cft numeric(13,4), 
@imd_untcde nvarchar(6),
@imd_conftr int,
@imd_inrlin numeric(13,4), 
@imd_inrwin numeric(13,4), 
@imd_inrhin numeric(13,4),      
@imd_mtrlin numeric(13,4), 
@imd_mtrwin numeric(13,4), 
@imd_mtrhin numeric(13,4),      
@imd_splitr  nvarchar(800),    
@imd_lgtno int,  
@imd_frtchg nvarchar(6),      
@imd_dbxlbcst  numeric(13,4), 
@imd_dbxlbcstch nvarchar(6),      
@imd_tgtret numeric(13,4),   
@imd_pckitr nvarchar(800),   
@imd_lgtspec  nvarchar(800),
@imd_stage nvarchar(1),
@imd_refresh nvarchar(2),
@imd_xlsfil nvarchar(30),
@imd_chkdat datetime,
@imd_sysmsg nvarchar(300),
@imd_prctrm nvarchar(100),
@imd_mode nvarchar(3),
@imd_remark nvarchar(2000),
@imd_ftytmp nvarchar(1),
@imd_std nvarchar(1),
@imd_tranhk numeric(13,4),
@imd_tranfty numeric (13,4),
@imd_nat nvarchar(6),
@imd_negprc numeric(13,4)


AS

declare 
@imd_recseq int,  @imd_itmsts nvarchar(3),
@icA numeric(13,4), 
@icB numeric(13,4),      
@icC numeric(13,4), 
@icD numeric(13,4), 
@ictran numeric(13,4), 
@icpck numeric(13,4),      
@icttl numeric(13,4),
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
@imd_basprc numeric(13,4),
@debug	int


if @imd_cus2no is null
begin
   set @imd_cus2no =''
end	

if @imd_lnecde is null
begin
   set @imd_lnecde =''
end

if @imd_chndsc is null
begin
   set @imd_chndsc =''
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

if @imd_fcttl is null
begin
   set @imd_fcttl = 0
end

if @imd_inrqty is null      
begin      
 set @imd_inrqty = 0      
end      
      
if @imd_mtrqty is null      
begin      
 set @imd_mtrqty = 1      
end  

if @imd_cft is null      
begin      
 set @imd_cft = 0      
end  

if @imd_untcde is null      
begin      
 set @imd_untcde = ''  
end  

if @imd_conftr is null      
begin      
   set @imd_conftr = 1      
end   

if @imd_inrlin is null      
begin      
   set @imd_inrlin = 0      
end  

if @imd_inrwin is null      
begin      
   set @imd_inrwin = 0      
end  

if @imd_inrhin is null      
begin      
   set @imd_inrhin = 0      
end  

if @imd_mtrlin is null      
begin      
   set @imd_mtrlin = 0      
end  

if @imd_mtrwin is null      
begin      
   set @imd_mtrwin = 0      
end 

if @imd_mtrhin is null      
begin      
   set @imd_mtrhin = 0      
end 

if @imd_mtrhin is null      
begin      
   set @imd_mtrhin = 0      
end 

if @imd_splitr is null      
begin      
 set @imd_splitr = ''  
end  

if @imd_lgtno is null      
begin      
 set @imd_lgtno = 0
end  

if @imd_frtchg is null      
begin      
 set @imd_frtchg = 'N'
end  

if @imd_dbxlbcst is null      
begin      
 set @imd_dbxlbcst = 0
end  

if @imd_dbxlbcstch is null      
begin      
 set @imd_dbxlbcstch = 'N'
end    


if @imd_tgtret is null
begin 
   set @imd_tgtret  = 0
end

   
if @imd_pckitr is null      

begin      
 set @imd_pckitr = ''
end    

if @imd_lgtspec is null      
begin      
 set @imd_lgtspec = ''
end    

if @imd_remark is null
begin
   set @imd_remark =''
end 

if @imd_tranhk is null
begin
	set @imd_tranhk = 0
end

if @imd_tranfty is null
begin
	set @imd_tranfty = 0
end

if @imd_nat is null
begin
	set @imd_nat = ""
end



Set  @imd_recseq = (Select isnull(max(imd_recseq),0)  + 1 from IMMMITMDAT) 

/* Temporary hard code @imd_itmsts to "INC" */
Set @imd_itmsts = 'CMP'

-- print '@icA=' +  CONVERT(VARCHAR(20), @icA ) 

exec sp_select_PRCDTL @imd_fcA, @imd_fcB, @imd_fcC, @imd_fcD, @imd_fcTran, @imd_fcPck, @imd_fcttl, @imd_cus1no, @imd_cus2no, @imd_catlvl4,
@icA = @icA output, @icB = @icB output, @icC = @icC output, @icD = @icD output, @ictran = @ictran output, @icPck = @icPck output, @icTtl = @icTtl output,
@ftymuA = @ftymuA output, @ftymuB = @ftymuB output, @ftymuC = @ftymuC output,  @ftymuD = @ftymuD output, @ftymuTran = @ftymuTran output, @ftymuPck = @ftymuPck output,
@hkmuA = @hkmuA output, @hkmuB = @hkmuB output, @hkmuC = @hkmuC output, @hkmuD = @hkmuD output, @hkmuTran = @hkmuTran output, @hkmuPck = @hkmuPck output,
@ccA = @ccA output,  @ccB = @ccB output, @ccC = @ccC output, @ccD = @ccD output, @ccTran = @ccTran output, @ccPck = @ccPck output,  
@calftyprc = @calftyprc	 output

/*
set @debug = 1
if @debug = 1
begin
	print '@icPck=' +  CONVERT(VARCHAR(20), @imd_fcPck ) 
	print '@ftymuP=' +  CONVERT(VARCHAR(20), @ftymuPck ) 
	print '@hkmuP=' +  CONVERT(VARCHAR(20), @hkmuPck ) 
	print '@icPck=' +  CONVERT(VARCHAR(20), @icPck ) 
end
*/

exec sp_calc_basprc @imd_catlvl4, @imd_lnecde, @icTtl, @imd_fcD,@imd_basprc output


BEGIN TRANSACTION 
          		
		IF (select count(1) from IMMMITMDAT where  imd_itmno = @imd_itmno and imd_inrqty = @imd_inrqty and      
		       imd_mtrqty = @imd_mtrqty and imd_untcde = @imd_untcde and  imd_venno = @imd_venno and
		      imd_prdven = @imd_prdven and (imd_stage = 'W' or imd_stage = 'I') ) > 0      
			BEGIN      
			 update IMMMITMDAT set imd_stage = 'O', imd_upddat = getdate() 
				where	 imd_itmno = @imd_itmno and
					 imd_inrqty = @imd_inrqty and      
			              	imd_mtrqty = @imd_mtrqty and
					 imd_untcde = @imd_untcde and
					 imd_venno = @imd_venno and
					imd_prdven = @imd_prdven and
					(imd_stage = 'W' or imd_stage = 'O')
			END      

			IF @@ERROR != 0 --check @@ERROR variable after each DML statements..
				BEGIN
					ROLLBACK TRANSACTION --RollBack Transaction if Error..
					RETURN
				END
			ELSE
				BEGIN
					 insert into  IMMMITMDAT      
					 (       
					imd_venno, imd_prdven, imd_cus1no, imd_cus2no, imd_catlvl4, imd_lnecde,      
					imd_itmno, imd_aliasItemNo, imd_curcde, imd_engdsc, imd_chndsc, imd_itmtyp, imd_itmseq, imd_recseq, imd_mode, imd_itmsts,
				        	imd_fcA, imd_fcB, imd_fcC, imd_fcD, imd_fctran, imd_fcpck,  
				        	imd_icA, imd_icB, imd_icC, imd_icD, imd_ictran, imd_icpck, imd_basprc,
					imd_hkfmloptA, imd_hkfmloptB , imd_hkfmloptC, imd_hkfmloptD, imd_hkfmloptT, imd_hkfmloptP,
					imd_ftyfmloptA, imd_ftyfmloptB , imd_ftyfmloptC, imd_ftyfmloptD, imd_ftyfmloptT, imd_ftyfmloptP,
					imd_fcttl, imd_icttl, imd_inrqty,  imd_mtrqty,      
					imd_cft, imd_untcde, imd_conftr,
					imd_inrlin, imd_inrwin, imd_inrhin,      
					imd_mtrlin, imd_mtrwin, imd_mtrhin,      
					imd_splitr,   imd_lgtno,  imd_frtchg,      
					imd_dbxlbcst, imd_dbxlbcstch,   
					imd_tgtret, imd_pckitr,  imd_lgtspec, 
					imd_stage, imd_refresh, imd_xlsfil, imd_chkdat, imd_sysmsg, imd_prctrm, imd_remark,imd_ftytmp,
					imd_std, imd_tranhk, imd_tranfty, imd_nat,
					imd_ccA, imd_ccB, imd_ccC, imd_ccD, imd_ccTran, imd_ccPck, imd_calftyprc, imd_negprc,
					imd_creusr, imd_updusr, imd_credat, imd_upddat					
					 )      
					 values      
					 (      
					@imd_venno, @imd_prdven, @imd_cus1no, @imd_cus2no, @imd_catlvl4, @imd_lnecde,
					@imd_itmno, @imd_aliasItemNo, @imd_curcde, @imd_engdsc, @imd_chndsc, @imd_itmtyp, @imd_itmseq, @imd_recseq, @imd_mode, @imd_itmsts,
					@imd_fcA, @imd_fcB, @imd_fcC, @imd_fcD, @imd_fctran,  @imd_fcpck, 
					@icA, @icB, @icC, @icD, @ictran, @icpck, @imd_basprc,	
					@hkmuA, @hkmuB , @hkmuC, @hkmuD, @hkmuTran, @hkmuPck,
					@ftymuA, @ftymuB, @ftymuC, @ftymuD, @ftymuTran, @ftymuPck,
					@imd_fcttl, @icttl, @imd_inrqty,  @imd_mtrqty,      
					@imd_cft, @imd_untcde, @imd_conftr,
					@imd_inrlin, @imd_inrwin, @imd_inrhin,      
					@imd_mtrlin, @imd_mtrwin, @imd_mtrhin,      
					@imd_splitr,    @imd_lgtno,  @imd_frtchg,      
					@imd_dbxlbcst, @imd_dbxlbcstch,   
					@imd_tgtret, @imd_pckitr, @imd_lgtspec, 
					@imd_stage, @imd_refresh, @imd_xlsfil, @imd_chkdat, @imd_sysmsg, @imd_prctrm, @imd_remark,@imd_ftytmp,
					@imd_std, @imd_tranhk, @imd_tranfty, @imd_nat,
					@ccA, @ccB, @ccC, @CCD, @ccTran, @ccPck, @calftyprc, @imd_negprc,
					'Excel', 'Excel', getdate(), getdate()   
					 )									           		
					IF @@ERROR != 0 --check @@ERROR variable after each DML statements..
						BEGIN
							ROLLBACK TRANSACTION --RollBack Transaction if Error..
							RETURN
						END 
					ELSE
						BEGIN
							COMMIT TRANSACTION --finally, Commit the transaction if Success..
							RETURN
						END
				END




GO
GRANT EXECUTE ON [dbo].[sp_IMMMITMDAT] TO [ERPUSER] AS [dbo]
GO
