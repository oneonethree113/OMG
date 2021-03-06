/****** Object:  StoredProcedure [dbo].[sp_select_IMCALFML_QUM00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IMCALFML_QUM00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IMCALFML_QUM00001]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





/********************************************************************************************************************
Modification History
********************************************************************************************************************
Modify on		Modify by		Description
********************************************************************************************************************

********************************************************************************************************************/

CREATE  PROCEDURE [dbo].[sp_select_IMCALFML_QUM00001] 
@ied_cus1no	nvarchar(6),
@ied_cus2no	nvarchar(6),
@ied_prdven	nvarchar(6),
@ied_fcurcde	nvarchar(6),
@ied_ftyprc	numeric(13, 4)

AS

declare
@imu_fmlopt	nvarchar(6),	@fml	nvarchar(300),	@ied_catlvl4	nvarchar(20),
@OP		nvarchar(1),	@temp	numeric(13,4),	@imu_selrat	numeric(16,11),
@imu_itmprc	numeric(13,4),
@imu_basprc	numeric(21,11)

-- Initialize variables --
set @imu_fmlopt = ''
set @fml = ''
set @ied_catlvl4 = ''


-- Select the appropriate Markup Formula --
if (select count(*) from IMCALFML where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
	icf_vencde = 'EXT' and icf_cus1no = @ied_cus1no and icf_cus2no = @ied_cus2no and
	icf_catlvl4 = @ied_catlvl4 and icf_expdat >= getdate() and icf_def = 'Y') > 0 and
	@ied_cus1no <> '' and @ied_cus2no <> '' and @ied_catlvl4 <> ''
begin


	select	@imu_fmlopt = icf_fml_hk,
		@fml = yfi_fml
	from	IMCALFML, SYFMLINF
	where	icf_caltar = 'IM' and
		icf_caltyp = 'BASIC' and
		icf_vencde = 'EXT' and
		icf_cus1no = @ied_cus1no and
		icf_cus2no = @ied_cus2no and
		icf_catlvl4 = @ied_catlvl4 and
		icf_expdat >= getdate() and
		icf_def = 'Y' and
		yfi_fmlopt = icf_fml_hk
end
else if (select count(*) from IMCALFML where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
	icf_vencde = 'EXT' and icf_cus1no = @ied_cus1no and icf_cus2no = '' and
	icf_catlvl4 = @ied_catlvl4 and icf_expdat >= getdate() and icf_def = 'Y') > 0 and
	@ied_cus1no <> '' and @ied_catlvl4 <> ''
begin

	select	@imu_fmlopt = icf_fml_hk,
		@fml = yfi_fml
	from	IMCALFML, SYFMLINF
	where	icf_caltar = 'IM' and
		icf_caltyp = 'BASIC' and
		icf_vencde = 'EXT' and
		icf_cus1no = @ied_cus1no and
		icf_cus2no = '' and
		icf_catlvl4 = @ied_catlvl4 and
		icf_expdat >= getdate() and
		icf_def = 'Y' and
		yfi_fmlopt = icf_fml_hk
end
else if (select count(*) from IMCALFML where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
	icf_vencde = 'EXT' and icf_cus1no = '' and icf_cus2no = '' and
	icf_catlvl4 = @ied_catlvl4 and icf_expdat >= getdate() and icf_def = 'Y') > 0 and
	@ied_catlvl4 <> ''
begin

	select	@imu_fmlopt = icf_fml_hk,
		@fml = yfi_fml
	from	IMCALFML, SYFMLINF
	where	icf_caltar = 'IM' and
		icf_caltyp = 'BASIC' and
		icf_vencde = 'EXT' and
		icf_cus1no = '' and
		icf_cus2no = '' and
		icf_catlvl4 = @ied_catlvl4 and
		icf_expdat >= getdate() and
		icf_def = 'Y' and
		yfi_fmlopt = icf_fml_hk
end
else if (select count(*) from IMCALFML where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
	icf_vencde = 'EXT' and icf_cus1no = @ied_cus1no and icf_cus2no = @ied_cus2no and
	icf_catlvl4 = '' and icf_expdat >= getdate() and icf_def = 'Y') > 0 and
	@ied_cus1no <> '' and @ied_cus2no <> ''
begin

	select	@imu_fmlopt = icf_fml_hk,
		@fml = yfi_fml
	from	IMCALFML, SYFMLINF
	where	icf_caltar = 'IM' and
		icf_caltyp = 'BASIC' and
		icf_vencde = 'EXT' and
		icf_cus1no = @ied_cus1no and
		icf_cus2no = @ied_cus2no and
		icf_catlvl4 = '' and
		icf_expdat >= getdate() and
		icf_def = 'Y' and
		yfi_fmlopt = icf_fml_hk
end
else if (select count(*) from IMCALFML where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
	icf_vencde = 'EXT' and icf_cus1no = @ied_cus1no and icf_cus2no = '' and
	icf_catlvl4 = '' and icf_expdat >= getdate() and icf_def = 'Y') > 0 and
	@ied_cus1no <> ''
begin

	select	@imu_fmlopt = icf_fml_hk,
		@fml = yfi_fml
	from	IMCALFML, SYFMLINF
	where	icf_caltar = 'IM' and
		icf_caltyp = 'BASIC' and
		icf_vencde = 'EXT' and
		icf_cus1no = @ied_cus1no and
		icf_cus2no = '' and
		icf_catlvl4 = '' and
		icf_expdat >= getdate() and
		icf_def = 'Y' and
		yfi_fmlopt = icf_fml_hk
end
else if (select count(*) from IMCALFML where icf_caltar = 'IM' and icf_caltyp = 'BASIC' and
	icf_vencde = @ied_prdven and icf_cus1no = '' and icf_cus2no = '' and
	icf_catlvl4 = '' and icf_expdat >= getdate() and icf_def = 'Y') > 0
begin

	select	@imu_fmlopt = icf_fml_hk,
		@fml = yfi_fml
	from	IMCALFML, SYFMLINF
	where	icf_caltar = 'IM' and
		icf_caltyp = 'BASIC' and
		icf_vencde = @ied_prdven and
		icf_cus1no = '' and
		icf_cus2no = '' and
		icf_catlvl4 = '' and
		icf_expdat >= getdate() and
		icf_def = 'Y' and
		yfi_fmlopt = icf_fml_hk
end
else
begin

	select	@imu_fmlopt = icf_fml_hk,
		@fml = yfi_fml
	from	IMCALFML, SYFMLINF
	where	icf_caltar = 'IM' and
		icf_caltyp = 'BASIC' and
		icf_vencde = 'EXT' and
		icf_cus1no = '' and
		icf_cus2no = '' and
		icf_catlvl4 = '' and
		icf_expdat >= getdate() and
		icf_def = 'Y' and
		yfi_fmlopt = icf_fml_hk

	--  set 1.45 to 1
	set @fml = 1
	-- 20140110
end

if @fml is null or @fml = ''
begin
	set @fml = '0'
end

-- Calculate IM Item Price --
set @imu_itmprc = @ied_ftyprc
set @imu_basprc = 0

set @fml = ltrim(rtrim(@fml))
set @fml = replace(@fml,' ','')

if (substring(@fml,1,1) <> '*') and (substring(@fml,1,1) <> '/')
begin
	set @fml = '*' + @fml
end

set @OP = substring(@fml,1,1)

set @temp = substring(@fml, 2, len(@fml)-1)

declare @CurrencyRate numeric(16,11)

set @CurrencyRate = 0

select @CurrencyRate = yce_selrat from SYCUREX where yce_iseff = 'Y' and yce_tocur = 'USD' and yce_frmcur = @ied_fcurcde

set @imu_itmprc = isnull(@imu_itmprc, 0) * @CurrencyRate

if @OP = '*'
begin
	set @imu_itmprc = @imu_itmprc * @temp
end
else if @OP = '/'
begin
	set @imu_itmprc = @imu_itmprc / @temp
end

-- Calculate IM Basic Price --
set @imu_basprc = round((@imu_itmprc),4)

select 'E' as 'vbi_ventyp', 'USD' as imu_bcurcde, @imu_basprc as 'imu_basprc'






GO
GRANT EXECUTE ON [dbo].[sp_select_IMCALFML_QUM00001] TO [ERPUSER] AS [dbo]
GO
