/****** Object:  StoredProcedure [dbo].[sp_select_PGM00006_DTL]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_PGM00006_DTL]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_PGM00006_DTL]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO














/*
=================================================================
Program ID	: sp_select_PGM00006_DTL
Description	: Retrieve SC Detail entries pending approval
Programmer	: David Yue
=================================================================
	MODIFICATION HISTORY
=================================================================
   Date		 Editor			Description
=================================================================
2013-05-10 	David Yue		SP Created
=================================================================
*/
--sp_select_PGM00006_DTL '1,2,3','4,5,6','7,8,9','10,11,12','13,14,15','16,17,18','19,20,21','01/01/2013','01/01/2013','mis'
--sp_select_PGM00006_DTL '','','','','','','','04/01/2014','06/01/2014','mis'

CREATE procedure [dbo].[sp_select_PGM00006_DTL]
@cocde		varchar(6),
@cocdelist	varchar(1000),
@cus1nolist	varchar(1000),
@cus2nolist	varchar(1000),
@ordnolist	varchar(1000),
@itmnolist	varchar(1000),
@prdvenlist	varchar(1000),
@issdatFm	varchar(10),
@issdatTo	varchar(10),
@creusr		varchar(30)

as

create table #TEMP_INIT (tmp_init nvarchar(1000)) on [PRIMARY]
create table #TEMP_COCDE (tmp_cocde nvarchar(10)) on [PRIMARY]
create table #TEMP_CUS1NO (tmp_cus1no nvarchar(10)) on [PRIMARY]
create table #TEMP_CUS2NO (tmp_cus2no nvarchar(10)) on [PRIMARY]
create table #TEMP_ORDNO (tmp_ordno nvarchar(20)) on [PRIMARY]
create table #TEMP_ITMNO (tmp_itmno nvarchar(20)) on [PRIMARY]
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

		insert into #TEMP_INIT values (@strPart)
	end
	if charindex(',',@strRemain) = 0
	begin
		set @strRemain = ltrim(@strRemain)

		insert into #TEMP_INIT values (@strRemain)
	end
	insert into #TEMP_COCDE
	select distinct tmp_init from #TEMP_INIT
end


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



--#TEMP_ORDNO
if ltrim(rtrim(@ordnolist)) <> ''
begin
	delete from #TEMP_INIT
	set @strRemain = @ordnolist
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
			select poh_ordno from PKORDHDR where poh_ordno between @fm and @to
		end
		else if charindex('%', @strRemain) <> 0
		begin
			insert into #TEMP_INIT
			select poh_ordno from PKORDHDR where poh_ordno like @strRemain
		end
		else
		begin
			insert into #TEMP_INIT values (@strRemain)
		end
	end
	insert into #TEMP_ORDNO
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


--#TEMP_PV
if ltrim(rtrim(@prdvenlist)) <> ''
begin
	delete from #TEMP_INIT

	set @strRemain = @prdvenlist
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
@flg_ordno_table char(1),
@flg_itmno_table char(1),
@flg_pv_table char(1),
@flg_issdat_fmto char(1)

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

if (select count(*) from #TEMP_ORDNO) >= 1
	set @flg_ordno_table = 'Y'
else
	set @flg_ordno_table = 'N'

if (select count(*) from #TEMP_ITMNO) >= 1
	set @flg_itmno_table = 'Y'
else
	set @flg_itmno_table = 'N'

if (select count(*) from #TEMP_PV) >= 1
	set @flg_pv_table = 'Y'
else
	set @flg_pv_table = 'N'




/*
select * from #TEMP_INIT
select * from #TEMP_COCDE
select * from #TEMP_CUS1NO
select * from #TEMP_CUS2NO
select * from #TEMP_ORDNO
select * from #TEMP_ITMNO
select * from #TEMP_PV

select @flg_cocde_table
select @flg_cus1no_table
select @flg_cus2no_table
select @flg_ordno_table
select @flg_itmno_table
select @flg_pv_table
select @flg_issdat_fmto
*/

select distinct 
'W' as 'action',
poh_reprtflg,
pod_cocde,
pod_ordno,
pod_seq,
pod_status,
pod_pkgven + ' - ' + vbi_vensna as 'pod_pkgven',
pod_pkgitm,
pod_engdsc,
pod_ordqty,
--pod_wasqty,
pod_bonqty,
pod_stkqty,
pod_ttlordqty,
pod_qtyum as 'um',
pod_curcde,
--pod_untprc,
cast(pod_untprc as numeric(13,5)) as 'pod_untprc' , 
--pod_ttlamtqty,
cast(pod_ttlamtqty as numeric(13,2)) as 'pod_ttlamtqty' ,
convert(nvarchar(500),prh_cus1no) as 'prh_cus1no',
convert(nvarchar(500),isnull(pri.cbi_cusno + ' - ' + pri.cbi_cussna,'')) as 'pri_cusnam',
convert(nvarchar(500),prh_cus2no) as 'prh_cus2no',
--isnull(sec.cbi_cusno + ' - ' + sec.cbi_cussna,'') as 'sec_cusnam',
' ' as 'sec_cusnam',
convert(varchar(20),poh_issdat, 101) as 'poh_issdat',
--pod_itemno,
--pod_tmpitmno,
--pod_venno,
--pod_venitm,
--pod_pckunt + ' / ' + cast(pod_inrqty as varchar(10)) + ' / ' + cast(pod_mtrqty as varchar(10)) + ' / ' + cast(pod_cft as varchar(10)) + ' / ' + pod_ftyprctrm + ' / ' + pod_hkprctrm + ' / ' + pod_trantrm as 'Packing and Terms' ,
--pod_curcde,
--pod_untprc as 'unit price',
--pod_ordqty,
--1 as 'pod_timstp',
convert(varchar(500),isnull(prd_ScToNo,'')) as 'prd_ScToNo'
into #TEMP_RESULT
from PKORDHDR (nolock)
left join PKORDDTL (nolock) on  pod_ordno = poh_ordno
left join PKREQDTL (nolock) on pod_ordno = prd_ordno and pod_seq = prd_ordseq
left join PKREQHDR (nolock) on prh_reqno = prd_reqno
left join CUBASINF pri (nolock) on pri.cbi_cusno = prh_cus1no
left join CUBASINF sec (nolock) on sec.cbi_cusno = prh_cus2no
left join VNBASINF (nolock) on vbi_venno = pod_pkgven
where
poh_issdat between @issdatFm and @issdatTo
and poh_status = 'REL' and pod_status = 'REL'
and ((@flg_cocde_table = 'N') or (@flg_cocde_table = 'Y' and poh_cocde in (select tmp_cocde from #TEMP_COCDE (nolock))))
and ((@flg_cus1no_table = 'N') or (@flg_cus1no_table = 'Y' and prh_cus1no in (select tmp_cus1no from #TEMP_CUS1NO (nolock))))
and ((@flg_cus2no_table = 'N') or (@flg_cus2no_table = 'Y' and prh_cus2no in (select tmp_cus2no from #TEMP_CUS2NO (nolock))))
and ((@flg_ordno_table = 'N') or (@flg_ordno_table = 'Y' and poh_ordno in (select tmp_ordno from #TEMP_ORDNO (nolock))))
and ((@flg_itmno_table = 'N') or (@flg_itmno_table = 'Y' and pod_itemno in (select tmp_itmno from #TEMP_ITMNO (nolock))))
and ((@flg_pv_table = 'N') or (@flg_pv_table = 'Y' and pod_Pkgven in (select tmp_pv from #TEMP_PV (nolock))))
order by pod_ordno, pod_seq, pri_cusnam,prd_ScToNo



declare @pod_ordno nvarchar(20)
declare @pod_seq int
declare @pod_cusnam nvarchar(50)
declare @prd_ScTo nvarchar(20)



declare @last_pod_ordno nvarchar(20)
declare @last_pod_seq int
declare @last_cusnam nvarchar(100)
declare @last_scto nvarchar(20)

declare @cusnam_str nvarchar(500)
declare @scto_str nvarchar(500)




set @last_pod_ordno = ''
set @last_pod_seq = 0
set @last_cusnam = ''
set @last_scto = ''

set @cusnam_str = ''
set @scto_str = ''



declare cur_pkord cursor
for
select 
pod_ordno, pod_seq, pri_cusnam,prd_ScToNo
from #TEMP_RESULT

open cur_pkord
fetch next from cur_pkord into
@pod_ordno, @pod_seq, @pod_cusnam, @prd_ScTo

while @@fetch_status = 0
begin

--select @last_cusnam,@last_scto,@cusnam_str,@scto_str

--select @last_pod_ordno, @last_pod_seq, @pod_ordno, @pod_seq, @pod_cusnam, @prd_ScTo

--select @cusnam_str,@pod_cusnam,@last_cusnam

if @last_pod_ordno = ''
begin
	set @cusnam_str = @pod_cusnam + ' , '
	set @scto_str = @prd_ScTo + ' , '
end
else
begin
	if @last_pod_ordno <> @pod_ordno or @last_pod_seq <> @pod_seq and @last_pod_seq <> 0
	begin
		update #TEMP_RESULT set prh_cus1no = @cusnam_str, prh_cus2no = @scto_str where pod_ordno = @last_pod_ordno and  pod_seq = @last_pod_seq
		set @cusnam_str = ''
		set @scto_str = ''
	end
	
--	if (@last_pod_ordno <> @pod_ordno or @last_pod_seq <> @pod_seq) and @last_pod_seq <> 0 and @last_cusnam <> @pod_cusnam
	if @last_pod_ordno <> @pod_ordno or  @last_cusnam <> @pod_cusnam
		set @cusnam_str = @cusnam_str +  @pod_cusnam + ','

	if  @last_pod_ordno <> @pod_ordno or @last_scto <> @prd_ScTo
		set @scto_str = @scto_str + @prd_ScTo + ','
end

set @last_pod_ordno = @pod_ordno
set @last_pod_seq = @pod_seq
set @last_cusnam = @pod_cusnam
set @last_scto = @prd_ScTo



fetch next from cur_pkord into
@pod_ordno, @pod_seq, @pod_cusnam, @prd_ScTo

end

update #TEMP_RESULT set prh_cus1no = @cusnam_str, prh_cus2no = @scto_str where pod_ordno = @last_pod_ordno and  pod_seq = @last_pod_seq
		

--sp_select_PGM00006_DTL 'EW,HB,HX,PG,TT,UCP,UCPP','','','','','','','04/01/2014','06/01/2014','mis'

update #TEMP_RESULT set pri_cusnam = case prh_cus1no when '' then '' else substring(prh_cus1no,1,len(prh_cus1no)-1) end, prd_ScToNo = case prh_cus2no when '' then '' else substring(prh_cus2no,1,len(prh_cus2no) -1) end


select distinct * from #TEMP_RESULT




drop table #TEMP_INIT
drop table #TEMP_COCDE
drop table #TEMP_CUS1NO
drop table #TEMP_CUS2NO
drop table #TEMP_ORDNO
drop table #TEMP_ITMNO
drop table #TEMP_PV
drop table #TEMP_RESULT

/*

declare
@cocdeSQL	varchar(2000),	@cus1noSQL	varchar(2000),	@cus2noSQL	varchar(2000),
@ordnoSQL	varchar(2000),	@itmnoSQL	varchar(2000) , @prdVenSQL	varchar(2000),
@issdatSQL	varchar(400)

declare
@i 		int,		@start 		varchar(20),	@end 		nvarchar(20),
@value		varchar(20)

declare
@header		varchar(2000),	@conditionSQL	varchar(5500),	@footer		varchar(100),
@statementSQL	varchar(8000)


-- Process Company Code Condition --
if ltrim(rtrim(@cocdelist)) <> ''
begin
	set @cocdeSQL = ''
	set @i = 0
	
	while charindex(',',@cocdelist) <> 0
	begin
		set @i = charindex(',',@cocdelist)
		if @i = 0 and charindex(@cocdelist,@cocdeSQL) = 0
			set @i = len(@cocdelist)
		set @value = substring(@cocdelist, 0, @i)
		set @cocdelist = substring(@cocdelist,@i+1,len(@cocdelist)-@i)
		if ltrim(rtrim(@value)) <> ''
		begin
			if charindex('~',@value) > 0
			begin
				set @i = charindex('~',@value)
				set @start = substring(@value, 0, @i)
				set @end = substring(@value, @i+1,len(@value))
				set @cocdeSQL = @cocdeSQL + case len(@cocdeSQL) when 0 then '' else ' or pod_cocde ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @cocdeSQL = @cocdeSQL + case len(@cocdeSQL) when 0 then '' else ' or pod_cocde ' end + '= ''' + @value + ''''
			end
		end
	end
	
	if charindex(@cocdelist, @cocdeSQL) = 0
	begin
		if charindex('~',@cocdelist) > 0
		begin
			set @i = charindex('~',@cocdelist)
			set @start = substring(@cocdelist, 0, @i)
			set @end = substring(@cocdelist, @i+1,len(@cocdelist))
			set @cocdeSQL = @cocdeSQL + case len(@cocdeSQL) when 0 then '' else ' or pod_cocde ' end + 'between ''' + @start + ''' and ''' + @end + ''''
		end
		else
		begin
			set @cocdeSQL = @cocdeSQL + case len(@cocdeSQL) when 0 then '' else ' or pod_cocde ' end + '= ''' + @cocdelist + ''''
		end
	end
	
	set @cocdeSQL = 'pod_cocde ' + @cocdeSQL
end -- if ltrim(rtrim(@cocdelist)) <> ''

-- Process Primary Customer Condition --
if ltrim(rtrim(@cus1nolist)) <> ''
begin
	set @cus1noSQL = ''
	set @i = 0
	
	while charindex(',',@cus1nolist) <> 0
	begin
		set @i = charindex(',',@cus1nolist)
		if @i = 0 and charindex(@cus1nolist,@cus1noSQL) = 0
			set @i = len(@cus1nolist)
		set @value = substring(@cus1nolist, 0, @i)
		set @cus1nolist = substring(@cus1nolist,@i+1,len(@cus1nolist)-@i)
		if ltrim(rtrim(@value)) <> ''
		begin
			if charindex('~',@value) > 0
			begin
				set @i = charindex('~',@value)
				set @start = substring(@value, 0, @i)
				set @end = substring(@value, @i+1,len(@value))
				set @cus1noSQL = @cus1noSQL + case len(@cus1noSQL) when 0 then '' else ' or poh_cus1no ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @cus1noSQL = @cus1noSQL + case len(@cus1noSQL) when 0 then '' else ' or poh_cus1no ' end + '= ''' + @value + ''''
			end
		end
	end
	
	if charindex(@cus1nolist, @cus1noSQL) = 0
	begin
		if charindex('~',@cus1nolist) > 0
		begin
			set @i = charindex('~',@cus1nolist)
			set @start = substring(@cus1nolist, 0, @i)
			set @end = substring(@cus1nolist, @i+1,len(@cus1nolist))
			set @cus1noSQL = @cus1noSQL + case len(@cus1noSQL) when 0 then '' else ' or poh_cus1no ' end + 'between ''' + @start + ''' and ''' + @end + ''''
		end
		else
		begin
			set @cus1noSQL = @cus1noSQL + case len(@cus1noSQL) when 0 then '' else ' or poh_cus1no ' end + '= ''' + @cus1nolist + ''''
		end
	end
	
	set @cus1noSQL = 'poh_cus1no ' + @cus1noSQL
end -- if ltrim(rtrim(@cus1nolist)) <> ''

-- Process Secondary Customer Condition --
if ltrim(rtrim(@cus2nolist)) <> ''
begin
	set @cus2noSQL = ''
	set @i = 0
	
	while charindex(',',@cus2nolist) <> 0
	begin
		set @i = charindex(',',@cus2nolist)
		if @i = 0 and charindex(@cus2nolist,@cus2noSQL) = 0
			set @i = len(@cus2nolist)
		set @value = substring(@cus2nolist, 0, @i)
		set @cus2nolist = substring(@cus2nolist,@i+1,len(@cus2nolist)-@i)
		if ltrim(rtrim(@value)) <> ''
		begin
			if charindex('~',@value) > 0
			begin
				set @i = charindex('~',@value)
				set @start = substring(@value, 0, @i)
				set @end = substring(@value, @i+1,len(@value))
				set @cus2noSQL = @cus2noSQL + case len(@cus2noSQL) when 0 then '' else ' or poh_cus2no ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @cus2noSQL = @cus2noSQL + case len(@cus2noSQL) when 0 then '' else ' or poh_cus2no ' end + '= ''' + @value + ''''
			end
		end
	end
	
	if charindex(@cus2nolist, @cus2noSQL) = 0
	begin
		if charindex('~',@cus2nolist) > 0
		begin
			set @i = charindex('~',@cus2nolist)
			set @start = substring(@cus2nolist, 0, @i)
			set @end = substring(@cus2nolist, @i+1,len(@cus2nolist))
			set @cus2noSQL = @cus2noSQL + case len(@cus2noSQL) when 0 then '' else ' or poh_cus2no ' end + 'between ''' + @start + ''' and ''' + @end + ''''
		end
		else
		begin
			set @cus2noSQL = @cus2noSQL + case len(@cus2noSQL) when 0 then '' else ' or poh_cus2no ' end + '= ''' + @cus2nolist + ''''
		end
	end
	
	set @cus2noSQL = 'poh_cus2no ' + @cus2noSQL
end -- if ltrim(rtrim(@cus2nolist)) <> ''

-- Process SC Order No Condition --
if ltrim(rtrim(@ordnolist)) <> ''
begin 
	set @ordnoSQL = ''
	set @i = 0
	
	while charindex(',',@ordnolist) <> 0
	begin
		set @i = charindex(',',@ordnolist)
		if @i = 0 and charindex(@ordnolist,@ordnoSQL) = 0
			set @i = len(@ordnolist)
		set @value = substring(@ordnolist, 0, @i)
		set @ordnolist = substring(@ordnolist,@i+1,len(@ordnolist)-@i)
		if ltrim(rtrim(@value)) <> ''
		begin
			if charindex('~',@value) > 0
			begin
				set @i = charindex('~',@value)
				set @start = substring(@value, 0, @i)
				set @end = substring(@value, @i+1,len(@value))
				set @ordnoSQL = @ordnoSQL + case len(@ordnoSQL) when 0 then '' else ' or pod_ordno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @ordnoSQL = @ordnoSQL + case len(@ordnoSQL) when 0 then '' else ' or pod_ordno ' end + '= ''' + @value + ''''
			end
		end
	end
	
	if charindex(@ordnolist, @ordnoSQL) = 0
	begin
		if charindex('~',@ordnolist) > 0
		begin
			set @i = charindex('~',@ordnolist)
			set @start = substring(@ordnolist, 0, @i)
			set @end = substring(@ordnolist, @i+1,len(@ordnolist))
			set @ordnoSQL = @ordnoSQL + case len(@ordnoSQL) when 0 then '' else ' or pod_ordno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
		end
		else
		begin
			set @ordnoSQL = @ordnoSQL + case len(@ordnoSQL) when 0 then '' else ' or pod_ordno ' end + '= ''' + @ordnolist + ''''
		end
	end
	
	set @ordnoSQL = 'pod_ordno ' + @ordnoSQL
end -- if ltrim(rtrim(@ordnolist)) <> ''

-- Process Item No Condition --
if ltrim(rtrim(@itmnolist)) <> ''
begin 
	set @itmnoSQL = ''
	set @i = 0
	
	while charindex(',',@itmnolist) <> 0
	begin
		set @i = charindex(',',@itmnolist)
		if @i = 0 and charindex(@itmnolist,@itmnoSQL) = 0
			set @i = len(@itmnolist)
		set @value = substring(@itmnolist, 0, @i)
		set @itmnolist = substring(@itmnolist,@i+1,len(@itmnolist)-@i)
		if ltrim(rtrim(@value)) <> ''
		begin
			if charindex('~',@value) > 0
			begin
				set @i = charindex('~',@value)
				set @start = substring(@value, 0, @i)
				set @end = substring(@value, @i+1,len(@value))
				set @itmnoSQL = @itmnoSQL + case len(@itmnoSQL) when 0 then '' else ' or pod_itemno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @itmnoSQL = @itmnoSQL + case len(@itmnoSQL) when 0 then '' else ' or pod_itemno ' end + '= ''' + @value + ''''
			end
		end
	end
	
	if charindex(@itmnolist, @itmnoSQL) = 0
	begin
		if charindex('~',@itmnolist) > 0
		begin
			set @i = charindex('~',@itmnolist)
			set @start = substring(@itmnolist, 0, @i)
			set @end = substring(@itmnolist, @i+1,len(@itmnolist))
			set @itmnoSQL = @itmnoSQL + case len(@itmnoSQL) when 0 then '' else ' or pod_itemno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
		end
		else
		begin
			set @itmnoSQL = @itmnoSQL + case len(@itmnoSQL) when 0 then '' else ' or pod_itemno ' end + '= ''' + @itmnolist + ''''
		end
	end
	
	set @itmnoSQL = 'pod_itemno ' + @itmnoSQL
end -- if ltrim(rtrim(@itmnolist)) <> ''

--*
-- Process Prd Ven Condition --
if ltrim(rtrim(@prdvenlist)) <> ''
begin 
	set @prdVenSQL = ''
	set @i = 0
	
	while charindex(',',@prdvenlist) <> 0
	begin
		set @i = charindex(',',@prdvenlist)
		if @i = 0 and charindex(@prdvenlist,@prdVenSQL) = 0
			set @i = len(@prdvenlist)
		set @value = substring(@prdvenlist, 0, @i)
		set @prdvenlist = substring(@prdvenlist,@i+1,len(@prdvenlist)-@i)
		if ltrim(rtrim(@value)) <> ''
		begin
			if charindex('~',@value) > 0
			begin
				set @i = charindex('~',@value)
				set @start = substring(@value, 0, @i)
				set @end = substring(@value, @i+1,len(@value))
				set @prdVenSQL = @prdVenSQL + case len(@prdVenSQL) when 0 then '' else ' or pod_Pkgven ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @prdVenSQL = @prdVenSQL + case len(@prdVenSQL) when 0 then '' else ' or pod_Pkgven ' end + '= ''' + @value + ''''
			end
		end
	end
	
	if charindex(@prdvenlist, @prdVenSQL) = 0
	begin
		if charindex('~',@prdvenlist) > 0
		begin
			set @i = charindex('~',@prdvenlist)
			set @start = substring(@prdvenlist, 0, @i)
			set @end = substring(@prdvenlist, @i+1,len(@prdvenlist))
			set @prdVenSQL = @prdVenSQL + case len(@prdVenSQL) when 0 then '' else ' or pod_Pkgven ' end + 'between ''' + @start + ''' and ''' + @end + ''''
		end
		else
		begin
			set @prdVenSQL = @prdVenSQL + case len(@prdVenSQL) when 0 then '' else ' or pod_Pkgven ' end + '= ''' + @prdvenlist + ''''
		end
	end
	
	set @prdVenSQL = 'pod_Pkgven ' + @prdVenSQL
end -- if ltrim(rtrim(@itmnolist)) <> ''


-- Process Issue Date Condition --
if @issdatFm <> '' and @issdatTo <> ''
begin
	set @issdatSQL = 'poh_issdat between ''' + @issdatFm + ' 00:00'' and ''' + @issdatTo + ' 23:59'''
end -- if @prcCredatFm <> '' and @prcCredatTo <> ''

--select @cocdeSQL, @cus1noSQL, @cus2noSQL, @ordnoSQL, @itmnoSQL, @issdatSQL

-- Concatenate Query Statement --
--set @conditionSQL = 'soh_ordsts = ''HLD'' and sod_apprve = ''W'' and ((sod_ordqty / sod_mtrctn) < sod_moq or round(sod_itmprc, 2, 2) > round(sod_untprc, 2, 2))'
set @conditionSQL =  'poh_status = ''REL'' and pod_status = ''REL'''
if @cocdeSQL <> ''
begin
	set @conditionSQL = @conditionSQL + case (len(@conditionSQL)) when 0 then '(' else ' and (' end + @cocdeSQL + ')'
end
if @cus1noSQL <> ''
begin
	set @conditionSQL = @conditionSQL + case (len(@conditionSQL)) when 0 then '(' else ' and (' end + @cus1noSQL + ')'
end
if @cus2noSQL <> ''
begin
	set @conditionSQL = @conditionSQL + case (len(@conditionSQL)) when 0 then '(' else ' and (' end + @cus2noSQL + ')'
end
if @ordnoSQL <> ''
begin
	set @conditionSQL = @conditionSQL + case (len(@conditionSQL)) when 0 then '(' else ' and (' end + @ordnoSQL + ')'
end
if @itmnoSQL <> ''
begin
	set @conditionSQL = @conditionSQL + case (len(@conditionSQL)) when 0 then '(' else ' and (' end + @itmnoSQL + ')'
end

if @prdVenSQL <> ''
begin
	set @conditionSQL = @conditionSQL + case (len(@conditionSQL)) when 0 then '(' else ' and (' end + @prdVenSQL + ')'
end

if @issdatSQL <> ''
begin
	set @conditionSQL = @conditionSQL + case (len(@conditionSQL)) when 0 then '(' else ' and (' end + @issdatSQL + ')'
end

--print @conditionSQL

-- Construct SQL Statement
set @header = 'select distinct 
 ''W'' as ''action'',
 pod_cocde,
 pod_ordno,
 poh_status,
 ''1'' as ''prh_cus1no'',
 isnull(pri.cbi_cusno + '' - '' + pri.cbi_cussna,'''') as ''pri_cusnam'',
 ''2'' as ''prh_cus2no'',
 isnull(sec.cbi_cusno + '' - '' + sec.cbi_cussna,'''') as ''sec_cusnam'',
 convert(varchar(12),poh_issdat, 101) as ''poh_issdat'',
 pod_seq,
 pod_pkgitm,
 pod_pkgven,
 pod_itemno,
 pod_tmpitmno,
 pod_venno,
 pod_venitm,
 pod_pckunt + '' / '' + cast(pod_inrqty as varchar(10)) + '' / '' + cast(pod_mtrqty as varchar(10)) + '' / '' + cast(pod_cft as varchar(10)) + '' / '' + pod_ftyprctrm + '' / '' + pod_hkprctrm + '' / '' + pod_trantrm as ''Packing and Terms'' ,
 pod_curcde,
 pod_untprc as ''unit price'',
 pod_ordqty,
 1 as ''pod_timstp'',
 isnull(prd_ScToNo,'''') as ''prd_ScToNo''
 from PKORDHDR (nolock)
 left join PKORDDTL (nolock) on  pod_ordno = poh_ordno
 left join PKREQDTL (nolock) on pod_ordno = prd_ordno and pod_seq = prd_ordseq
 left join PKREQHDR (nolock) on prh_reqno = prd_reqno
 left join CUBASINF pri (nolock) on pri.cbi_cusno = prh_cus1no
 left join CUBASINF sec (nolock) on sec.cbi_cusno = prh_cus2no
 where'
set @footer = 'order by pod_ordno, pod_seq'

set @statementSQL = @header + ' ' + @conditionSQL + ' ' + @footer

--print @statementSQL

-- Execute Constructed SQL Query
exec(@statementSQL)

*/







GO
GRANT EXECUTE ON [dbo].[sp_select_PGM00006_DTL] TO [ERPUSER] AS [dbo]
GO
