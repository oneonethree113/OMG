/****** Object:  StoredProcedure [dbo].[sp_list_DYR00004]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_DYR00004]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_DYR00004]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









/************************************************************************
Author:		Marco Chan
Date:		15th February, 2011
***********************************************************************
*/

CREATE procedure [dbo].[sp_list_DYR00004]
@cocde nvarchar(6),
@cocdelist nvarchar(1000),
@itmnolist nvarchar(1000),
@dvlist nvarchar(1000),
@imcredatfm datetime,
@imcredatto datetime,
@usrid nvarchar(30)
 
AS

BEGIN

SET NOCOUNT ON


create table #TEMP_INIT (tmp_init nvarchar(1000)) on [PRIMARY]
create table #TEMP_ITMNO (tmp_itmno nvarchar(20)) on [PRIMARY]
create table #TEMP_DV (tmp_dv nvarchar(10)) on [PRIMARY]

declare	@fm nvarchar(100), @to nvarchar(100)

declare @strPart nvarchar(1000), @strRemain nvarchar(1000)

set @fm = ''
set @to = ''
set @strPart = ''
set @strRemain = ''


--#TEMP_ITMNO
if ltrim(rtrim(@itmnolist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @itmnolist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select ibi_itmno from IMBASINF (nolock) where ibi_itmno between @fm and @to
			union all
			select ibi_itmno from IMBASINFH (nolock) where ibi_itmno between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select ibi_itmno from IMBASINF (nolock) where ibi_itmno like @strPart
			union all
			select ibi_itmno from IMBASINFH (nolock) where ibi_itmno like @strPart
		end
		else
		begin
			insert into #TEMP_INIT values (@strPart)
		end
	end
	if charindex(',',@strRemain) = 0
	begin
		set @strRemain = ltrim(@strRemain)
		if charindex('~', @strRemain) <> 0 
		begin
			set @fm = ltrim(left(@strRemain, charindex('~', @strRemain)-1))
			set @to = right(@strRemain, len(@strRemain) - charindex('~', @strRemain))
			insert into #TEMP_INIT
			select ibi_itmno from IMBASINF (nolock) where ibi_itmno between @fm and @to
			union all
			select ibi_itmno from IMBASINFH (nolock) where ibi_itmno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select ibi_itmno from IMBASINF (nolock)  where ibi_itmno like @strRemain
			union all
			select ibi_itmno from IMBASINFH (nolock) where ibi_itmno like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_ITMNO
	select distinct tmp_init from #TEMP_INIT
end



--#TEMP_DV
if ltrim(rtrim(@dvlist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @dvlist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select vbi_venno from VNBASINF (nolock) where vbi_venno between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select vbi_venno from VNBASINF (nolock) where vbi_venno like @strPart
		end
		else
		begin
			insert into #TEMP_INIT values (@strPart)
		end
	end
	if charindex(',',@strRemain) = 0
	begin
		set @strRemain = ltrim(@strRemain)
		if charindex('~', @strRemain) <> 0 
		begin
			set @fm = ltrim(left(@strRemain, charindex('~', @strRemain)-1))
			set @to = right(@strRemain, len(@strRemain) - charindex('~', @strRemain))
			insert into #TEMP_INIT
			select vbi_venno from VNBASINF (nolock) where vbi_venno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select vbi_venno from VNBASINF where vbi_venno like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_DV
	select distinct tmp_init from #TEMP_INIT
end


declare 
@flg_itmno_table char(1),
@flg_dv_table char(1),
@flg_imcredat_fmto char(1)

if (select count(*) from #TEMP_ITMNO) >= 1
	set @flg_itmno_table = 'Y'
else
	set @flg_itmno_table = 'N'

if (select count(*) from #TEMP_DV) >= 1
	set @flg_dv_table = 'Y'
else
	set @flg_dv_table = 'N'

if @imcredatfm <> '1900/01/01'
begin
	set @flg_imcredat_fmto = 'Y'
	set @imcredatto = dateadd(DD,1,@imcredatto)
end
else
begin
	set @flg_imcredat_fmto = 'N'
end


SET NOCOUNT OFF

if @flg_imcredat_fmto = 'Y'
begin

select
distinct
ibi_cocde as [Company ID],
ibi_itmno as [Item No],
ibi_alsitmno as  [Alias Item No],
ibi_typ as [Item Type],  
ibi_prdtyp as [Product Type],
ibi_engdsc as [Eng Desc],
ibi_chndsc as [Chinese Desc],
ipi_pckunt as [Packing Unit],
ipi_inrqty as [Inner],
ipi_mtrqty as [Master],
STR(ipi_cft, 13, 4) as [CFT],
STR(ipi_cbm, 13, 4) as [CBM],
case vbi_ventyp when 'E' then icf_lnecde else ibi_lnecde end as [Product Line],  
isnull(yli_dsgcde,'') as [Designer Code],  
isnull(ysi_dsc,'') as [Designer Name],  
ibi_catlvl0 + case when ibi_catlvl0 = '' then '' else ' - ' + lvl0.ycc_catdsc end as [Category L0],  
ibi_catlvl1 + case when ibi_catlvl1 = '' then '' else ' - ' + lvl1.ycc_catdsc end as [Category L1],  
ibi_catlvl2 + case when ibi_catlvl2 = '' then '' else ' - ' + lvl2.ycc_catdsc end as [Category L2],  
ibi_catlvl3 + case when ibi_catlvl3 = '' then '' else ' - ' + lvl3.ycc_catdsc end as [Category L3],  
ibi_catlvl4 + case when ibi_catlvl4 = '' then '' else ' - ' + lvl4.ycc_catdsc end as [Category L4],  
icf_colcde as [Color Code],
icf_coldsc as [Color Desc],
icf_vencol as [Vendor Color Code],
ibi_itmsts as [Item Status],
imu_ventyp as [Vendor Type],
ivi_def as [Default Production Vendor],  
ibi_venno + case when vbi_venno = '' then '' else ' - ' + vbi_vensna + ' ' end as [DesignVendor],  
ivi_venno as [Production Vendor],  
ivi_subcde as [Sub-Code],  
ivi_venitm as [Vendor Item No],
5 as [MOQ],
0 as [MOA],
ibi_wastage as [Wastage%],  
imu_fmlopt as [Price Formula],  
imu_ftyprctrm as [Factory Price Term],
imu_curcde as [Factory Cost Currency],  
STR(imu_ftycst, 13, 4) as [Factory Cost],  
imu_curcde as [Item Cost Currency],  
STR(imu_ftyprc, 13, 4) as [Item Cost],  
imu_curcde as [BOM Cost Currency],  
STR(imu_bomcst, 13, 4) as [BOM Cost],  
imu_curcde as [Total Cost Currency],  
STR(imu_ttlcst, 13, 4) as [Total Cost],  
imu_prctrm as [HK Price Term],
imu_bcurcde as [Item Price Currency],
imu_itmprc as [Item Price],
imu_bcurcde as [BOM Price Currency],
str(imu_bomprc,13,4) as [BOM Price],
imu_bcurcde as [Basic Price Currency],
STR(imu_basprc, 13, 4) as [Basic Price],
imu_curcde as [Cal Price Currency],
STR(imu_calftyprc, 13, 4) as [Cal Price],
imu_curcde as [Neg Price Currency],
STR(imu_negprc, 13, 4) as [Neg Price],
isnull(ici_cstrmk, '') as [Cost Remark],
convert(varchar, ibi_credat, 111) as [Create Date],
convert( varchar, ibi_upddat, 111) as [Update Date]
from   
IMBASINFH (nolock)
left join IMPCKINFH (nolock) on ibi_itmno = ipi_itmno
left join IMCOLINFH (nolock) on ibi_itmno = icf_itmno
left join IMVENINFH (nolock) on ibi_itmno = ivi_itmno
left join IMMRKUPH (nolock) on imu_itmno = ibi_itmno and imu_prdven = ivi_venno and imu_pckunt = ipi_pckunt and imu_inrqty = ipi_inrqty and imu_mtrqty = ipi_mtrqty
left join IMCSTINFH (nolock) on ici_itmno = ibi_itmno
left join VNBASINF (nolock) on vbi_venno = ibi_venno
left join SYCATCDE lvl4 (nolock) on ibi_catlvl4 = lvl4.ycc_catcde and lvl4.ycc_level = 4
left join SYCATCDE lvl3 (nolock) on ibi_catlvl3 = lvl3.ycc_catcde and lvl3.ycc_level = 3
left join SYCATCDE lvl2 (nolock) on ibi_catlvl2 = lvl2.ycc_catcde and lvl2.ycc_level = 2
left join SYCATCDE lvl1 (nolock) on ibi_catlvl1 = lvl1.ycc_catcde and lvl1.ycc_level = 1
left join SYCATCDE lvl0 (nolock) on ibi_catlvl0 = lvl0.ycc_catcde and lvl0.ycc_level = 0
left join SYLNEINF (nolock) on ibi_lnecde = yli_lnecde
left join SYSETINF (nolock) on yli_dsgcde = ysi_cde and ysi_typ = 15
where ibi_credat between @imcredatfm and @imcredatto
and ((@flg_dv_table = 'N') or (@flg_dv_table = 'Y' and ibi_venno in (select tmp_dv from #TEMP_DV (nolock))))
and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and ibi_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))


end
else
begin


select
distinct
ibi_cocde as [Company ID],
ibi_itmno as [Item No],
ibi_alsitmno as  [Alias Item No],
ibi_typ as [Item Type],  
ibi_prdtyp as [Product Type],
ibi_engdsc as [Eng Desc],
ibi_chndsc as [Chinese Desc],
ipi_pckunt as [Packing Unit],
ipi_inrqty as [Inner],
ipi_mtrqty as [Master],
STR(ipi_cft, 13, 4) as [CFT],
STR(ipi_cbm, 13, 4) as [CBM],
case vbi_ventyp when 'E' then icf_lnecde else ibi_lnecde end as [Product Line],  
isnull(yli_dsgcde,'') as [Designer Code],  
isnull(ysi_dsc,'') as [Designer Name],  
ibi_catlvl0 + case when ibi_catlvl0 = '' then '' else ' - ' + lvl0.ycc_catdsc end as [Category L0],  
ibi_catlvl1 + case when ibi_catlvl1 = '' then '' else ' - ' + lvl1.ycc_catdsc end as [Category L1],  
ibi_catlvl2 + case when ibi_catlvl2 = '' then '' else ' - ' + lvl2.ycc_catdsc end as [Category L2],  
ibi_catlvl3 + case when ibi_catlvl3 = '' then '' else ' - ' + lvl3.ycc_catdsc end as [Category L3],  
ibi_catlvl4 + case when ibi_catlvl4 = '' then '' else ' - ' + lvl4.ycc_catdsc end as [Category L4],  
icf_colcde as [Color Code],
icf_coldsc as [Color Desc],
icf_vencol as [Vendor Color Code],
ibi_itmsts as [Item Status],
imu_ventyp as [Vendor Type],
ivi_def as [Default Production Vendor],  
ibi_venno + case when vbi_venno = '' then '' else ' - ' + vbi_vensna + ' ' end as [DesignVendor],  
ivi_venno as [Production Vendor],  
ivi_subcde as [Sub-Code],  
ivi_venitm as [Vendor Item No],
5 as [MOQ],
0 as [MOA],
ibi_wastage as [Wastage%],  
imu_fmlopt as [Price Formula],  
imu_ftyprctrm as [Factory Price Term],
imu_curcde as [Factory Cost Currency],  
STR(imu_ftycst, 13, 4) as [Factory Cost],  
imu_curcde as [Item Cost Currency],  
STR(imu_ftyprc, 13, 4) as [Item Cost],  
imu_curcde as [BOM Cost Currency],  
STR(imu_bomcst, 13, 4) as [BOM Cost],  
imu_curcde as [Total Cost Currency],  
STR(imu_ttlcst, 13, 4) as [Total Cost],  
imu_prctrm as [HK Price Term],
imu_bcurcde as [Item Price Currency],
imu_itmprc as [Item Price],
imu_bcurcde as [BOM Price Currency],
str(imu_bomprc,13,4) as [BOM Price],
imu_bcurcde as [Basic Price Currency],
STR(imu_basprc, 13, 4) as [Basic Price],
imu_curcde as [Cal Price Currency],
STR(imu_calftyprc, 13, 4) as [Cal Price],
imu_curcde as [Neg Price Currency],
STR(imu_negprc, 13, 4) as [Neg Price],
isnull(ici_cstrmk, '') as [Cost Remark],
convert(varchar, ibi_credat, 111) as [Create Date],
convert( varchar, ibi_upddat, 111) as [Update Date]
from #TEMP_ITMNO (nolock)
left join IMBASINFH (nolock) on ibi_itmno = tmp_itmno
left join IMCSTINFH (nolock) on ici_itmno = ibi_itmno
left join IMPCKINFH (nolock) on ibi_itmno = ipi_itmno
left join IMCOLINFH (nolock) on ibi_itmno = icf_itmno
left join IMVENINFH (nolock) on ibi_itmno = ivi_itmno
left join IMMRKUPH (nolock) on imu_itmno = ibi_itmno and imu_prdven = ivi_venno and imu_pckunt = ipi_pckunt and imu_inrqty = ipi_inrqty and imu_mtrqty = ipi_mtrqty
left join VNBASINF (nolock) on vbi_venno = ibi_venno
left join SYCATCDE lvl4 (nolock) on ibi_catlvl4 = lvl4.ycc_catcde and lvl4.ycc_level = 4
left join SYCATCDE lvl3 (nolock) on ibi_catlvl3 = lvl3.ycc_catcde and lvl3.ycc_level = 3
left join SYCATCDE lvl2 (nolock) on ibi_catlvl2 = lvl2.ycc_catcde and lvl2.ycc_level = 2
left join SYCATCDE lvl1 (nolock) on ibi_catlvl1 = lvl1.ycc_catcde and lvl1.ycc_level = 1
left join SYCATCDE lvl0 (nolock) on ibi_catlvl0 = lvl0.ycc_catcde and lvl0.ycc_level = 0
left join SYLNEINF (nolock) on ibi_lnecde = yli_lnecde
left join SYSETINF (nolock) on yli_dsgcde = ysi_cde and ysi_typ = 15
where ((@flg_dv_table = 'N') or (@flg_dv_table = 'Y' and ibi_venno in (select tmp_dv from #TEMP_DV (nolock))))

end




drop table #TEMP_INIT
drop table #TEMP_ITMNO
drop table #TEMP_DV

END


GO
GRANT EXECUTE ON [dbo].[sp_list_DYR00004] TO [ERPUSER] AS [dbo]
GO
