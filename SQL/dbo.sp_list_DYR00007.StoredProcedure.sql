/****** Object:  StoredProcedure [dbo].[sp_list_DYR00007]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_DYR00007]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_DYR00007]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









/************************************************************************
Author:		Marco Chan
Date:		15th February, 2011
***********************************************************************
--sp_list_DYR00007 '','UCP','','','','','','','','01/01/2011','01/05/2011','mis'
*/

CREATE procedure [dbo].[sp_list_DYR00007]
@cocde nvarchar(6),
@cocdelist nvarchar(1000),
@cus1nolist nvarchar(1000),
@cus2nolist nvarchar(1000),
@itmnolist nvarchar(1000),
@dvlist nvarchar(1000),
@pvlist nvarchar(1000),
@saissdatfm datetime,
@saissdatto datetime,
@sarvsdatfm datetime,
@sarvsdatto datetime,
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
@flg_saissdat_fmto char(1),
@flg_sarvsdat_fmto char(1)

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


if @saissdatfm <> '1900/01/01'
begin
	set @flg_saissdat_fmto = 'Y'
	set @saissdatto = dateadd(DD,1,@saissdatto)
end
else
begin
	set @flg_saissdat_fmto = 'N'
end


if @sarvsdatfm <> '1900/01/01'
begin
	set @flg_sarvsdat_fmto = 'Y'
	set @sarvsdatto = dateadd(DD,1,@sarvsdatto)
end
else
begin
	set @flg_sarvsdat_fmto = 'N'
end




create table #TEMP_SALIST
(
tmp_cocde	nvarchar(10),
tmp_sano	nvarchar(20),
tmp_issdat	datetime,
tmp_rvsdat	datetime,
tmp_cus1no	nvarchar(6),
tmp_cus1sna	nvarchar(20),
tmp_cus2no	nvarchar(6),
tmp_cus2sna	nvarchar(20),
tmp_cusagt	nvarchar(6),
tmp_invsts	nvarchar(3),
tmp_salrepdsc	nvarchar(200),
tmp_smpprddsc	nvarchar(200),
tmp_smpfgtdsc	nvarchar(200),
tmp_prctrm	nvarchar(6),
tmp_ttlamt	numeric(13,4),
tmp_itmno	nvarchar(20),
tmp_colcde	nvarchar(30),
tmp_pv		nvarchar(6),
tmp_pvsna	nvarchar(100),
tmp_cv		nvarchar(6),
tmp_cvsna	nvarchar(100),
tmp_cusitm	nvarchar(20),
tmp_cussmppo	nvarchar(50),
tmp_itmdsc	nvarchar(800),
tmp_pck		nvarchar(100),
tmp_cuscol	nvarchar(30),
tmp_coldsc	nvarchar(300),
tmp_smpunt	nvarchar(6),
tmp_shpqty	int,
tmp_chgqty	int,
tmp_balfreqty	int,
tmp_curcde	nvarchar(6),
tmp_selprc	numeric(13,4),
tmp_fcurcde	nvarchar(6),
tmp_ftyprc	numeric(13,4),
tmp_sid_ttlamt	numeric(13,4)
)

if @flg_saissdat_fmto = 'Y'
begin

insert into #TEMP_SALIST
select
sih_cocde, 
sih_invno, 
sih_issdat, 
sih_rvsdat,
sih_cus1no,
CUBASINF.cbi_cussna,
isnull(sih_cus2no,''),
isnull(CUBASINF_1.cbi_cussna,''),
sih_cusagt,
sih_invsts,
sih_salrep + ' - ' + SYSALREP.ysr_dsc, 
isnull(sih_smpprd,'') +	CASE WHEN st1.yst_trmdsc IS NULL THEN ' ' ELSE ' - ' END + isnull(st1.yst_trmdsc, ''),
isnull(sih_smpfgt,'') +	CASE WHEN st2.yst_trmdsc IS NULL THEN ' ' ELSE ' - ' END + isnull(st2.yst_trmdsc, ''),
sih_prctrm,
sih_ttlamt,
sid_itmno,
sid_colcde,
isnull(sid_venno,''),
isnull(VB2.vbi_vensna, ''),
isnull(sid_cusven ,''),
isnull(VB1.vbi_vensna, ''),
sid_cusitm,
sid_cussmppo,
sid_itmdsc,
cast(sid_untcde as nvarchar(6)) + ' / ' + cast(sid_inrqty as nvarchar(10)) + ' / ' + cast(sid_mtrqty as nvarchar(10)) + ' / ' + cast(sid_cft as nvarchar(10)),
sid_cuscol,
sid_coldsc,
sid_smpunt,
sid_shpqty,
sid_chgqty,
sid_balfreqty,
sid_curcde,
sid_selprc,
sid_fcurcde,
sid_ftyprc,
sid_ttlamt
FROM               
SAINVDTL (nolock) 
left join SAINVHDR (nolock) on sih_cocde =sid_cocde  and   sih_invno =sid_invno 
Left JOIN CUBASINF (nolock) ON sih_cus1no = CUBASINF.cbi_cusno AND CUBASINF.cbi_custyp = 'P' 
Left JOIN CUBASINF CUBASINF_1  (nolock) ON  sih_cus2no = CUBASINF_1.cbi_cusno AND CUBASINF_1.cbi_custyp = 'S' 
left JOIN SYSALREP (nolock) ON sih_salrep = ysr_code1
left join v_imbasinf_rpt on sid_itmno = ibi_itmno
LEFT JOIN VNBASINF VB1 (nolock) ON vb1.VBI_VENNO = sid_venno
LEFT JOIN VNBASINF VB2 (nolock) ON vb2.VBI_VENNO = sid_cusven
left join SYSMPTRM ST1 (nolock) on st1.yst_trmcde = sih_smpprd
left join SYSMPTRM ST2 (nolock) on st2.yst_trmcde = sih_smpfgt
where sih_issdat between @saissdatfm and @saissdatto
and ((@flg_cocde_table = 'N') or (@flg_cocde_table = 'Y' and sih_cocde in (select tmp_cocde from #TEMP_COCDE (nolock))))
and ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and sih_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and sih_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and sid_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
and ((@flg_dv_table = 'N') or (@flg_dv_table = 'Y' and ibi_venno in (select tmp_dv from #TEMP_DV (nolock))))
and ((@flg_pv_table = 'N') or (@flg_pv_table = 'Y' and sid_venno in (select tmp_pv from #TEMP_PV (nolock))))


end
else
begin

insert into #TEMP_SALIST
select
sih_cocde, 
sih_invno, 
sih_issdat, 
sih_rvsdat,
sih_cus1no,
CUBASINF.cbi_cussna,
isnull(sih_cus2no,''),
isnull(CUBASINF_1.cbi_cussna,''),
sih_cusagt,
sih_invsts,
sih_salrep + ' - ' + SYSALREP.ysr_dsc, 
isnull(sih_smpprd,'') +	CASE WHEN st1.yst_trmdsc IS NULL THEN ' ' ELSE ' - ' END + isnull(st1.yst_trmdsc, ''),
isnull(sih_smpfgt,'') +	CASE WHEN st2.yst_trmdsc IS NULL THEN ' ' ELSE ' - ' END + isnull(st2.yst_trmdsc, ''),
sih_prctrm,
sih_ttlamt,
sid_itmno,
sid_colcde,
isnull(sid_venno,''),
isnull(VB2.vbi_vensna, ''),
isnull(sid_cusven ,''),
isnull(VB1.vbi_vensna, ''),
sid_cusitm,
sid_cussmppo,
sid_itmdsc,
cast(sid_untcde as nvarchar(6)) + ' / ' + cast(sid_inrqty as nvarchar(10)) + ' / ' + cast(sid_mtrqty as nvarchar(10)) + ' / ' + cast(sid_cft as nvarchar(10)),
sid_cuscol,
sid_coldsc,
sid_smpunt,
sid_shpqty,
sid_chgqty,
sid_balfreqty,
sid_curcde,
sid_selprc,
sid_fcurcde,
sid_ftyprc,
sid_ttlamt
FROM               
SAINVDTL (nolock) 
left join SAINVHDR (nolock) on sih_cocde =sid_cocde  and   sih_invno =sid_invno 
Left JOIN CUBASINF (nolock) ON sih_cus1no = CUBASINF.cbi_cusno AND CUBASINF.cbi_custyp = 'P' 
Left JOIN CUBASINF CUBASINF_1  (nolock) ON  sih_cus2no = CUBASINF_1.cbi_cusno AND CUBASINF_1.cbi_custyp = 'S' 
left JOIN SYSALREP (nolock) ON sih_salrep = ysr_code1
left join v_imbasinf_rpt on sid_itmno = ibi_itmno
LEFT JOIN VNBASINF VB1 (nolock) ON vb1.VBI_VENNO = sid_venno
LEFT JOIN VNBASINF VB2 (nolock) ON vb2.VBI_VENNO = sid_cusven
left join SYSMPTRM ST1 (nolock) on st1.yst_trmcde = sih_smpprd
left join SYSMPTRM ST2 (nolock) on st2.yst_trmcde = sih_smpfgt
where sih_rvsdat between @sarvsdatfm and @sarvsdatto
and ((@flg_cocde_table = 'N') or (@flg_cocde_table = 'Y' and sih_cocde in (select tmp_cocde from #TEMP_COCDE (nolock))))
and ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and sih_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and sih_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and sid_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
and ((@flg_dv_table = 'N') or (@flg_dv_table = 'Y' and ibi_venno in (select tmp_dv from #TEMP_DV (nolock))))
and ((@flg_pv_table = 'N') or (@flg_pv_table = 'Y' and sid_venno in (select tmp_pv from #TEMP_PV (nolock))))



end

SET NOCOUNT OFF


select
tmp_cocde as [Company ID],
tmp_sano as [Sample Invoice No],
convert(nvarchar(10),tmp_issdat,111) as [Issue Date],
convert(nvarchar(10),tmp_rvsdat,111) as [Revise Date],
tmp_cus1no as [Pri Cust No],
tmp_cus1sna as [Pri Cust Name],
tmp_cus2no as [Sec Cust No],
tmp_cus2sna as [Sec Cust Name],
tmp_cusagt as [Agent],
tmp_invsts as [Status],
tmp_salrepdsc as [Sale Rep],
tmp_smpprddsc as [Sample Product Term],
tmp_smpfgtdsc as [Sample Freight Term],
tmp_prctrm as [Price Term],
tmp_ttlamt as [Total Amount],
tmp_itmno as [Item No],
tmp_colcde as [Color Code],
tmp_pv as [PV],
tmp_pvsna as [PV Name],
tmp_cv as [CV],
tmp_cvsna as [CV Name],
tmp_cusitm as [Cust Item No],
tmp_cussmppo as [Cust PO No],
tmp_itmdsc as [Item Description],
tmp_pck as [Packing],
tmp_cuscol as [Cust Color Code],
tmp_coldsc as [Color Desc],
tmp_smpunt as [Sample UM],
tmp_shpqty as [Shipped Qty],
tmp_chgqty as [Charge Qty],
tmp_balfreqty as [Shipped Free Qty],
tmp_curcde as [Sales Currency],
tmp_selprc as [Selling Price],
tmp_fcurcde as [Fty Currency],
tmp_ftyprc as [Sample Total Cost],
tmp_sid_ttlamt as [Total Amount Item]
from #TEMP_SALIST (nolock)


drop table #TEMP_INIT
drop table #TEMP_COCDE
drop table #TEMP_CUS1NO
drop table #TEMP_CUS2NO
drop table #TEMP_ITMNO
drop table #TEMP_DV
drop table #TEMP_PV

drop table #TEMP_SALIST


END


GO
GRANT EXECUTE ON [dbo].[sp_list_DYR00007] TO [ERPUSER] AS [dbo]
GO
