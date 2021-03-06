/****** Object:  StoredProcedure [dbo].[sp_select_QUM00005_DTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QUM00005_DTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QUM00005_DTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO













CREATE         PROCEDURE [dbo].[sp_select_QUM00005_DTL]
@cocdelist nvarchar(1000),
@cus1nolist nvarchar(1000),
@cus2nolist nvarchar(1000),
--@pvlist nvarchar(1000),
@qunolist nvarchar(1000),
@itmnolist nvarchar(1000),
--@scnolist nvarchar(1000),
--@ponolist nvarchar(1000),
--@jobnolist nvarchar(1000),
--@invnolist nvarchar(1000),
--@cusponolist nvarchar(1000),
--@cusitmnolist nvarchar(1000),
--@cusstylenolist nvarchar(1000),
--@claimstslist nvarchar(1000),
@qucredatfm datetime,
@qucredatto datetime,
@usrid nvarchar(30)

AS

create table #TEMP_INIT (tmp_init nvarchar(1000)) on [PRIMARY]
--create table #TEMP_COCDE (tmp_cocde nvarchar(10)) on [PRIMARY]
create table #TEMP_CUS1NO (tmp_cus1no nvarchar(10)) on [PRIMARY]
create table #TEMP_CUS2NO (tmp_cus2no nvarchar(10)) on [PRIMARY]
--create table #TEMP_PV (tmp_pv nvarchar(10)) on [PRIMARY]
create table #TEMP_QUNO (tmp_quno nvarchar(20)) on [PRIMARY]
create table #TEMP_ITMNO (tmp_itmno nvarchar(20)) on [PRIMARY]
--create table #TEMP_SCNO (tmp_scno nvarchar(20)) on [PRIMARY]
--create table #TEMP_PONO (tmp_pono nvarchar(20)) on [PRIMARY]
--create table #TEMP_JOBNO (tmp_jobno nvarchar(20)) on [PRIMARY]
--create table #TEMP_INVNO (tmp_invno nvarchar(20)) on [PRIMARY]
--create table #TEMP_CUSPONO (tmp_cuspono nvarchar(20)) on [PRIMARY]
--create table #TEMP_CUSITMNO (tmp_cusitmno nvarchar(20)) on [PRIMARY]
--create table #TEMP_CUSSTYLENO (tmp_cusstyleno nvarchar(20)) on [PRIMARY]
--create table #TEMP_CLAIMSTS (tmp_claimsts nvarchar(20)) on [PRIMARY]

declare @fm nvarchar(100), @to nvarchar(100)
declare @strPart nvarchar(1000), @strRemain nvarchar(1000)

set @fm = ''
set @to = ''
set @strPart = ''
set @strRemain = ''

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
			select cbi_cusno
			from CUBASINF
			left join SYSALREP on ysr_cocde = ' ' and  ysr_code1 = cbi_salrep
			where cbi_cusno between @fm and @to
			and (cbi_custyp = 'P' and cbi_cussts = 'A')
			and (exists(select 1 from syusrright where yur_usrid = @usrid  and yur_doctyp = 'CA' and yur_lvl = 0)
			or ysr_saltem in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 1)
			or cbi_cusno in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 2)
			) and cbi_cusno > '50000'
			order by cbi_cusno
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select cbi_cusno
			from CUBASINF
			left join SYSALREP on ysr_cocde = ' ' and  ysr_code1 = cbi_salrep
			where cbi_cusno like @strPart
			and (cbi_custyp = 'P' and cbi_cussts = 'A')
			and (exists(select 1 from syusrright where yur_usrid = @usrid  and yur_doctyp = 'CA' and yur_lvl = 0)
			or ysr_saltem in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 1)
			or cbi_cusno in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 2)
			) and cbi_cusno > '50000'
			order by cbi_cusno
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
			select cbi_cusno
			from CUBASINF
			left join SYSALREP on ysr_cocde = ' ' and  ysr_code1 = cbi_salrep
			where cbi_cusno between @fm and @to
			and (cbi_custyp = 'P' and cbi_cussts = 'A')
			and (exists(select 1 from syusrright where yur_usrid = @usrid  and yur_doctyp = 'CA' and yur_lvl = 0)
			or ysr_saltem in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 1)
			or cbi_cusno in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 2)
			) and cbi_cusno > '50000'
			order by cbi_cusno
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select cbi_cusno
			from CUBASINF
			left join SYSALREP on ysr_cocde = ' ' and  ysr_code1 = cbi_salrep
			where cbi_cusno like @strRemain
			and (cbi_custyp = 'P' and cbi_cussts = 'A')
			and (exists(select 1 from syusrright where yur_usrid = @usrid  and yur_doctyp = 'CA' and yur_lvl = 0)
			or ysr_saltem in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 1)
			or cbi_cusno in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 2)
			) and cbi_cusno > '50000'
			order by cbi_cusno
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
	cbi_custyp = 'P' and cbi_cussts = 'A' and
	(exists(select 1 from syusrright where yur_usrid = @usrid  and yur_doctyp = 'CA' and yur_lvl = 0)
		or ysr_saltem in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 1)
		or cbi_cusno in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 2)
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
			select cbi_cusno
			from CUBASINF
			left join SYSALREP on ysr_cocde = ' ' and  ysr_code1 = cbi_salrep
			where cbi_cusno between @fm and @to
			and (cbi_custyp = 'S' and cbi_cussts = 'A')
			and (exists(select 1 from syusrright where yur_usrid = @usrid  and yur_doctyp = 'CA' and yur_lvl = 0)
			or ysr_saltem in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 1)
			or cbi_cusno in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 2)
			) and cbi_cusno > '50000'
			union 
			select ''
			order by cbi_cusno
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select cbi_cusno
			from CUBASINF
			left join SYSALREP on ysr_cocde = ' ' and  ysr_code1 = cbi_salrep
			where cbi_cusno like @strPart
			and (cbi_custyp = 'S' and cbi_cussts = 'A')
			and (exists(select 1 from syusrright where yur_usrid = @usrid  and yur_doctyp = 'CA' and yur_lvl = 0)
			or ysr_saltem in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 1)
			or cbi_cusno in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 2)
			) and cbi_cusno > '50000'
			union 
			select ''
			order by cbi_cusno
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
			select cbi_cusno
			from CUBASINF
			left join SYSALREP on ysr_cocde = ' ' and  ysr_code1 = cbi_salrep
			where cbi_cusno between @fm and @to
			and (cbi_custyp = 'S' and cbi_cussts = 'A')
			and (exists(select 1 from syusrright where yur_usrid = @usrid  and yur_doctyp = 'CA' and yur_lvl = 0)
			or ysr_saltem in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 1)
			or cbi_cusno in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 2)
			) and cbi_cusno > '50000'
			union 
			select ''
			order by cbi_cusno
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select cbi_cusno
			from CUBASINF
			left join SYSALREP on ysr_cocde = ' ' and  ysr_code1 = cbi_salrep
			where cbi_cusno like @strRemain
			and (cbi_custyp = 'S' and cbi_cussts = 'A')
			and (exists(select 1 from syusrright where yur_usrid = @usrid  and yur_doctyp = 'CA' and yur_lvl = 0)
			or ysr_saltem in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 1)
			or cbi_cusno in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 2)
			) and cbi_cusno > '50000'
			union 
			select ''
			order by cbi_cusno
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
	cbi_custyp = 'S' and cbi_cussts = 'A' and
	(exists(select 1 from syusrright where yur_usrid = @usrid  and yur_doctyp = 'CA' and yur_lvl = 0)
		or ysr_saltem in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 1)
		or cbi_cusno in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 2)
	) and cbi_cusno > '50000'
	union 
	select ''
	order by cbi_cusno
end

/*
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
*/

--#TEMP_QUNO
if ltrim(rtrim(@qunolist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @qunolist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select quh_qutno from QUOTNHDR (nolock) where quh_qutno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select quh_qutno from QUOTNHDR where quh_qutno like @strRemain
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
			select quh_qutno from QUOTNHDR (nolock) where quh_qutno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select quh_qutno from QUOTNHDR where quh_qutno like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_QUNO
	select distinct tmp_init from #TEMP_INIT
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

/*
--#TEMP_SCNO
if ltrim(rtrim(@scnolist)) <> ''
begin
	delete from #TEMP_INIT
	set @strRemain = @scnolist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select soh_ordno from SCORDHDR (nolock) where soh_ordno between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select soh_ordno from SCORDHDR (nolock) where soh_ordno like @strPart
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
			select soh_ordno from SCORDHDR where soh_ordno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select soh_ordno from SCORDHDR where soh_ordno like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_SCNO
	select distinct tmp_init from #TEMP_INIT
end

--#TEMP_PONO
if ltrim(rtrim(@ponolist)) <> ''
begin
	delete from #TEMP_INIT
	set @strRemain = @ponolist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select poh_purord from POORDHDR (nolock) where poh_purord between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select poh_purord from POORDHDR (nolock) where poh_purord like @strPart
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
			select poh_purord from POORDHDR where poh_purord between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select poh_purord from POORDHDR where poh_purord like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_PONO
	select distinct tmp_init from #TEMP_INIT
end

--#TEMP_JOBNO
if ltrim(rtrim(@jobnolist)) <> ''
begin
	delete from #TEMP_INIT
	set @strRemain = @jobnolist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select pod_jobord from POORDDTL (nolock) where pod_jobord between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select pod_jobord from POORDDTL (nolock) where pod_jobord like @strPart
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
			select pod_jobord from POORDDTL where pod_jobord between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select pod_jobord from POORDDTL where pod_jobord like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_JOBNO
	select distinct tmp_init from #TEMP_INIT
end

--#TEMP_INVNO
if ltrim(rtrim(@invnolist)) <> ''
begin
	delete from #TEMP_INIT
	set @strRemain = @invnolist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select hid_invno from SHIPGDTL (nolock) where hid_invno between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select hid_invno from SHIPGDTL (nolock) where hid_invno like @strPart
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
			select hid_invno from SHIPGDTL where hid_invno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select hid_invno from SHIPGDTL where hid_invno like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_INVNO
	select distinct tmp_init from #TEMP_INIT
end

--#TEMP_CUSPONO
if ltrim(rtrim(@cusponolist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @cusponolist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select soh_cuspo from SCORDHDR (nolock) where soh_cuspo between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select soh_cuspo from SCORDHDR where soh_cuspo like @strRemain
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
			select soh_cuspo from SCORDHDR (nolock) where soh_cuspo between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select soh_cuspo from SCORDHDR where soh_cuspo like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end

	if (select count(*) from #TEMP_INIT) = 0
	begin
	set @strRemain = @cusponolist
		while charindex(',', @strRemain) <> 0
		begin
			set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
			set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
			if charindex('~', @strPart) <> 0 
			begin
				set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
				set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
				insert into #TEMP_INIT
				select sod_cuspo from SCORDDTL (nolock) where sod_cuspo between @fm and @to
			end
			else if charindex('%', @strRemain) <> 0
			begin
				insert into #TEMP_INIT
				select sod_cuspo from SCORDDTL where sod_cuspo like @strRemain
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
				select sod_cuspo from SCORDDTL (nolock) where sod_cuspo between @fm and @to
			end
			else if charindex('%', @strRemain) <> 0
			begin
				insert into #TEMP_INIT
				select sod_cuspo from SCORDDTL where sod_cuspo like @strRemain
			end
			else
			begin
				insert into #TEMP_INIT values (@strRemain)
			end
		end
	end
	insert into #TEMP_CUSPONO
	select distinct tmp_init from #TEMP_INIT
end

--#TEMP_CUSITMNO
if ltrim(rtrim(@cusitmnolist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @cusitmnolist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select sod_cusitm from SCORDDTL (nolock) where sod_cusitm between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select sod_cusitm from SCORDDTL where sod_cusitm like @strRemain
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
			select sod_cusitm from SCORDDTL (nolock) where sod_cusitm between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select sod_cusitm from SCORDDTL where sod_cusitm like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_CUSITMNO
	select distinct tmp_init from #TEMP_INIT
end

--#TEMP_CUSSTYLENO
if ltrim(rtrim(@cusstylenolist)) <> ''
begin

	delete from #TEMP_INIT

	set @strRemain = @cusstylenolist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select sod_cusstyno from SCORDDTL (nolock) where sod_cusstyno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select sod_cusstyno from SCORDDTL where sod_cusstyno like @strRemain
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
			select sod_cusstyno from SCORDDTL (nolock) where sod_cusstyno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select sod_cusstyno from SCORDDTL where sod_cusstyno like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_CUSSTYLENO
	select distinct tmp_init from #TEMP_INIT
end

--#TEMP_CLAIMSTS
if ltrim(rtrim(@claimstslist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @claimstslist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select cah_caordsts from QUOTNHDR (nolock) where cah_caordsts between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select cah_caordsts from QUOTNHDR where cah_caordsts like @strRemain
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
			select cah_caordsts from QUOTNHDR (nolock) where cah_caordsts between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select cah_caordsts from QUOTNHDR where cah_caordsts like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_CLAIMSTS
	select distinct tmp_init from #TEMP_INIT
end
*/

-------------------------------------------------------------------
declare
--@flg_cocde_table char(1), 
@flg_cus1no_table char(1),
@flg_cus2no_table char(1),
--@flg_pv_table char(1),
@flg_quno_table char(1),
@flg_itmno_table char(1)
--@flg_scno_table char(1),
--@flg_pono_table char(1),
--@flg_jobno_table char(1),
--@flg_invno_table char(1),
--@flg_cuspono_table char(1),
--@flg_cusitmno_table char(1),
--@flg_cusstyleno_table char(1),
--@flg_claimsts_table char(1)
--@flg_claimcredat_fmto char(1)

if (select count(*) from #TEMP_CUS1NO) >= 1
	set @flg_cus1no_table = 'Y'
else
	set @flg_cus1no_table = 'N'

if (select count(*) from #TEMP_CUS2NO) >= 1
	set @flg_cus2no_table = 'Y'
else
	set @flg_cus2no_table = 'N'

/*
if (select count(*) from #TEMP_PV) >= 1
	set @flg_pv_table = 'Y'
else
	set @flg_pv_table = 'N'
*/

if (select count(*) from #TEMP_QUNO) >= 1
	set @flg_quno_table = 'Y'
else
	set @flg_quno_table = 'N'

if (select count(*) from #TEMP_ITMNO) >= 1
	set @flg_itmno_table = 'Y'
else
	set @flg_itmno_table = 'N'

/*
if (select count(*) from #TEMP_SCNO) >= 1
	set @flg_scno_table = 'Y'
else
	set @flg_scno_table = 'N'

if (select count(*) from #TEMP_PONO) >= 1
	set @flg_pono_table = 'Y'
else
	set @flg_pono_table = 'N'

if (select count(*) from #TEMP_JOBNO) >= 1
	set @flg_jobno_table = 'Y'
else
	set @flg_jobno_table = 'N'

if (select count(*) from #TEMP_INVNO) >= 1
	set @flg_invno_table = 'Y'
else
	set @flg_invno_table = 'N'

if (select count(*) from #TEMP_CUSPONO) >= 1
	set @flg_cuspono_table = 'Y'
else
	set @flg_cuspono_table = 'N'

if (select count(*) from #TEMP_CUSITMNO) >= 1
	set @flg_cusitmno_table = 'Y'
else
	set @flg_cusitmno_table = 'N'

if (select count(*) from #TEMP_CUSSTYLENO) >= 1
	set @flg_cusstyleno_table = 'Y'
else
	set @flg_cusstyleno_table = 'N'

if (select count(*) from #TEMP_CLAIMSTS) >= 1
	set @flg_claimsts_table = 'Y'
else
	set @flg_claimsts_table = 'N'
*/

set @qucredatto = dateadd(DD,1,@qucredatto)

select distinct
'N' as 'Act',
--qud_apprve as 'Approved/Status',
qud_cocde as 'Comp',
quh_cus1no as 'Pri Cust',
isnull(c1.cbi_cussna, '') as 'Pri Cust Name',
quh_cus2no as 'Sec Cust',
isnull(c2.cbi_cussna, '') as 'Sec Cust Name',
qud_qutno as 'Quotation No',
qud_qutseq as 'Seq',
qud_itmno as 'Item No',
qud_colcde as 'Color',
qud_untcde + '/' + LTrim(RTrim(Str(qud_inrqty))) + '/' + LTrim(RTrim(Str(qud_mtrqty))) + '/' + LTrim(RTrim( (qud_prctrm))) + '/' + LTrim(RTrim( (qud_trantrm))) as 'Packing',
qud_curcde as 'Currency',
qud_basprc as 'Basic Price',
qud_cus1sp as 'Standard Price',
qpe_mumin as 'Min. Markup%',
qpe_mu as 'Markup%',
---20131219  qud_cus1dp as 'Calculated Adjusted Price',
qud_cus1dp as 'Adjusted Price',
---20131219  qud_discnt as 'Discount %',
qud_credat as 'Create Date'
/*
quh_qutsts as 'Approval Status',
quh_qutno as 'Quotation No',
quh_cocde as 'Quotation Comp',
cah_claPeriod as 'Claim Period',
cah_claby as 'Claim By',
cah_clatyp as 'Claim Type',
cah_rmk as 'Remark',
cah_cus1no as 'Pri Cust No',
isnull(c1.cbi_cussna, '') as 'Pri Cust Name',
cah_cus2no as 'Sec Cust No',
isnull(c2.cbi_cussna, '') as 'Sec Cust Name',
--cad_prdven + ' - ' + vbi_vensna as 'Prod Vendor',
--vbi_ventyp as 'Prod Vendor Type',
crh_salcur as 'Sales Currency',
crh_salttlamt as 'Sales Amount',
--crh_grspftamt as 'Gross Profit Amount',
crh_calmtamt as 'Claim Limit Amount',
crh_calmtper as 'Claim Limit Percent',
case cah_caordsts when 'CANL' then crh_caremamt else crh_caremamt + cah_caamt_final end as 'Claim Remain Amount',
cah_cacur as 'Claim Amount Currency',
cah_caamt_org as 'Claim Amount Original',
cah_caamt_final as 'Claim Amount Finalized',
cah_catoinscur as 'Insurance Amount Currency',
cah_catoinsamt as 'Insurance Amount',
cah_catovncur as 'Vendor Amount Currency',
cah_catovnamt as 'Vendor Amount',
cah_catohkocur as 'HK Office Amount Currency',
cah_catohkoamt as 'HK Office Amount'*/
from QUOTNDTL qt (nolock)
left join QUOTNHDR qh (nolock) on quh_cocde = qud_cocde and quh_qutno = qud_qutno
left join CUBASINF c1 (nolock) on quh_cus1no = c1.cbi_cusno
left join CUBASINF c2 (nolock) on quh_cus2no = c2.cbi_cusno
left join QUPRCEMT qp (nolock) on qud_cocde = qpe_cocde and qud_qutno = qpe_qutno and  qud_qutseq = qpe_qutseq
--left join VNBASINF (nolock) on cah_venno = vbi_venno
where qud_credat between @qucredatfm and @qucredatto
and qud_apprve = 'N'
and qud_qutitmsts ='W'
--where cah_credat between @qucredatfm and @qucredatto
--and ((@flg_cocde_table = 'N') or (@flg_cocde_table = 'Y' and cah_cocde in (select tmp_cocde from #TEMP_COCDE (nolock))))
and ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and quh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and quh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
--and ((@flg_pv_table = 'N') or (@flg_pv_table = 'Y' and cad_prdven in (select tmp_pv from #TEMP_PV (nolock))))
and ((@flg_quno_table = 'N') or (@flg_quno_table = 'Y' and quh_qutno in (select tmp_quno from #TEMP_QUNO (nolock))))
and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and qud_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
--and ((@flg_scno_table = 'N') or (@flg_scno_table = 'Y' and cad_scordno in (select tmp_scno from #TEMP_SCNO (nolock))))
--and ((@flg_pono_table = 'N') or (@flg_pono_table = 'Y' and cad_popurord in (select tmp_pono from #TEMP_PONO (nolock))))
--and ((@flg_jobno_table = 'N') or (@flg_jobno_table = 'Y' and cad_pojobord in (select tmp_jobno from #TEMP_JOBNO (nolock))))
--and ((@flg_invno_table = 'N') or (@flg_invno_table = 'Y' and cad_shinvno in (select tmp_invno from #TEMP_INVNO (nolock))))
--and ((@flg_cuspono_table = 'N') or (@flg_cuspono_table = 'Y' and cad_sccuspono in (select tmp_cuspono from #TEMP_CUSPONO (nolock))))
--and ((@flg_cusitmno_table = 'N') or (@flg_cusitmno_table = 'Y' and cad_cusitm in (select tmp_cusitmno from #TEMP_CUSITMNO (nolock))))
--and ((@flg_cusstyleno_table = 'N') or (@flg_cusstyleno_table = 'Y' and cad_cusstyno in (select tmp_cusstyleno from #TEMP_CUSSTYLENO (nolock))))
--and ((@flg_claimsts_table = 'N') or (@flg_claimsts_table = 'Y' and cah_caordsts in (select tmp_claimsts from #TEMP_CLAIMSTS (nolock))))
order by qud_qutno, qud_cocde--, cah_caordsts

drop table #TEMP_INIT
--drop table #TEMP_COCDE
drop table #TEMP_CUS1NO
drop table #TEMP_CUS2NO
--drop table #TEMP_PV
drop table #TEMP_QUNO
drop table #TEMP_ITMNO
--drop table #TEMP_SCNO
--drop table #TEMP_PONO
--drop table #TEMP_JOBNO
--drop table #TEMP_INVNO
--drop table #TEMP_CUSPONO
--drop table #TEMP_CUSITMNO
--drop table #TEMP_CUSSTYLENO
--drop table #TEMP_CLAIMSTS














GO
GRANT EXECUTE ON [dbo].[sp_select_QUM00005_DTL] TO [ERPUSER] AS [dbo]
GO
