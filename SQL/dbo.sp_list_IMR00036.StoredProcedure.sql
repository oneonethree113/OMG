/****** Object:  StoredProcedure [dbo].[sp_list_IMR00036]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_IMR00036]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_IMR00036]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/*
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Modification History
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Modify on	-- Modify by	-- Modification
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
*/
--sp_list_IMR00031 '', 'PG',                  '50001~50999', '60001~69999', 'CUSPOLIST', 'SC1000001', '10a001a001a01', 'A,B,C', '1001,1002,1003', 'D,E,F', 'A,B,C,D,E,F,G', '2010/01/01', '2010/01/10', '', '', '','','', 'mis'
--sp_list_IMR00031 '', 'UCPP,EW,HB,PG,TT,UCP','','','','sc1000001,sc1000005~sc1000010,us1000001','','A~A','','','', '2010-01-01','2010-01-10','1900-01-01','1900-01-01','N','A','C','mis'
CREATE           PROCEDURE [dbo].[sp_list_IMR00036]
@cocde nvarchar(6),
@cocdelist nvarchar(1000),
@cus1nolist nvarchar(1000),
@cus2nolist nvarchar(1000),
@cusponolist nvarchar(1000),
@scnolist nvarchar(1000),
@itmnolist nvarchar(1000),
@cvlist nvarchar(1000),
@dvlist nvarchar(1000),
@pvlist nvarchar(1000),
@salesteamlist nvarchar(1000),
@scissdatfm datetime,
@scissdatto datetime,
@shpdatfm datetime,
@shpdatto datetime,
@cuspodatfm datetime,
@cuspodatto datetime,
@printamt char(1),
@sctype char(1),
@rpttype char(2),
@sortby char(1),
@usrid nvarchar(20)
AS


SET NOCOUNT ON

create table #TEMP_INIT (tmp_init nvarchar(1000)) on [PRIMARY]
create table #TEMP_COCDE (tmp_cocde nvarchar(10)) on [PRIMARY]
create table #TEMP_CUS1NO (tmp_cus1no nvarchar(10)) on [PRIMARY]
create table #TEMP_CUS2NO (tmp_cus2no nvarchar(10)) on [PRIMARY]
create table #TEMP_CUSPONO (tmp_cuspono nvarchar(20)) on [PRIMARY]
create table #TEMP_SCNO (tmp_scno nvarchar(20)) on [PRIMARY]
create table #TEMP_ITMNO (tmp_itmno nvarchar(20)) on [PRIMARY]
create table #TEMP_CV (tmp_cv nvarchar(10)) on [PRIMARY]
create table #TEMP_DV (tmp_dv nvarchar(10)) on [PRIMARY]
create table #TEMP_PV (tmp_pv nvarchar(10)) on [PRIMARY]
create table #TEMP_SALESTEAM (tmp_salesteam nvarchar(10)) on [PRIMARY]

create table #TEMP_SCLIST(
tmp_cocde	nvarchar(10),
tmp_ordno	nvarchar(10),
tmp_issdat	datetime,
tmp_cuspodat	datetime,
tmp_ordsts	nvarchar(20),
tmp_cus1no	nvarchar(6),
tmp_cus2no	nvarchar(6),
tmp_cuspo	nvarchar(20),
tmp_salrep	nvarchar(12),
tmp_saltem	nvarchar(10),
tmp_shpstr	datetime,
tmp_shpend	datetime,
tmp_ordseq	int,
tmp_itmno	nvarchar(20),
tmp_cv		nvarchar(10),
tmp_dv		nvarchar(10),
tmp_pv		nvarchar(10)
)


declare	@fm nvarchar(100), @to nvarchar(100)

declare @strPart nvarchar(1000), @strRemain nvarchar(1000)

set @fm = ''
set @to = ''
set @strPart = ''
set @strRemain = ''

declare	@fmCusPONo nvarchar(100), @toCusPONo nvarchar(100)
set @fmCusPONo = ''
set @toCusPONo = ''


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
cbi_custyp = 'P' and 
--cbi_cussts = 'A' and
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
cbi_custyp = 'S' and 
--cbi_cussts = 'A' and
(exists(select 1 from syusrright where yur_usrid = @usrid  and yur_doctyp = 'SC' and yur_lvl = 0)
	or ysr_saltem in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'SC' and yur_lvl = 1)
	or cbi_cusno in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'SC' and yur_lvl = 2)
) and cbi_cusno > '50000'
union 
select ''
order by cbi_cusno

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
			set @fmCusPONo = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @toCusPONo = right(@strPart, len(@strPart) - charindex('~', @strPart))
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
			set @fmCusPONo = ltrim(left(@strRemain, charindex('~', @strRemain)-1))
			set @toCusPONo = right(@strRemain, len(@strRemain) - charindex('~', @strRemain))
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_CUSPONO
	select distinct tmp_init from #TEMP_INIT
end


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

--#TEMP_CV
if ltrim(rtrim(@cvlist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @cvlist
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
	insert into #TEMP_CV
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




--#TEMP_SALESTEAM
if ltrim(rtrim(@salesteamlist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @salesteamlist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select distinct ysr_saltem from SYSALREP (nolock) where ysr_saltem between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select distinct ysr_saltem from SYSALREP (nolock) where ysr_saltem like @strPart
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
			select distinct ysr_saltem from SYSALREP (nolock) where ysr_saltem between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select distinct ysr_saltem from SYSALREP (nolock) where ysr_saltem like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_SALESTEAM
	select distinct tmp_init from #TEMP_INIT
end

--select * from #TEMP_SALESTEAM
--select * from #TEMP_COCDE
--select * from #TEMP_CUS1NO
--select * from #TEMP_CUS2NO
--select * from #TEMP_CUSPONO
--select @fmCusPONo, @toCusPONo
--select * from #TEMP_SCNO
--select * from #TEMP_ITMNO
--select * from #TEMP_CV
--select * from #TEMP_DV
--select * from #TEMP_PV
--select * from #TEMP_SALESTEAM
--select * from #TEMP_SCLIST

-------------------------------------------------------------------
declare @flg_cocde_table char(1), 
@flg_cus1no_table char(1),
@flg_cus2no_table char(1),
@flg_cuspono_table char(1),
@flg_cuspono_fmto char(1),
@flg_scno_table char(1),
@flg_itmno_table char(1),
@flg_cv_table char(1),
@flg_dv_table char(1),
@flg_pv_table char(1),
@flg_salesteam_table char(1),
@flg_scissdat_fmto char(1),
@flg_shpdat_fmto char(1),
@flg_cuspodat_fmto char(1)

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

if (select count(*) from #TEMP_CUSPONO) >= 1
	set @flg_cuspono_table = 'Y'
else
	set @flg_cuspono_table = 'N'

if @fmCusPONo <> ''
	set @flg_cuspono_fmto = 'Y'
else
	set @flg_cuspono_fmto = 'N'

if (select count(*) from #TEMP_SCNO) >= 1
	set @flg_scno_table = 'Y'
else
	set @flg_scno_table = 'N'

if (select count(*) from #TEMP_ITMNO) >= 1
	set @flg_itmno_table = 'Y'
else
	set @flg_itmno_table = 'N'

if (select count(*) from #TEMP_CV) >= 1
	set @flg_cv_table = 'Y'
else
	set @flg_cv_table = 'N'

if (select count(*) from #TEMP_DV) >= 1
	set @flg_dv_table = 'Y'
else
	set @flg_dv_table = 'N'

if (select count(*) from #TEMP_PV) >= 1
	set @flg_pv_table = 'Y'
else
	set @flg_pv_table = 'N'

if (select count(*) from #TEMP_SALESTEAM) >= 1
	set @flg_salesteam_table = 'Y'
else
	set @flg_salesteam_table = 'N'

if @scissdatfm <> '1900/01/01'
begin
	set @flg_scissdat_fmto = 'Y'
	set @scissdatto = dateadd(DD,1,@scissdatto)
end
else
begin
	set @flg_scissdat_fmto = 'N'
end

if @shpdatfm <> '1900/01/01'
begin
	set @flg_shpdat_fmto = 'Y'
	--set @shpdatto = dateadd(DD,1,@shpdatto)
end
else
begin
	set @flg_shpdat_fmto = 'N'
end

if @cuspodatfm <> '1900/01/01'
begin
	set @flg_cuspodat_fmto = 'Y'
	--set @cuspodatto =  dateadd(DD,1,@cuspodatto)
end
else
begin
	set @flg_cuspodat_fmto = 'N'
end


--------------------------------------------------------------------
if @flg_scissdat_fmto = 'Y'
begin

insert into #TEMP_SCLIST
select soh_cocde, soh_ordno, soh_issdat, soh_cpodat, soh_ordsts, soh_cus1no, soh_cus2no, soh_cuspo,
--soh_salrep,isnull(ysr_saltem,'')
soh_srname,soh_saltem
,sod_shpstr, sod_shpend, sod_ordseq, sod_itmno, sod_cusven, sod_dv, sod_venno
from SCORDHDR (nolock)
--left join SYSALREP on ysr_code1 = soh_salrep
, SCORDDTL (nolock)
where soh_issdat between @scissdatfm and @scissdatto
and soh_ordno = sod_ordno
and ((@flg_cocde_table = 'N') or (@flg_cocde_table = 'Y' and soh_cocde in (select tmp_cocde from #TEMP_COCDE (nolock))))
and ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and soh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and soh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
and ((@flg_cuspono_table = 'N') or (@flg_cuspono_table = 'Y' and soh_cuspo in (select tmp_cuspono from #TEMP_CUSPONO (nolock))))
and ((@flg_cuspono_fmto = 'N') or (@flg_cuspono_fmto = 'Y' and soh_cuspo between @fmCusPONo and @toCusPONo))
and ((@flg_scno_table = 'N') or (@flg_scno_table = 'Y' and soh_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and sod_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
and ((@flg_cv_table = 'N') or (@flg_cv_table = 'Y' and sod_cusven in (select tmp_cv from #TEMP_CV (nolock))))
and ((@flg_dv_table = 'N') or (@flg_dv_table = 'Y' and sod_dv in (select tmp_dv from #TEMP_DV (nolock))))
and ((@flg_pv_table = 'N') or (@flg_pv_table = 'Y' and sod_venno in (select tmp_pv from #TEMP_PV (nolock))))
and ((@flg_shpdat_fmto = 'N') or (@flg_shpdat_fmto = 'Y' and sod_shpstr between @shpdatfm and @shpdatto))
and ((@flg_cuspodat_fmto = 'N') or (@flg_cuspodat_fmto = 'Y' and soh_cpodat between @cuspodatfm and @cuspodatto))

end
else if @flg_shpdat_fmto = 'Y'
begin

insert into #TEMP_SCLIST
select soh_cocde, soh_ordno, soh_issdat, soh_cpodat, soh_ordsts, soh_cus1no, soh_cus2no, soh_cuspo,
--soh_salrep,isnull(ysr_saltem,'')
soh_srname,soh_saltem
,sod_shpstr, sod_shpend, sod_ordseq, sod_itmno, sod_cusven, sod_dv, sod_venno
from SCORDHDR (nolock)
--left join SYSALREP on ysr_code1 = soh_salrep
, SCORDDTL (nolock)
where sod_shpstr between @shpdatfm and @shpdatto
and soh_ordno = sod_ordno
and ((@flg_cocde_table = 'N') or (@flg_cocde_table = 'Y' and soh_cocde in (select tmp_cocde from #TEMP_COCDE (nolock))))
and ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and soh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and soh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
and ((@flg_cuspono_table = 'N') or (@flg_cuspono_table = 'Y' and soh_cuspo in (select tmp_cuspono from #TEMP_CUSPONO (nolock))))
and ((@flg_cuspono_fmto = 'N') or (@flg_cuspono_fmto = 'Y' and soh_cuspo between @fmCusPONo and @toCusPONo))
and ((@flg_scno_table = 'N') or (@flg_scno_table = 'Y' and soh_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and sod_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
and ((@flg_cv_table = 'N') or (@flg_cv_table = 'Y' and sod_cusven in (select tmp_cv from #TEMP_CV (nolock))))
and ((@flg_dv_table = 'N') or (@flg_dv_table = 'Y' and sod_dv in (select tmp_dv from #TEMP_DV (nolock))))
and ((@flg_pv_table = 'N') or (@flg_pv_table = 'Y' and sod_venno in (select tmp_pv from #TEMP_PV (nolock))))
and ((@flg_cuspodat_fmto = 'N') or (@flg_cuspodat_fmto = 'Y' and soh_cpodat between @cuspodatfm and @cuspodatto))
and ((@flg_scissdat_fmto = 'N') or (@flg_scissdat_fmto = 'Y' and soh_issdat between @scissdatfm and @scissdatto))
end
else
begin

insert into #TEMP_SCLIST
select soh_cocde, soh_ordno, soh_issdat, soh_cpodat, soh_ordsts, soh_cus1no, soh_cus2no, soh_cuspo,
--soh_salrep,isnull(ysr_saltem,'')
soh_srname,soh_saltem
,sod_shpstr, sod_shpend, sod_ordseq, sod_itmno, sod_cusven, sod_dv, sod_venno
from SCORDHDR (nolock)
--left join SYSALREP on ysr_code1 = soh_salrep
, SCORDDTL (nolock)
where soh_cpodat between @cuspodatfm and @cuspodatto
and soh_ordno = sod_ordno
and ((@flg_cocde_table = 'N') or (@flg_cocde_table = 'Y' and soh_cocde in (select tmp_cocde from #TEMP_COCDE (nolock))))
and ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and soh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and soh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
and ((@flg_cuspono_table = 'N') or (@flg_cuspono_table = 'Y' and soh_cuspo in (select tmp_cuspono from #TEMP_CUSPONO (nolock))))
and ((@flg_cuspono_fmto = 'N') or (@flg_cuspono_fmto = 'Y' and soh_cuspo between @fmCusPONo and @toCusPONo))
and ((@flg_scno_table = 'N') or (@flg_scno_table = 'Y' and soh_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and sod_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
and ((@flg_cv_table = 'N') or (@flg_cv_table = 'Y' and sod_cusven in (select tmp_cv from #TEMP_CV (nolock))))
and ((@flg_dv_table = 'N') or (@flg_dv_table = 'Y' and sod_dv in (select tmp_dv from #TEMP_DV (nolock))))
and ((@flg_pv_table = 'N') or (@flg_pv_table = 'Y' and sod_venno in (select tmp_pv from #TEMP_PV (nolock))))
and ((@flg_shpdat_fmto = 'N') or (@flg_shpdat_fmto = 'Y' and sod_shpstr between @shpdatfm and @shpdatto))
and ((@flg_scissdat_fmto = 'N') or (@flg_scissdat_fmto = 'Y' and soh_issdat between @scissdatfm and @scissdatto))

end


if @sctype = 'O'
	delete from #TEMP_SCLIST where tmp_ordsts in ('CLO', 'CAN')


if @flg_salesteam_table = 'Y' --and ((select count(*) from #TEMP_SALESTEAM (nolock) where tmp_salesteam = 'S') <> 1)
	delete from #TEMP_SCLIST where tmp_saltem not in (select tmp_salesteam from #TEMP_SALESTEAM (nolock))


if @rpttype = 'MB'
begin
	select 
	distinct
	scb_cocde as 'Comp'
      ,scb_ordno as 'SC No'
      ,scb_ordseq  as 'SC Seq'
      ,scb_itmno  as 'Item No.'
      ,scb_cptseq as 'Cpt Seq'
      ,scb_cpt as 'Material'
      ,scb_curcde as 'Curr'
      ,scb_cst as 'Cost $'
      ,scb_cstpct as 'Cost %'
      ,scb_pct as 'Wgt %'
	from #TEMP_SCLIST
	left join SCCPTBKD  sc (nolock) on tmp_cocde = scb_cocde and tmp_ordno = scb_ordno and tmp_ordseq = scb_ordseq
	where scb_ordno is not null
	order by scb_ordno , scb_ordseq, scb_cptseq 
end
else if @rpttype = 'CH'-- Check Data
begin
	select 
	distinct
	tmp_cocde as 'Comp',
	tmp_ordno as 'SC No',
	tmp_ordsts as 'SC Status', 
	soh_cttper as 'Contact Person',
	isnull(tmp_cus1no + ' - ' + c1.cbi_cussna, '') as 'Pri Cust',
	isnull(tmp_cus2no + ' - ' + c2.cbi_cussna, '') as 'Sec Cust',
	tmp_saltem as 'Sales Team',
	convert(nvarchar(10),soh_issdat,101) as 'SC Issue Date',
	convert(nvarchar(10),tmp_cuspodat,101) as 'Cust PO Date',
--	soh_cuspo as 'Cust PO# (Header)',
--	sod_cuspo as 'Cust PO# (Detail)',
--	soh_resppo as 'Resp. PO# (Header)',
--	sod_resppo as 'Resp. PO# (Detail)',
	soh_cuspo as 'Cust PO# (Header)',
	sod_cuspo as 'Cust PO# (Detail)',
	soh_resppo as 'Resp PO# (Header)',
	sod_resppo as 'Resp PO# (Detail)',
	tmp_ordseq as 'SC Seq',
	isnull(pod_jobord,'') as 'Job No',
	ltrim(rtrim(tmp_itmno)) as 'Item No',
	sod_venitm as 'Vendor Item No',
	sod_cusitm as 'Cust Item No',
--	sod_seccusitm as 'Sec. Customer Item #',
	sod_seccusitm as 'Sec Cust Item#',
	sod_cusstyno as 'Cust Style No',
	sod_cussku as 'Cust SKU No',
	sod_itmdsc as 'Item Desc',
	sod_colcde as 'Color Code',
	sod_cuscol as 'Cust Color Code',
	sod_coldsc as 'Color Desc',
	sod_pckunt as 'UM',
	sod_conftr as 'Factor',
	sod_inrctn as 'Inner',
	sod_mtrctn as 'Master',
	sod_cft as 'CFT',
	sod_ftyprctrm as 'PrcTrm',
	sod_hkprctrm as 'HK PrcTrm',
	sod_trantrm as 'Tran Trm',
	sod_pckitr as 'Packing Inst',
	sod_ordqty as 'Order Qty',
--	case @printamt when 'Y' then sod_curcde else '' end as 'Curr',
--	case @printamt when 'Y' then sod_untprc else 0 end as 'Selling Price',
	sod_curcde as 'Curr',
	sod_untprc as 'Selling Price',
	sod_hrmcde as 'HSTU# / Tariff',
	sod_dtyrat as 'Duty',
	sod_dept as 'Dept',
	sod_code1 as 'UPC/EAN#(M)',
	sod_code2 as 'UPC/EAN#(I)',
	sod_code3 as 'UPC/EAN#(C)',
	sod_cususdcur as 'Retail Unit (1)',
	sod_cususd as 'Retail (1)',
	sod_cuscadcur as 'Retail Unit (2)',
	sod_cuscad as 'Retail (2)',
	sod_custum as 'Cust UM',
	sod_ctnstr as 'Start Ctn',
	sod_ctnend as 'End Ctn',
	case convert(nvarchar(10),sod_shpstr,101) when '01/01/1900' then '' else convert(nvarchar(10),sod_shpstr,101) end as 'S/C Ship Start Date',
	case convert(nvarchar(10),sod_shpend,101) when '01/01/1900' then '' else convert(nvarchar(10),sod_shpend,101) end as 'S/C Ship End Date',
	case convert(nvarchar(10),sod_candat,101) when '01/01/1900' then '' else convert(nvarchar(10),sod_candat,101) end as 'S/C Cancel Date',
	case convert(nvarchar(10),sod_posstr,101) when '01/01/1900' then '' else convert(nvarchar(10),sod_posstr,101) end as 'PO Ship Start Date',
	case convert(nvarchar(10),sod_posend,101) when '01/01/1900' then '' else convert(nvarchar(10),sod_posend,101) end as 'PO Ship End Date',
	case convert(nvarchar(10),sod_poscan,101) when '01/01/1900' then '' else convert(nvarchar(10),sod_poscan,101) end as 'PO Cancel Date',
	isnull(tmp_dv + ' - ' + dv.vbi_vensna, '') as 'DV',
	isnull(tmp_cv + ' - ' + cv.vbi_vensna, '') as 'CV',
	isnull(tmp_pv + ' - ' + pv.vbi_vensna, '') as 'PV',
	isnull(sod_tradeven + ' - ' + tv.vbi_vensna, '') as 'TV',
	isnull(sod_examven + ' - ' + fa.vbi_vensna, '') as 'FA',
--	case @printamt when 'Y' then sod_fcurcde else '' end as 'PV Fty Currency',
--	case @printamt when 'Y' then sod_ftyprc else 0 end as 'PV Factory Price',
--	case @printamt when 'Y' then sod_dvfcurcde else '' end as 'DV Fty Currency',
--	case @printamt when 'Y' then sod_dvftyprc else 0 end as 'DV Factory Price',
	sod_fcurcde as 'PV Fty Curr',
	sod_ftyprc as 'PV Fty Price',
	sod_dvfcurcde as 'DV Fty Curr',
	sod_dvftyprc as 'DV Fty Price',
	sod_rmk as 'SC Remark',
	sod_pormk as 'Additional PO Remark',
	sod_season as 'Season',
	sod_name_f1 as 'More Fields Name (1)',
	sod_dsc_f1 as 'More Fields Desc (1)',
	sod_name_f2 as 'More Fields Name (2)',
	sod_dsc_f2 as 'More Fields Desc (2)',
	sod_name_f3 as 'More Fields Name (3)',
	sod_dsc_f3 as 'More Fields Desc (3)',
	soh_rmk as 'Remark (Header)',
	isnull(sm.ssm_engrmk,'') as 'Remarks in English (M)',
	isnull(sm.ssm_chnrmk,'') as 'Remarks in Chinese (M)',
	isnull(ss.ssm_engrmk,'') as 'Remarks in English (S)',
	isnull(ss.ssm_chnrmk,'') as 'Remarks in Chinese (S)',
	isnull(si.ssm_engrmk,'') as 'Remarks in English (I)',
	isnull(si.ssm_chnrmk,'') as 'Remarks in Chinese (I)',
	soh_shpadr as 'Shipping Address',
	soh_shpstt as 'State/Province',
	soh_shpcty as 'Country',
	soh_shpzip as 'ZIP',
	soh_prctrm as 'Price Term (Header)',
	soh_cusctn as 'Total Ctn#',
	soh_dest  as 'Destination'
	from #TEMP_SCLIST
	left join SCORDHDR (nolock) on tmp_cocde = soh_cocde and tmp_ordno = soh_ordno
	left join SCORDDTL (nolock) on tmp_cocde = sod_cocde and tmp_ordno = sod_ordno and tmp_ordseq = sod_ordseq
	left join POORDDTL (nolock) on tmp_cocde = pod_cocde and pod_scno = tmp_ordno and pod_scline = tmp_ordseq
	left join CUBASINF c1 (nolock) on tmp_cus1no = c1.cbi_cusno
	left join CUBASINF c2 (nolock) on tmp_cus2no = c2.cbi_cusno
	left join VNBASINF cv (nolock) on tmp_cv = cv.vbi_venno
	left join VNBASINF dv (nolock) on tmp_dv = dv.vbi_venno
	left join VNBASINF pv (nolock) on tmp_pv = pv.vbi_venno
	left join VNBASINF tv (nolock) on sod_tradeven = tv.vbi_venno
	left join VNBASINF fa (nolock) on sod_examven = fa.vbi_venno
	left join SCSHPMRK sm (nolock) on tmp_cocde = sm.ssm_cocde and tmp_ordno = sm.ssm_ordno and sm.ssm_shptyp = 'M'
	left join SCSHPMRK ss (nolock) on tmp_cocde = ss.ssm_cocde and tmp_ordno = ss.ssm_ordno and ss.ssm_shptyp = 'S'
	left join SCSHPMRK si (nolock) on tmp_cocde = si.ssm_cocde and tmp_ordno = si.ssm_ordno and si.ssm_shptyp = 'I'
	
	where soh_ordno is not null
	and ((@sctype = 'A') or (@sctype = 'O' and  sod_ordqty - sod_shpqty > 0))
	--order by tmp_cus1no, tmp_cus2no,convert(nvarchar(10),tmp_shpstr,111) , convert(nvarchar(10),tmp_shpend,111) 
	order by tmp_ordno, tmp_ordseq
end
else if  @rpttype = 'AD'-- Assorted Item
begin
	select 
	distinct
	sai_cocde as 'Comp'
      ,sai_ordno as 'SC No'
      ,sai_ordseq as 'SC Seq'
      ,sai_itmno as 'Item No'
      ,sai_assitm as 'Assorted Item #'
      ,sai_assdsc as 'Asst Item Desc'
      ,sai_cusitm as 'Cust item #'
      ,sai_colcde as 'Color Code'
      ,sai_coldsc as 'Color Desc'
      ,sai_cussku as 'Cust SKU #'
	  ,sai_cusstyno as 'Customer Style No'
      ,sai_upcean as 'UPC#/EAN#'
      ,sai_cusrtl as 'Cust Retail'
      ,sai_untcde as 'UM'
      ,sai_inrqty as 'Inner'
      ,sai_mtrqty as 'Master'
		from #TEMP_SCLIST
		left join SCASSINF ss (nolock) on tmp_cocde = sai_cocde and tmp_ordno = sai_ordno and tmp_ordseq = sai_ordseq
	where sai_ordno is not null

	order by sai_ordno , sai_ordseq, sai_itmno
end
else if  @rpttype = 'MS'  --multi shipdate
begin
	select 
	sod_ordno as 'SC No' , 
	soh_cuspo as 'CusPo' , 
	sod_ordseq as 'SC Seq' , 
	sod_itmno as 'Item No' , 
	sod_pckunt as 'UM' , 
	sod_inrctn as 'Inner' , 
	sod_mtrctn as 'Master' , 
	sod_ordqty as 'Order Qty' , 
	sds_shpseq as 'Shp Seq' , 
	convert(varchar(10), sds_scfrom,101) as 'SC From' , 
	convert(varchar(10), sds_scto,101) as 'SC To' , 
	convert(varchar(10), sds_pofrom,101) as 'PO From' , 
	convert(varchar(10), sds_poto,101) as 'PO To' ,
	sds_ordqty as 'Shp Dtl Qty' , 
	sds_ctnstr as 'Ctn Frm' , 
	sds_ctnend as 'Ctn To' , 
	sds_ttlctn as 'No of Ctn' , 
	sds_dest as 'Dest' , 
	sds_rmk as 'Remark'
	from #TEMP_SCLIST
	left join SCORDDTL on tmp_ordno = sod_ordno and tmp_ordseq = sod_ordseq
	left join SCDTLSHP on sds_ordno = sod_ordno and sds_seq = sod_ordseq
	left join SCORDHDR on soh_ordno = sod_ordno
	where sod_ordno is not null and sds_shpseq is not null
	order by sod_ordno, sod_ordseq, sds_shpseq
end



drop table #TEMP_INIT
drop table #TEMP_COCDE
drop table #TEMP_CUS1NO
drop table #TEMP_CUS2NO
drop table #TEMP_CUSPONO
drop table #TEMP_SCNO
drop table #TEMP_ITMNO
drop table #TEMP_CV
drop table #TEMP_DV
drop table #TEMP_PV
drop table #TEMP_SALESTEAM
drop table #TEMP_SCLIST



GO
GRANT EXECUTE ON [dbo].[sp_list_IMR00036] TO [ERPUSER] AS [dbo]
GO
