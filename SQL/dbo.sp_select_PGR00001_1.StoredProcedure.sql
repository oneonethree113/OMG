/****** Object:  StoredProcedure [dbo].[sp_select_PGR00001_1]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PGR00001_1]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PGR00001_1]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[sp_select_PGR00001_1]
                                                                                                                                                                                                                                                                 
@code nvarchar(10),
@codelist nvarchar(1000),
@cus1nolist nvarchar(1000),
@cus2nolist nvarchar(1000),
@pkgREQlist nvarchar(1000),
@pkgitmlist nvarchar(1000),
@pkgprtco nvarchar(1000),
@sccde nvarchar(1000),
@tocde nvarchar(1000),
@reqcredatfm datetime,
@reqcredatto datetime,
@itmnolist nvarchar(1000),
@skunolist nvarchar(1000),
@cussnolist nvarchar(1000),
@opt_sc_to nvarchar(2),
@usrid nvarchar(30)


---------------------------------------------- 

 
AS
 

declare @flg_cocde_table char(1), 
@flg_cus1no_table char(1),
@flg_cus2no_table char(1),
@flg_pkgorder_table char(1),
@flg_pkgitm_table char(1),
@flg_pkgprtco_table char(1),
@flg_scno_table char(1),
@flg_tono_table char(1),
@flg_reqcredat_fmto char(1),
@flg_itmno_table char(1),
@flg_skuno_table char(1),
@flg_cussno_table char(1)

declare	@fm nvarchar(100), @to nvarchar(100), @date3 datetime


declare @strPart nvarchar(1000), @strRemain nvarchar(1000)

set @fm = ''
set @to = ''
set @strPart = ''
set @strRemain = ''
set @date3  = ''


begin

create table #TEMP_INIT (tmp_init nvarchar(1000)) on [PRIMARY]
create table #TEMP_CODELIST (tmp_code nvarchar(1000)) on [PRIMARY]
create table #TEMP_CUS1NO (tmp_cus1no nvarchar(10)) on [PRIMARY]
create table #TEMP_CUS2NO (tmp_cus2no nvarchar(10)) on [PRIMARY]
create table #TEMP_PKGREQ (tmp_reqno nvarchar(20)) on [PRIMARY]
create table #TEMP_PKGITM (tmp_item nvarchar(20)) on [PRIMARY]
create table #TEMP_PKGPRTCO (tmp_venno nvarchar(20)) on [PRIMARY]
create table #TEMP_SCNO (tmp_scno nvarchar(20)) on [PRIMARY]
create table #TEMP_TONO (tmp_tono nvarchar(20)) on [PRIMARY]
create table #TEMP_ITMNO (tmp_itmno nvarchar(20)) on [PRIMARY]
create table #TEMP_SKUNO (tmp_skuno nvarchar(20)) on [PRIMARY]
create table #TEMP_CUSSNO (tmp_cussno nvarchar(20)) on [PRIMARY]
create table #TEMP_REPRINT (tmp_reqno nvarchar(20),	tmp_repordno nvarchar(200))


--#TEMP_COCDE
if ltrim(rtrim(@codelist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @codelist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))

		insert into #TEMP_INIT values (@strPart)
	end
	if charindex(',',@strRemain) = 0
	begin
		set @strRemain = ltrim(@strRemain)

		insert into #TEMP_INIT values (@strRemain)
	end
	insert into #TEMP_CODELIST
	select distinct tmp_init from #TEMP_INIT
end

--------------------------------------------------------------
--------------------------------------------------------------
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
cbi_custyp = 'P' and cbi_cussts = 'A' and
(exists(select 1 from syusrright where yur_usrid = @usrid  and yur_doctyp = 'CA' and yur_lvl = 0)
	or ysr_saltem in (select yur_para from syusrright where  yur_doctyp = 'CA' and yur_lvl = 1 and yur_usrid = @usrid)
	or cbi_cusno in (select yur_para from syusrright where yur_doctyp = 'CA' and yur_lvl = 2 and yur_usrid = @usrid)
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
cbi_custyp = 'S' and cbi_cussts = 'A' and
(exists(select 1 from syusrright where yur_usrid = @usrid  and yur_doctyp = 'CA' and yur_lvl = 0)
	or ysr_saltem in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 1)
	or cbi_cusno in (select yur_para from syusrright where yur_usrid = @usrid and yur_doctyp = 'CA' and yur_lvl = 2)
) and cbi_cusno > '50000'
--union 
--select ''
order by cbi_cusno

end


--#TEMP_SCNO
if ltrim(rtrim(@sccde)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @sccde
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select sod_ordno from SCORDDTL where sod_ordno between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select sod_ordno from SCORDDTL where sod_ordno like @strPart
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
			select sod_ordno from SCORDDTL where sod_ordno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select sod_ordno from SCORDDTL where sod_ordno like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_SCNO
	select distinct tmp_init from #TEMP_INIT
end
 
-- select  * from  #TEMP_SCNO

-- select @tocde as '@tocde'

 if ltrim(rtrim(@tocde)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @tocde
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select tod_toordno from TOORDDTL where tod_toordno between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select tod_toordno from TOORDDTL where tod_toordno like @strPart
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
			select tod_toordno from TOORDDTL where tod_toordno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select tod_toordno from TOORDDTL where tod_toordno like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_TONO
	select distinct tmp_init from #TEMP_INIT
end
 
 --select  * from #TEMP_TONO


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

---


--#TEMP_PKGREQ 

if ltrim(rtrim(@pkgREQlist)) <> ''
  begin
	delete from #TEMP_INIT

	set @strRemain = @pkgREQlist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select pRh_REQno from PKreqHDR (nolock) where prh_reqno between @fm and @to
			
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select pRh_REQno  from PKreqHDR (nolock) where prh_reqno like @strPart
			 
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
			select prh_reqno from PKREQHDR (nolock) where prh_reqno between @fm and @to
			 
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select prh_reqno from PKREQHDR (nolock)  where prh_reqno like @strRemain
			 
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_PKGREQ 
	select distinct tmp_init from #TEMP_INIT
end

---

--#TEMP_PKGITM  
if ltrim(rtrim(@pkgitmlist)) <> ''
  begin
	delete from #TEMP_INIT

	set @strRemain = @pkgitmlist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select pib_pgitmno from PKIMBAIF (nolock) where pib_pgitmno between @fm and @to
			
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select pib_pgitmno from PKIMBAIF (nolock) where pib_pgitmno like @strPart
			 
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
			select pib_pgitmno from PKIMBAIF (nolock) where pib_pgitmno between @fm and @to
			 
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select pib_pgitmno from PKIMBAIF (nolock)  where pib_pgitmno like @strRemain
			 
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_PKGITM  
	select distinct tmp_init from #TEMP_INIT
end

---

--#TEMP_PKGITM  
if ltrim(rtrim(@pkgitmlist)) <> ''
  begin
	delete from #TEMP_INIT

	set @strRemain = @pkgitmlist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select pib_pgitmno from PKIMBAIF (nolock) where pib_pgitmno between @fm and @to
			
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select pib_pgitmno from PKIMBAIF (nolock) where pib_pgitmno like @strPart
			 
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
			select pib_pgitmno from PKIMBAIF (nolock) where pib_pgitmno between @fm and @to
			 
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select pib_pgitmno from PKIMBAIF (nolock)  where pib_pgitmno like @strRemain
			 
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_PKGITM  
	select distinct tmp_init from #TEMP_INIT
end

---

--#TEMP_PKGPRTCO   
if ltrim(rtrim(@pkgprtco)) <> ''
  begin
	delete from #TEMP_INIT

	set @strRemain = @pkgprtco
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
			and vbi_venflag in ('P','D') and vbi_vensts = 'A'
			
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select vbi_venno from VNBASINF (nolock) where vbi_venno like @strPart
			 and vbi_venflag in ('P','D') and vbi_vensts = 'A'
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
			  and vbi_venflag in ('P','D') and vbi_vensts = 'A'
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select vbi_venno from VNBASINF (nolock)  where vbi_venno like @strRemain
			   and vbi_venflag in ('P','D') and vbi_vensts = 'A'
		end
		else
		begin
-----------
			insert into #TEMP_INIT values (@strRemain)
-------------
		end
	end
	insert into #TEMP_PKGPRTCO   
	select distinct tmp_init from #TEMP_INIT
end

---

if (select count(*) from #TEMP_CODELIST) >= 1
	set @flg_cocde_table ='Y'
else
	set @flg_cocde_table ='N'

if (select count(*) from #TEMP_CUS1NO) >= 1
	set @flg_cus1no_table = 'Y'
else
	set @flg_cus1no_table = 'N'

if (select count(*) from #TEMP_CUS2NO) >= 1
	set @flg_cus2no_table = 'Y'
else
	set @flg_cus2no_table = 'N'


if (select count(*) from #TEMP_SCNO) >= 1
	set @flg_scno_table = 'Y'
else
	set @flg_scno_table = 'N'
--test
--select * from #TEMP_SCNO

if (select count(*) from #TEMP_TONO) >= 1
	set @flg_tono_table = 'Y'
else
	set @flg_tono_table = 'N'

--test	
--select * from #TEMP_TONO

if @reqcredatfm <> '1900/01/01'
begin
	set @flg_reqcredat_fmto  = 'Y'
	set @reqcredatto = dateadd(DD,1,@reqcredatto)
end
else
begin
	set @flg_reqcredat_fmto  = 'N'
end

if (select count(*) from #TEMP_ITMNO) >= 1
	set @flg_itmno_table = 'Y'
else
	set @flg_itmno_table = 'N'

if (select count(*) from #TEMP_SKUNO) >= 1
	set @flg_skuno_table = 'Y'
else
	set @flg_skuno_table = 'N'

if (select count(*) from #TEMP_CUSSNO) >= 1
	set @flg_cussno_table = 'Y'
else
	set @flg_cussno_table = 'N'

if (select count(*) from #TEMP_PKGREQ ) >= 1
	set @flg_pkgorder_table  = 'Y'
else
	set @flg_pkgorder_table  = 'N'


if (select count(*) from #TEMP_PKGITM ) >=1 
	set @flg_pkgitm_table  = 'Y'
else
	set @flg_pkgitm_table  = 'N'

 if (select count(*) from #TEMP_PKGPRTCO  )>= 1
	set @flg_pkgprtco_table  = 'Y'
else
	set @flg_pkgprtco_table  = 'N'

--------------------------------------------------------------
--------------------------------------------------------------


select distinct sod_tordno, sod_ordno
into #TEMP_SC_TO_RELATION
from SCORDDTL (nolock) where 
-- (  (@flg_tono_table = 'Y' and sod_tordno in (select tmp_tono from #TEMP_TONO (nolock))))
((@flg_tono_table = 'N') or (@flg_tono_table = 'Y' and sod_tordno in (select tmp_tono from #TEMP_TONO (nolock))))
--sod_tordno = @TONo

 
select distinct sod_tordno, sod_tordseq, sod_ordno, sod_ordseq
into #TEMP_SC_TO_RELATION_DTL
from SCORDDTL (nolock) where 
-- ( (@flg_tono_table = 'Y' and sod_tordno  in (select tmp_tono from #TEMP_TONO (nolock))))
 ((@flg_tono_table = 'N') or (@flg_tono_table = 'Y' and sod_tordno  in (select tmp_tono from #TEMP_TONO (nolock))))



--test
--select @flg_scno_table	 as '123'
--select @flg_scissdat_fmto
--select @flg_cus1no_table
--select @flg_cus2no_table
--select @flg_scno_table
--select @flg_tono_table
--select @flg_itmno_table

if @opt_sc_to = 'sc' 
begin
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
	--sc reg
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
select	
'A' as 'prd_act', 
''  as 'prd_reqno', 
'' as 'prd_seq', 
'' as 'prd_pkgitm', 
'' as 'prd_pkgven',
isnull(sod_ordno,'') as 'sod_ordno',
''as 'tod_toordno',
soh_cus1no + ' - '  + cbi_cusnam as 'prh_cus1no',
sod_itmno as 'prd_itemno',
'' as 'prd_assitm',
sod_cusitm as 'prd_cusitm',
sod_cussku as 'prd_sku',
sod_pckunt as 'um' ,
sod_inrctn as 'inr', 
sod_mtrctn as 'mst',
sod_ftyprctrm as 'prd_ftyprctrm' , 
sod_hkprctrm as 'prd_hkprctrm',
sod_trantrm,
sod_colcde as 'prd_colcde',
sod_cuspo,
isnull(sod_ordqty,0) as 'sctoqty',
sod_conftr,
'' as 'prd_ordqty',
''  as 'prd_wasqty',
0 as 'prd_ttlordqty',
'' as 'prd_curcde',
0 as 'prd_untprc', 
1 as 'prd_multip', 
'HKD' ,
0,
0 as 'peh_price'

	from scorddtl (nolock)
	 left join SCORDHDR (nolock) on sod_ordno = soh_ordno
	 	left join CUBASINF on cbi_cusno = soh_cus1no
	where 
  ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and soh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
 	and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and soh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
	and (   (@flg_scno_table = 'N' and ltrim(rtrim(@sccde)) = '' ) or (@flg_scno_table = 'N' and ltrim(rtrim(@sccde)) <> ''  and 1 > 2)   or (@flg_scno_table = 'Y' and sod_ordno  is not null and sod_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
	and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and sod_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
	and ((@flg_skuno_table = 'N') or (@flg_skuno_table = 'Y' and sod_cussku in (select tmp_skuno from #TEMP_skuno (nolock))))
	and ((@flg_cussno_table = 'N') or (@flg_cussno_table = 'Y' and sod_cusstyno in (select tmp_cussno from #TEMP_cussno (nolock))))
	and ((@flg_cocde_table = 'N') or (@flg_cocde_table ='Y' and soh_cocde in (select tmp_code from #TEMP_CODELIST(nolock))))
--	and sod_itmtyp = 'REG'	
	--and tod_latest = 'Y'
	--and prh_status ='REL'
	--and toh_ordsts not in  ('CLO','CAN')
	--and iba_itmno is not null	
--------- 	 order by  prd_reqno, prd_seq , prd_itemno

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
Union
						--SC Ass
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
select
'A' as 'prd_act', 
''  as 'prd_reqno', 
'' as 'prd_seq', 
'' as 'prd_pkgitm', 
'' as 'prd_pkgven',
isnull(sod_ordno,'') as 'sod_ordno',
''as 'tod_toordno',
soh_cus1no + ' - '  + cbi_cusnam as 'prh_cus1no',
sod_itmno as 'prd_itemno',
iba_assitm  as 'prd_assitm',
sod_cusitm as 'prd_cusitm',
sod_cussku as 'prd_sku',
iba_pckunt as 'um' ,
 iba_inrqty as 'inr', 
 iba_mtrqty as 'mst',
 sod_ftyprctrm as 'prd_ftyprctrm' , 
sod_hkprctrm as 'prd_hkprctrm',
sod_trantrm,
iba_colcde as 'prd_colcde',
sod_cuspo,
sod_ordqty * (iba_mtrqty /sod_mtrctn)as 'sctoqty',
--isnull(sod_ordqty,0) as 'sctoqty', 
sod_conftr,
'' as 'prd_ordqty',
''  as 'prd_wasqty',
0 as 'prd_ttlordqty',
'' as 'prd_curcde',
0 as 'prd_untprc', 
1 as 'prd_multip', 
'HKD' ,
0,
0 as 'peh_price'

	from scorddtl (nolock)
	 left join SCORDHDR (nolock) on sod_ordno = soh_ordno
	left join imbomass (nolock) on sod_itmno = iba_itmno and iba_typ = 'ASS'
		left join CUBASINF on cbi_cusno = soh_cus1no
	where 
  ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and soh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
 	and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and soh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
	and ((@flg_scno_table = 'N' and ltrim(rtrim(@sccde)) = '' ) or (@flg_scno_table = 'N' and ltrim(rtrim(@sccde)) <> ''  and 1 > 2)    or (@flg_scno_table = 'Y' and sod_ordno  is not null and sod_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
	and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and sod_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
	and ((@flg_skuno_table = 'N') or (@flg_skuno_table = 'Y' and sod_cussku in (select tmp_skuno from #TEMP_skuno (nolock))))
	and ((@flg_cussno_table = 'N') or (@flg_cussno_table = 'Y' and sod_cusstyno in (select tmp_cussno from #TEMP_cussno (nolock))))
	and ((@flg_cocde_table = 'N') or (@flg_cocde_table ='Y' and soh_cocde in (select tmp_code from #TEMP_CODELIST(nolock))))
	and iba_itmno is not null
	order by prd_itemno,prd_assitm
	--and sod_itmtyp = 'Ass'		
	--and tod_latest = 'Y'
	--and prh_status ='REL'
	--and toh_ordsts not in  ('CLO','CAN')
	--and iba_itmno is not null	
--------- 	 order by  prd_reqno, prd_seq , prd_itemno


end

else---------------- to part, from 4 unoin--------------------------------------------

begin  
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
	--to reg
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
select	
'A' as 'prd_act', 
''  as 'prd_reqno', 
'' as 'prd_seq', 
'' as 'prd_pkgitm', 
'' as 'prd_pkgven',
isnull(s.sod_ordno,'') as 'sod_ordno',
tod_toordno as 'tod_toordno',
toh_cus1no+ ' - '  + cbi_cusnam as 'prh_cus1no',
tod_ftyitmno as 'prd_itemno',
'' as 'prd_assitm',
'' as 'prd_cusitm',
 tod_itmsku as 'prd_sku',
tod_pckunt as 'um' ,
tod_inrqty as 'inr', 
tod_mtrqty as 'mst',
tod_ftyprctrm as 'prd_ftyprctrm' , 
tod_hkprctrm as 'prd_hkprctrm',
tod_trantrm as  'sod_trantrm',
tod_colcde as 'prd_colcde',
tod_cuspono as 'sod_cuspo',
tod_projqty as  'sctoqty',
tod_conftr as 'sod_conftr',
'' as 'prd_ordqty',
''  as 'prd_wasqty',
0 as 'prd_ttlordqty',
'' as 'prd_curcde',
0 as 'prd_untprc', 
1 as 'prd_multip', 
'HKD' ,
0,
0 as 'peh_price'

from TOORDDTL t
left join toordhdr on toh_toordno = tod_toordno
left join #TEMP_SC_TO_RELATION_DTL rd on t.tod_toordno = rd.sod_tordno and t.tod_toordseq = rd.sod_tordseq
left join SCORDDTL s on s.sod_ordno = rd.sod_ordno and s.sod_ordseq = rd.sod_ordseq
	left join CUBASINF on cbi_cusno = toh_cus1no
where 
((@flg_tono_table = 'N' and ltrim(rtrim(@tocde)) = '' ) or (@flg_tono_table = 'N' and ltrim(rtrim(@tocde)) <> ''  and 1 > 2)  or (@flg_tono_table = 'Y'   and tod_toordno  in (select tmp_tono from #TEMP_TONO (nolock))))
and tod_latest = 'Y'
and   ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and toh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
 	and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and toh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
--	and ((@flg_scno_table = 'N' and ltrim(rtrim(@codelist)) <> ''  and 1 > 2) or (@flg_scno_table = 'Y' and sod_ordno  is not null and sod_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
	and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and tod_ftyitmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
	and ((@flg_skuno_table = 'N') or (@flg_skuno_table = 'Y' and tod_itmsku in (select tmp_skuno from #TEMP_skuno (nolock))))
	--and ((@flg_cussno_table = 'N') or (@flg_cussno_table = 'Y' and tod_cusstyno in (select tmp_cussno from #TEMP_cussno (nolock))))
	and ((@flg_cocde_table = 'N') or (@flg_cocde_table ='Y' and toh_cocde in (select tmp_code from #TEMP_CODELIST(nolock))))
--	and sod_itmtyp = 'REG'	

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
Union -- sc regular
 -------------------------------------------------------------------------------
-------------------------------------------------------------------------------

select	
'A' as 'prd_act', 
''  as 'prd_reqno', 
'' as 'prd_seq', 
'' as 'prd_pkgitm', 
'' as 'prd_pkgven',
isnull(s.sod_ordno,'') as 'sod_ordno',
''as 'tod_toordno',
soh_cus1no+ ' - '  + cbi_cusnam as 'prh_cus1no',
sod_itmno as 'prd_itemno',
'' as 'prd_assitm',
sod_cusitm as 'prd_cusitm',
sod_cussku as 'prd_sku',
sod_pckunt as 'um' ,
sod_inrctn as 'inr', 
sod_mtrctn as 'mst',
sod_ftyprctrm as 'prd_ftyprctrm' , 
sod_hkprctrm as 'prd_hkprctrm',
sod_trantrm,
sod_colcde as 'prd_colcde',
sod_cuspo,
isnull(sod_ordqty,0) as 'sctoqty',
sod_conftr,
'' as 'prd_ordqty',
''  as 'prd_wasqty',
0 as 'prd_ttlordqty',
'' as 'prd_curcde',
0 as 'prd_untprc', 
1 as 'prd_multip', 
'HKD' ,
0,
0 as 'peh_price'
from #TEMP_SC_TO_RELATION r
left join SCORDDTL s on s.sod_ordno = r.sod_ordno
left join SCORDHDR on s.sod_ordno = soh_ordno
left join #TEMP_SC_TO_RELATION_DTL rd on rd.sod_ordno = s.sod_ordno and rd.sod_ordseq = s.sod_ordseq
	left join CUBASINF on cbi_cusno = soh_cus1no
--where rd.sod_ordseq <> s.sod_ordseq
where 
--r.sod_tordno = @TONo
((@flg_tono_table = 'N' and ltrim(rtrim(@tocde)) = '' ) or (@flg_tono_table = 'N' and ltrim(rtrim(@tocde)) <> ''  and 1 > 2)  or (@flg_tono_table = 'Y'  and r.sod_tordno  in (select tmp_tono from #TEMP_TONO (nolock))))
and rd.sod_tordno is null
and   ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and soh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
 	and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and soh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
--	and ((@flg_scno_table = 'N' and ltrim(rtrim(@codelist)) <> ''  and 1 > 2) or (@flg_scno_table = 'Y' and sod_ordno  is not null and sod_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
	and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and sod_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
	and ((@flg_skuno_table = 'N') or (@flg_skuno_table = 'Y' and sod_cussku in (select tmp_skuno from #TEMP_skuno (nolock))))
	--and ((@flg_cussno_table = 'N') or (@flg_cussno_table = 'Y' and tod_cusstyno in (select tmp_cussno from #TEMP_cussno (nolock))))
	and ((@flg_cocde_table = 'N') or (@flg_cocde_table ='Y' and soh_cocde in (select tmp_code from #TEMP_CODELIST(nolock))))
	
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
Union
						--to Ass
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
select
'A' as 'prd_act', 
''  as 'prd_reqno', 
'' as 'prd_seq', 
'' as 'prd_pkgitm', 
'' as 'prd_pkgven',
isnull(s.sod_ordno,'') as 'sod_ordno',
tod_toordno as 'tod_toordno',
toh_cus1no + ' - '  + cbi_cusnam as 'prh_cus1no',
tod_ftyitmno as 'prd_itemno',
iba_assitm as 'prd_assitm',
'' as 'prd_cusitm',
'' as 'prd_sku',
iba_pckunt as 'um' ,
 iba_inrqty as 'inr', 
 iba_mtrqty as 'mst',
 tod_ftyprctrm as 'prd_ftyprctrm' , 
tod_hkprctrm  as 'prd_hkprctrm',
tod_trantrm  as 'sod_trantrm',
tod_colcde as 'prd_colcde',
'' as 'sod_cuspo',
tod_projqty * (iba_mtrqty / tod_mtrqty)		 as 'sctoqty',
--isnull(sod_ordqty,0) as 'sctoqty',
1 as 'sod_conftr',
'' as 'prd_ordqty',
''  as 'prd_wasqty',
0 as 'prd_ttlordqty',
'' as 'prd_curcde',
0 as 'prd_untprc', 
1 as 'prd_multip', 
'HKD' ,
0,
0 as 'peh_price'

from TOORDDTL t
left join toordhdr on toh_toordno = tod_toordno
left join #TEMP_SC_TO_RELATION_DTL rd on t.tod_toordno = rd.sod_tordno and t.tod_toordseq = rd.sod_tordseq
left join SCORDDTL s on s.sod_ordno = rd.sod_ordno and s.sod_ordseq = rd.sod_ordseq
left join imbomass (nolock) on tod_ftyitmno = iba_itmno and iba_typ = 'ASS'
	left join CUBASINF on cbi_cusno = toh_cus1no
where 
((@flg_tono_table = 'N' and ltrim(rtrim(@tocde)) = '' ) or (@flg_tono_table = 'N' and ltrim(rtrim(@tocde)) <> ''  and 1 > 2)  or (@flg_tono_table = 'Y'  and t.tod_toordno  in (select tmp_tono from #TEMP_TONO (nolock))))
and tod_latest = 'Y'  
and iba_itmno is not null
and   ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and toh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
 	and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and toh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
--	and ((@flg_scno_table = 'N' and ltrim(rtrim(@codelist)) <> ''  and 1 > 2) or (@flg_scno_table = 'Y' and sod_ordno  is not null and sod_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
	and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and tod_ftyitmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
	and ((@flg_skuno_table = 'N') or (@flg_skuno_table = 'Y' and tod_itmsku in (select tmp_skuno from #TEMP_skuno (nolock))))
	--and ((@flg_cussno_table = 'N') or (@flg_cussno_table = 'Y' and tod_cusstyno in (select tmp_cussno from #TEMP_cussno (nolock))))
	and ((@flg_cocde_table = 'N') or (@flg_cocde_table ='Y' and toh_cocde in (select tmp_code from #TEMP_CODELIST(nolock))))

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
Union
			-- sc ass
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
select
'A' as 'prd_act', 
''  as 'prd_reqno', 
'' as 'prd_seq', 
'' as 'prd_pkgitm', 
'' as 'prd_pkgven',
isnull(s.sod_ordno,'') as 'sod_ordno',
''as 'tod_toordno',
soh_cus1no+ ' - '  + cbi_cusnam as 'prh_cus1no',
sod_itmno as 'prd_itemno',
iba_assitm  as 'prd_assitm',
sod_cusitm as 'prd_cusitm',
sod_cussku as 'prd_sku',
iba_pckunt as 'um' ,
 iba_inrqty as 'inr', 
 iba_mtrqty as 'mst',
 sod_ftyprctrm as 'prd_ftyprctrm' , 
sod_hkprctrm as 'prd_hkprctrm',
sod_trantrm as 'sod_trantrm',
iba_colcde as 'prd_colcde',
sod_cuspo as 'sod_cuspo',
sod_ordqty * (iba_mtrqty /sod_mtrctn)as 'sctoqty',
--isnull(sod_ordqty,0) as 'sctoqty',
1 as 'sod_conftr',
'' as 'prd_ordqty',
''  as 'prd_wasqty',
0 as 'prd_ttlordqty',
'' as 'prd_curcde',
0 as 'prd_untprc', 
1 as 'prd_multip', 
'HKD' ,
0,
0 as 'peh_price'
 from #TEMP_SC_TO_RELATION r
left join SCORDDTL s on s.sod_ordno = r.sod_ordno
left join SCORDHDR on s.sod_ordno = soh_ordno
left join #TEMP_SC_TO_RELATION_DTL rd on rd.sod_ordno = s.sod_ordno and rd.sod_ordseq = s.sod_ordseq
left join imbomass (nolock) on s.sod_itmno  =  iba_itmno and iba_typ = 'ASS'
	left join CUBASINF on cbi_cusno = soh_cus1no
where 
((@flg_tono_table = 'N' and ltrim(rtrim(@tocde)) = '' ) or (@flg_tono_table = 'N' and ltrim(rtrim(@tocde)) <> ''  and 1 > 2)  or (@flg_tono_table = 'Y'  and r.sod_tordno  in (select tmp_tono from #TEMP_TONO (nolock))))
and rd.sod_tordno is null 
and iba_itmno is not null
and   ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and soh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
 	and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and soh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
--	and ((@flg_scno_table = 'N' and ltrim(rtrim(@codelist)) <> ''  and 1 > 2) or (@flg_scno_table = 'Y' and sod_ordno  is not null and sod_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
	and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and sod_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
	and ((@flg_skuno_table = 'N') or (@flg_skuno_table = 'Y' and sod_cussku in (select tmp_skuno from #TEMP_skuno (nolock))))
	--and ((@flg_cussno_table = 'N') or (@flg_cussno_table = 'Y' and tod_cusstyno in (select tmp_cussno from #TEMP_cussno (nolock))))
	and ((@flg_cocde_table = 'N') or (@flg_cocde_table ='Y' and soh_cocde in (select tmp_code from #TEMP_CODELIST(nolock))))

		order by prd_itemno,prd_assitm


end




drop table #TEMP_INIT 
drop table #TEMP_CUS1NO 
drop table #TEMP_CUS2NO 
drop table #TEMP_PKGREQ 
drop table #TEMP_PKGITM 
drop table #TEMP_PKGPRTCO 
drop table #TEMP_SCNO
drop table #TEMP_TONO
drop table #TEMP_ITMNO 
drop table #TEMP_CODELIST
drop table #TEMP_REPRINT

end


GO
GRANT EXECUTE ON [dbo].[sp_select_PGR00001_1] TO [ERPUSER] AS [dbo]
GO
