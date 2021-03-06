/****** Object:  StoredProcedure [dbo].[sp_select_PKA00004]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PKA00004]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PKA00004]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO















CREATE      procedure [dbo].[sp_select_PKA00004]
                                                                                                                                                                                                                                                                 
@code nvarchar(10),
@codelist nvarchar(1000),
@cus1nolist nvarchar(1000),
@cus2nolist nvarchar(1000),
@pkgorderlist nvarchar(1000),
@pkgitmlist nvarchar(1000),
@pkgprtco nvarchar(1000),
@sccde nvarchar(1000),
@tocde nvarchar(1000),
@ordissdatfm datetime,
@ordissdatto datetime,
@itmnolist nvarchar(1000),
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
@flg_ordissdat_fmto char(1),
@flg_itmno_table char(1)

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
create table #TEMP_PKGORDER (tmp_ordno nvarchar(20)) on [PRIMARY]
create table #TEMP_PKGITM (tmp_item nvarchar(20)) on [PRIMARY]
create table #TEMP_PKGPRTCO (tmp_venno nvarchar(20)) on [PRIMARY]
create table #TEMP_SCNO (tmp_scno nvarchar(20)) on [PRIMARY]
create table #TEMP_TONO (tmp_tono nvarchar(20)) on [PRIMARY]
create table #TEMP_ITMNO (tmp_itmno nvarchar(20)) on [PRIMARY]
create table #TEMP_REPRINT (tmp_ordno nvarchar(20),
				tmp_repordno nvarchar(200))
create table #TEMP_RESULT
(  rpttype nvarchar(20) ,
	sod_ordno nvarchar(20),
	tod_toordseq int ,
	 soh_cus1na nvarchar(100),
	soh_cus2na nvarchar(100),
	sod_itmno nvarchar(50),
	sod_assitm nvarchar(50),
	sod_itmsku nvarchar(50),
	sod_cusitm nvarchar(50),
	tod_colcde nvarchar(50),
	tod_itmdsc nvarchar(800),
	tod_pckunt nvarchar(50),
	tod_conftr int , 
	tod_inrqty int ,
	tod_mtrqty int,
	tod_projqty bigint,
	tod_curcde nvarchar(50),
	ttlpkgcost numeric(13,4) , 
	estcost numeric(13,4),
	estcur nvarchar(50),
	 pod_ordno nvarchar(50),
	pod_status nvarchar(50),
	PCO nvarchar(50),
	ysi_dsc nvarchar(300),
	pod_seq int, 
	pod_pkgitm nvarchar(50), 
	pod_engdsc nvarchar(300),
	pib_remark nvarchar(300),
 	pod_EInchL numeric(13,4),
	pod_EInchW numeric(13,4),
	 pod_EInchH numeric(13,4),
	 pod_EcmL numeric(13,4),
	 pod_EcmW numeric(13,4),
	 pod_EcmH numeric(13,4),
	pod_matral nvarchar(200),
	pod_tiknes nvarchar(200),
	pod_prtmtd nvarchar(200),
	pod_clrfot nvarchar(200),
	pod_finish nvarchar(400),
	WTTHEmoacur nvarchar(20),
	WTTHEMOA numeric(13,4) ,
	MOQ int,
	pod_ordqty int ,
	pod_wasqty int ,
	 pod_bonqty int ,
	pod_ttlordqty int ,
	UM nvarchar(20),
	pod_curcde nvarchar(20),
	pod_untprc numeric(11,6),
	poh_TtlDelamt numeric(13,4),
	poh_iremark nvarchar(1000),
	pod_Conmak nvarchar(300),
	HdrVen nvarchar(100),
	DtlVen nvarchar(100),
	prd_reqno nvarchar(20),
	prd_seq int,
	prd_ordqty int,
	was int,
	bon int,
	prd_ttlordqty int) on [PRIMARY]
 



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
else
begin

insert into #TEMP_SCNO
select 	--distinct 
sod_ordno
from SCORDDTL (nolock)

order by sod_ordno

end


--#TEMP_TONO
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
else
begin

insert into #TEMP_TONO
select 	--distinct 
tod_toordno
from TOORDDTL (nolock)

order by tod_toordno

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

---


--#TEMP_PKGORDER 
if ltrim(rtrim(@pkgorderlist)) <> ''
  begin
	delete from #TEMP_INIT

	set @strRemain = @pkgorderlist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select poh_ordno from PKORDHDR (nolock) where poh_ordno between @fm and @to
			
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select poh_ordno from PKORDHDR (nolock) where poh_ordno like @strPart
			 
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
			select poh_ordno from PKORDHDR (nolock) where poh_ordno between @fm and @to
			 
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select poh_ordno from PKORDHDR (nolock)  where poh_ordno like @strRemain
			 
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_PKGORDER 
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
			insert into #TEMP_INIT values (@strRemain)
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

if @ordissdatfm <> '1900/01/01'
begin
	set @flg_ordissdat_fmto  = 'Y'
	set @ordissdatto = dateadd(DD,1,@ordissdatto)
end
else
begin
	set @flg_ordissdat_fmto  = 'N'
end

if (select count(*) from #TEMP_ITMNO) >= 1
	set @flg_itmno_table = 'Y'
else
	set @flg_itmno_table = 'N'

if (select count(*) from #TEMP_PKGORDER ) >= 1
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


--test
--select @flg_scno_table	 as '123'
--select @flg_scissdat_fmto
--select @flg_cus1no_table
--select @flg_cus2no_table
--select @flg_scno_table
--select @flg_tono_table
--select @flg_itmno_table



--TO
insert into #TEMP_RESULT
select 'TO' as 'rpttype',
	tod_toordno as 'sod_ordno',
	tod_toordseq as 'seq' ,
	isnull(pri.cbi_cussna,'') as 'soh_cus1na',
	isnull(sec.cbi_cussna,'') as 'soh_cus2na',
	tod_ftyitmno as 'sod_itmno',
	'' as 'sod_assitm',
	tod_itmsku as 'sod_itmsku',
	'' as 'sod_cusitm',
	tod_colcde as 'sod_colcde',
	tod_itmdsc as 'sod_itmdsc',
	tod_pckunt as 'sod_pckunt',
	tod_conftr as 'sod_conftr' , 
	tod_inrqty as 'sod_inrqty' ,
	tod_mtrqty as 'sod_mtrqty',
	tod_projqty as 'sod_ordqty',
	tod_curcde as 'sod_curcde',
	case isnull(prd_assitm,'') when ''  then tod_pckcst  else 0 end as 'ttlpkgcost?' , 
	 isnull(peh_price,0) as 'estcost?',
	isnull(peh_curcde,'') as 'estcur',
	isnull(pod_ordno,'') as 'pod_ordno',
	isnull(poh_status,'') as 'pod_status',
	isnull(PC.vbi_vensna,'')as 'PCO',
	isnull(ysi_dsc,'') as 'ysi_dsc',
	isnull(pod_seq,0) as 'pod_seq', 
	isnull(pod_pkgitm,'') as 'pod_pkgitm', 
	isnull(pod_engdsc,'') as 'pod_engdsc',
	isnull(pib_remark,'') as 'pib_remark',
 	isnull(pod_EInchL,0) as 'pod_EInchL',
	isnull(pod_EinchW,0)as 'pod_EInchW',
	isnull(pod_EinchH,0)as 'pod_EInchH',
	isnull(pod_EcmL,0)as 'pod_EcmL',
	isnull(pod_EcmW,0)as 'pod_EcmW',
	isnull(pod_EcmH,0)as 'pod_EcmH',
	isnull(pod_matral,'') as 'pod_matral',
	isnull(pod_tiknes,'') as 'pod_tiknes',
	isnull(pod_prtmtd,'') as 'pod_prtmtd',
	isnull(pod_clrfot,'')as 'pod_clrfot',
	isnull(pod_finish,'')as 'pod_finish',
	isnull(pod_curcde,'') as 'WT THE moacur',
	isnull(pod_moa,0) as 'WT THE MOA' ,
	isnull(ypc_moq,0) as 'MOQ',
	 isnull(pod_ordqty,0) as 'pod_ordqty' ,
	isnull(pod_wasqty,0) as 'pod_wasqty',
	isnull(pod_bonqty,0) as 'pod_bonqty',
	isnull(pod_ttlordqty,0)as 'pod_ttlordqty',
	isnull(pod_qtyum,'') as 'UM',
	isnull(pod_curcde,'')as 'pod_curcde',
	isnull(pod_untprc,0)as 'pod_untprc',
	isnull(poh_TtlDelamt,0)as 'poh_TtlDelamt',
	isnull(poh_iremark,'')as 'poh_dremark',
	isnull(pod_Conmak,'')as 'pod_Conmak',
	isnull(HDR.vbi_vensna,'')as 'HdrVen',
	isnull(DTL.vbi_vensna,'')as 'DtlVen',
	isnull(prd_reqno,'')as 'prd_reqno',
	isnull(prd_seq,0) as 'prd_seq',
	isnull(prd_ordqty,0) as 'prd_ordqty',
	isnull(prd_wasqty,0) as 'was',
	isnull(prd_bonqty,0) as 'bon',
	isnull(prd_ttlordqty,0) as 'prd_ttlordqty'
	
	
from	TOORDDTL (nolock)  
	 left join TOORDHDR(nolock) on tod_toordno = toh_toordno
	left join CUBASINF pri(nolock) on pri.cbi_cusno = toh_cus1no
	left join CUBASINF sec(nolock) on sec.cbi_cusno = toh_cus2no
	left join PKREQDTL (nolock) on prd_SCTONO = tod_toordno and prd_SCTOSEQ = tod_toordseq and prd_assitm =''
	left join PKORDDTL (nolock) on prd_ordno = pod_ordno and prd_ordseq = pod_seq
	left join PKORDHDR (nolock) on poh_ordno = pod_ordno
	left join PKIMBAIF (nolock) on pib_pgitmno = pod_pkgitm
	left join SYSETINF (nolock) on ysi_typ ='19' and ysi_cde = pib_season
	left join VNBASINF HDR (nolock) on poh_fty = HDR.vbi_venno  
	left join VNBASINF DTL (nolock) on pod_fty = DTL.vbi_venno
	left join SYPAKCAT (nolock) on pib_cate = ypc_code
	left join PKESDTL (nolock) on ped_reqno = prd_reqno and ped_reqseq = prd_seq
	left join VNBASINF PC (nolock) on poh_PKgven = PC.vbi_venno
	left join PKESHDR (nolock) on peh_reqno = ped_reqno and 
					peh_itemno = ped_itemno and 
					peh_assitm = ped_assitm and 
					peh_tmpitmno = ped_tmpitmno and 
					peh_venno = ped_venno and 
					peh_venitm = ped_venitm
	where 
	(
	(@flg_ordissdat_fmto  = 'N') 
	or
	 (@flg_ordissdat_fmto  = 'Y' and (poh_issdat between @ordissdatfm  and @ordissdatto  ))
	)
	and  ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and toh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
 	and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and toh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
--	and ((@flg_scno_table = 'N') or (@flg_scno_table = 'Y' and sod_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
	and ((@flg_tono_table = 'N') or (@flg_tono_table = 'Y' and tod_toordno in (select tmp_tono from #TEMP_TONO (nolock))))
	and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and tod_ftyitmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
	and ((@flg_pkgorder_table  = 'N') or (@flg_pkgorder_table  = 'Y' and poh_ordno in (select tmp_ordno  from #TEMP_PKGORDER (nolock))))
	and ((@flg_pkgitm_table = 'N') or (@flg_pkgitm_table  = 'Y' and pib_pgitmno in (select  tmp_item  from #TEMP_PKGITM (nolock))))
	and ((@flg_pkgprtco_table ='N') or (@flg_pkgprtco_table  ='Y' and poh_PKGven in (select tmp_venno from #TEMP_PKGPRTCO (nolock))))
	and ((@flg_cocde_table = 'N') or (@flg_cocde_table ='Y' and toh_cocde in (select tmp_code from #TEMP_CODELIST(nolock))))
	and tod_latest = 'Y'
	and poh_status <> null
	--and poh_status ='REL'
	--and toh_ordsts not in  ('CLO','CAN')
	--and iba_itmno <> null	
 	 
union 
--SC
	select 'SC' as 'rpttype',
	sod_ordno as 'sod_ordno',
	sod_ordseq as 'seq' ,
	isnull(pri.cbi_cussna,'') as 'soh_cus1na',
	isnull(sec.cbi_cussna,'') as 'soh_cus2na',
	sod_itmno as 'sod_itmno',
	'' as 'sod_assitm',
	sod_cussku as 'sod_itmsku',
	sod_cusitm as 'sod_cusitm',
	sod_colcde as 'sod_colcde',
	sod_itmdsc as 'sod_itmdsc',
	sod_pckunt as 'sod_pckunt',
	sod_conftr as 'prd_conftr' , 
	sod_inrctn as 'sod_inrqty' ,
	sod_mtrctn as 'sod_mtrqty',
	sod_ordqty  as 'sod_ordqty',
	sod_curcde as 'sod_curcde',
	--sod_pckcst as 'ttlpkgcost?' , 
	case isnull(prd_assitm,'') when ''  then sod_pckcst  else 0 end as 'ttlpkgcost?' , 
	 isnull(peh_price,0) as 'estcost?',
	isnull(peh_curcde,'') as 'estcur',
	isnull(pod_ordno,'') as 'pod_ordno',
	isnull(poh_status,'') as 'pod_status',
	isnull(PC.vbi_vensna,'')as 'PCO',
	isnull(ysi_dsc,'') as 'ysi_dsc',
	isnull(pod_seq,0) as 'pod_seq', 
	isnull(pod_pkgitm,'') as 'pod_pkgitm', 
	isnull(pod_engdsc,'') as 'pod_engdsc',
	isnull(pib_remark,'') as 'pib_remark',
 	isnull(pod_EInchL,0) as 'pod_EInchL',
	isnull(pod_EinchW,0)as 'pod_EInchW',
	isnull(pod_EinchH,0)as 'pod_EInchH',
	isnull(pod_EcmL,0)as 'pod_EcmL',
	isnull(pod_EcmW,0)as 'pod_EcmW',
	isnull(pod_EcmH,0)as 'pod_EcmH',
	isnull(pod_matral,'') as 'pod_matral',
	isnull(pod_tiknes,'') as 'pod_tiknes',
	isnull(pod_prtmtd,'') as 'pod_prtmtd',
	isnull(pod_clrfot,'')as 'pod_clrfot',
	isnull(pod_finish,'')as 'pod_finish',
	isnull(pod_curcde,'') as 'WT THE moacur',
	isnull(pod_MOA,0) as 'WT THE MOA' ,
	isnull(ypc_moq,0) as 'MOQ',
	 isnull(pod_ordqty,0) as 'pod_ordqty' ,
	isnull(pod_wasqty,0) as 'pod_wasqty',
	isnull(pod_bonqty,0) as 'pod_bonqty',
	isnull(pod_ttlordqty,0)as 'pod_ttlordqty',
	isnull(pod_qtyum,'') as 'UM',
	isnull(pod_curcde,'')as 'pod_curcde',
	isnull(pod_untprc,0)as 'pod_untprc',
	isnull(poh_TtlDelamt,0)as 'poh_TtlDelamt',
	isnull(poh_iremark,'')as 'poh_dremark',
	isnull(pod_Conmak,'')as 'pod_Conmak',
	isnull(HDR.vbi_vensna,'')as 'HdrVen',
	isnull(DTL.vbi_vensna,'')as 'DtlVen',
	isnull(prd_reqno,'')as 'prd_reqno',
	isnull(prd_seq,0) as 'prd_seq',
	isnull(prd_ordqty,0) as 'prd_ordqty',
	isnull(prd_wasqty,0) as 'was',
	isnull(prd_bonqty,0) as 'bon',
	isnull(prd_ttlordqty,0) as 'prd_ttlordqty'
	
	
from	SCORDDTL (nolock)  
	 left join SCORDHDR (nolock) on sod_ordno = soh_ordno
	left join CUBASINF pri(nolock) on pri.cbi_cusno = soh_cus1no
	left join CUBASINF sec(nolock) on sec.cbi_cusno = soh_cus2no
	left join PKREQDTL (nolock) on prd_SCTONO = sod_ordno and prd_SCTOSEQ = sod_ordseq and prd_assitm =''
	left join PKORDDTL (nolock) on prd_ordno = pod_ordno and prd_ordseq = pod_seq
	left join PKORDHDR (nolock) on poh_ordno = pod_ordno
	left join PKIMBAIF (nolock) on pib_pgitmno = pod_pkgitm
	left join SYSETINF (nolock) on ysi_typ ='19' and ysi_cde = pib_season
	left join VNBASINF HDR (nolock) on poh_fty = HDR.vbi_venno  
	left join VNBASINF DTL (nolock) on pod_fty = DTL.vbi_venno
	left join SYPAKCAT (nolock) on pib_cate = ypc_code
	left join PKESDTL (nolock) on ped_reqno = prd_reqno and ped_reqseq = prd_seq
	left join VNBASINF PC (nolock) on poh_PKgven = PC.vbi_venno
	left join PKESHDR (nolock) on peh_reqno = ped_reqno and 
					peh_itemno = ped_itemno and 
					peh_assitm = ped_assitm and 
					peh_tmpitmno = ped_tmpitmno and 
					peh_venno = ped_venno and 
					peh_venitm = ped_venitm
	where 
	(
	(@flg_ordissdat_fmto  = 'N') 
	or
	 (@flg_ordissdat_fmto  = 'Y' and (poh_issdat between @ordissdatfm  and @ordissdatto  ))
	)
	and  ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and soh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
 	and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and soh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
	and ((@flg_scno_table = 'N') or (@flg_scno_table = 'Y' and sod_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
--	and ((@flg_tono_table = 'N') or (@flg_tono_table = 'Y' and tod_toordno in (select tmp_tono from #TEMP_TONO (nolock))))
	and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and sod_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
	and ((@flg_pkgorder_table  = 'N') or (@flg_pkgorder_table  = 'Y' and poh_ordno in (select tmp_ordno  from #TEMP_PKGORDER (nolock))))
	and ((@flg_pkgitm_table = 'N') or (@flg_pkgitm_table  = 'Y' and pib_pgitmno in (select  tmp_item  from #TEMP_PKGITM (nolock))))
	and ((@flg_pkgprtco_table ='N') or (@flg_pkgprtco_table  ='Y' and poh_PKGven in (select tmp_venno from #TEMP_PKGPRTCO (nolock))))
	and ((@flg_cocde_table = 'N') or (@flg_cocde_table ='Y' and soh_cocde in (select tmp_code from #TEMP_CODELIST(nolock))))
	and 
	 poh_status <> null
	--and tod_latest = 'Y'
	--and poh_status ='REL'
	--and toh_ordsts not in  ('CLO','CAN')
	--and iba_itmno <> null	
 	 --order by pod_ordno
union
-- TO ASS

select 'TO' as 'rpttype',
	tod_toordno as 'sod_ordno',
	tod_toordseq as 'seq',
	isnull(pri.cbi_cussna,'') as 'soh_cus1na',
	isnull(sec.cbi_cussna,'') as 'soh_cus2na',
	tod_ftyitmno as 'sod_itmno',
	iba_assitm as 'sod_assitm',
	'' as 'sod_itmsku',
	'' as 'sod_cusitm',
	iba_colcde as 'sod_colcde',
	'' as 'sod_itmdsc',
	iba_pckunt as 'sod_pckunt',
	1 as 'sod_conftr' , --0
	iba_inrqty as 'sod_inrqty' ,
	iba_mtrqty as 'sod_mtrqty',
	tod_projqty * (iba_mtrqty / tod_mtrqty) as 'sod_ordqty',
	tod_curcde as 'sod_curcde',
	--tod_pckcst as 'ttlpkgcost?' , 
	case isnull(prd_assitm,'') when ''  then tod_pckcst  else 0 end as 'ttlpkgcost?' , 
	 isnull(peh_price,0) as 'estcost?',
	isnull(peh_curcde,'') as 'estcur',
	isnull(pod_ordno,'') as 'pod_ordno',
	isnull(poh_status,'') as 'pod_status',
	isnull(PC.vbi_vensna,'')as 'PCO',
	isnull(ysi_dsc,'') as 'ysi_dsc',
	isnull(pod_seq,0) as 'pod_seq', 
	isnull(pod_pkgitm,'') as 'pod_pkgitm', 
	isnull(pod_engdsc,'') as 'pod_engdsc',
	isnull(pib_remark,'') as 'pib_remark',
 	isnull(pod_EInchL,0) as 'pod_EInchL',
	isnull(pod_EinchW,0)as 'pod_EInchW',
	isnull(pod_EinchH,0)as 'pod_EInchH',
	isnull(pod_EcmL,0)as 'pod_EcmL',
	isnull(pod_EcmW,0)as 'pod_EcmW',
	isnull(pod_EcmH,0)as 'pod_EcmH',
	isnull(pod_matral,'') as 'pod_matral',
	isnull(pod_tiknes,'') as 'pod_tiknes',
	isnull(pod_prtmtd,'') as 'pod_prtmtd',
	isnull(pod_clrfot,'')as 'pod_clrfot',
	isnull(pod_finish,'')as 'pod_finish',
	isnull(pod_curcde,'') as 'WT THE moacur',
	isnull(pod_MOA,0) as 'WT THE MOA' ,
	isnull(ypc_moq,0) as 'MOQ',
	 isnull(pod_ordqty,0) as 'pod_ordqty' ,
	isnull(pod_wasqty,0) as 'pod_wasqty',
	isnull(pod_bonqty,0) as 'pod_bonqty',
	isnull(pod_ttlordqty,0)as 'pod_ttlordqty',
	isnull(pod_qtyum,'') as 'UM',
	isnull(pod_curcde,'')as 'pod_curcde',
	isnull(pod_untprc,0)as 'pod_untprc',
	isnull(poh_TtlDelamt,0)as 'poh_TtlDelamt',
	isnull(poh_iremark,'')as 'poh_dremark',
	isnull(pod_Conmak,'')as 'pod_Conmak',
	isnull(HDR.vbi_vensna,'')as 'HdrVen',
	isnull(DTL.vbi_vensna,'')as 'DtlVen',
	isnull(prd_reqno,'')as 'prd_reqno',
	isnull(prd_seq,0) as 'prd_seq',
	isnull(prd_ordqty,0) as 'prd_ordqty',
	isnull(prd_wasqty,0) as 'was',
	isnull(prd_bonqty,0) as 'bon',
	isnull(prd_ttlordqty,0) as 'prd_ttlordqty'
	
	
from	TOORDDTL (nolock)  
	left join IMBOMASS (nolock) on tod_ftyitmno = iba_itmno and iba_typ = 'ASS'
	 left join TOORDHDR(nolock) on tod_toordno = toh_toordno
	left join CUBASINF pri(nolock) on pri.cbi_cusno = toh_cus1no
	left join CUBASINF sec(nolock) on sec.cbi_cusno = toh_cus2no
	left join PKREQDTL (nolock) on prd_SCTONO = tod_toordno and prd_SCTOSEQ = tod_toordseq and prd_assitm = iba_assitm and prd_colcde = iba_colcde
	left join PKORDDTL (nolock) on prd_ordno = pod_ordno and prd_ordseq = pod_seq
	left join PKORDHDR (nolock) on poh_ordno = pod_ordno
	left join PKIMBAIF (nolock) on pib_pgitmno = pod_pkgitm
	left join SYSETINF (nolock) on ysi_typ ='19' and ysi_cde = pib_season
	left join VNBASINF HDR (nolock) on poh_fty = HDR.vbi_venno  
	left join VNBASINF DTL (nolock) on pod_fty = DTL.vbi_venno
	left join SYPAKCAT (nolock) on pib_cate = ypc_code
	left join PKESDTL (nolock) on ped_reqno = prd_reqno and ped_reqseq = prd_seq
	 left join VNBASINF PC (nolock) on poh_PKgven = PC.vbi_venno
	left join PKESHDR (nolock) on peh_reqno = ped_reqno and 
					peh_itemno = ped_itemno and 
					peh_assitm = ped_assitm and 
					peh_tmpitmno = ped_tmpitmno and 
					peh_venno = ped_venno and 
					peh_venitm = ped_venitm
	where 
	(
	(@flg_ordissdat_fmto  = 'N') 
	or
	 (@flg_ordissdat_fmto  = 'Y' and (poh_issdat between @ordissdatfm  and @ordissdatto  ))
	)
	and  ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and toh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
 	and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and toh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
--	and ((@flg_scno_table = 'N') or (@flg_scno_table = 'Y' and sod_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
	and ((@flg_tono_table = 'N') or (@flg_tono_table = 'Y' and tod_toordno in (select tmp_tono from #TEMP_TONO (nolock))))
	and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and tod_ftyitmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
	and ((@flg_pkgorder_table  = 'N') or (@flg_pkgorder_table  = 'Y' and poh_ordno in (select tmp_ordno  from #TEMP_PKGORDER (nolock))))
	and ((@flg_pkgitm_table = 'N') or (@flg_pkgitm_table  = 'Y' and pib_pgitmno in (select  tmp_item  from #TEMP_PKGITM (nolock))))
	and ((@flg_pkgprtco_table ='N') or (@flg_pkgprtco_table  ='Y' and poh_PKGven in (select tmp_venno from #TEMP_PKGPRTCO (nolock))))
	and ((@flg_cocde_table = 'N') or (@flg_cocde_table ='Y' and toh_cocde in (select tmp_code from #TEMP_CODELIST(nolock))))
	and tod_latest = 'Y'
	and poh_status <> null
	and iba_itmno <> null	
	--and poh_status ='REL'
	--and toh_ordsts not in  ('CLO','CAN')
	--and iba_itmno <> null	
union

--SC ASS
	select 'SC' as 'rpttype',
	sod_ordno as 'sod_ordno',
	sod_ordseq as 'seq' ,
	isnull(pri.cbi_cussna,'') as 'soh_cus1na',
	isnull(sec.cbi_cussna,'') as 'soh_cus2na',
	sod_itmno as 'sod_itmno',
	iba_assitm as 'sod_assitm',
	'' as 'sod_itmsku',
	'' as 'sod_cusitm',
	iba_colcde as 'sod_colcde',
	'' as 'sod_itmdsc',
	iba_pckunt as 'sod_pckunt',
	1 as 'sod_conftr' , --0
	iba_inrqty as 'sod_inrqty' ,
	iba_mtrqty as 'sod_mtrqty',
	sod_ordqty * (iba_mtrqty / sod_mtrctn)  as 'sod_ordqty',
	sod_curcde as 'sod_curcde',
	--sod_pckcst as 'ttlpkgcost?' , 
	case isnull(prd_assitm,'') when ''  then sod_pckcst  else 0 end as 'ttlpkgcost?' ,
	 isnull(peh_price,0) as 'estcost?',
	isnull(peh_curcde,'') as 'estcur',
	isnull(pod_ordno,'') as 'pod_ordno',
	isnull(poh_status,'') as 'pod_status',
	isnull(PC.vbi_vensna,'')as 'PCO',
	isnull(ysi_dsc,'') as 'ysi_dsc',
	isnull(pod_seq,0) as 'pod_seq', 
	isnull(pod_pkgitm,'') as 'pod_pkgitm', 
	isnull(pod_engdsc,'') as 'pod_engdsc',
	isnull(pib_remark,'') as 'pib_remark',
 	isnull(pod_EInchL,0) as 'pod_EInchL',
	isnull(pod_EinchW,0)as 'pod_EInchW',
	isnull(pod_EinchH,0)as 'pod_EInchH',
	isnull(pod_EcmL,0)as 'pod_EcmL',
	isnull(pod_EcmW,0)as 'pod_EcmW',
	isnull(pod_EcmH,0)as 'pod_EcmH',
	isnull(pod_matral,'') as 'pod_matral',
	isnull(pod_tiknes,'') as 'pod_tiknes',
	isnull(pod_prtmtd,'') as 'pod_prtmtd',
	isnull(pod_clrfot,'')as 'pod_clrfot',
	isnull(pod_finish,'')as 'pod_finish',
	isnull(pod_curcde,'') as 'WT THE moacur',
	isnull(pod_MOA,0) as 'WT THE MOA' ,
	isnull(ypc_moq,0) as 'MOQ',
	 isnull(pod_ordqty,0) as 'pod_ordqty' ,
	isnull(pod_wasqty,0) as 'pod_wasqty',
	isnull(pod_bonqty,0) as 'pod_bonqty',
	isnull(pod_ttlordqty,0)as 'pod_ttlordqty',
	isnull(pod_qtyum,'') as 'UM',
	isnull(pod_curcde,'')as 'pod_curcde',
	isnull(pod_untprc,0)as 'pod_untprc',
	isnull(poh_TtlDelamt,0)as 'poh_TtlDelamt',
	isnull(poh_iremark,'')as 'poh_dremark',
	isnull(pod_Conmak,'')as 'pod_Conmak',
	isnull(HDR.vbi_vensna,'')as 'HdrVen',
	isnull(DTL.vbi_vensna,'')as 'DtlVen',
	isnull(prd_reqno,'')as 'prd_reqno',
	isnull(prd_seq,0) as 'prd_seq',
	isnull(prd_ordqty,0) as 'prd_ordqty',
	isnull(prd_wasqty,0) as 'was',
	isnull(prd_bonqty,0) as 'bon',
	isnull(prd_ttlordqty,0) as 'prd_ttlordqty'
	
	
from	SCORDDTL (nolock)  
	left join IMBOMASS (nolock) on sod_itmno  =  iba_itmno and iba_typ = 'ASS'
	 left join SCORDHDR (nolock) on sod_ordno = soh_ordno
	left join CUBASINF pri(nolock) on pri.cbi_cusno = soh_cus1no
	left join CUBASINF sec(nolock) on sec.cbi_cusno = soh_cus2no
	left join PKREQDTL (nolock) on prd_SCTONO = sod_ordno and prd_SCTOSEQ = sod_ordseq and prd_assitm = iba_assitm and prd_colcde = iba_colcde
	left join PKORDDTL (nolock) on prd_ordno = pod_ordno and prd_ordseq = pod_seq
	left join PKORDHDR (nolock) on poh_ordno = pod_ordno
	left join PKIMBAIF (nolock) on pib_pgitmno = pod_pkgitm
	left join SYSETINF (nolock) on ysi_typ ='19' and ysi_cde = pib_season
	left join VNBASINF HDR (nolock) on poh_fty = HDR.vbi_venno  
	left join VNBASINF DTL (nolock) on pod_fty = DTL.vbi_venno
	left join SYPAKCAT (nolock) on pib_cate = ypc_code
	left join PKESDTL (nolock) on ped_reqno = prd_reqno and ped_reqseq = prd_seq
	left join VNBASINF PC (nolock) on poh_PKgven = PC.vbi_venno
	left join PKESHDR (nolock) on peh_reqno = ped_reqno and 
					peh_itemno = ped_itemno and 
					peh_assitm = ped_assitm and 
					peh_tmpitmno = ped_tmpitmno and 
					peh_venno = ped_venno and 
					peh_venitm = ped_venitm
	where 
	(
	(@flg_ordissdat_fmto  = 'N') 
	or
	 (@flg_ordissdat_fmto  = 'Y' and (poh_issdat between @ordissdatfm  and @ordissdatto  ))
	)
	and  ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and soh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
 	and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and soh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
	and ((@flg_scno_table = 'N') or (@flg_scno_table = 'Y' and sod_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
--	and ((@flg_tono_table = 'N') or (@flg_tono_table = 'Y' and tod_toordno in (select tmp_tono from #TEMP_TONO (nolock))))
	and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and sod_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
	and ((@flg_pkgorder_table  = 'N') or (@flg_pkgorder_table  = 'Y' and poh_ordno in (select tmp_ordno  from #TEMP_PKGORDER (nolock))))
	and ((@flg_pkgitm_table = 'N') or (@flg_pkgitm_table  = 'Y' and pib_pgitmno in (select  tmp_item  from #TEMP_PKGITM (nolock))))
	and ((@flg_pkgprtco_table ='N') or (@flg_pkgprtco_table  ='Y' and poh_PKGven in (select tmp_venno from #TEMP_PKGPRTCO (nolock))))
	and ((@flg_cocde_table = 'N') or (@flg_cocde_table ='Y' and soh_cocde in (select tmp_code from #TEMP_CODELIST(nolock))))
	and 
	 poh_status <> null
	and iba_itmno <> null
	--and tod_latest = 'Y'
	--and poh_status ='REL'
	--and toh_ordsts not in  ('CLO','CAN')
	--and iba_itmno <> null	
 	 order by rpttype , sod_ordno , pod_ordno ,pod_seq , prd_reqno , prd_seq


------------------------------------------------ Reprint Order
declare @reprint_list nvarchar(500)
declare @tmp_reprint nvarchar(100)
declare @tmp_ordno nvarchar(20)
set @reprint_list = ''
set @tmp_reprint = ''
set @tmp_ordno = ''

declare cur_ordno cursor
for 
select distinct pod_ordno 
from #TEMP_RESULT(nolock)
--left join PKREPORD(nolock) on  pro_ordno = pod_ordno
 

open cur_ordno 
fetch next from cur_ordno into @tmp_ordno

while @@fetch_status = 0
begin

if @tmp_ordno <> ''
begin
	declare cur_reprintorder cursor
	for 
	select  pro_repord
	from PKREPORD(nolock)
	 where pro_ordno = @tmp_ordno

	open cur_reprintorder 
	fetch next from cur_reprintorder into @tmp_reprint

	while @@fetch_status = 0
	begin

	if @tmp_reprint <> ''
	begin
	set @reprint_list = @reprint_list + @tmp_reprint + ','
	
	end
	
	 

	fetch next from cur_reprintorder into @tmp_reprint
	end
	if @reprint_list <>''
	begin
	set @reprint_list =  LEFT(@reprint_list, LEN(@reprint_list) - 1)
	
	insert into #TEMP_REPRINT
	select @tmp_ordno, @reprint_list	
	end	
	set @reprint_list = ''
	set @tmp_reprint = ''
	set @tmp_ordno = ''	

	close cur_reprintorder
	deallocate cur_reprintorder
end

fetch next from cur_ordno into @tmp_ordno
end

close cur_ordno
deallocate cur_ordno
----------------------------------------------*/
 
select   rpttype  as 'rpttype' ,
	sod_ordno as 'sod_ordno' ,
	tod_toordseq as 'seq' ,
	 soh_cus1na as 'soh_cus1na',
	soh_cus2na as 'soh_cus2na',
	sod_itmno as 'sod_itmno',
	sod_assitm as 'sod_assitm',
	sod_itmsku as 'sod_itmsku',
	sod_cusitm as 'sod_cusitm',
	tod_colcde as 'sod_colcde',
	tod_itmdsc  as 'sod_itmdsc',
	tod_pckunt  as 'sod_pckunt',
	tod_conftr  as 'sod_conftr' , 
	tod_inrqty  as 'sod_inrqty' ,
	tod_mtrqty as 'sod_mtrqty',
	tod_projqty  as 'sod_ordqty',
	tod_curcde as 'sod_curcde',
	ttlpkgcost as 'ttlpkgcost?' , 
	estcost as 'estcost?',
	estcur as 'estcur',
	 pod_ordno as 'pod_ordno',
	pod_status as 'pod_status',
	PCO as 'PCO',
	ysi_dsc as 'ysi_dsc',
	pod_seq as 'pod_seq', 
	pod_pkgitm as 'pod_pkgitm', 
	pod_engdsc as 'pod_engdsc',
	pib_remark as 'pib_remark',
 	pod_EInchL as 'pod_EInchL',
	pod_EInchW as 'pod_EInchW',
	 pod_EInchH as 'pod_EInchH',
	 pod_EcmL as 'pod_EcmL',
	 pod_EcmW as 'pod_EcmW',
	 pod_EcmH as 'pod_EcmH',
	pod_matral as 'pod_matral',
	pod_tiknes as 'pod_tiknes',
	pod_prtmtd as 'pod_prtmtd',
	pod_clrfot as 'pod_clrfot',
	pod_finish as 'pod_finish',
	WTTHEmoacur as 'WT THE moacur',
	WTTHEMOA as 'WT THE MOA' ,
	MOQ as 'MOQ',
	pod_ordqty  as 'pod_ordqty' ,
	pod_wasqty as 'pod_wasqty',
	 pod_bonqty  as 'pod_bonqty',
	pod_ttlordqty as 'pod_ttlordqty',
	UM as 'UM',
	pod_curcde as 'pod_curcde',
	pod_untprc as 'pod_untprc',
	poh_TtlDelamt as 'poh_TtlDelamt',
	poh_iremark  as 'poh_dremark',
	pod_Conmak as 'pod_Conmak',
	HdrVen as 'HdrVen',
	DtlVen as 'DtlVen',
	prd_reqno as 'prd_reqno',
	prd_seq  as 'prd_seq',
	prd_ordqty   as 'prd_ordqty',
	was as 'was',
	bon as 'bon',
	prd_ttlordqty as 'prd_ttlordqty',
	--'' as 'pro_repord'
	tmp_repordno as 'pro_repord'
from #TEMP_RESULT(nolock)
left join #TEMP_REPRINT on tmp_ordno = pod_ordno
 order by rpttype , sod_ordno , pod_ordno ,pod_seq , prd_reqno , prd_seq


drop table #TEMP_INIT 
drop table #TEMP_CUS1NO 
drop table #TEMP_CUS2NO 
drop table #TEMP_PKGORDER 
drop table #TEMP_PKGITM 
drop table #TEMP_PKGPRTCO 
drop table #TEMP_SCNO
drop table #TEMP_TONO
drop table #TEMP_ITMNO 
drop table #TEMP_CODELIST
drop table #TEMP_RESULT
drop table #TEMP_REPRINT

end









GO
GRANT EXECUTE ON [dbo].[sp_select_PKA00004] TO [ERPUSER] AS [dbo]
GO
