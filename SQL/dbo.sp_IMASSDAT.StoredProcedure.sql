/****** Object:  StoredProcedure [dbo].[sp_IMASSDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_IMASSDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_IMASSDAT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





/* Author : Tommy Ho */  
  
-- Checked by Allan Yuen at 1 Aug 2003  
  

CREATE procedure [dbo].[sp_IMASSDAT]  
                                                                                                                                                                                                                                                               
    
@iad_cocde  nvarchar(6),	@iad_venitm nvarchar(20),	@iad_acsno nvarchar(20),  
@iad_colcde nvarchar(30),	@iad_inrqty int, 		@iad_mtrqty int,  
@iad_chkdat nvarchar(30), 	@iad_stage nvarchar(3), 	@iad_xlsfil  nvarchar(30),   
@iad_veneml nvarchar(50), 	@iad_malsts nvarchar(1), 	@iad_sysmsg nvarchar(300),  
@iad_untcde nvarchar(6), 	@iad_conftr int,  		@iad_venno nvarchar(6),  
@iad_prdven nvarchar(6), 	@iad_period datetime,	@isCheck  char(1)  
  
AS  
  
declare  @iad_recseq int,  @itmno  nvarchar(20),  
@ibi_lnecde nvarchar(10), @iid_lnecde nvarchar(10), 
@period_bef	datetime
  
Set @iad_recseq = (Select isnull(max(iad_recseq),0)  + 1 from IMASSDAT  where iad_cocde = @iad_cocde)  
Set @iad_stage = 'W'  
Set @iad_sysmsg = ''  

--Frankie Cheung 20110421 Get before Assd Period
select top 1 @period_bef = iba_period from imbomass 
where  iba_itmno = @iad_venitm and  iba_assitm = @iad_acsno and  iba_colcde = @iad_colcde 

  
if (select count(*) from IMITMDAT where iid_cocde = @iad_cocde and iid_venitm = @iad_acsno and   
            --iid_untcde = @iad_untcde and iid_inrqty = @iad_inrqty and iid_mtrqty = @iad_mtrqty and  
          iid_chkdat = @iad_chkdat and iid_xlsfil = @iad_xlsfil) = 0   
begin  
 if @iad_cocde = 'UCPP'   
 begin  
  if (select count(*) from IMBASINF where   
      --ibi_cocde = @iad_cocde and   
      ibi_itmno = @iad_acsno and   
      ibi_typ = 'REG') = 0   
  begin  
   set @iad_sysmsg = @iad_sysmsg + (case @iad_sysmsg when '' then @iad_acsno + ' - Invalid Assorted Item'   
          else ', ' + @iad_acsno + ' - Invalid Assorted Item' end)  
   set @iad_stage = 'I'  
   
   update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left(iid_sysmsg +  (case iid_sysmsg when '' then @iad_acsno + ' - Invalid Assorted Item'   
          else ', ' + @iad_acsno + ' - Invalid Assorted Item' end),300)  
   where iid_cocde = @iad_cocde and iid_venitm = @iad_venitm and iid_xlsfil = @iad_xlsfil and iid_chkdat = @iad_chkdat  
    
  end  
    
  if (select count(*) from IMCOLINF where   
      --icf_cocde = @iad_cocde and   
      icf_itmno = @iad_acsno and   
      icf_colcde = @iad_colcde) = 0   
  begin  
   set @iad_sysmsg = @iad_sysmsg + left((case @iad_sysmsg when '' then @iad_colcde + ' - Invalid Assorted Item Color Code'   
        else ', ' + @iad_colcde + ' - Invalid Assorted Item Color Code' end),300)  
   set @iad_stage = 'I'  
   
   update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left(iid_sysmsg +  (case iid_sysmsg when '' then @iad_colcde + ' - Invalid Assorted Item Color Code'   
          else ', ' + @iad_colcde + ' - Invalid Assorted Item Color Code' end),300)  
   where iid_cocde = @iad_cocde and iid_venitm = @iad_venitm and iid_xlsfil = @iad_xlsfil and iid_chkdat = @iad_chkdat  
  end  
/*  
--  if (select count(*) from IMPCKINF where ipi_cocde = @iad_cocde and ipi_itmno = @iad_acsno and ipi_pckunt = @iad_untcde and ipi_inrqty = @iad_inrqty and ipi_mtrqty = @iad_mtrqty) = 0   
--  begin  
--   set @iad_sysmsg = @iad_sysmsg + (case @iad_sysmsg when '' then @iad_untcde + '/' + ltrim(str(@iad_inrqty)) + '/' + ltrim(str(@iad_mtrqty)) + ' - Invalid Assorted Item Packing'   
--        else ', ' + @iad_untcde + '/' + ltrim(str(@iad_inrqty)) + '/' + ltrim(str(@iad_mtrqty)) + ' - Invalid Assorted Item Packing' end)  
--   set @iad_stage = 'I'  
--   
--   update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left(iid_sysmsg +  (case iid_sysmsg when '' then @iad_untcde + '/' + ltrim(str(@iad_inrqty)) + '/' + ltrim(str(@iad_mtrqty)) + ' - Invalid Assorted Item Packing'   
--          else ', ' + @iad_untcde + '/' + ltrim(str(@iad_inrqty)) + '/' + ltrim(str(@iad_mtrqty)) + ' - Invalid Assorted Item Packing' end),300)  
--   where iid_cocde = @iad_cocde and iid_venitm = @iad_venitm and iid_xlsfil = @iad_xlsfil and iid_chkdat = @iad_chkdat  
--  end  
*/  
 end  
 else  
 begin  
  set @itmno = ''  
  select @itmno = ivi_itmno from IMVENINF where   
      --ivi_cocde = @iad_cocde and   
      ivi_venitm = @iad_acsno and   
      ivi_venno = @iad_venno  
  
  if (select count(*) from IMBASINF where   
      --ibi_cocde = @iad_cocde and   
      ibi_itmno = @itmno and   
      ibi_typ = 'REG') = 0   
  begin  
   set @iad_sysmsg = @iad_sysmsg + left((case @iad_sysmsg when '' then @iad_acsno + ' - Invalid Assorted Vendor Item'   
          else ', ' + @iad_acsno + ' - Invalid Assorted Vendor Item' end),300)  
   set @iad_stage = 'I'  
   
   update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left(iid_sysmsg +  (case iid_sysmsg when '' then @iad_acsno + ' - Invalid Assorted Vendor Item'   
          else ', ' + @iad_acsno + ' - Invalid Assorted Vendor Item' end),300)  
   where iid_cocde = @iad_cocde and iid_venitm = @iad_venitm and iid_xlsfil = @iad_xlsfil and iid_chkdat = @iad_chkdat  
    
  end  
    
  if (select count(*) from IMCOLINF where   
      --icf_cocde = @iad_cocde and   
      icf_itmno = @itmno and   
      icf_colcde = @iad_colcde) = 0   
  begin  
   set @iad_sysmsg = left(@iad_sysmsg + (case @iad_sysmsg when '' then @iad_colcde + ' - Invalid Assorted Vendor Item Color Code'   
        else ', ' + @iad_colcde + ' - Invalid Assorted Vendor Item Color Code' end),300)  
   set @iad_stage = 'I'  
   
   update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left(iid_sysmsg +  (case iid_sysmsg when '' then @iad_colcde + ' - Invalid Assorted Vendor Item Color Code'   
          else ', ' + @iad_colcde + ' - Invalid Assorted Vendor Item Color Code' end),300)  
   where iid_cocde = @iad_cocde and iid_venitm = @iad_venitm and iid_xlsfil = @iad_xlsfil and iid_chkdat = @iad_chkdat  
  end  
/*  
--  if (select count(*) from IMPCKINF where ipi_cocde = @iad_cocde and ipi_itmno = @itmno and ipi_pckunt = @iad_untcde and ipi_inrqty = @iad_inrqty and ipi_mtrqty = @iad_mtrqty) = 0   
--  begin  
--   set @iad_sysmsg = left(@iad_sysmsg + (case @iad_sysmsg when '' then @iad_untcde + '/' + ltrim(str(@iad_inrqty)) + '/' + ltrim(str(@iad_mtrqty)) + ' - Invalid Assorted Item Packing'   
--        else ', ' + @iad_untcde + '/' +ltrim(str(@iad_inrqty)) + '/' + ltrim(str(@iad_mtrqty)) + ' - Invalid Assorted Item Packing' end),300)  
--   set @iad_stage = 'I'  
--   
--   update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left(iid_sysmsg +  (case iid_sysmsg when '' then @iad_untcde + '/' + ltrim(str(@iad_inrqty)) + '/' + ltrim(str(@iad_mtrqty)) + ' - Invalid Assorted Item Packing'   
--          else ', ' + @iad_untcde + '/' + ltrim(str(@iad_inrqty)) + '/' + ltrim(str(@iad_mtrqty)) + ' - Invalid Assorted Item Packing' end),300)  
--   where iid_cocde = @iad_cocde and iid_venitm = @iad_venitm and iid_xlsfil = @iad_xlsfil and iid_chkdat = @iad_chkdat  
--  end  
*/  
 end   
end  
else  
begin  
 if (select count(*) from IMCOLDAT where   
     --icd_cocde = @iad_cocde and   
     icd_venitm = @iad_acsno and   
     icd_colcde = @iad_colcde) = 0   
 begin  
  set @iad_sysmsg = @iad_sysmsg + left((case @iad_sysmsg when '' then @iad_colcde + ' - Invalid Assorted Item Color Code'   
       else ', ' + @iad_colcde + ' - Invalid Assorted Item Color Code' end),300)  
  set @iad_stage = 'I'  
  
  update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left(iid_sysmsg +  (case iid_sysmsg when '' then @iad_colcde + ' - Invalid Assorted Vendor Item Color Code'   
         else ', ' + @iad_colcde + ' - Invalid Assorted Vendor Item Color Code' end),300)  
  where iid_cocde = @iad_cocde and iid_venitm = @iad_venitm and iid_xlsfil = @iad_xlsfil and iid_chkdat = @iad_chkdat  
  
--tommy and Johnson (19 oct 2002)  
  update  IMBASINF set ibi_itmsts = ibi_prvsts, ibi_upddat = getdate(), ibi_updusr = 'Excel-A'  
  where     
   --ibi_cocde = @iad_cocde and   
   ibi_itmno = @iad_venitm and   
   ibi_itmsts = 'HLD' and   
   ibi_prvsts <> 'HLD' and   
   @iad_venitm not in (select iid_venitm from IMITMDAT where    
      iid_cocde = @iad_cocde and iid_venitm = @iad_venitm and  
      (iid_stage = 'A' or iid_stage = 'W' or iid_stage = 'R'))        
 end  
/*  
-- if (select count(*) from IMITMDAT where iid_cocde = @iad_cocde and iid_venitm = @iad_acsno and iid_chkdat = @iad_chkdat and  
--      iid_xlsfil = @iad_xlsfil and iid_untcde = @iad_untcde and iid_inrqty = @iad_inrqty and iid_mtrqty = @iad_mtrqty) = 0   
-- begin  
--  set @iad_sysmsg = @iad_sysmsg + (case @iad_sysmsg when '' then @iad_acsno + ' - Invalid Assorted Item in Item Info (Excel)'   
--       else ', ' + @iad_acsno + ' - Invalid Assorted Item in Item Info (Excel)' end)  
--  set @iad_stage = 'I'  
--  
--  update IMITMDAT set iid_stage = 'I' , iid_sysmsg = iid_sysmsg +  (case iid_sysmsg when '' then @iad_acsno + ' - Invalid Assorted Item in Item Info (Excel)'  
--         else ', ' + @iad_acsno + ' - Invalid Assorted Item in Item Info (Excel)' end)  
--  where iid_cocde = @iad_cocde and iid_venitm = @iad_venitm and iid_xlsfil = @iad_xlsfil and iid_chkdat = @iad_chkdat  
--  
-- end  
*/  
end  
  
set @itmno = ''  
select @itmno = ivi_itmno from IMVENINF where ivi_cocde = @iad_cocde and ivi_venitm = @iad_venitm and ivi_venno = @iad_venno  
  
if @itmno is not null and @itmno <> ''  
begin   
 if (select count(*) from IMBASINF where   
     --ibi_cocde = @iad_cocde and   
     ibi_itmno = @itmno and   
     ibi_typ = 'ASS') = 0   
 begin  
  set @iad_sysmsg = @iad_sysmsg + (case @iad_sysmsg when '' then @itmno + ' - The Item is not an Assortment Item'   
     else ', ' + @itmno + ' - The Item is not an Assortment Item' end)  
  set @iad_stage = 'I'   
  set @iad_untcde = ''  
  
  update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left(iid_sysmsg +  (case iid_sysmsg when '' then @itmno + ' - The Item is not an Assortment Item'   
         else ', ' + @itmno + ' - The Item is not an Assortment Item' end),300)  
  where iid_cocde = @iad_cocde and iid_venitm = @iad_venitm and iid_xlsfil = @iad_xlsfil and iid_chkdat = @iad_chkdat  
--tommy and Johnson (19 oct 2002)  
  update  IMBASINF set ibi_itmsts = ibi_prvsts, ibi_upddat = getdate(), ibi_updusr = 'Excel-A'  
  where     
   --ibi_cocde = @iad_cocde and   
   ibi_itmno = @iad_venitm and   
   ibi_itmsts = 'HLD' and   
   ibi_prvsts <> 'HLD' and   
   @iad_venitm not in (select iid_venitm from IMITMDAT where    
      iid_cocde = @iad_cocde and iid_venitm = @iad_venitm and  
      (iid_stage = 'A' or iid_stage = 'W' or iid_stage = 'R'))        
 end  
  
 select @iid_lnecde = iid_lnecde from IMITMDAT where  iid_cocde = @iad_cocde and iid_venitm = @iad_venitm and   
       iid_venno = @iad_venno and iid_xlsfil = @iad_xlsfil and   
       iid_chkdat = @iad_chkdat  
  
 if @iid_lnecde <> (select ibi_lnecde from IMBASINF where   
      --ibi_cocde = @iad_cocde and   
      ibi_itmno = @itmno)  
 begin  
  set @iad_sysmsg = left(@iad_sysmsg + (case @iad_sysmsg when '' then @iid_lnecde + ' - Prod. Line/Season Code does not match with Item Master'   
               else ', ' + @iid_lnecde + ' - Prod. Line/Season Code does not match with Item Master' end),300)  
  set @iad_stage = 'I'  
  
  update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left(iid_sysmsg +  (case iid_sysmsg when '' then @iid_lnecde + ' - Prod. Line/Season Code does not match with Item Master'   
         else ', ' + @iid_lnecde + ' - Prod. Line/Season Code does not match with Item Master' end),300)  
  where iid_venitm = @iad_venitm and iid_xlsfil = @iad_xlsfil and iid_chkdat = @iad_chkdat  

--tommy and Johnson (19 oct 2002)  
  update  IMBASINF set ibi_itmsts = ibi_prvsts, ibi_upddat = getdate(), ibi_updusr = 'Excel-A'  
  where     
   --ibi_cocde = @iad_cocde and   
   ibi_itmno = @iad_venitm and   
   ibi_itmsts = 'HLD' and   
   ibi_prvsts <> 'HLD' and   
   @iad_venitm not in (select iid_venitm from IMITMDAT where    
      iid_cocde = @iad_cocde and iid_venitm = @iad_venitm and  
      (iid_stage = 'A' or iid_stage = 'W' or iid_stage = 'R'))        
 end  
end  
  
/* -- Remark by frankie 20110428
-- Check Assorted Items Duplicate
if (select count(1) from IMASSDAT where iad_venitm = @iad_venitm and iad_acsno = @iad_acsno and iad_colcde = @iad_colcde and iad_xlsfil = @iad_xlsfil) > 0   
begin  
	
	set @iad_sysmsg = left(@iad_sysmsg + (case @iad_sysmsg when '' then 'Ass''d item:' + @iad_acsno + ' duplicate' else ', Ass''d item:' + @iad_acsno + ' duplicate' end),300)  

	set @iad_stage = 'I'  
	
	update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left(iid_sysmsg +  (case iid_sysmsg when '' then 'Ass''d item:' + @iad_acsno + ' duplicate'  else ', Ass''d item:' + @iad_acsno + ' duplicate' end),300)  
	where iid_venitm = @iad_venitm and iid_xlsfil = @iad_xlsfil and iid_chkdat = @iad_chkdat  
	
	update  IMBASINF set ibi_itmsts = ibi_prvsts, ibi_upddat = getdate(), ibi_updusr = 'Excel-A'  
	where     
	--ibi_cocde = @iad_cocde and   
	ibi_itmno = @iad_venitm and   
	ibi_itmsts = 'HLD' and   
	ibi_prvsts <> 'HLD' and   
	@iad_venitm not in (select iid_venitm from IMITMDAT where    
	  iid_cocde = @iad_cocde and iid_venitm = @iad_venitm and  
	  (iid_stage = 'A' or iid_stage = 'W' or iid_stage = 'R'))        
end  
*/

-- Check Assorted Item In New Item Format  
if @isCheck = 'Y'   
Begin  
-- C, D, T, V, X added by Mark Lau 20090212
 if (select count(1) from IMVENINF where ivi_itmno = @iad_acsno and ivi_venno in ('A','B','U','C','D','T','V','X')) > 0   
 begin  
  set @iad_stage = 'I'  
    
  update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left(iid_sysmsg +  case iid_sysmsg when '' then '' else ',' end + 'Assorted Item ' + @iad_acsno  + ' not in new item format', 300)  
  where iid_cocde = @iad_cocde and iid_venitm = @iad_venitm and iid_xlsfil = @iad_xlsfil and iid_chkdat = @iad_chkdat  
 end  
  
End  
  
  
--if (select count(1) from IMASSDAT where iad_cocde = @iad_cocde and iad_venitm = @iad_venitm and iad_acsno = @iad_acsno and iad_colcde = @iad_colcde and iad_inrqty = @iad_inrqty and iad_mtrqty = @iad_mtrqty and iad_untcde = @iad_untcde) > 0   
if (select count(1) from IMASSDAT where iad_venitm = @iad_venitm and iad_acsno = @iad_acsno and iad_colcde = @iad_colcde) > 0   
begin  
 update   
  IMASSDAT set iad_stage = 'O'   
 where    
  iad_cocde = @iad_cocde and iad_venitm = @iad_venitm and   
  iad_acsno = @iad_acsno and iad_colcde = @iad_colcde and   
  iad_inrqty = @iad_inrqty and iad_mtrqty = @iad_mtrqty and   
  iad_untcde = @iad_untcde  
end  
  
  
insert into  IMASSDAT  
(   
	iad_cocde,		iad_venitm,		iad_acsno,  
	iad_recseq,		iad_colcde,		iad_inrqty,   
	iad_mtrqty, 		iad_untcde, 		iad_conftr,  
	iad_stage,  		iad_sysmsg, 		iad_xlsfil,    
	iad_veneml, 		iad_malsts, 		iad_chkdat,   
	iad_creusr,  		iad_updusr,  		iad_credat,    
	iad_upddat,		iad_venno, 		iad_prdven,  
	iad_period,		iad_period_bef		-- Frankie Cheung 20110216 Add Assd Period
)  
values  
(  
	@iad_cocde,  		@iad_venitm,  	@iad_acsno,  
	@iad_recseq, 		@iad_colcde,  	@iad_inrqty,  
	@iad_mtrqty, 		@iad_untcde, 		@iad_conftr,  
	@iad_stage, 		@iad_sysmsg, 	@iad_xlsfil,   
	@iad_veneml, 		@iad_malsts, 		@iad_chkdat,   
	'Excel',  		'Excel',   		getdate(),     
	getdate(),  		@iad_venno, 		@iad_prdven,  
	@iad_period, 		isnull(@period_bef,'')	-- Frankie Cheung 20110216 Add Assd Period
)        
  
---------------------------------------------------------------------------------------------------------------------------------------------------------------------





GO
GRANT EXECUTE ON [dbo].[sp_IMASSDAT] TO [ERPUSER] AS [dbo]
GO
