/****** Object:  StoredProcedure [dbo].[sp_IMBOMDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_IMBOMDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_IMBOMDAT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







/*  
=========================================================  
Program ID : sp_IMINSDAT  
Description    :   
Programmer   : Tommy Ho   
Create Date    :  
Last Modified   :   
Table Read(s)  :  
Table Write(s)  :  
=========================================================  
 Modification History                                      
=========================================================  
 Date        Initial    Description                            
=========================================================      
10/08/2004  Allan Yuen  Add Checking BOM item Status is complete or not..  
2006-07-24 Lester Wu  add column "Accessory Description"  
*/  
  
-- Checked by Allan Yuen at 1 Aug 2003  
  
/* Author : Tommy Ho */  
  
CREATE procedure [dbo].[sp_IMBOMDAT]  
                                                                                                                                                                                                                                                               
    
@ibd_cocde  nvarchar(6), 		@ibd_venitm nvarchar(20), 		@ibd_acsno nvarchar(20),  
@ibd_colcde nvarchar(30), 		@ibd_qty  int,  			@ibd_chkdat nvarchar(30),  
@ibd_stage nvarchar(3), 		@ibd_xlsfil  nvarchar(30), 		@ibd_veneml nvarchar(50),  
@ibd_malsts nvarchar(1), 		@ibd_sysmsg nvarchar(300), 	@ibd_untcde nvarchar(6),  
@ibd_conftr int,  			@ibd_venno nvarchar(6), 		@ibd_prdven nvarchar(6),  
@ibd_itmdsc nvarchar(3200),  
@ibd_period datetime,	-- Frankie Cheung 20100304 Add BOM Period
@dummy  char(1)  

AS  
  
declare  @ibd_recseq int,	@itmno   nvarchar(20),	@period_bef	datetime  -- Frankie Cheung 20110421 Add BOM Period before
  
Set @ibd_recseq = (Select isnull(max(ibd_recseq),0)  + 1 from IMBOMDAT  where ibd_cocde = @ibd_cocde)  
Set @ibd_sysmsg = ''  
Set @ibd_stage = 'W'  

--Frankie Cheung 20110217 Get before Bom Period
select top 1 @period_bef = iba_period from imbomass 
where  iba_itmno = @ibd_venitm and  iba_assitm = @ibd_acsno and  iba_colcde = @ibd_colcde 

  
/*  
if (select count(*) from IMITMDAT where  iid_cocde = @ibd_cocde and iid_venno = @ibd_venno and iid_venitm = @ibd_venitm and  
     iid_xlsfil = @ibd_xlsfil and iid_chkdat = @ibd_chkdat) = 0  
begin  
 set @itmno = ''  
  
 select @itmno = ivi_itmno from IMVENINF where   
   --ivi_cocde = @ibd_cocde and   
   ivi_venitm = @ibd_venitm and   
   ivi_venno = @ibd_venno   
  
 if @itmno is null or @itmno = ''  
 begin  
  set @ibd_stage = 'I'  
  set @ibd_sysmsg =  @ibd_sysmsg +  (case @ibd_sysmsg when '' then 'Vendor Item Number not exist'  
       else  ', Vendor Item Number not exist'  
       end)  
 end  
end  
*/  
  
/*  
--if @itmno is NULL or @itmno = ''   
--begin  
-- set @ibd_sysmsg = @ibd_sysmsg + (case @ibd_sysmsg when '' then 'The Item is not a Regualr Item'   
--        else ', The Item is not a Regualr Item' end)  
-- set @ibd_stage = 'I'  
--end  
--else   
--begin  
-- update IMBOMASS set iba_bomqty = @ibd_qty where   
--  iba_cocde = @ibd_cocde and iba_itmno = @itmno and  
--  iba_assitm = @ibd_acsno and iba_colcde = @ibd_colcde and   
--  iba_typ = 'BOM'  
--end  
*/  
if @ibd_cocde = 'UCPP'  
begin  
 if (select count(*) from IMBASINF where   
   --ibi_cocde = @ibd_cocde and   
   ibi_itmno = @ibd_acsno and   
   ibi_typ = 'BOM' and ibi_itmsts = 'CMP') = 0   
 begin  
  set @ibd_sysmsg = left(@ibd_sysmsg + (case @ibd_sysmsg when '' then @ibd_acsno + ' - Invalid BOM Item or BOM Item Status not complete'   
         else ', ' + @ibd_acsno + ' - Invalid BOM Item or BOM Item Status not complete' end)  , 300)
  set @ibd_stage = 'I'  
   
  update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left(iid_sysmsg +  (case iid_sysmsg when '' then @ibd_acsno + ' - Invalid BOM Item or BOM Item Status not complete'   
         else ', ' + @ibd_acsno + ' - Invalid BOM Item or BOM Item Status not complete' end)  , 300)
  where iid_cocde = @ibd_cocde and iid_venitm = @ibd_venitm and iid_xlsfil = @ibd_xlsfil and iid_chkdat = @ibd_chkdat  
 end  
  
  
 if (select count(*) from IMCOLINF where   
   --icf_cocde = @ibd_cocde and   
   icf_itmno = @ibd_acsno and   
   icf_colcde = @ibd_colcde) = 0   
 begin  
  set @ibd_sysmsg = left(@ibd_sysmsg + (case @ibd_sysmsg when '' then @ibd_colcde + ' - Invalid BOM Item Color Code'   
       else ', ' + @ibd_colcde + ' - Invalid BOM Item Color Code' end)  , 300)
  set @ibd_stage = 'I'  
   
  update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left(iid_sysmsg +  (case iid_sysmsg when '' then @ibd_colcde + ' - Invalid BOM Item Color Code'   
        else ', ' + @ibd_colcde + ' - Invalid BOM Item Color Code' end)  , 300)
  where iid_cocde = @ibd_cocde and iid_venitm = @ibd_venitm and iid_xlsfil = @ibd_xlsfil and iid_chkdat = @ibd_chkdat  
 end  
  
 if @ibd_untcde <> (select top 1 ipi_pckunt from IMPCKINF where   
     --ipi_cocde = @ibd_cocde and   
     ipi_itmno = @ibd_acsno)   
 begin  
  set @ibd_sysmsg = left( @ibd_sysmsg + (case @ibd_sysmsg when '' then @ibd_untcde + ' - Invalid BOM Item UM'   
       else ', ' + @ibd_untcde + ' - Invalid BOM Item UM' end)  , 300)
  set @ibd_stage = 'I'  
   
  update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left( iid_sysmsg +  (case iid_sysmsg when '' then @ibd_untcde + ' - Invalid BOM Item UM'   
        else ', ' + @ibd_untcde + ' - Invalid BOM Item UM' end)  , 300)
  where iid_cocde = @ibd_cocde and iid_venitm = @ibd_venitm and iid_xlsfil = @ibd_xlsfil and iid_chkdat = @ibd_chkdat  
 end   
end  
else  
begin  
 set @itmno = ''  
 select @itmno = ivi_itmno from IMVENINF where ivi_cocde = @ibd_cocde and   
   ivi_venitm = @ibd_acsno and ivi_venno = @ibd_venno   
  
 if (select count(*) from IMBASINF where   
    --ibi_cocde = @ibd_cocde and   
    ibi_itmno = @itmno and   
    ibi_typ = 'BOM' and ibi_itmsts = 'CMP') = 0   
 begin  
  set @ibd_sysmsg = left( @ibd_sysmsg + (case @ibd_sysmsg when '' then @ibd_acsno + ' - Invalid BOM Vendor Item or BOM Item Status not complete'  
         else ', ' + @ibd_acsno + ' - Invalid BOM Vendor Item or BOM Item Status not complete' end)  , 300)
  set @ibd_stage = 'I'  
   
  update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left( iid_sysmsg +  (case iid_sysmsg when '' then @ibd_acsno + ' - Invalid BOM Vendor Item or BOM Item Status not complete'    
         else ', ' + @ibd_acsno + ' - Invalid BOM Vendor Item or BOM Item Status not complete'  end)  , 300)
  where iid_cocde = @ibd_cocde and iid_venitm = @ibd_venitm and iid_xlsfil = @ibd_xlsfil and iid_chkdat = @ibd_chkdat  
 end  
  
 if (select count(*) from IMCOLINF where   
    --icf_cocde = @ibd_cocde and   
    icf_itmno = @itmno and   
    icf_colcde = @ibd_colcde) = 0   
 begin  
  set @ibd_sysmsg = left( @ibd_sysmsg + (case @ibd_sysmsg when '' then @ibd_colcde + ' - Invalid BOM Vendor Item Color Code'   
       else ', ' + @ibd_colcde + ' - Invalid BOM Item Vendor Color Code' end)  , 300)
  set @ibd_stage = 'I'  
   
  update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left( iid_sysmsg +  (case iid_sysmsg when '' then @ibd_colcde + ' - Invalid BOM Vendor Item Color Code'   
        else ', ' + @ibd_colcde + ' - Invalid BOM Vendor Item Color Code' end)  , 300)
  where iid_cocde = @ibd_cocde and iid_venitm = @ibd_venitm and iid_xlsfil = @ibd_xlsfil and iid_chkdat = @ibd_chkdat  
 end  
  
 if @ibd_untcde <> (select top 1 ipi_pckunt from IMPCKINF where   
      --ipi_cocde = @ibd_cocde and   
      ipi_itmno = @itmno)   
 begin  
  set @ibd_sysmsg = left( @ibd_sysmsg + (case @ibd_sysmsg when '' then @ibd_untcde + ' - Invalid BOM Vendor Item UM'   
       else ', ' + @ibd_untcde + ' - Invalid BOM Vendor Item UM' end)  , 300)
  set @ibd_stage = 'I'  
   
  update IMITMDAT set iid_stage = 'I' , iid_sysmsg = left( iid_sysmsg +  (case iid_sysmsg when '' then @ibd_untcde + ' - Invalid BOM Vendor Item UM'   
        else ', ' + @ibd_untcde + ' - Invalid BOM Vendor Item UM' end)  , 300)
  where iid_cocde = @ibd_cocde and iid_venitm = @ibd_venitm and iid_xlsfil = @ibd_xlsfil and iid_chkdat = @ibd_chkdat  
 end   
end  
  
if (select count(1) from IMBOMDAT where ibd_cocde = @ibd_cocde and ibd_venitm = @ibd_venitm and ibd_acsno = @ibd_acsno and ibd_colcde = @ibd_colcde) > 0  
begin  
 UPDATE   
  IMBOMDAT set ibd_stage = 'O'  
 where  
  ibd_cocde = @ibd_cocde and ibd_venitm = @ibd_venitm and   
  ibd_acsno = @ibd_acsno and ibd_colcde = @ibd_colcde   
end  
  
  
insert into  IMBOMDAT  
(   
	ibd_cocde,  		ibd_venitm,  		ibd_acsno,  
	ibd_recseq, 		ibd_colcde,  		ibd_qty,   
	ibd_untcde, 		ibd_conftr, 		ibd_stage,  
	ibd_sysmsg, 		ibd_xlsfil,  		ibd_veneml,  
	ibd_malsts, 		ibd_chkdat, 		ibd_creusr,  
	ibd_updusr,  		ibd_credat,  		ibd_upddat,  
	ibd_venno, 		ibd_prdven  
	,ibd_itmdsc -- Lester Wu 2006-07-24  
	, ibd_period -- Frankie Cheung 20100304 Add BOM Period
	, ibd_period_bef	-- Frankie Cheung 20110217 Add Bom Period Before
)  
values  
(  
	@ibd_cocde,  		@ibd_venitm,  	@ibd_acsno,  
	@ibd_recseq, 		@ibd_colcde,  	@ibd_qty,  
	@ibd_untcde, 		@ibd_conftr,		@ibd_stage,   
	@ibd_sysmsg, 	@ibd_xlsfil, 		@ibd_veneml,   
	@ibd_malsts, 		@ibd_chkdat, 		'Excel',     
	'Excel',   		getdate(),   		getdate(),    
	@ibd_venno, 		@ibd_prdven  
	,@ibd_itmdsc -- Lester Wu 2006-07-24  
	, @ibd_period	-- Frankie Cheung 20100303 Add BOM Period
	, @period_bef	-- Frankie Cheung 20110217 Add Bom Period Before
)        
---------------------------------------------------------------------------------------------------------------------------------------------------------------------  
  
  
  
  









GO
GRANT EXECUTE ON [dbo].[sp_IMBOMDAT] TO [ERPUSER] AS [dbo]
GO
