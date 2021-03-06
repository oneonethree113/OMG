/****** Object:  StoredProcedure [dbo].[sp_list_DYR00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_DYR00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_DYR00001]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









/************************************************************************
Author:		Marco Chan
Date:		15th February, 2011
***********************************************************************
*/

CREATE procedure [dbo].[sp_list_DYR00001]
@cocde nvarchar(6),
@cocdelist nvarchar(1000),
@cus1nolist nvarchar(1000),
@cus2nolist nvarchar(1000),
@itmnolist nvarchar(1000),
@dvlist nvarchar(1000),
@cihcredatfm datetime,
@cihcredatto datetime,
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
cbi_custyp = 'S' and -- cbi_cussts = 'A' and
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


declare @flg_cocde_table char(1), 
@flg_cus1no_table char(1),
@flg_cus2no_table char(1),
@flg_itmno_table char(1),
@flg_dv_table char(1),
@flg_cihdat_fmto char(1)


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

if @cihcredatfm <> '1900/01/01'
begin
	set @flg_cihdat_fmto = 'Y'
	set @cihcredatto = dateadd(DD,1,@cihcredatto)
end
else
begin
	set @flg_cihdat_fmto = 'N'
end


create table #TEMP_CIHLIST
(
tmp_cocde	nvarchar(10),
tmp_cusno	nvarchar(10),
tmp_seccus	nvarchar(10),
tmp_itmno	nvarchar(20), 
tmp_colcde	nvarchar(30),
tmp_untcde	nvarchar(6),
tmp_inrqty	int,
tmp_mtrqty	int,
tmp_cft		numeric(11,4),
tmp_cusitm	nvarchar(20), 
tmp_itmdsc	nvarchar(800),
tmp_cussku	nvarchar(20),
tmp_coldsc	nvarchar(300),
tmp_pckitr	nvarchar(300),
tmp_curcde	nvarchar(6),
tmp_selprc	numeric(13,4),
tmp_cususd	numeric(11,4),
tmp_cuscad	numeric(11,4),
tmp_credat	datetime
)

if @flg_cihdat_fmto = 'Y'
begin

insert into #TEMP_CIHLIST
select 
distinct
cis_cocde,
cis_cusno,
cis_seccus,
cis_itmno, 
cis_colcde,
cis_untcde,
cis_inrqty,
cis_mtrqty,
cis_cft,
cis_cusitm, 
cis_itmdsc,
cis_cussku,
cis_coldsc,
cis_pckitr,
cis_curcde,
cis_selprc,
cis_cususd,
cis_cuscad,
cis_credat
from CUITMSUM (nolock)
where cis_credat between @cihcredatfm and @cihcredatto
--and ((@flg_cocde_table = 'N') or (@flg_cocde_table = 'Y' and cis_cocde in (select tmp_cocde from #TEMP_COCDE (nolock))))
and ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and cis_cusno in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
--and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and cis_seccus in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and cis_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))

end
else
begin

insert into #TEMP_CIHLIST
select 
distinct
cis_cocde,
cis_cusno,
cis_seccus,
cis_itmno, 
cis_colcde,
cis_untcde,
cis_inrqty,
cis_mtrqty,
cis_cft,
cis_cusitm, 
cis_itmdsc,
cis_cussku,
cis_coldsc,
cis_pckitr,
cis_curcde,
cis_selprc,
cis_cususd,
cis_cuscad,
cis_credat
from CUITMSUM (nolock)
where 
--((@flg_cocde_table = 'N') or (@flg_cocde_table = 'Y' and cis_cocde in (select tmp_cocde from #TEMP_COCDE (nolock)))) and 
((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and cis_cusno in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
--and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and cis_seccus in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and cis_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))

end





create table #TEMP_RESULT
(
res_cis_cusno	nvarchar(10),
res_cbi_cussna	nvarchar(20),
res_cis_seccus	nvarchar(10),
res_cbi_secsna	nvarchar(20),
res_cis_credat	datetime,
res_cis_itmno	nvarchar(20), 
res_ivi_venitm	nvarchar(20),
res_cis_cusitm	nvarchar(20), 
res_cis_itmdsc	nvarchar(800),
res_cis_cussku	nvarchar(20),
res_cis_colcde	nvarchar(30),
res_cis_coldsc	nvarchar(300),
res_cis_untcde	nvarchar(6),
res_cis_inrqty	int,
res_cis_mtrqty	int,
res_cis_cft	numeric(11,4),
res_cis_pckitr	nvarchar(300),
res_cis_curcde	nvarchar(6),
res_cis_selprc	numeric(13,4),
res_cis_cususd	numeric(11,4),
res_cis_cuscad	numeric(11,4),
res_imu_basprc	numeric(13,4),
res_ibi_venno	nvarchar(6),
res_ivi_subcde	nvarchar(6),
res_vbi_ventyp	char(1)

)


insert into #TEMP_RESULT
select 
tmp_cusno,
isnull(pri.cbi_cussna,''),
tmp_seccus,
isnull(sec.cbi_cussna,''),
tmp_credat,
tmp_itmno, 
isnull(ivi_venitm,''),
tmp_cusitm, 
tmp_itmdsc,
tmp_cussku,
tmp_colcde,
tmp_coldsc,
tmp_untcde,
tmp_inrqty,
tmp_mtrqty,
tmp_cft,
tmp_pckitr,
tmp_curcde,
tmp_selprc,
tmp_cususd,
tmp_cuscad,
isnull(imu_basprc,0),
isnull(ibi_venno,''),
isnull(ivi_subcde,''),
isnull(vbi_ventyp,'')

from #TEMP_CIHLIST (nolock)
left join CUBASINF pri (nolock) on pri.cbi_cusno = tmp_cusno
left join CUBASINF sec (nolock) on sec.cbi_cusno = tmp_seccus
left join IMBASINF (nolock) on ibi_itmno = tmp_itmno
left join VNBASINF (nolock) on vbi_venno = ibi_venno
left join IMVENINF (nolock) on ivi_itmno = tmp_itmno
left join IMMRKUP (nolock) on imu_itmno = tmp_itmno and imu_pckunt = tmp_untcde and imu_mtrqty = tmp_mtrqty and imu_inrqty = tmp_inrqty and imu_ventyp = 'D'

if ((select count(*) from #TEMP_RESULT where res_ibi_venno = '') > 0)
begin


update #TEMP_RESULT set
res_imu_basprc = imu_basprc,
res_ibi_venno = ibi_venno,
res_ivi_subcde = ivi_subcde,
res_vbi_ventyp = vbi_ventyp
from #TEMP_RESULT (nolock)
left join IMBASINFH (nolock) on ibi_itmno = res_cis_itmno
left join VNBASINF (nolock) on vbi_venno = ibi_venno
left join IMVENINFH (nolock) on ivi_itmno = res_cis_itmno
left join IMMRKUPH (nolock) on imu_itmno = res_cis_itmno and imu_pckunt = res_cis_untcde and imu_mtrqty = res_cis_mtrqty and imu_inrqty = res_cis_inrqty and imu_ventyp = 'D'
where res_ibi_venno = ''

end 

SET NOCOUNT OFF


select
res_cis_cusno as [Customer No],
res_cbi_cussna as [Customer Name],
--res_cis_seccus as [Sec Customer No],
--res_cbi_secsna as [Sec Customer Name],
convert(char, res_cis_credat , 111) as [Create Date],
res_cis_itmno as [Item No], 
res_ivi_venitm as [Vendor Item No],
res_cis_cusitm as [Customer Item No], 
res_cis_itmdsc as [Item Description],
res_cis_cussku as [SKU#],
res_cis_colcde as [Color Code],
res_cis_coldsc as [Color Description],
res_cis_untcde as [UM],
res_cis_inrqty as [Inner],
res_cis_mtrqty as [Master],
res_cis_cft as [CFT],
res_cis_pckitr as [Packing Instruction],
res_cis_curcde as [Currency],
res_cis_selprc as [Selling Price],
res_cis_cususd as [Cust Retail (USD)],
res_cis_cuscad as [Cust Retail (CAD)],
res_imu_basprc as [Basic Price (I/M)],
res_ibi_venno as [Design Vendor],
res_ivi_subcde as [Vendor Sub Code],
res_vbi_ventyp as [Vendor Type]
from #TEMP_RESULT (nolock)


drop table #TEMP_INIT
drop table #TEMP_COCDE
drop table #TEMP_CUS1NO
drop table #TEMP_CUS2NO
drop table #TEMP_ITMNO
drop table #TEMP_DV

drop table #TEMP_CIHLIST
drop table #TEMP_RESULT

END


GO
GRANT EXECUTE ON [dbo].[sp_list_DYR00001] TO [ERPUSER] AS [dbo]
GO
