/****** Object:  StoredProcedure [dbo].[sp_calBasicPrice_excel]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_calBasicPrice_excel]
GO
/****** Object:  StoredProcedure [dbo].[sp_calBasicPrice_excel]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*
=========================================================
Program ID	: 	sp_calBasicPrice_excel
Description   	: 	Calculate Basic Price for IMITMDAT
Programmer  	: 	David Yue
Create Date	:	2012-08-29
=========================================================
 Modification History                                   
=========================================================
2012-08-29	David Yue	Rewritten for new calculation algorithm
2013-06-05	David Yue	Performance Revision
=========================================================     
*/

CREATE   procedure [dbo].[sp_calBasicPrice_excel]
@iid_cocde	varchar(6) ,
@iid_venitm	nvarchar(30) ,
@iid_venno	nvarchar(6) ,
@iid_xlsfil	nvarchar(30) ,	
@iid_chkdat 	datetime ,
@iid_prdven	nvarchar(6) ,
@iid_curcde	nvarchar(6) ,
@iid_ftyprc	numeric(13,4) , 
@iid_lnecde 	nvarchar(10) , 
@iid_catlvl4	nvarchar(20) , 
@ventyp		char(1),
@basicPrice_af	numeric(13,4) output,
@bomprice_af	numeric(13,4) output

AS

DECLARE
@iid_itmtyp	nvarchar(4),	@iid_itmseq	int,		@iid_recseq	int,
@iid_untcde	nvarchar(6),	@iid_inrqty	int,		@iid_mtrqty 	int,
@iid_assconftr	int,		@iic_cus1no	nvarchar(6),	@iic_cus2no	nvarchar(6),
@iic_negprc	numeric(13,4)

DECLARE
@imu_basprc	numeric(13,4),	@imu_fmlopt	nvarchar(5),	@fml		nvarchar(300),
@i		int,		@OP		nvarchar(1),	@end		int,
@imu_selrat	numeric(16,11),	@temp 		numeric(13,4),	@imu_itmprc	numeric(13,4)

-- Initializing Output Values
set @imu_basprc = 0
set @basicPrice_af = 0
set @bomprice_af = 0

select	@iid_itmtyp = iid_itmtyp,
	@iid_untcde = iid_untcde,
	@iid_inrqty = iid_inrqty,
	@iid_mtrqty = iid_mtrqty,
	@iid_itmseq = iid_itmseq,
	@iid_recseq = iid_recseq,
	@iid_assconftr = iid_assconftr
from	IMITMDAT
where	iid_venitm = @iid_venitm and
	iid_venno = @iid_venno and
	iid_xlsfil = @iid_xlsfil and
	iid_chkdat = @iid_chkdat and 
	iid_prdven = @iid_prdven

SELECT top 1
	@iic_cus1no = isnull(iic_cus1no,''),
	@iic_cus2no = isnull(iic_cus2no,''),
	@iic_negprc = round(isnull(iic_negprc,0),4)
FROM 	IMITMDATCST (nolock)
WHERE	iic_venno = @iid_venno and  
	iic_prdven = @iid_prdven and  
   	iic_venitm = @iid_venitm and 
	iic_untcde = @iid_untcde and  
	iic_inrqty = @iid_inrqty and 
	iic_mtrqty = @iid_mtrqty and
	iic_itmseq = @iid_itmseq and
	iic_recseq = @iid_recseq and 
	iic_xlsfil = @iid_xlsfil and
	iic_chkdat = @iid_chkdat and
	iic_stage = 'W' and
	iic_conftr = @iid_assconftr
ORDER BY iic_credat desc

if @iid_itmtyp = 'BOM'
begin
	set @basicPrice_af = 0
	set @bomprice_af = 0
end
else -- if @iid_itmtyp <> 'BOM'
begin
	-- Select the appropriate Markup Formula --
	if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
		icf_vencde = 'INT' and icf_cus1no = @iic_cus1no and icf_cus2no = @iic_cus2no and
		icf_catlvl4 = @iid_catlvl4 and icf_expdat >= getdate()) > 0 and
		@iic_cus1no <> '' and @iic_cus2no <> '' and @iid_catlvl4 <> ''
	begin
		select	@imu_fmlopt = icf_fml_hk,
			@fml = yfi_fml
		from	IMCALFML (nolock), SYFMLINF (nolock)
		where	icf_caltar = 'IM' and
			icf_caltyp = 'BASIC' and
			icf_vencde = 'INT' and
			icf_cus1no = @iic_cus1no and
			icf_cus2no = @iic_cus2no and
			icf_catlvl4 = @iid_catlvl4 and
			icf_expdat >= getdate() and
			yfi_fmlopt = icf_fml_hk
	end
	else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
		icf_vencde = 'INT' and icf_cus1no = @iic_cus1no and icf_cus2no = '' and
		icf_catlvl4 = @iid_catlvl4 and icf_expdat >= getdate()) > 0 and
		@iic_cus1no <> '' and @iid_catlvl4 <> ''
	begin
		select	@imu_fmlopt = icf_fml_hk,
			@fml = yfi_fml
		from	IMCALFML (nolock), SYFMLINF (nolock)
		where	icf_caltar = 'IM' and
			icf_caltyp = 'BASIC' and
			icf_vencde = 'INT' and
			icf_cus1no = @iic_cus1no and
			icf_cus2no = '' and
			icf_catlvl4 = @iid_catlvl4 and
			icf_expdat >= getdate() and
			yfi_fmlopt = icf_fml_hk
	end
	else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
		icf_vencde = 'INT' and icf_cus1no = '' and icf_cus2no = '' and
		icf_catlvl4 = @iid_catlvl4 and icf_expdat >= getdate()) > 0 and @iid_catlvl4 <> ''
	begin
		select	@imu_fmlopt = icf_fml_hk,
			@fml = yfi_fml
		from	IMCALFML (nolock), SYFMLINF (nolock)
		where	icf_caltar = 'IM' and
			icf_caltyp = 'BASIC' and
			icf_vencde = 'INT' and
			icf_cus1no = '' and
			icf_cus2no = '' and
			icf_catlvl4 = @iid_catlvl4 and
			icf_expdat >= getdate() and
			yfi_fmlopt = icf_fml_hk
	end
	else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
		icf_vencde = 'INT' and icf_cus1no = @iic_cus1no and icf_cus2no = @iic_cus2no and
		icf_catlvl4 = '' and icf_expdat >= getdate()) > 0 and @iic_cus1no <> '' and @iic_cus2no <> ''
	begin
		select	@imu_fmlopt = icf_fml_hk,
			@fml = yfi_fml
		from	IMCALFML (nolock), SYFMLINF (nolock)
		where	icf_caltar = 'IM' and
			icf_caltyp = 'BASIC' and
			icf_vencde = 'INT' and
			icf_cus1no = @iic_cus1no and
			icf_cus2no = @iic_cus2no and
			icf_catlvl4 = '' and
			icf_expdat >= getdate() and
			yfi_fmlopt = icf_fml_hk
	end
	else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
		icf_vencde = 'INT' and icf_cus1no = @iic_cus1no and icf_cus2no = '' and
		icf_catlvl4 = '' and icf_expdat >= getdate()) > 0 and @iic_cus1no <> ''
	begin
		select	@imu_fmlopt = icf_fml_hk,
			@fml = yfi_fml
		from	IMCALFML (nolock), SYFMLINF (nolock)
		where	icf_caltar = 'IM' and
			icf_caltyp = 'BASIC' and
			icf_vencde = 'INT' and
			icf_cus1no = @iic_cus1no and
			icf_cus2no = '' and
			icf_catlvl4 = '' and
			icf_expdat >= getdate() and
			yfi_fmlopt = icf_fml_hk
	end
	else if (select count(*) from IMCALFML (nolock) where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
		icf_vencde = @iid_venno and icf_cus1no = '' and icf_cus2no = '' and
		icf_catlvl4 = '' and icf_expdat >= getdate()) > 0
	begin
		select	@imu_fmlopt = icf_fml_hk,
			@fml = yfi_fml
		from	IMCALFML (nolock), SYFMLINF (nolock)
		where	icf_caltar = 'IM' and
			icf_caltyp = 'BASIC' and
			icf_vencde = @iid_venno and
			icf_cus1no = '' and
			icf_cus2no = '' and
			icf_catlvl4 = '' and
			icf_expdat >= getdate() and
			yfi_fmlopt = icf_fml_hk
	end
	else
	begin
		select	@imu_fmlopt = icf_fml_hk,
			@fml = yfi_fml
		from	IMCALFML (nolock), SYFMLINF (nolock)
		where	icf_caltar = 'IM' and
			icf_caltyp = 'BASIC' and
			icf_vencde = 'INT' and
			icf_cus1no = '' and
			icf_cus2no = '' and
			icf_catlvl4 = '' and
			icf_expdat >= getdate() and
			yfi_fmlopt = icf_fml_hk
	end
	
	if @fml is null or @fml = ''
	begin
		set @fml = '0'
	end
	
	select	@imu_selrat = isnull(yce_selrat, 0)
	from	SYCUREX (nolock)
	where	yce_frmcur = @iid_curcde and
		yce_tocur = (select ysi_cde from SYSETINF (nolock) where ysi_typ = '06' and ysi_def = 'Y') and
		yce_iseff = 'Y'
	
	SET @fml = LTRIM(RTRIM(@fml))
	SET @i  = 1

	set @fml = replace(@fml, ' ','')

	if (substring(@fml,1,1) <> '*') and (substring(@fml,1,1)<> '/')
	begin
		set @fml = '*' + @fml
	end
	
	set @imu_itmprc = @iid_ftyprc
	
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
			set @end = charindex('/', @fml)
		else if (charindex('/', @fml) = 0) 
			set @end = charindex('*', @fml)
		else
		    begin
			if (charindex('*', @fml) < charindex('/', @fml)) 
				set @end = charindex('*', @fml)
			else
				set @end = charindex('/', @fml)
		    end	
		---------------------------
		set @temp = substring(@fml, 1, @end -1)
		if @OP = '*'
			set @imu_itmprc = @imu_itmprc   * @temp
		else if @OP = '/' 
			set @imu_itmprc = @imu_itmprc   / @temp
		---------------------------
		set @fml = substring(@fml, @end, len(@fml))
	end
	
	--- Calculate Basic Price ---
	
	set @bomprice_af = 0
	set @imu_basprc = round((@imu_itmprc * @imu_selrat) + @bomprice_af,4)
	set @imu_itmprc = round(@imu_itmprc * @imu_selrat ,4)	

	-- END Basic Price Calculation --
	
	-- Output Results --
	set @bomprice_af = 0
	set @basicPrice_af = @imu_basprc
end





GO
GRANT EXECUTE ON [dbo].[sp_calBasicPrice_excel] TO [ERPUSER] AS [dbo]
GO
