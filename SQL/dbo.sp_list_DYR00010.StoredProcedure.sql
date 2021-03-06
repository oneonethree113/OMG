/****** Object:  StoredProcedure [dbo].[sp_list_DYR00010]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_DYR00010]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_DYR00010]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









/************************************************************************
Author:		Marco Chan
Date:		15th February, 2011
***********************************************************************
--sp_list_DYR00010 '','UCP','','','','','','','','01/01/2011','01/05/2011','mis'
*/

CREATE procedure [dbo].[sp_list_DYR00010]
@cocde nvarchar(6),
@cocdelist nvarchar(1000),
@cus1nolist nvarchar(1000),
@cus2nolist nvarchar(1000),
@itmnolist nvarchar(1000),
@dvlist nvarchar(1000),
@pvlist nvarchar(1000),
@shinvdatfm datetime,
@shinvdatto datetime,
@shslndatfm datetime,
@shslndatto datetime,
@usrid nvarchar(30)
 
AS

BEGIN

SET NOCOUNT ON


create table #TEMP_INIT (tmp_init nvarchar(1000)) on [PRIMARY]
create table #TEMP_COCDE (tmp_cocde nvarchar(10)) on [PRIMARY]
create table #TEMP_CUS1NO (tmp_cus1no nvarchar(10)) on [PRIMARY]
create table #TEMP_CUS2NO (tmp_cus2no nvarchar(10)) on [PRIMARY]
create table #TEMP_ITMNO (tmp_itmno nvarchar(20)) on [PRIMARY]
create table #TEMP_DV (tmp_dv nvarchar(10)) on [PRIMARY]
create table #TEMP_PV (tmp_pv nvarchar(10)) on [PRIMARY]

declare	@fm nvarchar(100), @to nvarchar(100)

declare @strPart nvarchar(1000), @strRemain nvarchar(1000)

set @fm = ''
set @to = ''
set @strPart = ''
set @strRemain = ''


--#TEMP_COCDE
if ltrim(rtrim(@cocdelist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @cocdelist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select yco_cocde from SYCOMINF where yco_cocde between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select yco_cocde from SYCOMINF where yco_cocde like @strPart
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
			select yco_cocde from SYCOMINF where yco_cocde between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select yco_cocde from SYCOMINF where yco_cocde like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_COCDE
	select distinct tmp_init from #TEMP_INIT
end


--#TEMP_CUS1NO
if ltrim(rtrim(@cus1nolist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @cus1nolist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select cbi_cusno from CUBASINF where cbi_cusno between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select cbi_cusno from CUBASINF where cbi_cusno like @strPart
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
			select cbi_cusno from CUBASINF where cbi_cusno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select cbi_cusno from CUBASINF where cbi_cusno like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_CUS1NO
	select distinct tmp_init from #TEMP_INIT
end
else
begin

insert into #TEMP_CUS1NO
select 	distinct cbi_cusno
from CUBASINF (nolock)
left join SYSALREP on ysr_cocde = ' ' and  ysr_code1 = cbi_salrep
where
cbi_custyp = 'P' and --cbi_cussts = 'A' and
(exists(select 1 from syusrright where yur_usrid = @usrid  and yur_doctyp = 'SC' and yur_lvl = 0)
	or ysr_saltem in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'SC' and yur_lvl = 1)
	or cbi_cusno in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'SC' and yur_lvl = 2)
) and cbi_cusno > '50000'
order by cbi_cusno

end

--#TEMP_CUS2NO
if ltrim(rtrim(@cus2nolist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @cus2nolist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select cbi_cusno from CUBASINF where cbi_cusno between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select cbi_cusno from CUBASINF where cbi_cusno like @strPart
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
			select cbi_cusno from CUBASINF where cbi_cusno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select cbi_cusno from CUBASINF where cbi_cusno like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_CUS2NO
	select distinct tmp_init from #TEMP_INIT
end
else
begin

insert into #TEMP_CUS2NO
select 	distinct cbi_cusno
from CUBASINF (nolock)
left join SYSALREP on ysr_cocde = ' ' and  ysr_code1 = cbi_salrep
where
cbi_custyp = 'S' and --cbi_cussts = 'A' and
(exists(select 1 from syusrright where yur_usrid = @usrid  and yur_doctyp = 'SC' and yur_lvl = 0)
	or ysr_saltem in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'SC' and yur_lvl = 1)
	or cbi_cusno in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'SC' and yur_lvl = 2)
) and cbi_cusno > '50000'
union 
select ''
order by cbi_cusno

end

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


--#TEMP_PV
if ltrim(rtrim(@pvlist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @pvlist
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
	insert into #TEMP_PV
	select distinct tmp_init from #TEMP_INIT
end



declare @flg_cocde_table char(1), 
@flg_cus1no_table char(1),
@flg_cus2no_table char(1),
@flg_itmno_table char(1),
@flg_dv_table char(1),
@flg_pv_table char(1),
@flg_shinvdat_fmto char(1),
@flg_shslndat_fmto char(1)

if (select count(*) from #TEMP_COCDE) >= 1
	set @flg_cocde_table = 'Y'
else
	set @flg_cocde_table = 'N'

if (select count(*) from #TEMP_CUS1NO) >= 1
	set @flg_cus1no_table = 'Y'
else
	set @flg_cus1no_table = 'N'

if (select count(*) from #TEMP_CUS2NO) >= 1
	set @flg_cus2no_table = 'Y'
else
	set @flg_cus2no_table = 'N'

if (select count(*) from #TEMP_ITMNO) >= 1
	set @flg_itmno_table = 'Y'
else
	set @flg_itmno_table = 'N'

if (select count(*) from #TEMP_DV) >= 1
	set @flg_dv_table = 'Y'
else
	set @flg_dv_table = 'N'

if (select count(*) from #TEMP_PV) >= 1
	set @flg_pv_table = 'Y'
else
	set @flg_pv_table = 'N'


if @shinvdatfm <> '1900/01/01'
begin
	set @flg_shinvdat_fmto = 'Y'
	set @shinvdatto = dateadd(DD,1,@shinvdatto)
end
else
begin
	set @flg_shinvdat_fmto = 'N'
end


if @shslndatfm <> '1900/01/01'
begin
	set @flg_shslndat_fmto = 'Y'
	set @shslndatto = dateadd(DD,1,@shslndatto)
end
else
begin
	set @flg_shslndat_fmto = 'N'
end




create table #TEMP_SHLIST
(
tmp_cocde	nvarchar(10),
tmp_cus1sna	nvarchar(200),
tmp_shpno	nvarchar(20),
tmp_invno	nvarchar(20),
tmp_slnonb	datetime,
tmp_ctrcfs	nvarchar(20),
tmp_pckrmk	nvarchar(40),
tmp_ctrsiz	nvarchar(10),
tmp_invdat	datetime,
tmp_shpseq	int,
tmp_ordno	nvarchar(20),
tmp_itmno	nvarchar(20),
tmp_venno	nvarchar(20),
tmp_subcde	nvarchar(20),
tmp_shpqty	int,
tmp_untcde	nvarchar(6),
tmp_vol		numeric(11,4),
tmp_actvol	numeric(11,4),
tmp_ttlctn	int,
tmp_vol2	numeric(11,4),
tmp_ttlvol	numeric(11,4)	
)

if @flg_shinvdat_fmto = 'Y'
begin

insert into #TEMP_SHLIST
select	
distinct
SHIPGDTL.hid_cocde,
case  when isnull(HIH_CUS1NO,'') = '' then '' when isnull(cbi_cusno,'') = '' then HIH_CUS1NO else HIH_CUS1NO + ' - ' + CBI_CUSSNA end,
SHIPGDTL.hid_shpno,
SHIPGDTL.hid_invno,
case isnull(HIH_SLNONB,'') when '' then '' else convert(nvarchar(10),HIH_SLNONB,101) end,
hid_ctrcfs,
hid_pckrmk,
isnull(HID_CTRSIZ,''),
convert(char(10), SHINVHDR.hiv_invdat,111),
SHIPGDTL.hid_shpseq, 
SHIPGDTL.hid_ordno, 
SHIPGDTL.hid_itmno, 
SHIPGDTL.hid_venno, 
SCORDDTL.sod_subcde,
SHIPGDTL.hid_shpqty,
SHIPGDTL.hid_untcde,
SHIPGDTL.hid_vol,
SHIPGDTL.hid_actvol,
SHIPGDTL.hid_ttlctn,
SHIPGDTL.hid_vol,
SHIPGDTL.hid_ttlvol
from	
SHIPGDTL (nolock)
left join SHINVHDR (nolock) on SHINVHDR.hiv_shpno = shipgdtl.hid_shpno  and SHINVHDR.hiv_invno = shipgdtl.hid_invno
LEFT JOIN SHIPGHDR (nolock) on HID_COCDE = HIH_COCDE and HID_SHPNO = HIH_SHPNO
Left Join CUBASINF (nolock) on HIH_CUS1NO = CBI_CUSNO
left join SCORDDTL (nolock) on shipgdtl.hid_ordno = scorddtl.sod_ordno and shipgdtl.hid_itmno = scorddtl.sod_itmno and shipgdtl.hid_colcde = scorddtl.sod_colcde 
where hiv_invdat between @shinvdatfm and @shinvdatto
and ((@flg_cocde_table = 'N') or (@flg_cocde_table = 'Y' and hid_cocde in (select tmp_cocde from #TEMP_COCDE (nolock))))
and ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and hih_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and hih_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and hid_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
--and ((@flg_dv_table = 'N') or (@flg_dv_table = 'Y' and ibi_venno in (select tmp_dv from #TEMP_DV (nolock))))
and ((@flg_pv_table = 'N') or (@flg_pv_table = 'Y' and hid_venno in (select tmp_pv from #TEMP_PV (nolock))))
order by hid_cocde, hid_shpno

end
else
begin

insert into #TEMP_SHLIST
select	
distinct
SHIPGDTL.hid_cocde,
case  when isnull(HIH_CUS1NO,'') = '' then '' when isnull(cbi_cusno,'') = '' then HIH_CUS1NO else HIH_CUS1NO + ' - ' + CBI_CUSSNA end,
SHIPGDTL.hid_shpno,
SHIPGDTL.hid_invno,
case isnull(HIH_SLNONB,'') when '' then '' else convert(nvarchar(10),HIH_SLNONB,101) end,
hid_ctrcfs,
hid_pckrmk,
isnull(HID_CTRSIZ,''),
convert(char(10), SHINVHDR.hiv_invdat,111),
SHIPGDTL.hid_shpseq, 
SHIPGDTL.hid_ordno, 
SHIPGDTL.hid_itmno, 
SHIPGDTL.hid_venno, 
SCORDDTL.sod_subcde,
SHIPGDTL.hid_shpqty,
SHIPGDTL.hid_untcde,
SHIPGDTL.hid_vol,
SHIPGDTL.hid_actvol,
SHIPGDTL.hid_ttlctn,
SHIPGDTL.hid_vol,
SHIPGDTL.hid_ttlvol
from	
SHIPGDTL (nolock)
left join SHINVHDR (nolock) on SHINVHDR.hiv_shpno = shipgdtl.hid_shpno  and SHINVHDR.hiv_invno = shipgdtl.hid_invno
LEFT JOIN SHIPGHDR (nolock) on HID_COCDE = HIH_COCDE and HID_SHPNO = HIH_SHPNO
Left Join CUBASINF (nolock) on HIH_CUS1NO = CBI_CUSNO
left join SCORDDTL (nolock) on shipgdtl.hid_ordno = scorddtl.sod_ordno and shipgdtl.hid_itmno = scorddtl.sod_itmno and shipgdtl.hid_colcde = scorddtl.sod_colcde 
where hih_slnonb between @shslndatfm and @shslndatto
and ((@flg_cocde_table = 'N') or (@flg_cocde_table = 'Y' and hid_cocde in (select tmp_cocde from #TEMP_COCDE (nolock))))
and ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and hih_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and hih_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and hid_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
--and ((@flg_dv_table = 'N') or (@flg_dv_table = 'Y' and ibi_venno in (select tmp_dv from #TEMP_DV (nolock))))
and ((@flg_pv_table = 'N') or (@flg_pv_table = 'Y' and hid_venno in (select tmp_pv from #TEMP_PV (nolock))))
order by hid_cocde, hid_shpno



end

SET NOCOUNT OFF


select
tmp_cocde as [Company],
tmp_cus1sna as [Cust Short Name],
tmp_shpno as [Shipping No],
tmp_invno as [Invoice No],
tmp_slnonb as [Sailing on board Date],
tmp_ctrcfs as [CTR/CFS],
tmp_pckrmk as [Rmk for Packing],
tmp_ctrsiz as [Container Size],
tmp_invdat as [Invoice Date],
tmp_shpseq as [Shipping Seq],
tmp_ordno as [SC Order No],
tmp_itmno as [Item No],
tmp_venno as [Vendor],
tmp_subcde as [Vendor Sub Code],
tmp_shpqty as [Shipped Qty],
tmp_untcde as [Unit],
tmp_vol as [Volume],
tmp_actvol as [Actual Volume],
tmp_ttlctn as [Total Carton],
tmp_vol2 as [Total Volume],
tmp_ttlvol as [Total CBM]
from #TEMP_SHLIST (nolock)


drop table #TEMP_INIT
drop table #TEMP_COCDE
drop table #TEMP_CUS1NO
drop table #TEMP_CUS2NO
drop table #TEMP_ITMNO
drop table #TEMP_DV
drop table #TEMP_PV

drop table #TEMP_SHLIST


END


GO
GRANT EXECUTE ON [dbo].[sp_list_DYR00010] TO [ERPUSER] AS [dbo]
GO
