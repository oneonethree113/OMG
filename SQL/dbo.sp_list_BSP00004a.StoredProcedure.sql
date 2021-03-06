/****** Object:  StoredProcedure [dbo].[sp_list_BSP00004a]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_BSP00004a]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_BSP00004a]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO








/*
=========================================================
Program ID	: sp_list_BSP00004a
Description   	: 
Programmer  	: Marco Chan
Create  Date   	: 20/10/2005
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
-- sp_list_BSP00004a '', '01/01/2004 00:00:00.000', '01/01/2006 23:59:59', '01/01/2004 00:00:00.000', '12/01/2005 23:59:59', '', '', '', '04a582-803191', '04a582-803191', '', '', '', '', '', '', 'Q', 'N', 'Hello world', 'Y', 'X'


*/
create procedure [dbo].[sp_list_BSP00004a]
	@cocde		nvarchar(6),	

	@itmcredatFm	datetime,
	@itmcredatTo	datetime,

	@scissdatFm	datetime,
	@scissdatTo	datetime,

	@vdrFm		nvarchar(20),
	@vdrTo		nvarchar(20),
	@vdrTyp		char(1),

	@vitmnoFm	nvarchar(20),
	@vitmnoTo	nvarchar(20),
	@vitmList	nvarchar(1000),

	@prdlneFm	nvarchar(10),
	@prdlneTo	nvarchar(10),
	@prdlneList	nvarchar(1000),

	@dsgFm		nvarchar(10),
	@dsgTo		nvarchar(10),

	@orderBy	nvarchar(20),
	@printAmt	nvarchar(20),

	@title		nvarchar(100),

	@showCust	char(1),

	@TEMP		nvarchar(10)
as

set nocount on 

declare @optItmStr		char(1),
	@optPrdLneStr		char(1),
	@ItmStrRemain		nvarchar(1000),
	@PrdLneStrRemain	nvarchar(1000),
	@ItmStrPart		nvarchar(20),
	@PrdLneStrPart		nvarchar(10)
create table #TMP_ITM (tmp_ITMNO nvarchar(20)) on [PRIMARY]
create table #TMP_LNE (tmp_PRDLNE nvarchar(10)) on [PRIMARY]

set @optItmStr = 'N'
if ltrim(rtrim(@vitmList)) <> '' 
begin 
	set @optItmStr = 'Y'
	set @ItmStrRemain = @vitmList

	while charindex(',',@ItmStrRemain)<>0
	begin
		set @ItmStrPart = ltrim(left(@ItmStrRemain, charindex(',', @ItmStrRemain)-1))
		set @ItmStrRemain = right(@ItmStrRemain, len(@ItmStrRemain) - charindex(',', @ItmStrRemain))
		insert into #TMP_ITM values (@ItmStrPart)
	end

	if charindex(',',@ItmStrRemain) = 0 
		insert into #TMP_ITM values (@ItmStrRemain)
end

set @optPrdLneStr = 'N'
if ltrim(rtrim(@prdlneList)) <> ''
begin
	set @optPrdLneStr = 'Y'
	set @PrdLneStrRemain = @prdlneList

	while charindex(',', @PrdLneStrRemain) <> 0
	begin
		set @PrdLneStrPart = ltrim(left(@PrdLneStrRemain, charindex(',', @PrdLneStrRemain)-1))
		set @PrdLneStrRemain = right(@PrdLneStrRemain, len(@PrdLneStrRemain) - charindex(',', @PrdLneStrRemain))
		insert into #TMP_LNE values (@PrdLneStrPart)
	end

	if charindex(',',@PrdLneStrRemain) = 0 
		insert into #TMP_LNE values (@PrdLneStrRemain)
end

CREATE TABLE #TMP_RESULT(
	tmp_dsg		nvarchar(100),
	tmp_prdlne	nvarchar(20),
	tmp_itmno	nvarchar(20),
	tmp_vitmno	nvarchar(20),
	tmp_itmdsc	nvarchar(800),
	tmp_imgpth	nvarchar(200),
)

CREATE TABLE #RESULT(
	res_reccnt	int,
	res_dsg		nvarchar(100),
	res_prdlne	nvarchar(20),
	res_itmno	nvarchar(20),
	res_vitmno	nvarchar(20),
	res_itmdsc	nvarchar(800),
	res_imgpth	nvarchar(200),
	res_baseunt	nvarchar(6),
	res_ordqty	int,
	res_salamtusd	numeric(13,4),	
	res_ttlcnt_vdr	int,
	res_qutcnt_vdr	int, 
	res_cuslist		nvarchar(1000) --Lester Wu 2005-12-06
)

declare @optVdr char(1), @optvItmno char(1), @optPrdlne char(1), @optDsg char(1)
declare @optSCIssDate char(1)

-- Lester Wu 2005-12-06
declare @cussna nvarchar(50), @cusString nvarchar(1000)

if @vdrFm = ''
	set @optVdr = 'N'
else
	set @optVdr = 'Y'

if @vitmnoFm = ''
	set @optvItmno = 'N'
else
	set @optvItmno = 'Y'

if @prdlneFm = ''
	set @optPrdlne = 'N'
else
	set @optPrdlne = 'Y'

if @dsgFm = ''
	set @optDsg = 'N'
else
	set @optDsg = 'Y'

if @scissdatFm = ''
	set @optSCIssDate = 'N'
else
	set @optSCIssDate = 'Y'


insert into #TMP_RESULT
select 
ysi_cde + ' - ' + ysi_dsc,
ibi_lnecde,
ibi_itmno,
ivi_venitm,
ibi_engdsc,
ibi_imgpth
from 
IMBASINF (nolock)
left join IMVENINF (nolock) on ibi_itmno = ivi_itmno and ivi_def = 'Y'
left join SYLNEINF (nolock) on ibi_lnecde = yli_lnecde
left join SYSETINF (nolock) on ysi_typ = '15' and ysi_cde = yli_dsgcde
--left join VNBASINF (nolock) on vbi_venno = ivi_venno
left join VNBASINF (nolock) on vbi_venno = ibi_venno
where
(ibi_credat between @itmcredatFm and @itmcredatTo)
and (@vdrTyp = '' or (vbi_ventyp = @vdrTyp))
--and (@optVdr = 'N' or (vbi_venno between @vdrFm and @vdrTo))
and (@optVdr = 'N' or (ibi_venno between @vdrFm and @vdrTo))
and (@optvItmno = 'N' or (ivi_venitm between @vitmnoFm and @vitmnoTo))
and (@optPrdlne = 'N' or (ibi_lnecde between @prdlneFm and @prdlneTo))
and (@optDsg = 'N' or (yli_dsgcde between @dsgFm and @dsgTo))
and vbi_ventyp in ('I', 'J')
and yli_dsgcde <> ''
and ibi_lnecde <> ''

if @optItmStr = 'Y' and @optPrdLneStr = 'Y'
begin
	insert into #RESULT
	select
	0,
	a.tmp_dsg,
	a.tmp_prdlne,
	a.tmp_itmno,
	a.tmp_vitmno,
	a.tmp_itmdsc,
	a.tmp_imgpth,
	'',
	0,
	0,
	0,
	0, 
	'' 	-- Lester Wu 
	from 
	#TMP_RESULT a, #TMP_ITM b, #TMP_LNE c
	where a.tmp_vitmno = b.tmp_ITMNO
	and a.tmp_prdlne = c.tmp_PRDLNE
end
else if @optItmStr = 'Y'
begin
	insert into #RESULT
	select
	0,
	a.tmp_dsg,
	a.tmp_prdlne,
	a.tmp_itmno,
	a.tmp_vitmno,
	a.tmp_itmdsc,
	a.tmp_imgpth,
	'',
	0,
	0,
	0,
	0 , 
	'' 	-- Lester Wu 2005-12-06
	from 
	#TMP_RESULT a, #TMP_ITM b
	where a.tmp_vitmno = b.tmp_ITMNO
end
else if @optPrdLneStr = 'Y'
begin
	insert into #RESULT
	select
	0,
	a.tmp_dsg,
	a.tmp_prdlne,
	a.tmp_itmno,
	a.tmp_vitmno,
	a.tmp_itmdsc,
	a.tmp_imgpth,
	'',
	0,
	0,
	0,
	0,
	''	-- Lester Wu 2005-12-06
	from 
	#TMP_RESULT a, #TMP_LNE c
	where a.tmp_prdlne = c.tmp_PRDLNE
end
else
begin
	insert into #RESULT
	select
	0,
	a.tmp_dsg,
	a.tmp_prdlne,
	a.tmp_itmno,
	a.tmp_vitmno,
	a.tmp_itmdsc,
	a.tmp_imgpth,
	'',
	0,
	0,
	0,
	0,
	''	-- Lester Wu 2005-12-06
	from 
	#TMP_RESULT a
end


declare @dsg nvarchar(100), @pre_dsg nvarchar(100)
declare @prdlne nvarchar(20), @pre_prdlne nvarchar(20)
declare @itmno nvarchar(20), @vitmno nvarchar(20)
declare @ordqty int, @salamtusd numeric(13,4), @baseunt nvarchar(6)

declare @counter0 int, @counter1 int
set @counter0 = 0 -- count for total per vendor
set @counter1 = 0 -- count for quoted total per vendor

set @pre_dsg = ''
set @pre_prdlne = ''

declare cur_itmno cursor for select res_dsg, res_prdlne, res_itmno, res_vitmno from #RESULT order by res_dsg, res_prdlne, res_itmno, res_vitmno
open cur_itmno
fetch next from cur_itmno into @dsg, @prdlne, @itmno, @vitmno

while @@fetch_status = 0
begin
	if @pre_dsg = '' and @pre_prdlne = ''
	begin
		set @pre_dsg = @dsg
		set @pre_prdlne = @prdlne
	end
	
	if @pre_dsg = @dsg and @pre_prdlne = @prdlne
	begin
		set @counter0 = @counter0 + 1
	end
	else
	begin
		set @counter0 = 1
		set @counter1 = 0
		set @pre_dsg = @dsg
		set @pre_prdlne = @prdlne
	end

	set @ordqty = 0
	set @salamtusd = 0

	-- Order Qty in PC
	select @ordqty = sum(sod_ordqty * isnull(ycf_value, 0)), @baseunt = ycf_code2 
	from SCORDDTL (nolock)
	left join SCORDHDR (nolock) on sod_ordno = soh_ordno
	left join SYCONFTR (nolock) on ycf_code1 = sod_pckunt
	where sod_itmno = @itmno
	and (@optSCIssDate = 'N' or (soh_issdat between @scissdatFm and @scissdatTo))
	group by ycf_code2

	-- Sales Amount in USD
--	select @salamtusd = isnull(sum(sod_selprc * isnull(ysi_selrat, 0)), 0)
	-- Frankie Cheung 20091006
	Select @salamtusd = sum(case soh_curexrat when 0 then 0 else isnull(sod_selprc / soh_curexrat,0) end)
	from SCORDDTL (nolock)
	left join SCORDHDR (nolock) on sod_ordno = soh_ordno
	--Frankie Cheung 20091006
--	left join SYSETINF (nolock) on ysi_typ = '06' and ysi_cde = sod_curcde
	where sod_itmno = @itmno
	and (@optSCIssDate = 'N' or (soh_issdat between @scissdatFm and @scissdatTo))

	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	-- Lester Wu 2005-12-06
	-- Retrieve List of ordered customer
	set @cusString = ''

	if @ordqty > 0 
	begin
		declare cur_cusno cursor for 
		select distinct isnull(cbi_cussna,'') as 'cbi_cussna'
		from SCORDDTL (nolock)
		left join SCORDHDR (nolock) on sod_ordno = soh_ordno
		left join CUBASINF (nolock) on soh_cus1no = cbi_cusno
		where sod_itmno = @itmno
		and (@optSCIssDate = 'N' or (soh_issdat between @scissdatFm and @scissdatTo))
		
		open cur_cusno
		fetch next from cur_cusno into @cussna
		
		while @@fetch_status = 0
		begin
			if @cusString = '' 
			begin
				set @cusString = @cussna
			end
			else
			begin
				set @cusString = @cusString + ', ' + @cussna
			end
			fetch next from cur_cusno into @cussna
		end
		close cur_cusno
		deallocate cur_cusno
	end
	--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

	if @ordqty > 0 
	begin
		set @counter1 = @counter1 + 1
	end
	
	-- Lester Wu 2005-12-06, update the customer list
	--update #RESULT set res_reccnt = @counter0, res_ordqty = @ordqty, res_salamtusd = @salamtusd , res_baseunt = @baseunt where res_itmno = @itmno
	update #RESULT set res_cuslist = @cusString,  res_reccnt = @counter0, res_ordqty = @ordqty, res_salamtusd = @salamtusd , res_baseunt = @baseunt where res_itmno = @itmno

	update #RESULT set res_ttlcnt_vdr = @counter0, res_qutcnt_vdr = @counter1 where res_dsg = @dsg and res_prdlne = @prdlne

	fetch next from cur_itmno into @dsg, @prdlne, @itmno, @vitmno
end
close cur_itmno
deallocate cur_itmno


-- Remove data with ordqty = 0
delete from #RESULT where res_ordqty = 0


-- Reorder of sequence by total qty or amount
declare @counter2 int
set @counter2 = 0 

set @pre_dsg = ''
set @pre_prdlne = ''


if @orderBy = 'A'
begin
	declare cur_orderAmt cursor for select res_dsg, res_prdlne, res_itmno, res_vitmno from #RESULT order by res_dsg, res_prdlne, res_salamtusd desc, res_itmno, res_vitmno
	open cur_orderAmt
	fetch next from cur_orderAmt into @dsg, @prdlne, @itmno, @vitmno
	
	while @@fetch_status = 0
	begin
		if @pre_dsg = '' and @pre_prdlne = ''
		begin
			set @pre_dsg = @dsg
			set @pre_prdlne = @prdlne
		end
		
		if @pre_dsg = @dsg and @pre_prdlne = @prdlne
		begin
			set @counter2 = @counter2 + 1
		end
		else
		begin
			set @counter2 = 1
			set @pre_dsg = @dsg
			set @pre_prdlne = @prdlne
		end
	
		update #RESULT set res_reccnt = @counter2 where res_dsg = @dsg and res_prdlne = @prdlne and res_itmno = @itmno
	
		fetch next from cur_orderAmt into @dsg, @prdlne, @itmno, @vitmno
	end
	close cur_orderAmt
	deallocate cur_orderAmt
end
else
begin
	declare cur_orderQty cursor for select res_dsg, res_prdlne, res_itmno, res_vitmno from #RESULT order by res_dsg, res_prdlne, res_ordqty desc, res_itmno, res_vitmno
	open cur_orderQty
	fetch next from cur_orderQty into @dsg, @prdlne, @itmno, @vitmno
	
	while @@fetch_status = 0
	begin
		if @pre_dsg = '' and @pre_prdlne = ''
		begin
			set @pre_dsg = @dsg
			set @pre_prdlne = @prdlne
		end
		
		if @pre_dsg = @dsg and @pre_prdlne = @prdlne
		begin
			set @counter2 = @counter2 + 1
		end
		else
		begin
			set @counter2 = 1
			set @pre_dsg = @dsg
			set @pre_prdlne = @prdlne
		end
	
		update #RESULT set res_reccnt = @counter2 where res_dsg = @dsg and res_prdlne = @prdlne and res_itmno = @itmno
	
		fetch next from cur_orderQty into @dsg, @prdlne, @itmno, @vitmno
	end
	close cur_orderQty
	deallocate cur_orderQty
end



if @@LANGUAGE <> 'us_english' 
	set LANGUAGE 'us_english'

select 
isnull(convert(varchar(20), @itmcredatFm, 107),'') 'res_itmcredatFm',
isnull(convert(varchar(20), @itmcredatTo, 107),'') 'res_itmcredatTo',
isnull(convert(varchar(20), @scissdatFm, 107),'') 'res_scissdatFm',
isnull(convert(varchar(20), @scissdatTo, 107),'') 'res_scissdatTo',

isnull(@title, '') 'res_title',
isnull(@printAmt, '') 'res_printAmt',
isnull(@orderBy, '') 'res_orderBy',

isnull(@showCust, '') 'res_showCust',

isnull(a.res_reccnt, 0) 'res_reccnt1',
isnull(a.res_dsg, '') 'res_dsg1',
isnull(a.res_prdlne, '') 'res_prdlne1',
isnull(a.res_itmno, '') 'res_itmno1',
isnull(a.res_vitmno, '') 'res_vitmno1',
isnull(a.res_itmdsc, '') 'res_itmdsc1',
isnull(a.res_baseunt, '') 'res_baseunt1',
isnull(a.res_ordqty, 0) 'res_ordqty1',
isnull(a.res_salamtusd, 0) 'res_salamtusd1',
isnull(a.res_imgpth, '') 'res_imgpth1',
isnull(a.res_ttlcnt_vdr, 0) 'res_ttlcnt_vdr1',
isnull(a.res_qutcnt_vdr, 0) 'res_qutcnt_vdr1',
isnull(a.res_cuslist,'') 'res_cuslist1',		-- Lester Wu 2005-12-06

isnull(b.res_reccnt, 0) 'res_reccnt2',
isnull(b.res_dsg, '') 'res_dsg2',
isnull(b.res_prdlne, '') 'res_prdlne2',
isnull(b.res_itmno, '') 'res_itmno2',
isnull(b.res_vitmno, '') 'res_vitmno2',
isnull(b.res_itmdsc, '') 'res_itmdsc2',
isnull(b.res_baseunt, '') 'res_baseunt2',
isnull(b.res_ordqty, 0) 'res_ordqty2',
isnull(b.res_salamtusd, 0) 'res_salamtusd2',
isnull(b.res_imgpth, '') 'res_imgpth2',
isnull(b.res_ttlcnt_vdr, 0) 'res_ttlcnt_vdr2',
isnull(b.res_qutcnt_vdr, 0) 'res_qutcnt_vdr2',
isnull(b.res_cuslist,'') 'res_cuslist2',		-- Lester Wu 2005-12-06

isnull(c.res_reccnt, 0) 'res_reccnt3',
isnull(c.res_dsg, '') 'res_dsg3',
isnull(c.res_prdlne, '') 'res_prdlne3',
isnull(c.res_itmno, '') 'res_itmno3',
isnull(c.res_vitmno, '') 'res_vitmno3',
isnull(c.res_itmdsc, '') 'res_itmdsc3',
isnull(c.res_baseunt, '') 'res_baseunt3',
isnull(c.res_ordqty, 0) 'res_ordqty3',
isnull(c.res_salamtusd, 0) 'res_salamtusd3',
isnull(c.res_imgpth, '') 'res_imgpth3',
isnull(c.res_ttlcnt_vdr, 0) 'res_ttlcnt_vdr3',
isnull(c.res_qutcnt_vdr, 0) 'res_qutcnt_vdr3',
isnull(c.res_cuslist,'') 'res_cuslist3'		-- Lester Wu 2005-12-06

from #RESULT a (nolock)
left join #RESULT b (nolock) on a.res_dsg = b.res_dsg and a.res_prdlne = b.res_prdlne and a.res_reccnt = b.res_reccnt - 1
left join #RESULT c (nolock) on b.res_dsg = c.res_dsg and b.res_prdlne = c.res_prdlne and b.res_reccnt = c.res_reccnt - 1
where  a.res_reccnt % 3 = 1
order by a.res_dsg, a.res_prdlne, a.res_reccnt










GO
GRANT EXECUTE ON [dbo].[sp_list_BSP00004a] TO [ERPUSER] AS [dbo]
GO
