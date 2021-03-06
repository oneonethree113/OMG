/****** Object:  StoredProcedure [dbo].[sp_select_IAR00001_new]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_IAR00001_new]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_IAR00001_new]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO















-- Modify Information
-- Date			By			Description
-- 2006-09-19		Lester Wu		Handle Old Item replace by New in "NEW" stage
-- 2012-08-13		David Yue		Replaced IMMRKUP with IMPRCINF Table
-- 2012-08-27		David Yue		Transaction End Date ends at 11:59PM
--***************************************************************************************************************************

--sp_select_IAR00001_new 'UCPP','12/01/2003','12/31/2004','''03B431-BD0460''','mis'

CREATE      PROCEDURE [dbo].[sp_select_IAR00001_new] 
@cocde	varchar(6),
@transdate datetime,
@transend datetime,
@itmlst	varchar(4000),
@cus1nolist     varchar(1000)  ,
@cus2nolist     varchar(1000)  ,
@vennolist     varchar(1000),
@usrid	varchar(30)
AS

declare
@i 			int,			@cus1qry 	varchar(2000),	@value		varchar(20),		
@start 		varchar(20),	@end 		nvarchar(20),	@cus2qry 	varchar(2000),
@dvqry		varchar(2000)
declare @lstEmpty as char(1)

set @lstEmpty = 'N'
if len(rtrim(ltrim(replace(@itmlst,'''','')))) <= 0 
begin
	set @lstEmpty = 'Y'
end 

declare @Cus1Empty as char(1)
set @Cus1Empty = 'N'
if len(rtrim(ltrim(replace(@cus1nolist,'''','')))) <= 0 
begin
	set @Cus1Empty = 'Y'
end 


declare @Cus2Empty as char(1)
set @Cus2Empty = 'N'
if len(rtrim(ltrim(replace(@cus2nolist,'''','')))) <= 0 
begin
	set @Cus2Empty = 'Y'
end 


declare @VenEmpty as char(1)
set @VenEmpty = 'N'
if len(rtrim(ltrim(replace(@vennolist,'''','')))) <= 0 
begin
	set @VenEmpty = 'Y'
end 

DECLARE 
	@itmlst2	varchar(500),
	@dummy	varchar(20),
	@TIME	int

-- Editted by David Yue 2012-08-27
/*
declare 
	@transdate1 as char(10),
	@transdate2 as char(10),
	@transend1 as char(10),
	@transend2 as char(10)
*/

set @transend = dateadd(day,1,@transend)
set @transend = dateadd(millisecond, -10, @transend)

/*
set @transdate1  = convert(char(10),@transdate,111)
set @transdate2  = convert(char(10),@transdate-1,111)
set @transend1 = convert(char(10),@transend,111)
set @transend2 = convert(char(10),@transend-1,111)
*/

declare @compName varchar(100)
select @compName = yco_conam from SYCOMINF(NOLOCK) where yco_cocde=@cocde
if @cocde<>'MS' 
begin
	set @compName = 'UNITED CHINESE GROUP'
end
-----------------------------------------------------------------------------

SET ANSI_WARNINGS OFF 

DECLARE	-- IMITMDAT
@iid_cocde 	nvarchar(6),	@iid_venno 	nvarchar(6),	@iid_venitm 	nvarchar(20),	
@iid_xlsfil 	nvarchar(30),	@iid_chkdat	datetime,	@iid_alsitmno	nvarchar(20)

DECLARE @venitm VARCHAR(20)
DECLARE @datbomlist VARCHAR(100)
DECLARE @ibabomlist VARCHAR(100)

CREATE TABLE #tmpBOM_before
(
	venitm_bef nvarchar(20),
	bomlist_bef nvarchar(200)
)

CREATE TABLE #tmpBOM_after
(
	venitm_aft nvarchar(20),
	bomlist_aft nvarchar(200)
)


DECLARE @listStr VARCHAR(100)

CREATE TABLE #tmpItm
(
	itmlst nvarchar(50)
)

declare @ItmStrRemain	nvarchar(500)
declare @ItmStrPart		nvarchar(20)

if @lstEmpty <> 'Y'
begin

	set @itmlst = rtrim(ltrim(replace(@itmlst,'''','')))
	
	if @itmlst <> '' 
	begin 
		set @ItmStrRemain = @itmlst
	
		while charindex(',',@ItmStrRemain)<>0
		begin
			set @ItmStrPart = ltrim(left(@ItmStrRemain, charindex(',', @ItmStrRemain)-1))
			set @ItmStrRemain = right(@ItmStrRemain, len(@ItmStrRemain) - charindex(',', @ItmStrRemain))
			insert into #tmpItm values (@ItmStrPart)
		end
	
		if charindex(',',@ItmStrRemain) = 0 
			insert into #tmpItm values (ltrim(@ItmStrRemain))
	end
end
else
begin
	insert into #tmpItm values ('')
end 


-- Process cus1no Query --

create table #tempCus1no(
tempCus1no  nvarchar(6)
)
 if @Cus1Empty<>'Y'
begin
	set @cus1qry = ''
	set @i = 0
	
	while charindex(',',@cus1nolist) <> 0
	begin
		set @i = charindex(',',@cus1nolist)
		if @i = 0 and charindex(@cus1nolist,@cus1qry) = 0
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
				set @cus1qry = @cus1qry + case len(@cus1qry) when 0 then '' else ' or cbi_cusno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @cus1qry = @cus1qry + case len(@cus1qry) when 0 then '' else ' or cbi_cusno ' end + '= ''' + @value + ''''
			end
		end
	end
	
	if charindex(@cus1nolist, @cus1qry) = 0
	begin
		if charindex('~',@cus1nolist) > 0
		begin
			set @i = charindex('~',@cus1nolist)
			set @start = substring(@cus1nolist, 0, @i)
			set @end = substring(@cus1nolist, @i+1,len(@cus1nolist))
			set @cus1qry = @cus1qry + case len(@cus1qry) when 0 then '' else ' or cbi_cusno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
		end
		else
		begin
			set @cus1qry = @cus1qry + case len(@cus1qry) when 0 then '' else ' or cbi_cusno ' end + '= ''' + @cus1nolist + ''''
		end
	end
	
	set @cus1qry = ' where cbi_cusno ' + @cus1qry

	exec ('insert into #tempCus1no select distinct  cbi_cusno from CUBASINF '+@cus1qry)
end -- if ltrim(rtrim(@cus1nolist)) <> ''



--select * from #tempCus1no
--------------------cus1no part end

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--

-- Process cus2no Query --

create table #tempCus2no(
tempCus2no  nvarchar(6)
)
if @Cus2Empty<>'Y'
begin

	if ltrim(rtrim(@cus2nolist)) <> ''
	begin
		set @cus2qry = ''
		set @i = 0
	
		while charindex(',',@cus2nolist) <> 0
		begin
			set @i = charindex(',',@cus2nolist)
			if @i = 0 and charindex(@cus2nolist,@cus2qry) = 0
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
					set @cus2qry = @cus2qry + case len(@cus2qry) when 0 then '' else ' or cbi_cusno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
				end
				else
				begin
					set @cus2qry = @cus2qry + case len(@cus2qry) when 0 then '' else ' or cbi_cusno ' end + '= ''' + @value + ''''
				end
			end
		end
	
		if charindex(@cus2nolist, @cus2qry) = 0
		begin
			if charindex('~',@cus2nolist) > 0
			begin
				set @i = charindex('~',@cus2nolist)
				set @start = substring(@cus2nolist, 0, @i)
				set @end = substring(@cus2nolist, @i+1,len(@cus2nolist))
				set @cus2qry = @cus2qry + case len(@cus2qry) when 0 then '' else ' or cbi_cusno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @cus2qry = @cus2qry + case len(@cus2qry) when 0 then '' else ' or cbi_cusno ' end + '= ''' + @cus2nolist + ''''
			end
		end
	
		set @cus2qry = ' where cbi_cusno ' + @cus2qry
	end -- if ltrim(rtrim(@cus2nolist)) <> ''
	--select @cus2qry

	--select ('insert into #tempCus2no select distinct  cbi_cusno from CUBASINF'+@cus2qry)
	exec ('insert into #tempCus2no select distinct  cbi_cusno from CUBASINF'+@cus2qry)
	--select * from #tempCus2no
end

---------------------------
----------------------cus2no part end


--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
-- Process venno Query --
create table #tempVENno(
tempVen  nvarchar(6)
)
if @VenEmpty<>'Y'
begin

	if ltrim(rtrim(@vennolist)) <> ''
	begin
		set @dvqry = ''
		set @i = 0
	
		while charindex(',',@vennolist) <> 0
		begin
			set @i = charindex(',',@vennolist)
			if @i = 0 and charindex(@vennolist,@dvqry) = 0
				set @i = len(@vennolist)
			set @value = substring(@vennolist, 0, @i)
			set @vennolist = substring(@vennolist,@i+1,len(@vennolist)-@i)
			if ltrim(rtrim(@value)) <> ''
			begin
				if charindex('~',@value) > 0
				begin
					set @i = charindex('~',@value)
					set @start = substring(@value, 0, @i)
					set @end = substring(@value, @i+1,len(@value))
					set @dvqry = @dvqry + case len(@dvqry) when 0 then '' else ' or vbi_venno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
				end
				else
				begin
					set @dvqry = @dvqry + case len(@dvqry) when 0 then '' else ' or vbi_venno ' end + '= ''' + @value + ''''
				end
			end
		end
	
		if charindex(@vennolist, @dvqry) = 0
		begin
			if charindex('~',@vennolist) > 0
			begin
				set @i = charindex('~',@vennolist)
				set @start = substring(@vennolist, 0, @i)
				set @end = substring(@vennolist, @i+1,len(@vennolist))
				set @dvqry = @dvqry + case len(@dvqry) when 0 then '' else ' or vbi_venno ' end + 'between ''' + @start + ''' and ''' + @end + ''''
			end
			else
			begin
				set @dvqry = @dvqry + case len(@dvqry) when 0 then '' else ' or vbi_venno ' end + '= ''' + @vennolist + ''''
			end
		end
	
		set @dvqry = ' where vbi_venno ' + @dvqry
	end -- if ltrim(rtrim(@vennolist)) <> ''
	--select @dvqry

	--select ('insert into #tempVENno select distinct  vbi_venno from VNBASINF'+@dvqry)
	exec ('insert into #tempVENno select distinct  vbi_venno from VNBASINF'+@dvqry)
	--select * from #tempVENno
end
---------------------------
----------------------venno part end

DECLARE cur_IMITMDAT CURSOR
FOR 	SELECT 	
		iid_cocde ,		iid_venno ,		iid_venitm ,
		iid_xlsfil,		iid_chkdat,		iid_alsitmno
	FROM 	
		IMITMDAT	
	WHERE 	
		iid_stage = 'W' 	and  iid_mode = 'NEW'

OPEN cur_IMITMDAT
FETCH NEXT FROM cur_IMITMDAT INTO 
		@iid_cocde,		@iid_venno,		@iid_venitm ,
		@iid_xlsfil,		@iid_chkdat,		@iid_alsitmno


WHILE @@fetch_status = 0
BEGIN

	set @venitm = null
	set @datbomlist = null
	set @ibabomlist = null

	SELECT 
		@datbomlist = COALESCE(@datbomlist+',' ,'') + ibd_acsno 
	FROM 
		IMBOMDAT 
	where 
		ibd_venitm = @iid_venitm and 
		ibd_stage = 'W' and 
		ibd_xlsfil = @iid_xlsfil and
		ibd_chkdat = @iid_chkdat
		

	if isnull(@datbomlist,'') <> '' 
	begin
		insert into #tmpBOM_after 
		select @iid_venitm, @datbomlist
	end
	-----------------------------------------



	SELECT 
		@ibabomlist = COALESCE(@ibabomlist+',' ,'') + iba_assitm
	FROM 
		IMBOMASS where iba_itmno = @iid_alsitmno and iba_typ = 'BOM'

	if isnull(@ibabomlist,'') <> '' 
	begin
		insert into #tmpBOM_before
		select @iid_alsitmno, @ibabomlist
	end

FETCH NEXT FROM cur_IMITMDAT INTO 
@iid_cocde ,		@iid_venno ,		@iid_venitm ,
@iid_xlsfil ,		@iid_chkdat, 		@iid_alsitmno
END
CLOSE cur_IMITMDAT
DEALLOCATE cur_IMITMDAT

--select * from #tmpBOM_after



SELECT	DISTINCT
	'Q' as 'type',
--	Header
	bas.ibi_itmno as 'ibi_itmno',
	bas.ibi_engdsc as 'ibi_engdsc', 
	dat.iid_venitm as 'iid_venitm',
	isnull(itr_tmpitm,'') as 'itr_tmpitm',
	bas.ibi_venno as 'ibi_venno',
	vnb.vbi_vensna as 'vbi_vensna',
	convert(varchar(10),bas.ibi_upddat,101) as 'ibi_upddat',
	pck.ipi_pckseq as 'ipi_pckseq',
	pck.ipi_pckunt + ' / ' + ltrim(str(pck.ipi_inrqty))+ ' / ' + ltrim(str(pck.ipi_mtrqty)) + ' / ' + ltrim(str(pck.ipi_cft,8,2)) as 'pck_packing',
	dat.iid_untcde + ' / ' + ltrim(str(dat.iid_inrqty)) + ' / ' + ltrim(str(dat.iid_mtrqty)) + ' / ' + ltrim(str(dat.iid_cft,8,2)) as 'dat_packing',
	max(rtrim(isnull(mup.imu_curcde,'')) +ltrim(str(mup.imu_ftyprc,13,4))) as 'mup_curftyprc',
	max(rtrim(isnull(dat.iid_curcde,'')) + ltrim(str(dat.iid_ftyprc,13,4))) as 'dat_curftyprc',
	rtrim(mup.imu_bcurcde) + ltrim(str(mup.imu_basprc,13,4)) as 'imu_basprc',
	rtrim(isnull(iid_curr_bef,'')) + ltrim(str(iid_basprc,13,4)) as 'iid_ftyprc',
	Case mup.imu_ftyprc when 0 then 0 else (dat.iid_ftyprc - mup.imu_ftyprc) / mup.imu_ftyprc * 100 end as 'newbasicprice',
	case mup.imu_basprc when 0 then 0 else (iid_basprc - mup.imu_basprc ) / mup.imu_basprc  * 100 end as 'newbasicprice2',
	-- Frankie Cheung 20110318 Add Before/After IM Period
	case ltrim(str(year(pck.ipi_qutdat))) when '1900' then '' else
	ltrim(str(year(pck.ipi_qutdat))) + '-' + right('0' + ltrim(str(month(pck.ipi_qutdat))),2) end as 'pck_qutdat',
	case ltrim(str(year(iid_period))) when '1900' then '' else
	ltrim(str(year(iid_period))) + '-' + right('0' + ltrim(str(month(iid_period))),2) end as 'dat_qutdat',
	-- Frankie Cheung 20110318 Add Before/After BOM Info
	isnull(bomlist_bef,'') as 'bomlist_bef',
	isnull(bomlist_aft,'') as 'bomlist_aft',
-----------------------------------------------------
--	Detail
	hdr.quh_cus1no as 'quh_cus1no',	cq1.cbi_cussna as 'cbi_cussna_pri',
	hdr.quh_cus2no as 'quh_cus2no', cq2.cbi_cussna as 'cbi_cussna_sec',
	hdr.quh_qutno as 'quh_qutno',
	hdr.quh_rvsdat as 'quh_rvsdat',
	hdr.quh_valdat as 'quh_shpstr', 
	hdr.quh_valdat as 'quh_shpend',
	hdr.quh_curcde as 'quh_curcde', 
	dtl.qud_cus1sp as 'qud_basprc',
	dtl.qud_basprc as 'selprc',
	0 as 'ordqty',
	ltrim(fml.yfi_fmlopt) +  ' - ' + ltrim(fml.yfi_fml) as 'yfi_prcfml',
	qud_fcurcde as 'sod_fcurcde', 
	qud_ftyprc as 'sod_ftyprc',
	0 as 'sod_shpqty',
	'' as 'pod_jobord', 
	bas.ibi_cocde as 'ibi_cocde'
	,@cocde as 'cocde'
	,@compName  as 'compName'
	,'NEW' as 'Stage'
FROM	
	IMBASINF bas (NOLOCK), 
	IMPCKINF pck (NOLOCK), 
	SYFMLINF fml (NOLOCK), 
	VNBASINF vnb (NOLOCK), 
	IMPRCINF mup (NOLOCK),
	#tmpItm tmp,	-- Frankie Cheung 20110615
	IMITMDAT dat (NOLOCK)
	left join QUOTNDTL dtl (NOLOCK) on 
			(dat.iid_alsitmno = qud_itmno  or dat.iid_alsitmno = qud_venitm) and 
			dat.iid_untcde = qud_untcde and 
			dat.iid_inrqty = qud_inrqty and 
			dat.iid_mtrqty = qud_mtrqty

	left join QUOTNHDR hdr (NOLOCK) on  
			dtl.qud_qutno = hdr.quh_qutno 
			-- Editted by David Yue 2012-08-27
			--and convert(char(10),hdr.quh_valdat,111)  > @transdate1
			and hdr.quh_valdat > @transdate

	left join CUBASINF cq1 (NOLOCK) on 
			hdr.quh_cus1no = cq1.cbi_cusno 

	left join CUBASINF cq2 (NOLOCK) on 
			hdr.quh_cus2no = cq2.cbi_cusno
	-- Frankie Cheung 20110318 -- Before / after BOM info.
	left join #tmpBOM_before on
			dat.iid_alsitmno = venitm_bef
	left join #tmpBOM_after on 
			dat.iid_itmno = venitm_aft
	-----------------------------------------------------------
	
	left join IMTMPREL (nolock) on itr_itmno=iid_venitm
WHERE	
	--	Lester Wu 2005-12-13 Cater Empty Item List
	-- 	('''+@lstEmpty + ''' = ''Y'' or  dat.iid_venitm IN (' + @itmlst  + ') )

		(@lstEmpty = 'Y' or  dat.iid_venitm = tmp.itmlst )
		and 
		(@Cus1Empty='Y' or imu_cus1no in (select tempCus1no from #tempCus1no)) and 
		(@Cus2Empty='Y' or imu_cus2no in (select tempCus2no from #tempCus2no)) and 
		(@VenEmpty='Y' or ibi_venno in (select tempVen from #tempVENno)) and 
		isnull(hdr.quh_cus1no,'') <> ''
		and bas.ibi_venno = vnb.vbi_venno 
		and dat.iid_alsitmno = bas.ibi_itmno
		and dat.iid_alsitmno = pck.ipi_itmno
		and dat.iid_untcde = pck.ipi_pckunt 
		and dat.iid_inrqty = pck.ipi_inrqty 
		and dat.iid_mtrqty = pck.ipi_mtrqty
		and pck.ipi_itmno = mup.imu_itmno
		and mup.imu_ventyp = 'D' 
		--and dat.iid_venno = mup.imu_venno 
		--and pck.ipi_pckseq = mup.imu_pckseq
		and pck.ipi_pckunt = mup.imu_pckunt
		and pck.ipi_inrqty = mup.imu_inrqty
		and pck.ipi_mtrqty = mup.imu_mtrqty
		and  mup.imu_fmlopt = fml.yfi_fmlopt 
		and dat.iid_mode = 'NEW'
		and len(isnull(dat.iid_alsitmno,'')) > 0
		and dat.iid_stage = 'W'
		-- Editted by David Yue 2012-08-27
		/*
		and convert(char(10),dat.iid_upddat,111)  >= @transdate2
		and convert(char(10),dat.iid_upddat,111)  <= @transend2
		and convert(char(10),hdr.quh_valdat,111)  > @transdate1
		*/
		and dat.iid_upddat between @transdate and @transend
		and hdr.quh_valdat > @transdate

GROUP BY
		bas.ibi_itmno,
		bas.ibi_engdsc, 
		dat.iid_venitm,
		bas.ibi_venno,
		vnb.vbi_vensna,
		bas.ibi_upddat,
		pck.ipi_pckseq,
		pck.ipi_pckunt + ' / ' + ltrim(str(pck.ipi_inrqty))+ ' / ' + ltrim(str(pck.ipi_mtrqty)) + ' / ' + ltrim(str(pck.ipi_cft,8,2)),
		dat.iid_untcde + ' / ' + ltrim(str(dat.iid_inrqty)) + ' / ' + ltrim(str(dat.iid_mtrqty)) + ' / ' + ltrim(str(dat.iid_cft,8,2)),
		rtrim(mup.imu_bcurcde) + ltrim(str(mup.imu_basprc,13,4)),
		rtrim(isnull(iid_curr_bef,'')) + ltrim(str(iid_basprc,13,4)) , 
		Case mup.imu_ftyprc 	when 0 then 0 else (dat.iid_ftyprc - mup.imu_ftyprc) / mup.imu_ftyprc * 100 end,
		case mup.imu_basprc when 0 then 0 else (iid_basprc - mup.imu_basprc ) / mup.imu_basprc  * 100 end , 
		-- Frankie Cheung 20110318 Add Before/After IM Period
		case ltrim(str(year(pck.ipi_qutdat))) when '1900' then '' else
		ltrim(str(year(pck.ipi_qutdat))) + '-' + right('0' + ltrim(str(month(pck.ipi_qutdat))),2) end ,
		case ltrim(str(year(iid_period))) when '1900' then '' else
		ltrim(str(year(iid_period))) + '-' + right('0' + ltrim(str(month(iid_period))),2) end,
		-- Frankie Cheung 20110318 Add Before/After BOM Info
		isnull(bomlist_bef,''),
		isnull(bomlist_aft,''),
		-----------------------------------------------------
		hdr.quh_cus1no,	
		cq1.cbi_cussna,
		hdr.quh_cus2no, 
		cq2.cbi_cussna,
		hdr.quh_qutno,
		hdr.quh_rvsdat,
		hdr.quh_valdat, 
		hdr.quh_valdat,
		hdr.quh_curcde, 
		dtl.qud_cus1sp,
		dtl.qud_basprc,
		ltrim(fml.yfi_fmlopt) +  ' - ' + ltrim(fml.yfi_fml),
		qud_fcurcde, 
		qud_ftyprc,
		bas.ibi_cocde	
		,isnull(itr_tmpitm,'')
HAVING
		pck.ipi_pckunt + ' / ' + ltrim(str(pck.ipi_inrqty))+ ' / ' + ltrim(str(pck.ipi_mtrqty)) + ' / ' + ltrim(str(pck.ipi_cft,8,2)) <>
		dat.iid_untcde + ' / ' + ltrim(str(dat.iid_inrqty)) + ' / ' + ltrim(str(dat.iid_mtrqty)) + ' / ' + ltrim(str(dat.iid_cft,8,2))
		OR
		max(rtrim(ISNULL(mup.imu_curcde,'')) + str(mup.imu_ftyprc)) <>
		max(rtrim(ISNULL(dat.iid_curcde,'')) + str(dat.iid_ftyprc))
		OR
		rtrim(mup.imu_bcurcde) + ltrim(str(mup.imu_basprc,13,4)) <>
		rtrim(isnull(iid_curr_bef,'')) + ltrim(str(iid_basprc,13,4)) 
UNION
Select	DISTINCT
	'S',
--	Header
	bas.ibi_itmno,
	bas.ibi_engdsc, 
	dat.iid_venitm,
	isnull(itr_tmpitm,'') as 'itr_tmpitm',
	bas.ibi_venno,
	vnb.vbi_vensna,
	convert(varchar(10),bas.ibi_upddat,101),
	pck.ipi_pckseq,
	pck.ipi_pckunt + ' / ' + ltrim(str(pck.ipi_inrqty))+ ' / ' + ltrim(str(pck.ipi_mtrqty)) + ' / ' + ltrim(str(pck.ipi_cft,8,2)),
	dat.iid_untcde + ' / ' + ltrim(str(dat.iid_inrqty)) + ' / ' + ltrim(str(dat.iid_mtrqty)) + ' / ' + ltrim(str(dat.iid_cft,8,2)),
	max(rtrim(ISNULL(mup.imu_curcde,'')) + ltrim(str(mup.imu_ftyprc,13,4))),
	max(rtrim(ISNULL(dat.iid_curcde,'')) + ltrim(str(dat.iid_ftyprc,13,4))),
	rtrim(mup.imu_bcurcde) + ltrim(str(mup.imu_basprc,13,4)),
	rtrim(isnull(iid_curr_bef,'')) + ltrim(str(iid_basprc,13,4)) as 'iid_ftyprc',
--	new basic price
	Case mup.imu_ftyprc when 0 then 0 else (dat.iid_ftyprc - mup.imu_ftyprc) / mup.imu_ftyprc * 100 end,
	case mup.imu_basprc when 0 then 0 else (iid_basprc - mup.imu_basprc ) / mup.imu_basprc  * 100 end as 'newbasicprice2',
	-- Frankie Cheung 20110318 Add Before/After IM Period
	case ltrim(str(year(pck.ipi_qutdat))) when '1900' then '' else
	ltrim(str(year(pck.ipi_qutdat))) + '-' + right('0' + ltrim(str(month(pck.ipi_qutdat))),2) end as 'pck_qutdat',
	case ltrim(str(year(iid_period))) when '1900' then '' else
	ltrim(str(year(iid_period))) + '-' + right('0' + ltrim(str(month(iid_period))),2) end as 'dat_qutdat',
	-- Frankie Cheung 20110318 Add Before/After BOM Info
	isnull(bomlist_bef,'') as 'bomlist_bef',
	isnull(bomlist_aft,'') as 'bomlist_aft',
	-----------------------------------------------------
--	Detail
	vw.soh_cus1no, cq1.cbi_cussna,
	vw.soh_cus2no, cq2.cbi_cussna,
	vw.soh_ordno,
	vw.soh_issdat,
	vw.sod_shpstr, vw.sod_shpend,
	vw.soh_curcde, vw.sod_untprc,
	vw.sod_itmprc, sum(vw.sod_ordqty),
	ltrim(fml.yfi_fmlopt) +  ' - ' + ltrim(fml.yfi_fml),
	vw.sod_fcurcde, vw.sod_ftyprc,
	sum(vw.sod_shpqty),
	isnull(pod_jobord, ''),
	bas.ibi_cocde
	,@cocde
	,@compName as 'compName'
	,'NEW' as 'Stage'
FROM	
	IMBASINF bas (NOLOCK), 
	IMPCKINF pck (NOLOCK), 
	SYFMLINF fml (NOLOCK), 
	VNBASINF vnb (NOLOCK), 
	IMPRCINF mup (NOLOCK),
	#tmpItm tmp,	-- Frankie Cheung 20110615
	IMITMDAT dat (NOLOCK)
	left join vw_select_iar00001 vw  on 
		dat.iid_alsitmno =vw. sod_itmno and 
		dat.iid_untcde = vw.sod_pckunt and 
		dat.iid_inrqty = vw.sod_inrctn and 
		dat.iid_mtrqty = vw.sod_mtrctn 
--		and vw.soh_ordsts <> 'CLO'
	left join CUBASINF cq1 (NOLOCK) on 
			vw.soh_cus1no = cq1.cbi_cusno
	left join CUBASINF cq2 (NOLOCK) on 
			vw.soh_cus2no = cq2.cbi_cusno
	left join POORDDTL (NOLOCK) on 
			vw.sod_purord = pod_purord and 
			vw.sod_purseq = pod_purseq
	-- Frankie Cheung 20110318 -- Before / after BOM info.
	left join #tmpBOM_before on
			dat.iid_alsitmno = venitm_bef
	left join #tmpBOM_after on 
			dat.iid_itmno = venitm_aft
	-----------------------------------------------------------
	left join IMTMPREL (nolock) on itr_itmno=iid_venitm
WHERE	
--	(@lstEmpty = 'Y' or  dat.iid_venitm IN (@itmlst) )
	(@lstEmpty = 'Y' or  dat.iid_venitm = tmp.itmlst )
	and 
	(@Cus1Empty='Y' or imu_cus1no in (select tempCus1no from #tempCus1no)) and
	(@Cus2Empty='Y' or imu_cus2no in (select tempCus2no from #tempCus2no)) and 
	(@VenEmpty='Y' or ibi_venno in (select tempVen from #tempVENno)) and 
	bas.ibi_venno = vnb.vbi_venno 
	and dat.iid_alsitmno = bas.ibi_itmno
	and dat.iid_alsitmno = pck.ipi_itmno
	and	dat.iid_untcde = pck.ipi_pckunt and dat.iid_inrqty = pck.ipi_inrqty 
	and 	dat.iid_mtrqty = pck.ipi_mtrqty
	and pck.ipi_itmno = mup.imu_itmno
	and mup.imu_ventyp = 'D'
	--and dat.iid_venno = mup.imu_venno 
	--and pck.ipi_pckseq = mup.imu_pckseq
	and pck.ipi_pckunt = mup.imu_pckunt
	and pck.ipi_inrqty = mup.imu_inrqty
	and pck.ipi_mtrqty = mup.imu_mtrqty
	and mup.imu_fmlopt = fml.yfi_fmlopt 
	and dat.iid_mode = 'NEW'
	and len(isnull(dat.iid_alsitmno,'')) > 0 
	and dat.iid_stage = 'W' 
	-- Editted by David Yue 2012-08-27
	--and convert(char(10),dat.iid_upddat,111)  >=  @transdate2
	--and convert(char(10),dat.iid_upddat,111)  <=  @transend2
	and dat.iid_upddat between @transdate and @transend

GROUP BY
	bas.ibi_itmno,
	bas.ibi_engdsc, 
	dat.iid_venitm,
	bas.ibi_venno,
	vnb.vbi_vensna,
	bas.ibi_upddat,
	pck.ipi_pckseq,
	pck.ipi_pckunt + ' / ' + ltrim(str(pck.ipi_inrqty))+ ' / ' + ltrim(str(pck.ipi_mtrqty)) + ' / ' + ltrim(str(pck.ipi_cft,8,2)),
	dat.iid_untcde + ' / ' + ltrim(str(dat.iid_inrqty)) + ' / ' + ltrim(str(dat.iid_mtrqty)) + ' / ' + ltrim(str(dat.iid_cft,8,2)),
	rtrim(mup.imu_bcurcde) + ltrim(str(mup.imu_basprc,13,4)),
	rtrim(isnull(iid_curr_bef,'')) + ltrim(str(iid_basprc,13,4)) , 
	Case mup.imu_ftyprc when 0 then  0 else (dat.iid_ftyprc - mup.imu_ftyprc) / mup.imu_ftyprc * 100 end, 
	case mup.imu_basprc when 0 then 0 else (iid_basprc - mup.imu_basprc ) / mup.imu_basprc  * 100 end, 
	-- Frankie Cheung 20110318 Add Before/After IM Period
	case ltrim(str(year(pck.ipi_qutdat))) when '1900' then '' else
	ltrim(str(year(pck.ipi_qutdat))) + '-' + right('0' + ltrim(str(month(pck.ipi_qutdat))),2) end,
	case ltrim(str(year(iid_period))) when '1900' then '' else
	ltrim(str(year(iid_period))) + '-' + right('0' + ltrim(str(month(iid_period))),2) end,
	-- Frankie Cheung 20110318 Add Before/After BOM Info
	isnull(bomlist_bef,''),
	isnull(bomlist_aft,''),
	---------------------------------------------------
	vw.soh_cus1no, cq1.cbi_cussna,
	vw.soh_cus2no, cq2.cbi_cussna,
	vw.soh_ordno,
	vw.soh_issdat,
	vw.sod_shpstr, vw.sod_shpend,
	vw.soh_curcde, vw.sod_untprc,
	vw.sod_itmprc, vw.sod_ordqty,
	ltrim(fml.yfi_fmlopt) +  ' - ' + ltrim(fml.yfi_fml),
	vw.sod_fcurcde, vw.sod_ftyprc,
	pod_jobord,
	bas.ibi_cocde
	,isnull(itr_tmpitm,'')
HAVING
	pck.ipi_pckunt + ' / ' + ltrim(str(pck.ipi_inrqty))+ ' / ' + ltrim(str(pck.ipi_mtrqty)) + ' / ' + ltrim(str(pck.ipi_cft,8,2)) <>
	dat.iid_untcde + ' / ' + ltrim(str(dat.iid_inrqty)) + ' / ' + ltrim(str(dat.iid_mtrqty)) + ' / ' + ltrim(str(dat.iid_cft,8,2))
	OR
	max(rtrim(ISNULL(mup.imu_curcde,'')) + ltrim(str(mup.imu_ftyprc,13,4))) <>
	max(rtrim(ISNULL(dat.iid_curcde,'')) + ltrim(str(dat.iid_ftyprc,13,4)))
	OR
	rtrim(mup.imu_bcurcde) + ltrim(str(mup.imu_basprc,13,4)) <>
	rtrim(isnull(iid_curr_bef,'')) + ltrim(str(iid_basprc,13,4)) 
order by 	2,8,1

select @lstEmpty
SET ANSI_WARNINGS ON






















GO
GRANT EXECUTE ON [dbo].[sp_select_IAR00001_new] TO [ERPUSER] AS [dbo]
GO
