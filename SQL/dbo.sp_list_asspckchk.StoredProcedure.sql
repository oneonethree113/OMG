/****** Object:  StoredProcedure [dbo].[sp_list_asspckchk]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_asspckchk]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_asspckchk]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/*
=========================================================
Program ID	: 	sp_list_asspckchk
Description   	: 	
Programmer  	: 	
Date Created	:	
=========================================================
 Modification History                                    
=========================================================
2012-07-23	David Yue	Add User ID
=========================================================     
*/




CREATE  PROCEDURE [dbo].[sp_list_asspckchk] 

@iad_cocde  nvarchar(6),	@iad_xlsfil  nvarchar(30),	@iad_chkdat nvarchar(30),
@creusr		nvarchar(30)

AS

declare 
@cur_asstno nvarchar(20),	@asstsum int,			@assdsum int

BEGIN

DECLARE cur_ASSTNO CURSOR
FOR 	SELECT	distinct iad_asstno		
	FROM imassexdat where 	iad_xlsfil = @iad_xlsfil and iad_chkdat = @iad_chkdat

OPEN cur_ASSTNO
FETCH NEXT FROM cur_ASSTNO INTO 
@cur_asstno

WHILE @@fetch_status = 0
BEGIN

--- Check Packing Matching of assortment item and assorted item(s)

	select @asstsum = ied_mtrqty*ied_conftr from imitmexdat 
		where ied_ucpno = @cur_asstno and ied_xlsfil = @iad_xlsfil and ied_chkdat = @iad_chkdat and ied_stage = 'W'
	
	select @assdsum = sum(iad_mtrqty*iad_conftr) from imassexdat 
		where iad_asstno = @cur_asstno and iad_xlsfil = @iad_xlsfil and iad_chkdat = @iad_chkdat and iad_stage = 'W'
		
--		print 'asstsum: '+convert(nvarchar(20), @asstsum)
--		print 'assdsum: '+convert(nvarchar(20), @assdsum)
	
	if @asstsum <> @assdsum
	begin		
					
		--set @iad_sysmsg = @iad_sysmsg + (case @iad_sysmsg when '' then @iad_assdno + ' - Ass''d packing sum not match with Ass''t packing'   
			--else ', ' + @iad_assdno + ' - Ass''d packing sum not match with Ass''t packing' end)  
		--set @iad_stage = 'I'   
		--set @iad_untcde = ''  

		update IMASSEXDAT set iad_stage = 'I', iad_untcde = '', iad_sysmsg = left(iad_sysmsg +  (case iad_sysmsg when '' then @cur_asstno + ' - Ass''t packing not match with Ass''d packing sum'   
			else ', ' + @cur_asstno + ' - Ass''t packing not match with Ass''d packing sum' end),300)  
		where  iad_asstno = @cur_asstno and iad_xlsfil = @iad_xlsfil and iad_chkdat = @iad_chkdat
	
		update IMITMEXDAT set ied_stage = 'I' , ied_sysmsg = left(ied_sysmsg +  (case ied_sysmsg when '' then @cur_asstno + ' - Ass''t packing not match with Ass''d packing sum'   
			else ', ' + @cur_asstno + ' - Ass''t packing not match with Ass''d packing sum' end),300)  
		where  ied_ucpno = @cur_asstno and ied_xlsfil = @iad_xlsfil and ied_chkdat = @iad_chkdat  
		
		update  IMBASINF set ibi_itmsts = ibi_prvsts, ibi_upddat = getdate(), ibi_updusr = @creusr 
		where     
			ibi_itmno = @cur_asstno and   
			ibi_itmsts = 'HLD' and   
			ibi_prvsts <> 'HLD' and   
			@cur_asstno not in 
			(
				select ied_ucpno from IMITMEXDAT where    
				ied_ucpno = @cur_asstno and  
				(ied_stage = 'A' or ied_stage = 'W' or ied_stage = 'R')
			)        
	 end  



FETCH NEXT FROM cur_ASSTNO INTO 
@cur_asstno
END
CLOSE cur_ASSTNO
DEALLOCATE cur_ASSTNO



END









GO
GRANT EXECUTE ON [dbo].[sp_list_asspckchk] TO [ERPUSER] AS [dbo]
GO
