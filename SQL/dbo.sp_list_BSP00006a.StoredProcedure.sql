/****** Object:  StoredProcedure [dbo].[sp_list_BSP00006a]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_BSP00006a]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_BSP00006a]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





/*
=========================================================
Program ID	: sp_list_BSP00006a
Description   	: 
Programmer  	: Marco Chan
ALTER  Date   	: 20/10/2005
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
=========================================================     
-- sp_list_BSP00006a '', '03/01/2004 00:00:00.000', '03/01/2006 23:59:59', '', '', '', '', 'E', '', '', '041328-00095,051328-00b001,051328-f22r001', '', '', '', '', '', '', '2004 X''''mas Season', 'X'
*/
create procedure [dbo].[sp_list_BSP00006a]
	@cocde		nvarchar(6),	

	@itmcredatFm	datetime,
	@itmcredatTo	datetime,

	@vdrFm		nvarchar(20),
	@vdrTo		nvarchar(20),
	@vdrTyp		char(1),

	@itmnoFm	nvarchar(20),
	@itmnoTo	nvarchar(20),
	@itmList	nvarchar(1000),

	@prdlneFm	nvarchar(10),
	@prdlneTo	nvarchar(10),
	@prdlneList	nvarchar(1000),
	
	@excustFm	nvarchar(10),
	@excustTo	nvarchar(10),
	@excustList	nvarchar(1000),

	@title		nvarchar(100),
	@TEMP		nvarchar(10)
as

set nocount on 

declare @optItmStr		char(1),
	@optPrdLneStr		char(1),
	@optExCustStr		char(1),
	@ItmStrRemain		nvarchar(1000),
	@PrdLneStrRemain	nvarchar(1000),
	@ExCustStrRemain	nvarchar(1000),
	@ItmStrPart		nvarchar(20),
	@PrdLneStrPart		nvarchar(10),
	@ExCustStrPart		nvarchar(10)
create table #TMP_ITM (tmp_ITMNO nvarchar(20)) on [PRIMARY]
create table #TMP_LNE (tmp_PRDLNE nvarchar(10)) on [PRIMARY]
create table #TMP_EXCUST (tmp_CUSNO nvarchar(10)) on [PRIMARY]




set @optItmStr = 'N'
if ltrim(rtrim(@itmList)) <> '' 
begin 
	set @optItmStr = 'Y'
	set @ItmStrRemain = @itmList

	while charindex(',',@ItmStrRemain)<>0
	begin
		set @ItmStrPart = ltrim(left(@ItmStrRemain, charindex(',', @ItmStrRemain)-1))
		set @ItmStrRemain = right(@ItmStrRemain, len(@ItmStrRemain) - charindex(',', @ItmStrRemain))
		insert into #TMP_ITM values (@ItmStrPart)
	end

	if charindex(',',@ItmStrRemain) = 0 
		insert into #TMP_ITM values (ltrim(@ItmStrRemain))
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
		insert into #TMP_LNE values (ltrim(@PrdLneStrRemain))
end

set @optExCustStr = 'N'
if ltrim(rtrim(@excustList)) <> ''
begin
	set @optExCustStr = 'Y'
	set @ExCustStrRemain = @excustList

	while charindex(',', @ExCustStrRemain) <> 0
	begin
		set @ExCustStrPart = ltrim(left(@ExCustStrRemain, charindex(',', @ExCustStrRemain)-1))
		set @ExCustStrRemain = right(@ExCustStrRemain, len(@ExCustStrRemain) - charindex(',', @ExCustStrRemain))
		insert into #TMP_EXCUST values (@ExCustStrPart)
	end

	if charindex(',',@ExCustStrRemain) = 0 
		insert into #TMP_EXCUST values (ltrim(@ExCustStrRemain))
end


CREATE TABLE #TMP_RESULT(
	tmp_venno	nvarchar(20),
	tmp_vensna	nvarchar(20),
	tmp_itmno	nvarchar(20),
	tmp_itmdsc	nvarchar(800),
	tmp_imgpth	nvarchar(200),
	tmp_prdlne	nvarchar(20)
)


CREATE TABLE #RESULT(
	res_reccnt	int identity(1,1) ,
	res_venno	nvarchar(20),
	res_vensna	nvarchar(20),
	res_itmno	nvarchar(20),
	res_itmdsc	nvarchar(800),
	res_imgpth	nvarchar(200),
	res_ttlcnt_vdr	int,
	res_qutcnt_vdr	int
)

declare @optVdr char(1), @optItmno char(1), @optPrdlne char(1)


if @vdrFm = ''
	set @optVdr = 'N'
else
	set @optVdr = 'Y'

if @itmnoFm = ''
	set @optItmno = 'N'
else
	set @optItmno = 'Y'

if @prdlneFm = ''
	set @optPrdlne = 'N'
else
	set @optPrdlne = 'Y'




insert into #TMP_RESULT
select 
vbi_venno, 
vbi_vensna,
ibi_itmno,
ibi_engdsc,
ibi_imgpth,
ibi_lnecde
from 
IMBASINF (nolock)
left join IMVENINF (nolock) on ibi_itmno = ivi_itmno and ivi_def = 'Y'
left join VNBASINF (nolock) on vbi_venno = ivi_venno
where
--(ibi_credat between @itmcredatFm and @itmcredatTo) and 
(ibi_lnecde between @prdlneFm and @prdlneTo)

/*
if @optItmStr = 'Y' and @optPrdLneStr = 'Y'
begin
	insert into #RESULT
	select
	0,
	a.tmp_venno,
	a.tmp_vensna,
	a.tmp_itmno,
	a.tmp_itmdsc,
	a.tmp_imgpth, 
	0,
	0
	from 
	#TMP_RESULT a, #TMP_ITM b, #TMP_LNE c
	where a.tmp_itmno = b.tmp_ITMNO
	and a.tmp_prdlne = c.tmp_PRDLNE
end
else if @optItmStr = 'Y'
begin
	insert into #RESULT
	select
	0,
	a.tmp_venno,
	a.tmp_vensna,
	a.tmp_itmno,
	a.tmp_itmdsc,
	a.tmp_imgpth, 
	0,
	0
	from 
	#TMP_RESULT a, #TMP_ITM b
	where a.tmp_itmno = b.tmp_ITMNO
end
else if @optPrdLneStr = 'Y'
begin
	insert into #RESULT
	select
	0,
	a.tmp_venno,
	a.tmp_vensna,
	a.tmp_itmno,
	a.tmp_itmdsc,
	a.tmp_imgpth, 
	0,
	0
	from 
	#TMP_RESULT a, #TMP_LNE c
	where a.tmp_prdlne = c.tmp_PRDLNE
end
else
begin
*/
	insert into #RESULT
	(res_venno,
	res_vensna,
	res_itmno,
	res_itmdsc,
	res_imgpth,
	res_ttlcnt_vdr,
	res_qutcnt_vdr)
	select
--	0,
	tmp_venno,
	tmp_vensna,
	tmp_itmno,
	tmp_itmdsc,
	tmp_imgpth, 
	0,
	0
	from 
	#TMP_RESULT
	order by tmp_itmno
/*
end
*/


if @@LANGUAGE <> 'us_english' 
	set LANGUAGE 'us_english'


select @title = yli_lnecde + ' - ' + yli_lnedsc from SYLNEINF
where yli_lnecde = @prdlneFm



select 
isnull(convert(varchar(20), @itmcredatFm, 107),'') 'res_itmcredatFm',
isnull(convert(varchar(20), @itmcredatTo, 107),'') 'res_itmcredatTo',
isnull(@title, '') 'res_title',

isnull(a.res_reccnt, 0) 'res_reccnt1',
isnull(a.res_venno, '') 'res_venno1',
isnull(a.res_vensna, '') 'res_vensna1',
isnull(a.res_itmno, '') 'res_itmno1',
isnull(a.res_itmdsc, '') 'res_itmdsc1',
isnull(a.res_imgpth, '') 'res_imgpth1',
isnull(a.res_ttlcnt_vdr, 0) 'res_ttlcnt_vdr1',
isnull(a.res_qutcnt_vdr, 0) 'res_qutcnt_vdr1',

isnull(b.res_reccnt, 0) 'res_reccnt2',
isnull(b.res_venno, '') 'res_venno2',
isnull(b.res_vensna, '') 'res_vensna2',
isnull(b.res_itmno, '') 'res_itmno2',
isnull(b.res_itmdsc, '') 'res_itmdsc2',
isnull(b.res_imgpth, '') 'res_imgpth2',
isnull(b.res_ttlcnt_vdr, 0) 'res_ttlcnt_vdr2',
isnull(b.res_qutcnt_vdr, 0) 'res_qutcnt_vdr2',

isnull(c.res_reccnt, 0) 'res_reccnt3',
isnull(c.res_venno, '') 'res_venno3',
isnull(c.res_vensna, '') 'res_vensna3',
isnull(c.res_itmno, '') 'res_itmno3',
isnull(c.res_itmdsc, '') 'res_itmdsc3',
isnull(c.res_imgpth, '') 'res_imgpth3',
isnull(c.res_ttlcnt_vdr, 0) 'res_ttlcnt_vdr3',
isnull(c.res_qutcnt_vdr, 0) 'res_qutcnt_vdr3'

from #RESULT a
left join #RESULT b on --a.res_venno = b.res_venno and 
a.res_reccnt = b.res_reccnt - 1
left join #RESULT c on --b.res_venno = c.res_venno and 
b.res_reccnt = c.res_reccnt - 1
where  a.res_reccnt % 3 = 1
order by a.res_reccnt







GO
GRANT EXECUTE ON [dbo].[sp_list_BSP00006a] TO [ERPUSER] AS [dbo]
GO
