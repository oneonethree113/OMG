/****** Object:  StoredProcedure [dbo].[sp_select_MSR00027_A]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_MSR00027_A]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_MSR00027_A]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create   PROCEDURE [dbo].[sp_select_MSR00027_A]
	@cocde nvarchar(6),
	@containlist nvarchar(1000),
	@pricuslist nvarchar(1000), 
	@seccustlist nvarchar(1000),
	@scnolist nvarchar(1000),
	@itmlist nvarchar(1000),
	@custitemlist nvarchar(1000),
	@pricetermlist nvarchar(1000),
	@custpolist nvarchar(1000),
	@etddatefm datetime, 
	@etddateto datetime,
	
	@opt_sort nvarchar(2),			-- 'C' => Customeer PO 'SS' => Ship Start Date 'SE' => Ship End DAte
	
	@usrid nvarchar(30),
	@SalTem nvarchar(7)
	
AS
BEGIN
	SET NOCOUNT ON
	
	CREATE table #TEMP_INIT(tmp_init nvarchar(1000)) on [PRIMARY]
	CREATE table #TEMP_CONT(tmp_cont nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_CUS1NO(tmp_cus1no nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_CUS2NO(tmp_cus2no nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_SCNO(tmp_scno nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_ITM(tmp_itmno nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_CUSITM(tmp_cusitm nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_SHIPTM(tmp_shiptm nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_CUSTPO(tmp_custpo nvarchar(50)) on [PRIMARY]

	DECLARE @token nvarchar(100)
	DECLARE @tmp_fm nvarchar(50)
	DECLARE @tmp_to nvarchar(50)
	

	
	declare	@fm nvarchar(100), @to nvarchar(100)
	set @fm = ''
	set @to = ''
	declare @strPart nvarchar(1000), @strRemain nvarchar(1000)
	set @strPart = ''
	set @strRemain = ''
	
	-- print @flg_shipstartdate_from
	-- print @flg_shipstartdate_to

	
	--*** Insert Temp Table Start ***--
	
--#TEMP_CONTAIN
if ltrim(rtrim(@containlist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @containlist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select hid_ctrcfs from SHIPGDTL where hid_ctrcfs between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select hid_ctrcfs from SHIPGDTL where hid_ctrcfs like @strPart
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
			select hid_ctrcfs from SHIPGDTL where hid_ctrcfs between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select hid_ctrcfs from SHIPGDTL where hid_ctrcfs like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_CONT
	select distinct tmp_init from #TEMP_INIT
end
	
	
	--#TEMP_CUS1NO
if ltrim(rtrim(@pricuslist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @pricuslist
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
if ltrim(rtrim(@seccustlist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @seccustlist
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





--#TEMP_SC_no
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
			select soh_ordno from SCORDHDR where soh_ordno between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select soh_ordno from SCORDHDR where soh_ordno like @strPart
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
if ltrim(rtrim(@itmlist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @itmlist
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
	insert into #TEMP_ITM
	select distinct tmp_init from #TEMP_INIT
end



--#TEMP_Customer Item
if ltrim(rtrim(@custitemlist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @custitemlist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select cis_itmno from CUITMHIS where cis_itmno between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select cis_itmno from CUITMHIS where cis_itmno like @strPart
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
			select cis_itmno from CUITMHIS where cis_itmno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select cis_itmno from CUITMHIS where cis_itmno like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_CUSITM
	select distinct tmp_init from #TEMP_INIT
end
	
	
--#TEMP_Price Term 
if ltrim(rtrim(@pricetermlist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @pricetermlist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select ysi_cde from SYSETINF where ysi_cde between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select ysi_cde from SYSETINF where ysi_cde like @strPart
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
			select ysi_cde from SYSETINF where ysi_cde between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select ysi_cde from SYSETINF where ysi_cde like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_SHIPTM
	select distinct tmp_init from #TEMP_INIT
end

	--#TEMP_Customer PO
if ltrim(rtrim(@custpolist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @custpolist
	while charindex(',', @strRemain) <> 0
	begin
		set @strPart = ltrim(left(@strRemain, charindex(',', @strRemain)-1))
		set @strRemain = right(@strRemain, len(@strRemain) - charindex(',', @strRemain))
		if charindex('~', @strPart) <> 0 
		begin
			set @fm = ltrim(left(@strPart, charindex('~', @strPart)-1))
			set @to = right(@strPart, len(@strPart) - charindex('~', @strPart))
			insert into #TEMP_INIT
			select case isnull(sod_cuspo,'') when '' then soh_cuspo else sod_cuspo end as 'sod_cuspo',
			soh_cuspo, sod_cuspo,
			* from SCORDHDR
			left join SCORDDTL on sod_ordno = soh_ordno where sod_cuspo between @fm and @to
		end
		else if charindex('%', @strPart) <> 0
		begin
			insert into #TEMP_INIT
			select case isnull(sod_cuspo,'') when '' then soh_cuspo else sod_cuspo end as 'sod_cuspo',
			soh_cuspo, sod_cuspo,
			* from SCORDHDR
			left join SCORDDTL on sod_ordno = soh_ordno where sod_cuspo like @strPart
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
			select ysi_cde from SYSETINF where ysi_cde between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select ysi_cde from SYSETINF where ysi_cde like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_CUSTPO
	select distinct tmp_init from #TEMP_INIT
end
	
	
	
	
	
	DECLARE @flg_contain char(1),
	@flg_pricust char(1),
	@flg_seccust char(1),
	@flg_scno char(1),
	@flg_item char(1),
	@flg_custitm char(1),
	@flg_shipterm char(1),
	@flg_custpo char(1),
	@flg_etddatefmto char(1)

if (select count(*) from #TEMP_CONT) >= 1
	set @flg_contain = 'Y'
else
	set @flg_contain = 'N'
	
if (select count(*) from #TEMP_CUS1NO) >= 1
	set @flg_pricust = 'Y'
else
	set @flg_pricust = 'N'

if (select count(*) from #TEMP_CUS2NO) >= 1
	set @flg_seccust = 'Y'
else
	set @flg_seccust = 'N'

if (select count(*) from #TEMP_SCNO) >= 1
	set @flg_scno = 'Y'
else
	set @flg_scno = 'N'

if (select count(*) from #TEMP_ITM) >= 1
	set @flg_item = 'Y'
else
	set @flg_item = 'N'

if (select count(*) from #TEMP_CUSITM) >= 1
	set @flg_custitm = 'Y'
else
	set @flg_custitm = 'N'
	
	
if (select count(*) from #TEMP_SHIPTM) >= 1
	set @flg_shipterm = 'Y'
else
	set @flg_shipterm = 'N'
	
if (select count(*) from #TEMP_CUSTPO) >= 1
	set @flg_custpo = 'Y'
else
	set @flg_custpo = 'N'
	
	
	
if @etddatefm <> '01/01/1900'
begin
	set @flg_etddatefmto = 'Y'
	set @etddateto = dateadd(DD,1,@etddateto)
end
else
begin
	set @flg_etddatefmto = 'N'
end

	create table #TEMP_SHIP_SQ
(
tmp_cocde	varchar(6),
tmp_shpno	varchar(20),
tmp_shpseq	int
)

if @flg_etddatefmto = 'Y'
begin

insert into #TEMP_SHIP_SQ
select distinct hid_cocde, hid_shpno, hid_shpseq
from SHIPGDTL (nolock), SHIPGHDR (nolock) where 
hih_slnonb between @etddatefm and @etddateto and
hih_cocde = hid_cocde and hid_shpno = hih_shpno
order by hid_shpno, hid_shpseq

end
else 
	
begin
insert into #TEMP_SHIP_SQ
select distinct hid_cocde, hid_shpno, hid_shpseq
from SHIPGDTL (nolock), SHIPGHDR (nolock) where
hih_cocde = hid_cocde and hid_shpno = hih_shpno
order by hid_shpno, hid_shpseq
end


	SET NOCOUNT OFF
	
	--*** Insert Temp Table Start ***--
	
	--Get Compnay Name
	Declare @compName as nvarchar(100)
	set @compName = 'UNITED CHINESE GROUP'
	if @cocde <> 'UC-G'
	BEGIN
		select @compName = yco_conam from SYCOMINF where yco_cocde = @cocde
	END

	--Temp table for storing SC That have discount/premium Start
	-- select distinct sdp_ordno INTO #tmp_dp from SCDISPRM
	--Temp table for storing SC That have discount/premium Start
	
	--Main Query Start
		
	SELECT distinct
		-- sod_ordno as 'SC',
		-- pod_jobord AS 'po',
		-- SOD_ordqty as 'soq',
		-- sod_selprc AS 'TTL AMOUNT',
		
		--Search Criteria
		@cocde as 's_cocde',
		@containlist as 's_containno',
		@pricuslist as 's_pricust',
		@seccustlist as 's_seccust',
		@scnolist as 's_scno',
		@itmlist as 's_item',
		@custitemlist as 's_custitm',
		@pricetermlist as 's_priceterm',
		@custpolist as 's_custpo',
		
		@etddatefm as 's_etddatefm',
		@etddateto as 's_etddateto',
		
		@opt_sort as 'opt_sort',
		--@opt_group as 'opt_group',
		@usrid as 'usrid',
		@SalTem AS 'SalTem',

		--groupKey = ltrim(hid_itmno) +  ltrim(hid_untcde) + ltrim(str(hid_inrctn)) + ltrim(str(hid_mtrctn)),

			-- SHIPGDTL
			hid_shpno as 'hid_shpno',
			hid_ctrcfs as 'hid_ctrcfs',
			hid_sealno as 'hid_sealno',
			hid_ctrsiz as 'hid_ctrsiz',
			hid_invno as 'hid_invno',
			hid_jobno as 'hid_jobno', 
			hid_cusitm as 'hid_cusitm',
			hid_itmdsc as 'hid_itmdsc',
			hid_shpqty as 'hid_shpqty',
			hid_purord  as 'hid_purord',
			hid_itmno as 'hid_itmno',
			--hid_colcde as 'hid_colcde',
			--hid_inrctn as 'hid_inrctn',
			--hid_mtrctn as 'hid_mtrctn',						
			--hid_ctnstr as 'hid_ctnstr',
			hid_ttlvol  as 'hid_ttlvol', 
			--  may need to check diff between SHPCKDIM hpd_ttlcbm_cm  --
			hid_ttlctn  as 'hid_ttlctn', 
			
			-- SCORDDTL
			sod_ordno as 'sod_ordno',
			sod_ordqty as 'sod_ordqty',
			case isnull(sod_cuspo,'') when '' then soh_cuspo else sod_cuspo end  as 'sod_cuspo',
			ISNULL(sod_venno + ' - ' + vn.vbi_vensna,'') as 'sod_venno',
			ISNULL(sod_examven +' - ' + vn2.vbi_vensna,'') as "sod_examven",
			
			
			-- SHINVHDR
			-- hiv_invdat as 'hiv_invdat',

			
			-- SYSETINF
			--pckunt = ysi_dsc,
			--@yco_conam as 'yco_connam' --Retrieve company information from database
			ysi_dsc as 'ysi_dsc',
			
			
			-- SHIPGHDR
			ISNULL(hih_cus1no +' - '+ c1.cbi_cussna,'') as 'hih_cus1no',
		    ISNULL(hih_cus2no +' - '+ c2.cbi_cussna,'') as 'hih_cus2no',
			hih_ves as 'hih_ves',
			hih_voy as 'hih_voy',
			hih_slnonb as 'hih_slnonb',
			hih_arrdat as 'hih_arrdat',
			hih_potloa as 'hih_potloa',
			hih_dst as 'hih_dst',
			
			-- SHPCKDIM
		
		@compName as 'compName',
		Case @opt_sort when 'S' then sod_ordno when 'J' then hid_jobno when 'C' then hid_ctrcfs when 'I' then hid_invno end
		

		From #TEMP_SHIP_SQ (nolock)
		left join SHIPGDTL st(nolock) on tmp_cocde = st.hid_cocde and st.hid_shpno = tmp_shpno
		left join SHIPGHDR sr1(nolock) on sr1.hih_cocde = tmp_cocde and tmp_shpno = sr1.hih_shpno
		left join SHINVHDR sr2(nolock) on  sr2.hiv_shpno = st.hid_shpno and st.hid_cocde = sr2.hiv_cocde 
		left join SCORDDTL sd (nolock) on  sd.sod_ordno = st.hid_ordno  and st.hid_cocde = sd.sod_cocde and st.hid_ordseq = sd.sod_ordseq
		left join SCORDHDR sd2 (nolock) on sd2.soh_ordno = sd.sod_ordno
		left join SYSALREP b (nolock) on b.ysr_code1 = sd2.soh_salrep
		left join CUBASINF c1 (nolock) on c1.cbi_cusno = sr1.hih_cus1no
		left join SYSALREP b1 (nolock) on b1.ysr_code1 = c1.cbi_salrep
		left join CUBASINF c2 (nolock) on c2.cbi_cusno = sr1.hih_cus2no
		left join SYSETINF on sod_pckunt = ysi_cde and  ysi_typ = '05'
		left join VNBASINF vn on vn.vbi_venno = sd.sod_venno
		left join VNBASINF vn2 on vn2.vbi_venno = sd.sod_examven
		Where
		((@flg_etddatefmto = 'N') or (@flg_etddatefmto = 'Y' and hih_slnonb between @etddatefm and @etddateto))
		and	((@flg_contain = 'N') or (@flg_contain = 'Y' and hid_ctrcfs in (select tmp_cont from #TEMP_CONT (nolock))))
		and ((@flg_pricust = 'N') or (@flg_pricust = 'Y' and hih_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
		and ((@flg_seccust = 'N') or (@flg_seccust = 'Y' and hih_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
		and ((@flg_scno = 'N') or (@flg_scno = 'Y' and sod_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
		and ((@flg_item = 'N') or (@flg_item = 'Y' and hid_itmno in (select tmp_itmno from #TEMP_ITM (nolock))))
		and ((@flg_custitm = 'N') or (@flg_custitm = 'Y' and hid_cusitm in (select tmp_cusitm from #TEMP_CUSITM (nolock))))
		and ((@flg_shipterm = 'N') or (@flg_shipterm = 'Y' and ysi_dsc in (select tmp_shiptm from #TEMP_SHIPTM (nolock))))
		and ((@flg_custpo = 'N') or (@flg_custpo = 'Y' and sod_cuspo in (select tmp_custpo from #TEMP_CUSTPO (nolock))))
		

Order by 
	--hid_itmno,
	Case @opt_sort when 'S' then sod_ordno when 'J' then hid_jobno when 'C' then hid_ctrcfs when 'I' then hid_invno end
	--sod_ordno, hid_jobno, hid_ctrcfs, hid_invno

	
	--Main Query End
	

	
--END


	drop table #TEMP_INIT
	drop table #TEMP_CONT
	drop table #TEMP_CUS1NO
	drop table #TEMP_CUS2NO
	drop table #TEMP_SCNO
	drop table #TEMP_ITM
	drop table #TEMP_CUSITM
	drop table #TEMP_SHIPTM
	drop table #TEMP_CUSTPO

END




GO
GRANT EXECUTE ON [dbo].[sp_select_MSR00027_A] TO [ERPUSER] AS [dbo]
GO
