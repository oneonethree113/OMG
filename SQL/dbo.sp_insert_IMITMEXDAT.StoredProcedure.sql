/****** Object:  StoredProcedure [dbo].[sp_insert_IMITMEXDAT]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_insert_IMITMEXDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_IMITMEXDAT]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



























/************************************************************************
Author:		
Date:		15th January, 2009
Description:	Upload External Factory Excel template
*************************************************************************
	MODIFICATION HISTORY
*************************************************************************
2012-07-23	David Yue	Added User ID
2012-07-27	David Yue	Added expiry date validation
2013-02-25	David Yue	External IM Enhancement
*************************************************************************
*/

CREATE          PROCEDURE [dbo].[sp_insert_IMITMEXDAT] 
@ied_cocde nvarchar(6),
@ied_venno nvarchar(6),		@ied_prdven nvarchar(6),	@ied_cusven nvarchar(6),	
@ied_cus1no nvarchar(10), 	@ied_cus2no nvarchar(10), 	@ied_venitm nvarchar(20),		
@ied_ucpno nvarchar(20),	@ied_ditmno nvarchar(20),	@ied_itmtyp nvarchar(4),
@ied_catlvl4 nvarchar(20),	@ied_engdsc nvarchar(800),	@ied_chndsc nvarchar(1600),
@ied_finishing nvarchar(50),	@ied_matl nvarchar(200),	@ied_natdsc nvarchar(200),
@ied_prdtyp nvarchar(50),	@ied_prdsztyp nvarchar(50),	@ied_prdszunt nvarchar(50),
@ied_prdszval numeric(13,4),	@ied_vencol nvarchar(50),	@ied_vencoldsc nvarchar(50),
@ied_vencol2 nvarchar(50),	@ied_lnecde nvarchar(10),	@ied_um nvarchar(20),		
@ied_inrqty int,		@ied_mtrqty int,		@ied_cft numeric(13,4),		
@ied_conftr int,		@ied_inrlin numeric(13,4),	@ied_inrwin numeric(13,4),	
@ied_inrhin numeric(13,4),	@ied_mtrlin numeric(13,4),	@ied_mtrwin numeric(13,4),	
@ied_mtrhin numeric(13,4),	@ied_grswgt numeric(13,4),	@ied_netwgt numeric(13,4),	
@ied_pckitr nvarchar(300),	@ied_xlsfil nvarchar(50),	@ied_chkdat datetime,
@ied_pbag nvarchar(50),		@ied_sfoam nvarchar(50),	@ied_bpack nvarchar(50),
@ied_ftyprctrmdsc nvarchar(200),@ied_curcde nvarchar(6),	@ied_ftycst numeric(13,4),
@ied_ftyprc numeric(13,4),	@ied_moqum nvarchar(4),		@ied_moq_str nvarchar(18),
@ied_moaccy nvarchar(6),	@ied_moa_str nvarchar(18),	@ied_qutdat datetime,
@ied_expdat datetime,		@ied_fcurcde nvarchar(6),	@ied_pckM  nvarchar(10),
@ied_prdgrpdsc nvarchar(200),	@ied_prdicondsc nvarchar(200),	@ied_intrmk nvarchar(2000),
@ied_cstrmk nvarchar(2000),	@ied_hkprctrmdsc nvarchar(200),	@ied_trantrmdsc nvarchar(100),
@ied_estprcflg nvarchar(1),	@ied_estprcref nvarchar(50),	@ied_end nvarchar(3),
@creusr		nvarchar(30)		

AS

BEGIN

declare
@ied_recseq int,			@ied_itmseq int,			@ied_mode nvarchar(3),			
@ied_itmsts nvarchar(3),	@ied_stage char(1),		@ied_sysmsg nvarchar(300),		
@ied_refresh char(1),		@ied_untcde nvarchar(6),	@ied_nat nvarchar(6),			
@ied_catlvl2 nvarchar(20),	@bomcst numeric(13,4), 	@bomprc numeric(13,4), 
@basprc numeric(13,4),		@ied_matcde nvarchar(6),	@ied_fmlopt nvarchar(10),	
@ied_itmprc numeric(13,4),	@bomqty int,			@ied_finishcde nvarchar(2),
@ied_moq int,			@ied_moa numeric(13,4)	,	@ipi_pckseq int,
@ipi_pckunt nvarchar(4),	@ipi_mtrqty int,			@ipi_inrqty int,
@exist_DV nvarchar(6),		@ied_prdgrp nvarchar(6),	@ied_prdicon nvarchar(6),
@ied_ftyprctrm nvarchar(6),	@ied_hkprctrm nvarchar(6),	@ied_trantrm nvarchar(10),
@debug int

declare
@imu_fmlopt nvarchar(5),	@imu_fmlopt1 nvarchar(5)   

declare
@ibi_engdsc nvarchar(800), 	@ibi_chndsc nvarchar(1600), 	@ibi_lnecde nvarchar(10),      
@ibi_catlvl4 nvarchar(20), 	@ibi_typ nvarchar(4),		@ibi_itmno nvarchar(20),      
@defven nvarchar(6),  		@itmtyp  nvarchar(4),  		@ibi_moqctn int, 
@ibi_wastage numeric(5,2),  	@ibi_remark nvarchar(2000)


set @ied_itmsts = 'INC'
set @ied_stage = 'W'
set @ied_cocde = ''
set @bomqty =  0

if @ied_venno is null
begin
 set @ied_venno = ''
end 

if @ied_prdven is null
begin
   set @ied_prdven = ''
end 

if @ied_cusven is null
begin
   set @ied_cusven = @ied_venno
end

if @ied_ucpno is null
begin
   set @ied_ucpno =''
end	

if @ied_venitm is null
begin
   set @ied_venitm =''
end

if @ied_ditmno is null
begin
   set @ied_ditmno =''
end	

if @ied_cus1no is null
begin
   set @ied_cus1no =''
end	

if @ied_cus2no is null
begin
   set @ied_cus2no =''
end	

if @ied_chndsc is null
begin
   set @ied_chndsc =''
end

-- set finishing to nothing
   set @ied_finishing =''


if @ied_natdsc is null
begin
  set @ied_natdsc = ''
end

if @ied_matl is null
begin
   set @ied_matl =''
end

if @ied_prdgrpdsc is null
begin
  set @ied_prdgrpdsc = ''
end

if @ied_prdicondsc is null
begin
  set @ied_prdicondsc = ''
end

if @ied_prdtyp is null
begin
   set @ied_prdtyp =''
end


if @ied_prdsztyp is null
begin
   set @ied_prdsztyp =''
end

if @ied_prdszunt is null
begin
   set @ied_prdszunt =''
end

if @ied_prdszval is null
begin
   set @ied_prdszval = 0
end

if @ied_vencol is null
begin
   set @ied_vencol =''
end

if @ied_vencoldsc is null
begin
   set @ied_vencoldsc =''
end

if @ied_vencol2 is null
begin
   set @ied_vencol2 =''
end

if @ied_ftycst is null
begin
   set @ied_ftycst = 0
end

if @ied_ftyprc is null
begin
   set @ied_ftyprc = 0
end

if @ied_inrqty is null      
begin      
 set @ied_inrqty = 0      
end      
      
if @ied_mtrqty is null      
begin      
 set @ied_mtrqty = 1      
end  

if @ied_cft is null      
begin      
 set @ied_cft = 0      
end  

if @ied_untcde is null      
begin      
 set @ied_untcde = ''  
end  

if @ied_conftr is null      
begin      
   set @ied_conftr = 1      
end   

if @ied_inrlin is null      
begin      
   set @ied_inrlin = 0      
end  

if @ied_inrwin is null      
begin      
   set @ied_inrwin = 0      
end  

if @ied_inrhin is null      
begin      
   set @ied_inrhin = 0      
end  

if @ied_mtrlin is null      
begin      
   set @ied_mtrlin = 0      
end  

if @ied_mtrwin is null      
begin      
   set @ied_mtrwin = 0      
end 

if @ied_mtrhin is null      
begin      
   set @ied_mtrhin = 0      
end 

if @ied_mtrhin is null      
begin      
   set @ied_mtrhin = 0      
end 

if @ied_grswgt is null      
begin      
   set @ied_grswgt = 0      
end 
   
if @ied_netwgt is null      
begin      
   set @ied_netwgt = 0      
end 

if @ied_pbag is null      
begin      
   set @ied_pbag = 0      
end 

if @ied_sfoam is null      
begin      
   set @ied_sfoam = 0      
end 

if @ied_bpack is null      
begin      
   set @ied_bpack = 0      
end 

if @ied_ftyprctrmdsc is null      
begin      
   set @ied_ftyprctrmdsc = ''      
end 

if @ied_hkprctrmdsc is null      
begin      
   set @ied_hkprctrmdsc = ''      
end 

if @ied_pckitr is null      
begin      
 set @ied_pckitr = ''
end    

if @ied_nat is null
begin
  set @ied_nat = ''
end

if @ied_moqum is null
begin
  set @ied_moqum = ''
end

if @ied_moq_str is null
begin
  set @ied_moq_str = ''
end

if @ied_moaccy is null
begin
  set @ied_moaccy = ''
end

if @ied_moa_str is null
begin
  set @ied_moa_str = ''
end

if @ied_intrmk is null
begin
  set @ied_intrmk = ''
end

if @ied_cstrmk is null
begin
  set @ied_cstrmk = ''
end

set @ied_engdsc = upper(@ied_engdsc)
set @ied_recseq = (Select isnull(max(ied_recseq),0)  + 1 from IMITMEXDAT where ied_cocde = @ied_cocde)    
set @ied_itmseq = (Select isnull(max(ied_itmseq),0)  + 1 from IMITMEXDAT)
set @ied_sysmsg = ''


/************************************************/      
-- Before Value - Start      
/************************************************/      
 
--Retrieve the English Desc, Chinese Desc., Line Code, Category Level 4, Item Type from IMBASINF      

	select		@ibi_engdsc = ibi_engdsc, 
			@ibi_chndsc = ibi_chndsc, 
			@ibi_lnecde = ibi_lnecde,      
	 		@ibi_catlvl4 = ibi_catlvl4, 
			@ibi_typ = ibi_typ,  
			@ibi_itmno = ibi_itmno,      
	 		@defven = ibi_venno, 
			@itmtyp = ibi_typ,  
	 		@ibi_moqctn=ibi_moqctn, 
			@ibi_wastage = ibi_wastage,  
			@ibi_remark = ibi_rmk      
	from 		IMBASINF 
	where		ibi_itmno = @ied_ucpno

 


/************************************************/      
-- Before Value - En
/************************************************/      

--- Check Exist of Design Vendor

if @ied_venno <> ''

begin
	if (select count(*) from VNBASINF (nolock) where vbi_venno = @ied_venno) = 0
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'      
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then  @ied_venno + ' - Design Vendor not found in Vendor Master'       
				else ', ' + @ied_venno + ' - Design Vendor not found in Vendor Master' end), 300)		
	end
end
else
begin
	set @ied_stage = 'I'      
	set @ied_refresh = 'N'  
	set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then  'Design Vendor is empty'       
			else ', Design Vendor is empty' end), 300)		
end

--- Check Exist of Production Vendor

if @ied_prdven <> ''
begin
	if (select count(*) from VNBASINF (nolock) where vbi_venno = @ied_prdven) = 0
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'      
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then  @ied_prdven + ' - Production Vendor not found in Vendor Master'       
				else ', ' + @ied_prdven + ' - Production Vendor not found in Vendor Master' end), 300)		
	end
end
else
begin
	set @ied_stage = 'I'      
	set @ied_refresh = 'N'  
	set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then  'Production Vendor is empty'       
			else ', Production Vendor is empty' end), 300)		
end

-- Check Exist of Custom Vendor
if @ied_cusven <> ''
begin
	if (select count(*) from VNBASINF (nolock) where vbi_venno = @ied_cusven) = 0
	begin
		set @ied_stage = 'I'
		set @ied_refresh = 'N'
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then '' else ', ' end) + @ied_cusven + ' - Custom Vendor not found in Vendor Master', 300)
	end
end

--- Check Category 4 is it exists ---
-- Note: catlvl4 can be empty in External Factory Excel Upload
if ltrim(rtrim(@ied_catlvl4)) <> ''
begin
	if @ied_itmtyp <> 'BOM'
	begin
		if (Select count(*) from SYCATREL (nolock) where ycr_catlvl4 = ltrim(rtrim(@ied_catlvl4))) = 0
		begin
			set @ied_stage = 'I'      
			set @ied_refresh = 'Y'      
			set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then @ied_catlvl4 + ' - Category 4 not found in Item Master!'       
				else ', ' + @ied_catlvl4 + ' - Category 4 not found in Item Master!' end), 300) 	
		end
		else
		begin
			Select @ied_catlvl2 = ycr_catlvl2 from SYCATREL (nolock) where ycr_catlvl4 = ltrim(rtrim(@ied_catlvl4))		
			if @ied_catlvl2 is null or @ied_catlvl2 = ''
			begin
				set @ied_stage = 'I'      
				set @ied_refresh = 'Y'      
				set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then @ied_catlvl2 + ' - Category 2 not found in Item Master!'       
					else ', ' + @ied_catlvl2 + ' - Category 2 not found in Item Master!' end), 300) 	
			end
		
		end
	end
end
else
begin
	set @ied_catlvl2 = ''
end				

--- Check BOM should not have cus1no, cus2no ---

if @ied_itmtyp = 'BOM'
begin
	if @ied_cus1no <> '' or @ied_cus2no <> '' 
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'  
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then  ' - BOM item should not have pri. or sec. customer.'       
				else ', - BOM item should not have pri. or sec. customer.' end), 300)						
	end		
end

--  Check Missing Pri. customer --
if ltrim(rtrim(@ied_cus1no)) = '' and ltrim(rtrim(@ied_cus2no)) <> '' 
begin
	set @ied_stage = 'I'      
	set @ied_refresh = 'N'  
	set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then  ' - Missing Pri. customer with Sec. customer entered.'       
			else ', - Missing Pri. customer with Sec. customer entered.' end), 300)						
end	

-- Check Vendor / Customer Group Relation --
if (select count(*) from CUGRPINF where cgi_cugrpcde = @ied_cus1no and cgi_flg_ext = 'Y') > 0
begin
	if (select count(*) from VNCUGREL where vcr_venno = @ied_prdven and vcr_cugrpcde = @ied_cus1no and vcr_flg_ext = 'Y') = 0
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then '' else ', ' end) + @ied_venno +
					' - PV Cannot be used with Customer Group (' + @ied_cus1no + ')', 300)
	end
end


-- Check exist of previous DV
select top 1 @exist_DV = imu_venno from IMPRCINF where imu_itmno = @ied_ucpno

if @exist_DV is not null and @exist_DV <> @ied_venno
begin	
	set @ied_stage = 'I'      
	set @ied_refresh = 'N'  
	set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then  ' - Item already have existing DV, no different DV can add.'       
		else ', - Item already have existing DV, no different DV can add.' end), 300)			
end

--- Check Key Mateial Item  ---
if ltrim(rtrim(@ied_matl)) <> ''
begin
	select @ied_matcde = ysi_cde from sysetinf where ysi_typ = '25' and ysi_dsc = ltrim(rtrim(replace(@ied_matl,'''''',''''))) 
	
	if @ied_matcde = '' or @ied_matcde is null
	begin  
		set @ied_stage = 'I'      
		set @ied_refresh = 'Y'   
		set @ied_matcde = ''
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then @ied_matl + ' - Invalid material!'       
			else ', ' + @ied_matl + ' - Invalid material!' end), 300) 	
	end  
end
else
begin
--	Frankie Cheung 2009/04/01  if Key material is empty in Excel file, use default material code 00
--	set @ied_stage = 'I'      
--	set @ied_refresh = 'Y'   
--	set @ied_matcde = ''
--	set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then 'Key Material is Empty.'       
--			 else ', Key Material is Empty.' end), 300) 
	set @ied_matcde = '00'
end	


--- Check Item Nature ---
if @ied_natdsc <> ''
begin
	select @ied_nat = ysi_cde from SYSETINF where ysi_dsc = ltrim(rtrim(replace(@ied_natdsc,'''''',''''))) and ysi_typ = '29'
	if @ied_nat is null
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'      
		set @ied_nat = ''
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then @ied_natdsc + ' - Invalid Item Nature.'       
			else ', ' + @ied_natdsc + '- Invalid Item Nature' end), 300) 
	end
end
else
begin
	set @ied_stage = 'I'      
	set @ied_refresh = 'N'   
	set @ied_nat = ''
	set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then 'Item Nature is Empty.'       
			 else ', Item Nature is Empty.' end), 300)  		
end


--- Check Product Group ---
if @ied_prdgrpdsc <> ''
begin
	select @ied_prdgrp = ysi_cde from SYSETINF where ysi_dsc = ltrim(rtrim(replace(@ied_prdgrpdsc,'''''',''''))) and ysi_typ = '24'
	if @ied_prdgrp is null
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'      
		set @ied_prdgrp = ''
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then @ied_prdgrpdsc + ' - Invalid Product Group.'       
			else ', ' + @ied_prdgrpdsc + '- Invalid Product Group.' end), 300) 
	end
end
else
begin
	set @ied_stage = 'I'      
	set @ied_refresh = 'N'   
	set @ied_prdgrp = ''
	set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then 'Product Group is Empty.'       
			 else ', Product Group is Empty.' end), 300)  		
end


--- Check Product Icon ---
if @ied_prdicondsc <> ''
begin
	select @ied_prdicon = ysi_cde from SYSETINF where ysi_dsc = ltrim(rtrim(replace(@ied_prdicondsc,'''''',''''))) and ysi_typ = '28'
	if @ied_prdicon is null
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'      
		set @ied_prdicon = ''
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then @ied_prdicondsc + ' - Invalid Product Icon.'       
			else ', ' + @ied_prdicondsc + '- Invalid Product Icon.' end), 300) 
	end
end
else
begin
	set @ied_stage = 'I'      
	set @ied_refresh = 'N'   
	set @ied_prdicon = ''
	set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then 'Product Icon is Empty.'       
			 else ', Product Icon is Empty.' end), 300)  		
end


-- Check Expiry Date --
if @ied_expdat <> ''
begin
	declare @date datetime
	declare @datestr nvarchar(40)
	set @datestr = convert(varchar(10),@ied_expdat,120) + ' 23:59:59'
	set @date = @datestr

	if @date >= getdate()
	begin
		set @ied_expdat = @date
	end
	else
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then '' else ', ' end) + convert(varchar(10),@ied_expdat,120) + ' - Expiry Date Already Expired',300)
	end
end

-- Check Exist of External Vendor markup formula

if @ied_stage <> 'I'    -- >>> i.e. with valid PV, catlvl2, and Material code <<< --
begin
	if @ied_itmtyp = 'BOM'
	begin
		set @imu_fmlopt = 'B01'
	end
	else if (select count(*) from IMCALFML where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
		icf_vencde = 'EXT' and icf_cus1no = @ied_cus1no and icf_cus2no = @ied_cus2no and
		icf_catlvl4 = @ied_catlvl4 and icf_expdat >= getdate()) > 0 and @ied_cus1no <> '' and
		@ied_cus2no <> '' and @ied_catlvl4 <> ''
	begin
		select	@imu_fmlopt = icf_fml_hk
		from	IMCALFML
		where	icf_caltar = 'IM' and
			icf_caltyp = 'BASIC' and
			icf_vencde = 'EXT' and
			icf_cus1no = @ied_cus1no and
			icf_cus2no = @ied_cus2no and
			icf_catlvl4 = @ied_catlvl4 and
			icf_expdat >= getdate()
	end
	else if (select count(*) from IMCALFML where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
		icf_vencde = 'EXT' and icf_cus1no = @ied_cus1no and icf_cus2no = '' and
		icf_catlvl4 = @ied_catlvl4 and icf_expdat >= getdate()) > 0 and @ied_cus1no <> '' and
		@ied_catlvl4 <> ''
	begin
		select	@imu_fmlopt = icf_fml_hk
		from	IMCALFML
		where	icf_caltar = 'IM' and
			icf_caltyp = 'BASIC' and
			icf_vencde = 'EXT' and
			icf_cus1no = @ied_cus1no and
			icf_cus2no = '' and
			icf_catlvl4 = @ied_catlvl4 and
			icf_expdat >= getdate()
	end
	else if (select count(*) from IMCALFML where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
		icf_vencde = 'EXT' and icf_cus1no = '' and icf_cus2no = '' and
		icf_catlvl4 = @ied_catlvl4 and icf_expdat >= getdate()) > 0 and @ied_catlvl4 <> ''
	begin
		select	@imu_fmlopt = icf_fml_hk
		from	IMCALFML
		where	icf_caltar = 'IM' and
			icf_caltyp = 'BASIC' and
			icf_vencde = 'EXT' and
			icf_cus1no = '' and
			icf_cus2no = '' and
			icf_catlvl4 = @ied_catlvl4 and
			icf_expdat >= getdate()
	end
	else if (select count(*) from IMCALFML where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
		icf_vencde = 'EXT' and icf_cus1no = @ied_cus1no and icf_cus2no = @ied_cus2no and
		icf_catlvl4 = '' and icf_expdat >= getdate()) > 0 and @ied_cus1no <> '' and @ied_cus2no <> ''
	begin
		select	@imu_fmlopt = icf_fml_hk
		from	IMCALFML
		where	icf_caltar = 'IM' and
			icf_caltyp = 'BASIC' and
			icf_vencde = 'EXT' and
			icf_cus1no = @ied_cus1no and
			icf_cus2no = @ied_cus2no and
			icf_catlvl4 = '' and
			icf_expdat >= getdate()
	end
	else if (select count(*) from IMCALFML where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
		icf_vencde = 'EXT' and icf_cus1no = @ied_cus1no and icf_cus2no = '' and
		icf_catlvl4 = '' and icf_expdat >= getdate()) > 0 and @ied_cus1no <> ''
	begin
		select	@imu_fmlopt = icf_fml_hk
		from	IMCALFML
		where	icf_caltar = 'IM' and
			icf_caltyp = 'BASIC' and
			icf_vencde = 'EXT' and
			icf_cus1no = @ied_cus1no and
			icf_cus2no = '' and
			icf_catlvl4 = '' and
			icf_expdat >= getdate()
	end
	else if (select count(*) from IMCALFML where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
		icf_vencde = @ied_venno and icf_cus1no = '' and icf_cus2no = '' and
		icf_catlvl4 = '' and icf_expdat >= getdate()) > 0
	begin
		select	@imu_fmlopt = icf_fml_hk
		from	IMCALFML
		where	icf_caltar = 'IM' and
			icf_caltyp = 'BASIC' and
			icf_vencde = @ied_venno and
			icf_cus1no = '' and
			icf_cus2no = '' and
			icf_catlvl4 = '' and
			icf_expdat >= getdate()
	end
	else
	begin
		select	@imu_fmlopt = icf_fml_hk
		from	IMCALFML
		where	icf_caltar = 'IM' and
			icf_caltyp = 'BASIC' and
			icf_vencde = 'EXT' and
			icf_cus1no = '' and
			icf_cus2no = '' and
			icf_catlvl4 = '' and
			icf_expdat >= getdate()
	end

	if @imu_fmlopt is NULL
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'Y'      
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then  @ied_prdven + '-'  + @ied_matcde + ' - Markup formula not found'       
			else ', ' + @ied_prdven + '-'  + @ied_matcde + ' - Markup formula not found' end), 300)	
	end	
end




--- Check Conversion Factor is it exists ---

if @ied_itmtyp <> 'AST'
begin
	Select @ied_untcde =  ycf_code1 from SYCONFTR 
	where 
		ycf_systyp = 'Y' and 
		ycf_code2 = 'PC' and 
		ycf_dsc1 = @ied_um and 
		ycf_value = @ied_conftr

	if @ied_untcde is NULL or @ied_untcde = ''       
	begin  
		if @ied_conftr = 1 and (@ied_um = 'BUNDLE')
		begin
			Select @ied_untcde =  ycf_code1 from SYCONFTR 
			where 
				ycf_systyp = 'N' and 
				ycf_code2 = 'PC' and 
				ycf_dsc1 = @ied_um and 
				ycf_value = @ied_conftr
		end
		else
		begin
			set @ied_stage = 'I'      
			set @ied_refresh = 'N'      
			set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then 'Invalid Conversion Factor'       
					 else ', Invalid Conversion Factor' end), 300)  
		end
	end
end 
else -- if @ied_itmtyp <> 'AST', else mean = 'AST'
begin
	Select @ied_untcde =  ycf_code1 from SYCONFTR 
	where 
		ycf_systyp = 'Y' and 
		ycf_code2 = 'PC' and 
		ycf_dsc1 = @ied_um and 
		ycf_value = @ied_conftr
	if @ied_untcde is NULL or @ied_untcde = ''       
	begin  
		-- if UM and conftr not found in SYCONFTR, it is invalid conversion factor.
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'      
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then 'Invalid Conversion Factor'       
				 else ', Invalid Conversion Factor' end), 300)  
	end
	else
	begin
		--For external AST, the UM must be ST, not ST2, ST50 etc as the UM
		Select @ied_untcde =  ycf_code1 from SYCONFTR 
		where 
			ycf_systyp = 'Y' and 
			ycf_code2 = 'PC' and 
			ycf_dsc1 = @ied_um and 
			ycf_value = 1		 
	end
end
 
 -- Altered  by David Yue 2012-10-11 --
 -- Item Cost can consist no more than 4 decimal places
 -- check Item Cost field is more than 4 decimal point or not.      
if @ied_ftyprc <> round(@ied_ftyprc,4)      
begin      
	set @ied_stage = 'I'      
	set @ied_refresh = 'N'      
	set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then 'Item Cost should not be more than 4 decimal point'       
			else ', Item Cost should not be  more than 4 decimal point ' end), 300)    
end

/*
 ---- Check Primary Customer exist or not. ----
If isnull(@ied_cus1no,'') <> ''
begin            
	if (Select count(1) from CUBASINF where cbi_cusno = @ied_cus1no and cbi_custyp = 'P') = 0
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'      
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then @ied_cus1no + ' - Primary Customer not found in Customer Master !'       
			else ', ' + @ied_cus1no + '- Primary Customer not found in Customer Master !' end), 300)  
	end
end

---- Check Secondary Customer exist or not. ----
If isnull(@ied_cus2no,'') <> ''
begin           
	if (Select count(1) from CUBASINF where cbi_cusno = @ied_cus2no and cbi_custyp = 'S') = 0
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'      
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then @ied_cus2no + ' - Secondary Customer not found in Customer Master !'       
			else ', ' + @ied_cus2no + '- Secondary Customer not found in Customer Master !' end), 300)  
	end
end

---- Check Mapping of Primary and Secondary Customers. ----
If (isnull(@ied_cus1no,'') <> '') and (isnull(@ied_cus2no,'') <> '')
begin
	if (select count(1) from CUSUBCUS where csc_prmcus = @ied_cus1no and csc_seccus = @ied_cus2no) = 0
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'      
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then ' - Primary Customer: ' + @ied_cus1no + ' not map with Secondary Customer: ' + @ied_cus2no +  '. '       
			else ', ' + '- Primary Customer: ' + @ied_cus1no + ' not map with Secondary Customer: ' + @ied_cus2no +  '. '  end), 300) 
	end 		
end
*/

-- Edited by David Yue 2013-02-25 External IM Enhancement --
-- Check if Primary Customer is Empty --
if ltrim(rtrim(isnull(@ied_cus1no,''))) = ''
begin
	if @ied_itmtyp <> 'BOM'
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'      
		set @ied_sysmsg = left(@ied_sysmsg + (case len(@ied_sysmsg) when 0 then '' else ', ' end) + @ied_cus1no + 
					' - Primary Customer cannot be empty', 300) 
	end
end
else
begin
	-- Check Primary Customer if contains in Customer Group --
	if (select count(*) from CUGRPINF where cgi_flg_ext = 'Y' and cgi_cugrpcde = ltrim(rtrim(@ied_cus1no))) > 0
	begin
		if ltrim(rtrim(isnull(@ied_cus2no,''))) <> ''
		begin
			set @ied_stage = 'I'      
			set @ied_refresh = 'N'      
			set @ied_sysmsg = left(@ied_sysmsg + (case len(@ied_sysmsg) when 0 then '' else ', ' end) + @ied_cus2no + 
						' - Customer Group does not contain Secondary Customer', 300) 
		end
	end
	else
	begin
		-- Check if Primary Customer exist in Customer Master --
		if ltrim(rtrim(isnull(@ied_cus2no,''))) <> ''
		begin
			if (Select count(1) from CUBASINF where cbi_cusno = @ied_cus2no and cbi_custyp = 'S') = 0
			begin
				set @ied_stage = 'I'      
				set @ied_refresh = 'N'      
				set @ied_sysmsg = left(@ied_sysmsg + (case len(@ied_sysmsg) when 0 then '' else ', ' end) + @ied_cus2no + 
						  '- Secondary Customer not found in Customer Master !', 300)  
			end
			else
			begin
				-- Check Mapping of Primary and Secondary Customers --
				if (select count(1) from CUSUBCUS where csc_prmcus = @ied_cus1no and csc_seccus = @ied_cus2no) = 0
				begin
					set @ied_stage = 'I'      
					set @ied_refresh = 'N'      
					set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then ' - Primary Customer: ' + @ied_cus1no + ' not map with Secondary Customer: ' + @ied_cus2no +  '. '       
						else ', ' + '- Primary Customer: ' + @ied_cus1no + ' not map with Secondary Customer: ' + @ied_cus2no +  '. '  end), 300) 
				end 	
			end
		end
	end
end
      
-- Check the Product Line with Item Master    

if @ied_itmtyp <> 'BOM'
begin
	if (Select count(1) from SYLNEINF where yli_lnecde = ltrim(rtrim(@ied_lnecde))) = 0
	begin
		set @ied_stage = 'I'      

		set @ied_refresh = 'N'      
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then @ied_lnecde + ' - Product line not exist in Item Master!'       
			else ', ' + @ied_lnecde + ' - Product line not exist in Item Master!' end), 300) 	
	end
end

---- Check Price Term ----

If @ied_ftyprctrmdsc <> ''
begin
	select @ied_ftyprctrm = ysi_cde from SYSETINF where ysi_dsc = ltrim(rtrim(replace(@ied_ftyprctrmdsc,'''''',''''))) and ysi_typ = '03'
	if @ied_ftyprctrm is null
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'      
		set @ied_prdicon = ''
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then @ied_ftyprctrmdsc + ' - Invalid Factory Price Term.'       
			else ', ' + @ied_ftyprctrmdsc + '- Invalid Factory Price Term.' end), 300) 
	end
end
else
begin
	set @ied_stage = 'I'      
	set @ied_refresh = 'N'      
	set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then 'Factory Price term is empty'       
			else ', Factory Price term is empty' end), 300) 
end


If @ied_hkprctrmdsc <> ''
begin
	select @ied_hkprctrm = ysi_cde from SYSETINF where ysi_dsc = ltrim(rtrim(replace(@ied_hkprctrmdsc,'''''',''''))) and ysi_typ = '03'
	if @ied_hkprctrm is null
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'      
		set @ied_prdicon = ''
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then @ied_hkprctrmdsc + ' - Invalid HK Price Term.'       
			else ', ' + @ied_hkprctrmdsc + '- Invalid HK Price Term.' end), 300) 
	end
end
else
begin
	set @ied_stage = 'I'      
	set @ied_refresh = 'N'      
	set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then 'HK Price term is empty'       
			else ', HK Price term is empty' end), 300) 
end

set @ied_finishcde = ''

--- Check Transport Term ---
if @ied_trantrmdsc <> ''
begin
	select @ied_trantrm = isnull(ysi_cde,'') from SYSETINF (nolock) where ysi_typ = '30' and ysi_dsc = ltrim(rtrim(replace(@ied_trantrmdsc,'''''','''')))
	if @ied_trantrm is null
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'      
		set @ied_prdicon = ''
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then @ied_trantrmdsc + ' - Invalid Transport Term.'       
			else ', ' + @ied_trantrmdsc + '- Invalid Transport Term.' end), 300) 
	end
end
else
begin
	set @ied_stage = 'I'      
	set @ied_refresh = 'N'      
	set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then 'Transport Term is empty'       
			else ', Transport Term is empty' end), 300) 
end

-- Checking for MOQ and MOA

if ltrim(rtrim(@ied_moq_str)) <> '' and ltrim(rtrim(@ied_moa_str)) <> '' 
begin
	if ltrim(rtrim(@ied_moq_str)) <> '0' and ltrim(rtrim(@ied_moa_str)) <> '0' 
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'   
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then ' - Both of MOA and MOQ entered.'       
				else ', - Both of MOA and MOQ entered.' end), 300) 
	end
end
else if ltrim(rtrim(@ied_moq_str)) <> ''
begin
	if isnumeric(@ied_moq_str) > 0
	begin
		set @ied_moq = convert(integer, @ied_moq_str)
	end 
	else
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'   
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then ' - MOQ must be integer.'       
			else ', - MOQ must be integer.' end), 300) 		
	end
end
else if ltrim(rtrim(@ied_moa_str)) <> ''
begin
	if isnumeric(@ied_moa_str) > 0
	begin
		set @ied_moa = convert(numeric(13,4), @ied_moa_str)
	end 
	else
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'   
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then ' - MOA must be numeric.'       
			else ', - MOA must be numeric.' end), 300) 		
	end

end

-- Editted by David Yue 2013-06-03 Allowing User to use self-defined MOQ/MOA during upload
/*
-- Clear MOQ and MOA for Customer Group entries --
if (select count(*) from CUGRPINF where cgi_cugrpcde = ltrim(rtrim(@ied_cus1no)) and cgi_flg_ext = 'Y') > 0
begin
	
	if isnull(@ied_moq,0) > 0 or isnull(@ied_moa,0) > 0
	begin
		set @ied_moqum = ''
		set @ied_moq = 0
		set @ied_moaccy = ''
		set @ied_moa = 0
	end
end
else
begin
	if isnull(@ied_moq,0) = 0 and isnull(@ied_moa,0) = 0
	begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'   
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then '' else ', ' end) +
					' - MOQ or MOA must be entered for Customer Specific Price.', 300) 	
	end
end
*/
if isnull(@ied_moq,0) = 0 and isnull(@ied_moa,0) = 0
begin
	set @ied_stage = 'I'      
	set @ied_refresh = 'N'   
	set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then '' else ', ' end) +
				' - MOQ or MOA must be entered.', 300) 	
end

if @ied_itmtyp <> 'AST'
begin
	set @ied_conftr = 1
end

--- Editted by David Yue: Replaced IMMRKUP and IMMRKUPDTL Tables with IMPRCINF
--- Check exist of IMPRCINF record and get upload mode
	if (Select count(1) from IMPRCINF where 
		imu_itmno = @ied_ucpno and 
		imu_prdven = @ied_prdven and
		imu_venno = @ied_venno and
		imu_pckunt = @ied_untcde and 
		imu_mtrqty = @ied_mtrqty and 
		imu_inrqty = @ied_inrqty and
		imu_cus1no = ltrim(rtrim(@ied_cus1no)) and
		imu_cus2no = ltrim(rtrim(@ied_cus2no)) and
		imu_ftyprctrm = @ied_ftyprctrm and
		imu_hkprctrm = @ied_hkprctrm and
		imu_trantrm = @ied_trantrm
	) = 0
	begin
		set @ied_mode = 'NEW'
	end
	else
	begin
		set @ied_mode = 'UPD'
	end

--- Check exist of IMPRCINF record and get upload mode
if @ied_mode = 'UPD' 
begin
	if @ied_itmtyp = 'AST' 
	begin
		if @ibi_typ <> 'ASS'
		begin	
			set @ied_stage = 'I'      
			set @ied_refresh = 'N'   
			set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then @ied_itmtyp + ' - Item Type different with IM!'       
				else ', ' + @ied_itmtyp + ' - Item Type different with IM!' end), 300) 	
		end	
	end
	else
	begin
		if @ibi_typ <> @ied_itmtyp
		begin
		set @ied_stage = 'I'      
		set @ied_refresh = 'N'   
		set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then @ied_itmtyp + ' - Item Type different with IM!'       
			else ', ' + @ied_itmtyp + ' - Item Type different with IM!' end), 300) 	
		end
	end
end

if @ied_mode = 'NEW'
begin
	if (select count(*) from IMVENINF where ivi_itmno = @ied_ucpno and ivi_venno = @ied_prdven and ivi_venitm = @ied_venitm) = 0
	begin
		-- Add check for same PV, venitm => invalid
		if (select count(1) from imveninf where ivi_venno = @ied_prdven and ivi_venitm = @ied_venitm) > 0
		begin
			set @ied_stage = 'I'      
			set @ied_refresh = 'N'      
			set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then  @ied_venno + ' - PV + Vendor Item Number already exist'       
					else ', ' + @ied_venno + ' - PV + Vendor Item Number already exist' end), 300)		
		end
	end
end

--- Check whehter 'AST' already has a packing
if @ied_mode = 'NEW' and @ied_itmtyp = 'AST' 
begin
	select @ipi_pckseq = ipi_pckseq, @ipi_pckunt = ipi_Pckunt, @ipi_mtrqty = ipi_mtrqty, @ipi_inrqty = ipi_inrqty 
	from IMPCKINF 
	where  ipi_itmno = @ied_ucpno	
	
	if @ipi_pckunt is not null
	begin
		if @ipi_pckunt <> @ied_untcde or @ipi_mtrqty <> @ied_mtrqty or @ipi_inrqty <> @ied_inrqty
		begin
			set @ied_stage = 'I'      
			set @ied_refresh = 'N'   
			set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then @ied_itmtyp + ' - this Assortment Item already has a packing, cannot add new packing'       
				else ', ' + @ied_itmtyp + ' - this Assortment Item already has a packing, cannot add new packing' end), 300) 	
		end
	end	
end


--- Check whehter 'BOM' already has a packing
if @ied_mode = 'NEW' and @ied_itmtyp = 'BOM' 
begin
	select @ipi_pckseq = ipi_pckseq, @ipi_pckunt = ipi_Pckunt, @ipi_mtrqty = ipi_mtrqty, @ipi_inrqty = ipi_inrqty 
	from IMPCKINF 
	where  ipi_itmno = @ied_ucpno	
	
	if @ipi_pckunt is not null
	begin	
		if @ipi_pckunt <> @ied_untcde or @ipi_mtrqty <> @ied_mtrqty or @ipi_inrqty <> @ied_inrqty
		begin
			set @ied_stage = 'I'      
			set @ied_refresh = 'N'   
			set @ied_sysmsg = left(@ied_sysmsg + (case @ied_sysmsg when '' then @ied_itmtyp + ' - this BOM Item already has a packing, cannot add new packing'       
				else ', ' + @ied_itmtyp + ' - this BOM Item already has a packing, cannot add new packing' end), 300) 	
		end
	end
	
end



if @ied_stage <> 'I'
begin
	if (select count(*) from IMITMEXDAT where ied_ucpno = @ied_ucpno) = 0
	begin
		update IMBASINF
		set 
			ibi_prvsts = ibi_itmsts,
			ibi_itmsts = 'HLD',
			ibi_updusr = @creusr,
			ibi_upddat = getdate()
		where
			ibi_itmno = @ied_ucpno
	end
end

select @ied_prdsztyp = ysi_cde from sysetinf where ysi_typ = '26' and ysi_cde = ltrim(rtrim(@ied_prdsztyp))

select @ied_prdszunt = ysi_cde from sysetinf where ysi_typ = '27' and ysi_dsc = ltrim(rtrim(@ied_prdszunt))

if (select count(1) from IMITMEXDAT 
	where	ied_ucpno = @ied_ucpno and 
		ied_inrqty = @ied_inrqty and      
		ied_mtrqty = @ied_mtrqty and 
		ied_untcde = @ied_untcde and  
		ied_venno = @ied_venno and
		ied_prdven = @ied_prdven and 
		ied_cus1no = @ied_cus1no and
		ied_cus2no = @ied_cus2no and
		ied_prctrm = @ied_ftyprctrm and
		ied_hkprctrm = @ied_hkprctrm and
		ied_trantrm = @ied_trantrm and
		(ied_stage = 'W' or ied_stage = 'I') ) > 0      
begin      
	update	IMITMEXDAT 
	set 	ied_stage = 'O', ied_upddat = getdate() 
	where	ied_ucpno = @ied_ucpno and
		ied_inrqty = @ied_inrqty and      
	           ied_mtrqty = @ied_mtrqty and
		ied_untcde = @ied_untcde and
		ied_venno = @ied_venno and
		ied_prdven = @ied_prdven and
		ied_cus1no = @ied_cus1no and
		ied_cus2no = @ied_cus2no and
		ied_prctrm = @ied_ftyprctrm and
		ied_hkprctrm = @ied_hkprctrm and
		ied_trantrm = @ied_trantrm and
		(ied_stage = 'W' or ied_stage = 'I')
end    

-- Calculate bom cost, bom price and basic price for Before/After comparsion

set @ied_itmprc = 0
set @bomcst = 0
set @bomprc = 0
set @basprc = 0
set @ied_fmlopt = 0


/************************************************/      
-- INSERT INTO table IMITMEXDAT
/************************************************/   

insert into IMITMEXDAT
(
	ied_cocde,		ied_venno,		ied_prdven,
	ied_cusven,		ied_cus1no,		ied_cus2no,
	ied_venitm,		ied_itmseq,		ied_recseq,
	ied_ucpno,		ied_ditmno,		ied_mode,
	ied_itmsts,		ied_stage,		ied_catlvl4,
 	ied_itmtyp,		ied_engdsc,		ied_chndsc,
	ied_finishing,		ied_matcde,		ied_nat,	
	ied_prdgrp,		ied_prdicon,		ied_prdtyp,
	ied_prdsztyp,		ied_prdszunt,		ied_prdszval,
	ied_vencol,		ied_vencoldsc,		ied_vencol2,
	ied_lnecde,		ied_untcde,		ied_inrqty,
	ied_mtrqty,		ied_cft,		ied_conftr,
	ied_inrlin,		ied_inrwin,		ied_inrhin,
	ied_mtrlin,		ied_mtrwin,		ied_mtrhin,
	ied_pckM,		ied_grswgt,		ied_netwgt,
	ied_pckitr,		ied_sysmsg,		ied_xlsfil,
	ied_chkdat,		ied_prctrm,		ied_hkprctrm,
	ied_trantrm,		ied_curcde,		ied_ftycst,
	ied_ftyprc,		ied_moqum,		ied_moq,
	ied_moaccy,		ied_moa,		ied_qutdat,
	ied_expdat,		ied_bomcst, 		ied_bomprc,
	ied_basprc,		ied_fmlopt, 		ied_fcurcde,
	ied_intrmk,		ied_estprcflg,		ied_estprcref,
	ied_cstrmk,		ied_creusr,		ied_updusr,	
	ied_credat,		ied_upddat
)
values	
(
	'',			@ied_venno,		@ied_prdven,
	@ied_cusven,		@ied_cus1no,		@ied_cus2no,
	@ied_venitm,		@ied_itmseq,		@ied_recseq,
	@ied_ucpno,		@ied_ditmno,		@ied_mode,
	@ied_itmsts,		@ied_stage,		@ied_catlvl4,
	@ied_itmtyp,		@ied_engdsc,		@ied_chndsc,
	@ied_finishcde,		@ied_matcde,		@ied_nat,
	@ied_prdgrp,		@ied_prdicon,		@ied_prdtyp,
	@ied_prdsztyp,		@ied_prdszunt,		@ied_prdszval,	
	@ied_vencol,		@ied_vencoldsc,		@ied_vencol2,
	@ied_lnecde,		@ied_untcde,		@ied_inrqty,
	@ied_mtrqty,		@ied_cft,		@ied_conftr,
	@ied_inrlin,		@ied_inrwin,		@ied_inrhin,
	@ied_mtrlin,		@ied_mtrwin,		@ied_mtrhin,
	@ied_pckM,		@ied_grswgt,		@ied_netwgt,
	@ied_pckitr,		@ied_sysmsg,		@ied_xlsfil,
	@ied_chkdat,		@ied_ftyprctrm,		@ied_hkprctrm,
	@ied_trantrm,		@ied_curcde,		@ied_ftycst,
	@ied_ftyprc,		@ied_moqum,		@ied_moq,
	@ied_moaccy,		isnull(@ied_moa,0),	@ied_qutdat,
	@ied_expdat,		@bomcst, 		@bomprc, 
	@basprc, 		@ied_fmlopt,		@ied_fcurcde,
	@ied_intrmk,		@ied_estprcflg,		left(@ied_estprcref, 50),
	@ied_cstrmk,		@creusr,		@creusr,		
	getdate(),		getdate()

)
	
END



















GO
GRANT EXECUTE ON [dbo].[sp_insert_IMITMEXDAT] TO [ERPUSER] AS [dbo]
GO
