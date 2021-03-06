/****** Object:  StoredProcedure [dbo].[sp_select_TOORDDTL_PKG09]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[sp_select_TOORDDTL_PKG09]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_TOORDDTL_PKG09]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO











CREATE      procedure [dbo].[sp_select_TOORDDTL_PKG09]
                                                                                                                                                                                                                                                                 
@code nvarchar(10),
@cus1nolist nvarchar(1000),
@cus2nolist nvarchar(1000),
@scissdatfm datetime,
@scissdatto datetime,
@sccde nvarchar(1000),
@tocde nvarchar(1000),
@itmnolist nvarchar(1000),
@pkgitm nvarchar(20),
@usrid nvarchar(30)


---------------------------------------------- 

 
AS
 

declare @flg_cocde_table char(1), 
@flg_cus1no_table char(1),
@flg_cus2no_table char(1),
@flg_itmno_table char(1),
@flg_pv_table char(1),
@flg_clmno_table char(1),
@flg_scno_table char(1),
@flg_tono_table char(1),
@flg_clmsts_table char(1),
@flg_scissdat_fmto char(1),
@flg_sarvsdat_fmto char(1)

declare	@fm nvarchar(100), @to nvarchar(100), @date3 datetime


declare @strPart nvarchar(1000), @strRemain nvarchar(1000)

set @fm = ''
set @to = ''
set @strPart = ''
set @strRemain = ''
set @date3  = ''


begin

create table #TEMP_INIT (tmp_init nvarchar(1000)) on [PRIMARY]
create table #TEMP_CUS1NO (tmp_cus1no nvarchar(10)) on [PRIMARY]
create table #TEMP_CUS2NO (tmp_cus2no nvarchar(10)) on [PRIMARY]
create table #TEMP_SCNO (tmp_scno nvarchar(20)) on [PRIMARY]
create table #TEMP_TONO (tmp_tono nvarchar(20)) on [PRIMARY]
create table #TEMP_ITMNO (tmp_itmno nvarchar(20)) on [PRIMARY]


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

if @scissdatfm <> '1900/01/01'
begin
	set @flg_scissdat_fmto = 'Y'
	set @scissdatto = dateadd(DD,1,@scissdatto)
end
else
begin
	set @flg_scissdat_fmto = 'N'
end

if (select count(*) from #TEMP_ITMNO) >= 1
	set @flg_itmno_table = 'Y'
else
	set @flg_itmno_table = 'N'



--test
--select @flg_scno_table	 as '123'
--select @flg_scissdat_fmto
--select @flg_cus1no_table
--select @flg_cus2no_table
--select @flg_scno_table
--select @flg_tono_table
--select @flg_itmno_table


select 	
	--tod_toordno as 'tod_toordno', 
	0 as 'Counter','N' as 'Gen',sod_cocde as 'cocde' , sod_ordno as 'ordno' ,sod_ordseq as 'seq',
	sod_itmno as 'realitem',  '' as 'assitem' , sod_cusitm as 'custitm' , sod_cussku as 'sku' , '' as'tempitem',
	'' as 'venitem' , '' as 'venitemno', '' as 'vbi_vensna',
	sod_colcde as 'colcde' ,    sod_ordqty as 'ordqty' ,
	 case pwa_um when 'PC' then cast(isnull(pwa_wasage,0) as int) else cast(isnull(round(sod_ordqty * pwa_wasage /100 , 0 ),0 ) as int) end as 'wasqty', 
	sod_ordqty  as 'stqty',
	sod_pckunt as 'um' , sod_inrctn as 'inr', sod_mtrctn as 'mst', sod_cft as 'cft',
	sod_ftyprctrm as 'ftyprctrm',sod_hkprctrm as 'hkprctrm',sod_trantrm as 'trantrm',
	sod_pckunt + ' / ' + convert(varchar(10),sod_inrctn) + ' / ' + convert(varchar(10),sod_mtrctn) + ' / ' + convert(varchar(10),sod_cft)  + ' / ' + sod_ftyprctrm + ' / ' + sod_hkprctrm + ' / ' + sod_trantrm as 'Terms'
	,sod_curcde as 'curcde',
	sod_conftr as 'conftr',
	'sc' as 'flag'
	--isnull(sod_ordno,'')as'ScNo', isnull(sod_ordseq,0)as'ScSeq', isnull(sod_itmno,'')as'ScItem', isnull(sod_ordqty * (iba_mtrqty / sod_mtrctn),0)as'ScQty' 
	from   scordhdr  (nolock)
	left join	scorddtl (nolock) on soh_ordno = sod_ordno
	left join toorddtl  (nolock) on  sod_tordno = tod_toordno
					and sod_itmno = tod_ftyitmno and tod_latest = 'Y'
	left join CUBASINF     pri on pri.cbi_cusno = soh_cus1no
	left join CUBASINF    sec on sec.cbi_cusno = soh_cus2no
	left join PKIMBAIF (nolock) on pib_pgitmno = @pkgitm
	left join PKWASGE (nolock) on pwa_code = pib_cate and sod_ordqty >= pwa_qtyfrm and sod_ordqty <= pwa_qtyto
	
 	
	where 
	(
	(@flg_scissdat_fmto = 'N') 
	or
	 (@flg_scissdat_fmto = 'Y' and (soh_issdat between @scissdatfm and @scissdatto ))
	)
	and ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and soh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))

 	and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and soh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
	and ((@flg_scno_table = 'N') or (@flg_scno_table = 'Y' and sod_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
--test later
--	and ((@flg_tono_table = 'N') or (@flg_tono_table = 'Y' and tod_toordno in (select tmp_tono from #TEMP_TONO (nolock))))
	and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and sod_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
	and 
	soh_cocde = @code 
	and soh_ordsts not in  ('CLO','CAN')
	 

union        
select  
	--tod_toordno as 'tod_toordno', 
	0 as 'Counter','N' as 'Gen' , sod_cocde as 'cocde' , sod_ordno as 'ordno' ,sod_ordseq as 'seq',
	sod_itmno as 'realitem',  iba_assitm as 'assitem' , '' as 'custitm' , '' as 'sku' , '' as'tempitem',
	'' as 'venitem' , '' as 'venitemno', '' as 'vbi_vensna',
	iba_colcde as 'colcde'  , sod_ordqty * (iba_mtrqty / sod_mtrctn)  as 'ordqty' ,
	case pwa_um when 'PC' then cast(isnull(pwa_wasage,0) as int) else cast(isnull(round(sod_ordqty * (iba_mtrqty / sod_mtrctn) * pwa_wasage / 100 , 0),0) as int) end as 'wasqty',
	sod_ordqty * (iba_mtrqty / sod_mtrctn) as 'stqty',
	iba_pckunt as 'um' , iba_inrqty as 'inr', iba_mtrqty as 'mst', 0 as 'cft',
	sod_ftyprctrm as 'ftyprctrm',sod_hkprctrm as 'hkprctrm',sod_trantrm as 'trantrm',
	iba_pckunt + ' / ' + convert(varchar(10),iba_inrqty) + ' / ' + convert(varchar(10),iba_mtrqty) + ' / ' + convert(varchar(10),0)  + ' / ' + sod_ftyprctrm + ' / ' + sod_hkprctrm + ' / ' + sod_trantrm as 'Terms'
	,sod_curcde as 'curcde',
	--sod_conftr as 'conftr',
	1 as 'conftr',
	'sc' as 'flag'
	--isnull(sod_ordno,'')as'ScNo', isnull(sod_ordseq,0)as'ScSeq', isnull(sod_itmno,'')as'ScItem', isnull(sod_ordqty * (iba_mtrqty / sod_mtrctn),0)as'ScQty' 
	from   scordhdr  (nolock)
	left join	scorddtl (nolock) on soh_ordno = sod_ordno
	left join toorddtl  (nolock) on  sod_tordno = tod_toordno
					and sod_itmno = tod_ftyitmno and tod_latest = 'Y'
	left join imbomass (nolock) on sod_itmno = iba_itmno and iba_typ = 'ASS'
	left join CUBASINF     pri on pri.cbi_cusno = soh_cus1no
	left join CUBASINF    sec on sec.cbi_cusno = soh_cus2no
	left join PKIMBAIF (nolock) on pib_pgitmno = @pkgitm
	left join PKWASGE (nolock) on pwa_code = pib_cate and sod_ordqty * (iba_mtrqty / sod_mtrctn) >= pwa_qtyfrm and sod_ordqty * (iba_mtrqty / sod_mtrctn) <= pwa_qtyto 	


	where 
	(
	(@flg_scissdat_fmto = 'N') 
	or
	 (@flg_scissdat_fmto = 'Y' and (soh_issdat between @scissdatfm and @scissdatto ))
	)
	and ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and soh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))

 	and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and soh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
	and ((@flg_scno_table = 'N') or (@flg_scno_table = 'Y' and sod_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
--test later
--	and ((@flg_tono_table = 'N') or (@flg_tono_table = 'Y' and tod_toordno in (select tmp_tono from #TEMP_TONO (nolock))))
	and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and sod_itmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
	and 
	soh_cocde = @code 
	and soh_ordsts not in  ('CLO','CAN')
	and iba_itmno <> null	
	 

--order by sod_ordno,sod_ordseq , assitem


union  
select 0 as 'Counter','N' as 'Gen', tod_cocde as 'cocde' , tod_toordno as 'ordno' ,tod_toordseq as 'seq',
	tod_ftyitmno as 'realitem',  '' as 'assitem' , '' as 'custitm' , tod_itmsku as 'sku' ,  tod_ftytmpitmno as'tempitem',
	tod_venitm as 'venitem' , tod_venno as 'venitemno',  isnull(vbi_vensna,'') as 'vbi_vensna',
	tod_colcde as 'colcde' , tod_projqty as 'ordqty' ,
	 case pwa_um when 'PC' then cast(isnull(pwa_wasage,0) as int) else cast(isnull(round(tod_projqty * pwa_wasage /100 , 0 ),0) as int) end as 'wasqty', 
	 tod_projqty as 'stqty',
	tod_pckunt as 'um' , tod_inrqty as 'inr', tod_mtrqty as 'mst', tod_cft as 'cft',
	tod_ftyprctrm as 'ftyprctrm',tod_hkprctrm as 'hkprctrm',tod_trantrm as 'trantrm',
	tod_pckunt + ' / ' + convert(varchar(10),tod_inrqty) + ' / ' + convert(varchar(10),tod_mtrqty) +  ' / ' + convert(varchar(10),tod_cft)  + ' / ' + tod_ftyprctrm + ' / ' + tod_hkprctrm + ' / ' + tod_trantrm as 'Terms'
	,tod_curcde as 'curcde',
	tod_conftr as 'conftr',
	'to' as 'flag'
--isnull(s.sod_ordno,'')as'ScNo', isnull(s.sod_ordseq,0)as'ScSeq', isnull(s.sod_itmno,'')as'ScItem', isnull(s.sod_ordqty * (iba_mtrqty / sod_mtrctn),0)as'ScQty' 
from	TOORDhdr  h
	 left join TOORDDTL t  on h.toh_toordno = t.tod_toordno and tod_latest = 'Y'
	left join CUBASINF     pri on pri.cbi_cusno = h.toh_cus1no
	left join CUBASINF    sec on sec.cbi_cusno = h.toh_cus2no
	left join vnbasinf on vbi_venno = tod_venno
	left join PKIMBAIF (nolock) on pib_pgitmno = @pkgitm
	left join PKWASGE (nolock) on pwa_code = pib_cate and tod_projqty >= pwa_qtyfrm and tod_projqty <= pwa_qtyto

	where 
	(
	(@flg_scissdat_fmto = 'N') 
	or
	 (@flg_scissdat_fmto = 'Y' and (h.toh_issdat between @scissdatfm and @scissdatto ))
	)
	 and ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and h.toh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
 	and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and h.toh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
--	and ((@flg_scno_table = 'N') or (@flg_scno_table = 'Y' and sod_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
	and ((@flg_tono_table = 'N') or (@flg_tono_table = 'Y' and t.tod_toordno in (select tmp_tono from #TEMP_TONO (nolock))))
	and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and t.tod_ftyitmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
	and 
	h.toh_cocde = @code 
	and toh_ordsts not in  ('CLO','CAN')
	 
 



union  
select 0 as 'Counter','N' as 'Gen', tod_cocde as 'cocde' , tod_toordno as 'ordno' ,tod_toordseq as 'seq',
	tod_ftyitmno as 'realitem',  iba_assitm as 'assitem' , '' as 'custitm' , '' as 'sku' ,  tod_ftytmpitmno as'tempitem',
	tod_venitm as 'venitem' , tod_venno as 'venitemno', isnull(vbi_vensna,'') as 'vbi_vensna',
	iba_colcde as 'colcde' , tod_projqty * (iba_mtrqty / tod_mtrqty) as 'ordqty' ,
	 case pwa_um when 'PC' then cast(isnull(pwa_wasage,0)as int) else cast(isnull(round(tod_projqty * (iba_mtrqty / tod_mtrqty) * pwa_wasage /100 , 0 ),0)as int) end as 'wasqty', 
	tod_projqty as 'stqty',
	iba_pckunt as 'um' , iba_inrqty as 'inr', iba_mtrqty as 'mst', 0 as 'cft',
	tod_ftyprctrm as 'ftyprctrm',tod_hkprctrm as 'hkprctrm',tod_trantrm as 'trantrm',
	iba_pckunt + ' / ' + convert(varchar(10),iba_inrqty) + ' / ' + convert(varchar(10),iba_mtrqty) +  ' / ' + convert(varchar(10),0)  + ' / ' + tod_ftyprctrm + ' / ' + tod_hkprctrm + ' / ' + tod_trantrm as 'Terms'
	,tod_curcde as 'curcde',
	1 as 'conftr',
	'to' as 'flag'
--isnull(s.sod_ordno,'')as'ScNo', isnull(s.sod_ordseq,0)as'ScSeq', isnull(s.sod_itmno,'')as'ScItem', isnull(s.sod_ordqty * (iba_mtrqty / sod_mtrctn),0)as'ScQty' 
from	TOORDhdr  h
	 left join TOORDDTL t  on h.toh_toordno = t.tod_toordno and tod_latest = 'Y'
	left join imbomass (nolock) on tod_ftyitmno = iba_itmno and iba_typ = 'ASS'
	left join CUBASINF     pri on pri.cbi_cusno = h.toh_cus1no
	left join CUBASINF    sec on sec.cbi_cusno = h.toh_cus2no
	left join vnbasinf on vbi_venno = tod_venno
	left join PKIMBAIF (nolock) on pib_pgitmno = @pkgitm
	left join PKWASGE (nolock) on pwa_code = pib_cate and tod_projqty * (iba_mtrqty / tod_mtrqty) >= pwa_qtyfrm and tod_projqty * (iba_mtrqty / tod_mtrqty) <= pwa_qtyto
	--left join PKWASGE (nolock) on pwa_code = pib_cate and tod_projqty >= pwa_qtyfrm and tod_projqty <= pwa_qtyto
	
	--left join PKWASGE (nolock) on pwa_code = pib_cate and sod_ordqty * (iba_mtrqty / sod_mtrctn) >= pwa_qtyfrm and sod_ordqty * (iba_mtrqty / sod_mtrctn) <= pwa_qtyto 	

	where 
	(
	(@flg_scissdat_fmto = 'N') 
	or
	 (@flg_scissdat_fmto = 'Y' and (h.toh_issdat between @scissdatfm and @scissdatto ))
	)
	and  ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and h.toh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
 	and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and h.toh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
--	and ((@flg_scno_table = 'N') or (@flg_scno_table = 'Y' and sod_ordno in (select tmp_scno from #TEMP_SCNO (nolock))))
	and ((@flg_tono_table = 'N') or (@flg_tono_table = 'Y' and t.tod_toordno in (select tmp_tono from #TEMP_TONO (nolock))))
	and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and t.tod_ftyitmno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
	and 
	h.toh_cocde = @code 
	and toh_ordsts not in  ('CLO','CAN')
	and iba_itmno <> null	
 	 



end



 











GO
GRANT EXECUTE ON [dbo].[sp_select_TOORDDTL_PKG09] TO [ERPUSER] AS [dbo]
GO
