/****** Object:  StoredProcedure [dbo].[sp_insert_IMBOMEXDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMBOMEXDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMBOMEXDAT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





/* 
=========================================================  
Program ID : sp_Insert_IMBOMEXDAT
Description    :	   
ALTER  Date    :  
=========================================================
	MODIFICATION HISTORY
*********************************************************
2012-07-23	David Yue	Add User ID
*********************************************************
*/  
  
CREATE procedure [dbo].[sp_insert_IMBOMEXDAT]  
                                                                                                                                                                                                                                                                   
@ibd_cocde  nvarchar(6),
@ibd_ucpno nvarchar(20),
@ibd_bomno nvarchar(20),  
@ibd_colcde nvarchar(30), 	
@ibd_qty  int,  			
@ibd_um nvarchar(3),  		
@ibd_conftr int,
@ibd_xlsfil  nvarchar(50), 	
@ibd_chkdat datetime,
@creusr nvarchar(30)


AS  
  
declare  @ibd_recseq int, @itmno nvarchar(20), @ibd_untcde nvarchar(6), @ibd_stage nvarchar(3), @ibd_sysmsg nvarchar(300),
@ibd_venno nvarchar(20),	
@ibd_prdven nvarchar(20)	
  
Set @ibd_recseq = (Select isnull(max(ibd_recseq),0)  + 1 from IMBOMEXDAT)  
Set @ibd_sysmsg = ''  
Set @ibd_stage = 'W'  
set @ibd_cocde = ''


--- Check Exist of BOM Item  ---
if (select count(*) from IMBASINF where  ibi_itmno = @ibd_bomno and ibi_typ = 'BOM' and ibi_itmsts = 'CMP') = 0   
begin  
	set @ibd_sysmsg = left( @ibd_sysmsg + (case @ibd_sysmsg when '' then @ibd_bomno + ' - Invalid BOM Vendor Item or BOM Item Status not complete'  
		else ', ' + @ibd_bomno + ' - Invalid BOM Vendor Item or BOM Item Status not complete' end)  , 300)
	set @ibd_stage = 'I'  

	update IMITMEXDAT set ied_stage = 'I' , ied_sysmsg = left( ied_sysmsg +  (case ied_sysmsg when '' then @ibd_bomno + ' - Invalid BOM Vendor Item or BOM Item Status not complete'    
		else ', ' + @ibd_bomno + ' - Invalid BOM Vendor Item or BOM Item Status not complete'  end)  , 300)
	where  ied_ucpno = @ibd_ucpno and ied_xlsfil = @ibd_xlsfil and ied_chkdat = @ibd_chkdat  and ied_stage = 'W'	
end  

--- Check Exist of BOM Item Color code  ---

if (select count(*) from IMCOLINF where  icf_itmno = @ibd_bomno and  icf_colcde = @ibd_colcde) = 0   
begin  
	set @ibd_sysmsg = left( @ibd_sysmsg + (case @ibd_sysmsg when '' then @ibd_colcde + ' - Invalid BOM Vendor Item Color Code'   
		else ', ' + @ibd_colcde + ' - Invalid BOM Item Vendor Color Code' end)  , 300)
	set @ibd_stage = 'I'  

	update IMITMEXDAT set ied_stage = 'I' , ied_sysmsg = left( ied_sysmsg +  (case ied_sysmsg when '' then @ibd_colcde + ' - Invalid BOM Vendor Item Color Code'   
		else ', ' + @ibd_colcde + ' - Invalid BOM Vendor Item Color Code' end)  , 300)
	where ied_ucpno = @ibd_ucpno and ied_xlsfil = @ibd_xlsfil and ied_chkdat = @ibd_chkdat and ied_stage = 'W'
end  


Select @ibd_untcde =  ycf_code1 from SYCONFTR 
where 
	ycf_systyp = 'Y' and ycf_code2 = 'PC' and 
	ycf_dsc1 = @ibd_um and ycf_value = @ibd_conftr
if @ibd_untcde is NULL or @ibd_untcde = ''       
begin  
	set @ibd_untcde = ''	
	set @ibd_sysmsg = left( @ibd_sysmsg + (case @ibd_sysmsg when '' then ' - Invalid Conversion Factor for BOM Item'   
		else ', - Invalid Conversion Factor for BOM Item' end)  , 300)
	set @ibd_stage = 'I'  

	update IMITMEXDAT set ied_stage = 'I' , ied_sysmsg = left( ied_sysmsg +  (case ied_sysmsg when '' then ' - Invalid Conversion Factor for BOM Item'   
		else ',  - Invalid Conversion Factor for BOM Item' end)  , 300)
	where ied_ucpno = @ibd_ucpno and ied_xlsfil = @ibd_xlsfil and ied_chkdat = @ibd_chkdat and ied_stage = 'W'

	set @ibd_untcde = ''
end

Update	IMBOMEXDAT 
Set 	ibd_stage = 'O'
Where	ibd_ucpno = @ibd_ucpno and
	(ibd_xlsfil <> @ibd_xlsfil or ibd_chkdat <> @ibd_chkdat)

  
if (select count(1) from IMBOMEXDAT where ibd_ucpno = @ibd_ucpno and ibd_bomno = @ibd_bomno and 
	ibd_colcde = @ibd_colcde and (ibd_stage = 'W' or ibd_stage = 'I')) > 0  
begin  
	UPDATE	IMBOMEXDAT 
	set		ibd_stage = 'O'  
	where  		
			ibd_ucpno = @ibd_ucpno and   
			ibd_bomno = @ibd_bomno and 
			ibd_colcde = @ibd_colcde and
			(ibd_stage = 'W' or ibd_stage = 'I')  
end  

if (select count(*) from imitmexdat
	where ied_ucpno = @ibd_ucpno and ied_xlsfil = @ibd_xlsfil and ied_chkdat = @ibd_chkdat and  ied_stage = 'W') = 1
begin
	select @ibd_venno = ied_venno, @ibd_prdven = ied_prdven 
	from imitmexdat
	where
		ied_ucpno = @ibd_ucpno and
		ied_xlsfil = @ibd_xlsfil and
		ied_chkdat = @ibd_chkdat and 
		ied_stage = 'W'
end
else
begin
	select top 1 @ibd_venno = ied_venno, @ibd_prdven = ied_prdven 
	from imitmexdat
	where
		ied_ucpno = @ibd_ucpno and
		ied_xlsfil = @ibd_xlsfil and
		ied_chkdat = @ibd_chkdat 
end

 
insert into  IMBOMEXDAT  
(   
	 ibd_cocde,		ibd_ucpno,		ibd_bomno,  
	 ibd_recseq, 		ibd_colcde, 		ibd_qty,   
	 ibd_untcde, 		ibd_conftr,		ibd_stage,  
	 ibd_sysmsg,		ibd_xlsfil, 		ibd_veneml,  
	 ibd_malsts, 		ibd_chkdat,		ibd_creusr,  
	 ibd_updusr, 		ibd_credat,  		ibd_upddat,  
	 ibd_venno,		ibd_prdven,  		ibd_itmdsc 
)  
values  
(  
	 @ibd_cocde,		@ibd_ucpno,		@ibd_bomno,  
	 @ibd_recseq,		@ibd_colcde,		@ibd_qty,  
	 @ibd_untcde, 		@ibd_conftr, 		@ibd_stage,   
	 @ibd_sysmsg,		@ibd_xlsfil, 		'',   
	 '', 			@ibd_chkdat, 		@creusr,     
	 @creusr,   		getdate(),   		getdate(),    
	isnull(@ibd_venno, ''),	isnull(@ibd_prdven,''),  		''	
)        
---------------------------------------------------------------------------------------------------------------------------------------------------------------------









GO
GRANT EXECUTE ON [dbo].[sp_insert_IMBOMEXDAT] TO [ERPUSER] AS [dbo]
GO
