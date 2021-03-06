/****** Object:  StoredProcedure [dbo].[sp_select_INR00011]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_INR00011]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_INR00011]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE         PROCEDURE [dbo].[sp_select_INR00011]
	@cocde		nvarchar(6),
	@vendor		nvarchar(4000),
	@Vendor_label	nvarchar(4000),
	@SCFm		nvarchar(40),
	@SCTo		nvarchar(40),
	@CatL		nvarchar(1),
	@CatFm		nvarchar(20),
	@CatTo		nvarchar(20),
	@dateFm		datetime,
	@dateTo		datetime,
	--Lester Wu 2004/05/28
	@cust		nvarchar(1000),
	@cust_label	nvarchar(4000),
	@optYear		nvarchar(1),
	@optActShip	nvarchar(1),
	@optPeriod	nvarchar(1)		-- optPeriod :  H --> Half-month , M --> Monthly, Y --> Yearly
	-----------------------------
As 

create table 	#tmp_INR00011 (tmp_venno nvarchar(6)) 


--Lester Wu 2004/05/28
create table #tmp_INR00011_cust (tmp_custno nvarchar(6))

create table #Result_INR00011 (
	tmp_datefrom datetime,
	tmp_dateto datetime,
	tmp_usaosamt numeric(13,4),
	tmp_usaamt numeric(13,4),
	tmp_PUSAAMT numeric(13,4),
	tmp_Difference numeric(13,4),
	tmp_ACTUSAAMT numeric(13,4)
	-----------------------------		
)
--select * from #Result_INR00011
--drop table #Result_INR00011
-----------------------------
Declare	
	@vendor_part 	nvarchar(10),
	@vendor_remain	varchar(4000),
	@ReviewdateFm	datetime,
	@ReviewdateTo	datetime
	--Lester Wu 2004/05/28
	,@tmp_osaamt 	numeric(13,4)
	,@cust_part 	nvarchar(10)
	,@cust_remain	varchar(4000)


--Lester Wu 2005-03-30, retrieve company name from database
declare @compName varchar(100)
set @compName = 'UNITED CHINESE GROUP'
if @cocde<> 'UC-G'
begin
	select @compName=yco_conam  from SYCOMINF where yco_cocde = @cocde
end

--Lester Wu 2004/05/28
set @tmp_osaamt = 0
--set @custFm = Right(@custFm,len(@custFm) - 1)
--set @custTo = Right(@custTo,len(@custTo) - 1)
----------------------------------------------------------------
--2005/02/16 Lester Wu add factory 'S'
--if (@cocde = 'UCPP'  or @cocde = 'PG')  and @vendor = 'A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,T,U,W,Z' set @Vendor_label = 'Internal & Joint-Venture Vendor'
--if (@cocde = 'UCP' OR @cocde = 'ALL')   and @vendor = '0005,0006,0007,0008,0009,A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,T,U,W,Z' set @Vendor_label = 'Internal & Joint-Venture Vendor'
--Lester Wu 2005-04-01, add EW company
--if (@cocde = 'UCPP'  or @cocde = 'PG')  and @vendor = 'A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,U,W,Z' set @Vendor_label = 'Internal & Joint-Venture Vendor'
--if (@cocde = 'UCPP'  or @cocde = 'PG' or @cocde = 'EW' or @cocde = 'GU')  and @vendor = 'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z' set @Vendor_label = 'Internal & Joint-Venture Vendor'
--if (@cocde = 'UCP' OR @cocde = 'ALL')   and @vendor = '0005,0006,0007,0008,0009,A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,U,W,Z' set @Vendor_label = 'Internal & Joint-Venture Vendor'
--Lester Wu 2005-03-31, replace ALL with UC-G
--if (@cocde = 'UCP' OR @cocde = 'UC-G')   and @vendor = '0005,0006,0007,0008,0009,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z' set @Vendor_label = 'Internal & Joint-Venture Vendor'
--
--if @vendor <>'' 
--begin

--20160309 update
if @vendor = '0005,0006,0007,0008,0009,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z' set @Vendor_label = 'Internal & Joint-Venture Vendor'


Set 	@vendor_remain = @vendor
--Lester Wu 2005/03/04
--Cater Leaf Year Problem
--set 	@ReviewdateFm = convert(varchar(10),dateadd(yy,-1,@dateFm),101)
--set	@ReviewdateTo = convert(varchar(10),dateadd(yy,-1,@dateTo),101) + ' 23:59:59'
set 	@ReviewdateFm = convert(varchar(10),dateadd(yy,-1,@dateFm),101)
set	@ReviewdateTo = convert(varchar(10),dateadd(yy,-1,@dateTo),101) + ' 23:59:59'
--


While charindex(',', @vendor_remain) <> 0
begin
	Set @vendor_part = ltrim(left(@vendor_remain, charindex(',',@vendor_remain) - 1))
	Set @vendor_remain = right(@vendor_remain, len(@vendor_remain) - charindex(',', @vendor_remain))
	insert into #tmp_INR00011 values (@vendor_part)
end
insert into #tmp_INR00011 values (ltrim(@vendor_remain))

--end

--select * from #tmp_INR00011
--Lester Wu 2004/05/31
--------------------------------------------------------------------------------------------------------------------------------------------
if @cust<>''
begin
	set @cust_remain = @cust
	while charindex(',',@cust_remain)<>0
	begin
		set @cust_part = ltrim(left(@cust_remain,charindex(',',@cust_remain) - 1))
		set @cust_remain = right(@cust_remain, len(@cust_remain) - charindex(',',@cust_remain))
		insert into #tmp_INR00011_cust values(@cust_part)
	end
	insert into #tmp_INR00011_cust values (ltrim(@cust_remain))

-- cust alias
--create table #tmp_INR00011_cust (tmp_custno nvarchar(6))
--insert into #tmp_INR00011_cust values ('50001')
--insert into #tmp_INR00011_cust values ('50002')
--insert into #tmp_INR00011_cust values ('50003')

insert into #tmp_INR00011_cust 
select cbi_cusno from CUBASINF(NOLOCK),#tmp_INR00011_cust(NOLOCK)
where cbi_cusali = tmp_custno
--and cbi_cusno <> tmp_custno

--select * from #tmp_INR00011_cust
--drop table #tmp_INR00011_cust

end
--------------------------------------------------------------------------------------------------------------------------------------------

Declare 
	@SCFmC		nvarchar(4),
	@SCToC		nvarchar(4),
	@CURAT		numeric(15,11)
set 	@SCFmC  = ''
set 	@SCToC  = ''

If @SCFm <> ''
begin
	Set @SCFmC = left(@SCFm, charindex(' - ', @SCFm))
end

If @SCTo <> ''
begin
	Set @SCToC = left(@SCTo, charindex(' - ', @SCTo) )
end


/*
select 
	--.12903225806
	@CURAT =isnull(ysi_selrat,0) 
from 
	SYSETINF 
where 
	ysi_cde= 'HKD'
*/

Select	

	'dateFrom' = 	/*--------original code -------------*/
			 Case	when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01') <= @dateFm then convert(datetime,convert(char(10),@dateFm,111))
				when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01') >   @dateFm then convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01')

				when datepart(dd, soh_issdat) > 15   and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16') <=  @dateFm then convert(datetime,convert(char(10),@dateFm,111))
				when datepart(dd, soh_issdat) > 15   and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16') >    @dateFm then  convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16')end,
			/*------------------------------------*/
			
	'DateTo' = 		/*--------original code -------------*/
			Case	when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')  > @dateTo then convert(datetime,convert(char(10),@dateTo,111))
				when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')
				when datepart(dd, soh_issdat) > 15 and convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1
				when datepart(dd, soh_issdat) > 15 and convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1  > @dateTo then convert(datetime,convert(char(10),@dateTo,111)) end,
			/*-----------------------------------*/
--	'USAAMT' = sum(case sod_curcde when 'HKD' then isnull(sod_selprc * @CURAT,0) else isnull(sod_selprc ,0) end),
--	'USAOSAMT' = sum(case soh_ordsts when 'CLO' then 0 when 'CAN' then 0 else case sod_curcde when 'HKD' then isnull(((sod_ordqty - sod_shpqty) * sod_netuntprc )  * @CURAT,0) else isnull(((sod_ordqty - sod_shpqty) * sod_netuntprc) ,0) end end),
	--Frankie Cheung 20091005
	'USAAMT' = sum(case soh_curexrat when 0 then 0 else isnull(sod_selprc / soh_curexrat,0) end),
	'USAOSAMT' = sum(case soh_curexrat when 0 then 0 else case soh_ordsts when 'CLO' then 0 when 'CAN' then 0 else isnull(((sod_ordqty - sod_shpqty) * sod_netuntprc )  / soh_curexrat,0)  end end),
	sod_cocde
into 
	#report1
From	
	SCORDDTL (nolock)
left join v_imbasinf_rpt on sod_itmno = ibi_itmno

,
	SCORDHDR (nolock)

	--Lester Wu 2004/05/31
	left join #tmp_INR00011_cust(NOLOCK)  on soh_cus1no = tmp_custno
	-----------------------------
	,#tmp_INR00011
Where	
	sod_cocde = soh_cocde 
	and sod_ordno = soh_ordno
--	and sod_itmno = ibi_itmno
	and 	soh_issdat >=  convert(datetime,  @dateFm, 121) and soh_issdat <= convert(datetime, @dateTo, 121) 
	and 	sod_venno = tmp_venno

	and 	((@SCTo <> '' and ((sod_venno in ('0005') and sod_subcde Between @SCFmC and @SCToC) or sod_venno not in ('0005'))) or @SCTo = '')
	--and soh_cus1no = tmp_custno



	and	((@CatFm <> '' and ibi_catlvl0 between @CatFm and @CatTo and @CatL = '0') or
	(@CatFm <> '' and ibi_catlvl1 between @CatFm and @CatTo and @CatL = '1') or
	(@CatFm <> '' and ibi_catlvl2 between @CatFm and @CatTo and @CatL = '2') or
	(@CatFm <> '' and ibi_catlvl3 between @CatFm and @CatTo and @CatL = '3') or
	(@CatFm <> '' and ibi_catlvl4 between @CatFm and @CatTo and @CatL = '4') or @CatFm = '')
	
	--Lester Wu 2004/05/28
	--and 	((@custFm <>'' and soh_cus1no between @custFm and @custTo) or @custFm='')
	and	(@cust='' or (@cust<>'' and isnull(tmp_custno,'') <>''))
	-----------------------------
group by 
	/*--------original code -------------*/
	 Case	when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01') <= @dateFm then convert(datetime,convert(char(10),@dateFm,111))
		when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01') >   @dateFm then convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01')
		when datepart(dd, soh_issdat) > 15   and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16') <=  @dateFm then convert(datetime,convert(char(10),@dateFm,111))
		when datepart(dd, soh_issdat) > 15   and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16') >    @dateFm then  convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16')end,
	/*------------------------------------*/
	/*--------original code -------------*/
	Case	when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')  > @dateTo then convert(datetime,convert(char(10),@dateTo,111))
		when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')
		when datepart(dd, soh_issdat) > 15 and convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1
		when datepart(dd, soh_issdat) > 15 and convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1  > @dateTo then convert(datetime,convert(char(10),@dateTo,111)) end
	/*-----------------------------------*/
	,sod_cocde
order by 
	/*--------original code -------------*/
	 Case	when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01') <= @dateFm then convert(datetime,convert(char(10),@dateFm,111))
		when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01') >   @dateFm then convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01')
		when datepart(dd, soh_issdat) > 15   and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16') <=  @dateFm then convert(datetime,convert(char(10),@dateFm,111))
		when datepart(dd, soh_issdat) > 15   and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16') >    @dateFm then  convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16')end,
	/*------------------------------------*/
	/*--------original code -------------*/
	Case	when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')  > @dateTo then convert(datetime,convert(char(10),@dateTo,111))
		when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')
		when datepart(dd, soh_issdat) > 15 and convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1
		when datepart(dd, soh_issdat) > 15 and convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1  > @dateTo then convert(datetime,convert(char(10),@dateTo,111)) end
	/*-----------------------------------*/

declare @tmp_date_fm varchar(10)
declare @tmp_date_to varchar(10)
declare @tmp_cmp_date datetime

set @tmp_cmp_date = @dateFm

while @tmp_cmp_date < @dateTo
begin
   if day(@tmp_cmp_date) <= 15 
   begin
      set @tmp_date_fm = convert(varchar(4), year(@tmp_cmp_date)) + '-' + case len(convert(varchar(2), month(@tmp_cmp_date))) when 1 then '0' + convert(varchar(2), month(@tmp_cmp_date)) else convert(varchar(2), month(@tmp_cmp_date)) end + '-01'
      set @tmp_date_to = convert(varchar(4), year(@tmp_cmp_date)) + '-' + case len(convert(varchar(2), month(@tmp_cmp_date))) when 1 then '0' + convert(varchar(2), month(@tmp_cmp_date)) else convert(varchar(2), month(@tmp_cmp_date)) end + '-16'
      set @tmp_cmp_date = convert(datetime, @tmp_date_to)
   end
   else
   begin

      if month(@tmp_cmp_date) = 12
      begin
         set @tmp_date_fm = convert(varchar(4), year(@tmp_cmp_date)) + '-' + case len(convert(varchar(2), month(@tmp_cmp_date))) when 1 then '0' + convert(varchar(2), month(@tmp_cmp_date)) else convert(varchar(2), month(@tmp_cmp_date)) end + '-16'
         set @tmp_date_to = convert(varchar(4), year(@tmp_cmp_date)+1) + '-01-01' 
         set @tmp_cmp_date = convert(datetime, @tmp_date_to)
      end
      else
      begin
         set @tmp_date_fm = convert(varchar(4), year(@tmp_cmp_date)) + '-' + case len(convert(varchar(2), month(@tmp_cmp_date))) when 1 then '0' + convert(varchar(2), month(@tmp_cmp_date)) else convert(varchar(2), month(@tmp_cmp_date)) end + '-16'
         set @tmp_date_to = convert(varchar(4), year(@tmp_cmp_date)) + '-' + case len(convert(varchar(2), month(@tmp_cmp_date)+1)) when 1 then '0' + convert(varchar(2), month(@tmp_cmp_date)+1) else convert(varchar(2), month(@tmp_cmp_date)+1) end + '-01'
         set @tmp_cmp_date = convert(datetime, @tmp_date_to)
      end
   end

   if convert(datetime,@tmp_date_to) > @dateTo
   begin
      set @tmp_date_to = convert(varchar(10), @dateTo + 1, 111)
   end

   if not exists (select 1 from #report1 where [dateFrom] = convert(datetime,@tmp_date_fm) and [DateTo] = convert(datetime,@tmp_date_to)-1 and sod_cocde = 'UCPP')
   begin
      insert into #report1 values (convert(datetime,@tmp_date_fm), convert(datetime,@tmp_date_to)-1, 0, 0, 'UCPP')
   end

   if not exists (select 1 from #report1 where [dateFrom] = convert(datetime,@tmp_date_fm) and [DateTo] = convert(datetime,@tmp_date_to)-1 and sod_cocde = 'UCP')
   begin
      insert into #report1 values (convert(datetime,@tmp_date_fm), convert(datetime,@tmp_date_to)-1, 0, 0, 'UCP')
   end

   if not exists (select 1 from #report1 where [dateFrom] = convert(datetime,@tmp_date_fm) and [DateTo] = convert(datetime,@tmp_date_to)-1 and sod_cocde = 'PG')
   begin
      insert into #report1 values (convert(datetime,@tmp_date_fm), convert(datetime,@tmp_date_to)-1, 0, 0, 'PG')
   end
--Lestser Wu 2005-03-31, add company EW, MS
  if not exists (select 1 from #report1 where [dateFrom] = convert(datetime,@tmp_date_fm) and [DateTo] = convert(datetime,@tmp_date_to)-1 and sod_cocde = 'EW')
   begin
      insert into #report1 values (convert(datetime,@tmp_date_fm), convert(datetime,@tmp_date_to)-1, 0, 0, 'EW')
   end
  if not exists (select 1 from #report1 where [dateFrom] = convert(datetime,@tmp_date_fm) and [DateTo] = convert(datetime,@tmp_date_to)-1 and sod_cocde = 'MS')
   begin
      insert into #report1 values (convert(datetime,@tmp_date_fm), convert(datetime,@tmp_date_to)-1, 0, 0, 'MS')
   end
  if not exists (select 1 from #report1 where [dateFrom] = convert(datetime,@tmp_date_fm) and [DateTo] = convert(datetime,@tmp_date_to)-1 and sod_cocde = 'TT')
   begin
      insert into #report1 values (convert(datetime,@tmp_date_fm), convert(datetime,@tmp_date_to)-1, 0, 0, 'TT')
   end

end


Select	
	'dateFrom' = 	Case	when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01') <= @ReviewdateFm then @reviewdatefm
				when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01') >   @ReviewdateFm then  convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01')
				when datepart(dd, soh_issdat) > 15   and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16') <=  @ReviewdateFm then @reviewdatefm
				when datepart(dd, soh_issdat) > 15   and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16') >    @ReviewdateFm then  convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16')end,
	'DateTo' = 		Case	when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')  > @ReviewdateTo then @ReviewdateTo
				when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')  <= @ReviewdateTo then convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')
				when datepart(dd, soh_issdat) > 15 and convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1  <= @ReviewdateTo then convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1
				when datepart(dd, soh_issdat) > 15 and convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1  > @ReviewdateTo then @ReviewdateTo end,
--	'USAAMT' = sum(case sod_curcde when 'HKD' then isnull(sod_selprc * @CURAT,0) else isnull(sod_selprc ,0) end),
--	'USAOSAMT' = sum(case soh_ordsts when 'CLO' then 0 when 'CAN' then 0 else case sod_curcde when 'HKD' then isnull(((sod_ordqty - sod_shpqty) * sod_netuntprc * @CURAT) ,0) else isnull(((sod_ordqty - sod_shpqty) * sod_netuntprc) ,0) end end),
	--Frankie Cheung 20091005
	'USAAMT' = sum(case soh_curexrat when 0 then 0 else isnull(sod_selprc / soh_curexrat,0) end),
	'USAOSAMT' = sum(case soh_curexrat when 0 then 0 else case soh_ordsts when 'CLO' then 0 when 'CAN' then 0 else isnull(((sod_ordqty - sod_shpqty) * sod_netuntprc / soh_curexrat) ,0) end end),
	sod_cocde
into 
	#report2
From	
	SCORDDTL (nolock)
left join v_imbasinf_rpt on sod_itmno = ibi_itmno

,
	SCORDHDR (nolock)
	left join #tmp_INR00011_cust(NOLOCK) on soh_cus1no = tmp_custno
	,#tmp_INR00011
Where	
	sod_cocde = soh_cocde 
	and sod_ordno = soh_ordno
--	and sod_itmno = ibi_itmno
	and 	soh_issdat >=  convert(datetime,  @reviewdatefm, 121) and soh_issdat <=  convert(datetime, @ReviewdateTo, 121) 
	and 	sod_venno = tmp_venno
--	and 	((@SCTo <> '' and  sod_subcde Between @SCFmC and @SCToC ) or @SCTo = '')
	and 	((@SCTo <> '' and ((sod_venno in ('0005') and sod_subcde Between @SCFmC and @SCToC) or sod_venno not in ('0005'))) or @SCTo = '')

	and	((@CatFm <> '' and ibi_catlvl0 between @CatFm and @CatTo and @CatL = '0') or
	(@CatFm <> '' and ibi_catlvl1 between @CatFm and @CatTo and @CatL = '1') or
	(@CatFm <> '' and ibi_catlvl2 between @CatFm and @CatTo and @CatL = '2') or
	(@CatFm <> '' and ibi_catlvl3 between @CatFm and @CatTo and @CatL = '3') or
	(@CatFm <> '' and ibi_catlvl4 between @CatFm and @CatTo and @CatL = '4') or @CatFm = '')

	--Lester Wu 2004/05/28
	--and 	((@custFm <>'' and soh_cus1no between @custFm and @custTo) or @custFm='')
	and	(@cust='' or (@cust<>'' and isnull(tmp_custno,'') <>''))
	-----------------------------

group by 
			Case	when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01') <= @ReviewdateFm then @reviewdatefm
				when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01') >   @ReviewdateFm then  convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01')
				when datepart(dd, soh_issdat) > 15   and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16') <=  @ReviewdateFm then @reviewdatefm
				when datepart(dd, soh_issdat) > 15   and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16') >    @ReviewdateFm then  convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16')end,
	
			Case	when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')  > @ReviewdateTo then @ReviewdateTo
				when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')  <= @ReviewdateTo then convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')
				when datepart(dd, soh_issdat) > 15 and convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1  <= @ReviewdateTo then convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1
				when datepart(dd, soh_issdat) > 15 and convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1  > @ReviewdateTo then @ReviewdateTo end
		, sod_cocde
order by 
			Case	when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01') <= @ReviewdateFm then @reviewdatefm
				when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01') >   @ReviewdateFm then  convert(datetime,left(convert(char(10), soh_issdat,111),8) + '01')
				when datepart(dd, soh_issdat) > 15   and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16') <=  @ReviewdateFm then @reviewdatefm
				when datepart(dd, soh_issdat) > 15   and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16') >    @ReviewdateFm then  convert(datetime,left(convert(char(10), soh_issdat,111),8) + '16')end,
	
			Case	when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')  > @ReviewdateTo then @ReviewdateTo
				when datepart(dd, soh_issdat) <= 15 and convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')  <= @ReviewdateTo then convert(datetime,left(convert(char(10), soh_issdat,111),8) + '15')
				when datepart(dd, soh_issdat) > 15 and convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1  <= @ReviewdateTo then convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1
				when datepart(dd, soh_issdat) > 15 and convert(datetime, left(convert(char(10), soh_issdat +16,111),8) + '01') - 1  > @ReviewdateTo then @ReviewdateTo end
	
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- 2004/05/28 Lester Wu --Retrive Actual Ship Amt From Shipping Detail


if @optActShip='Y' 
begin

Select	

	'dateFrom' = 	Case	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') <= @dateFm then convert(datetime,convert(char(10),@dateFm,111))
				when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') >   @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01')
				when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') <=  @dateFm then convert(datetime,convert(char(10),@dateFm,111))
				when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') >    @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16')end,
	'DateTo' = 
			Case	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  > @dateTo then convert(datetime,convert(char(10),@dateTo,111))
				when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')
				when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1
				when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  > @dateTo then convert(datetime,convert(char(10),@dateTo,111)) end,

--	'USAAMT' = sum(case hid_untsel when 'HKD' then isnull(hid_shpqty * hid_selprc * @CURAT,0) else isnull(hid_shpqty * hid_selprc,0) end),
	--Frankie Cheung 20091005
	'USAAMT' = sum(case soh_curexrat when 0 then 0 else isnull(hid_shpqty * hid_selprc / soh_curexrat,0) end),
	'USAOSAMT' = @tmp_osaamt,
	hih_cocde
into 
	#report3		--Actual Shipped Amt
From	
	 SHIPGHDR (nolock)
	left join #tmp_INR00011_cust(NOLOCK) on tmp_custno = hih_cus1no,
	SHINVHDR (nolock),
	SHIPGDTL (nolock),
	SCORDDTL (nolock)
left join v_imbasinf_rpt on sod_itmno = ibi_itmno
,
	--Frankie Cheung 20091005 
	SCORDHDR (nolock),
	--------------------------
	#tmp_INR00011
Where	
		hih_cocde = hid_cocde 
	and	hih_shpno = hid_shpno
	and	hid_cocde = sod_cocde 
	and 	hid_ordno = sod_ordno 
	and 	hid_ordseq = sod_ordseq 
	--Frankie Cheung 20091005 
	and 	sod_ordno = soh_ordno
	and 	hid_cocde = hiv_cocde 
	and 	hid_shpno = hiv_shpno 
	and 	hid_invno = hiv_invno
	and	hid_itmno = sod_itmno
	and 	hiv_invdat >=  convert(datetime,  @dateFm, 121) and hiv_invdat <= convert(datetime, @dateTo, 121) 

	and hid_venno = tmp_venno

	and 	((@SCTo <> '' and ((sod_venno in ('0005') and sod_subcde Between @SCFmC and @SCToC) or sod_venno not in ('0005'))) or @SCTo = '')

	and	((@CatFm <> '' and ibi_catlvl0 between @CatFm and @CatTo and @CatL = '0') or
	(@CatFm <> '' and ibi_catlvl1 between @CatFm and @CatTo and @CatL = '1') or
	(@CatFm <> '' and ibi_catlvl2 between @CatFm and @CatTo and @CatL = '2') or
	(@CatFm <> '' and ibi_catlvl3 between @CatFm and @CatTo and @CatL = '3') or
	(@CatFm <> '' and ibi_catlvl4 between @CatFm and @CatTo and @CatL = '4') or @CatFm = '')

	--Lester Wu 2004/05/28
	--and 	((@custFm <>'' and hih_cus1no between @custFm and @custTo) or @custFm='')
	and	(@cust='' or (@cust<>'' and isnull(tmp_custno,'') <>''))
	-----------------------------

group by 
			Case	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') <= @dateFm then convert(datetime,convert(char(10),@dateFm,111))
				when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') >   @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01')
				when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') <=  @dateFm then convert(datetime,convert(char(10),@dateFm,111))
				when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') >    @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16')end,

			Case	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  > @dateTo then convert(datetime,convert(char(10),@dateTo,111))
				when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')
				when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1
				when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  > @dateTo then convert(datetime,convert(char(10),@dateTo,111)) end
	--Lester Wu 2004/02/27
	,hih_cocde
	---------------------
order by 
			Case	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') <= @dateFm then convert(datetime,convert(char(10),@dateFm,111))
				when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') >   @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01')
				when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') <=  @dateFm then convert(datetime,convert(char(10),@dateFm,111))
				when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') >    @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16')end,


			Case	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  > @dateTo then convert(datetime,convert(char(10),@dateTo,111))
				when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')
				when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1
				when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  > @dateTo then convert(datetime,convert(char(10),@dateTo,111)) end
end
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx



-- Lester Wu 2004/02/27

/*select @cocde
select * from #report1
select * from #report2
select * from #report3
*/

--Lester Wu 2005-03-30, replace ALL with UC-G
--if @cocde<>'ALL' 
if @cocde<>'UC-G' 
begin
	delete from #report1 where sod_cocde<>@cocde
	delete from #report2 where sod_cocde<>@cocde
	--Lester Wu 2004/05/28
	if @optActShip='Y' 
	begin
		delete from #report3 where hih_cocde<>@cocde
	end
end
else
begin
	delete from #report1 where sod_cocde='MS'
	delete from #report2 where sod_cocde='MS'

	if @optActShip='Y' 
	begin
		delete from #report3 where hih_cocde='MS'
	end
end 
----------------------------------------------

if @optActShip = 'Y' 
begin
insert into #Result_INR00011
select 

	--Lester Wu 2004/02/27
	--#report1.cocde,
	--#report1.vendor,
	--#report1.vendor_label,
	--#report1.scfm,
	--#report1.scto,
	/* 
	@Cocde as 'cocde',
	@vendor as 'vendor',
	replace(replace(@vendor_label, '(', '/'),')', '/') as 	'vendor_label',
	@SCFm as 'SCFm',
	@SCTo as 'SCTo',
	-------------------------
	@dateFm as 'RptDateFrom',
 	@dateTo as 'RptDateTo',
	*/ 
	#report1.datefrom as 'datefrom',
	#report1.dateto as 'dateto',
	sum(round(#report1.usaosamt,2)) as 'usaosamt',
	sum(round(#report1.usaamt,2)) as 'usaamt',
	sum(case isnull(#report2.usaamt,0) when 0 then 0 else round(#report2.usaamt,2) end) as 'PUSAAMT',
	sum(round(#report1.usaamt,2))- sum(case isnull(#report2.usaamt,0) when 0 then 0 else round(#report2.usaamt,2) end)as 'Difference'
	--#report1.usaamt -  isnull(#report2.usaamt,0)  as 'Difference'
	--Lester Wu 2004/05/28
	,sum(case isnull(#report3.usaamt,0) when 0 then 0 else round(#report3.usaamt,2) end) as 'ACTUSAAMT'
	-----------------------------
	
--into #RESULT
from 
	#report1
	left join #report2 on 
		#report1.sod_cocde = #report2.sod_cocde and
		-- Lester Wu 2004/03/05 
		convert(varchar(10),dateadd(yy,-1,#report1.datefrom),101) = convert(varchar(10),#report2.datefrom,101)-- and 
		--convert(varchar(10),dateadd(yy,-1,#report1.dateto),101) = convert(varchar(10),#report2.dateto,101) 
		--left(convert(varchar(10),#report1.datefrom,101),5) = left(convert(varchar(10),#report2.datefrom,101),5) and
		--left(convert(varchar(10),#report1.dateto,101),5) = left(convert(varchar(10),#report2.dateto,101),5)
		--------------------------------------------------------------------------------------------------------------------------------------
	--Lester Wu 2004/05/28
	left join #report3 on 
		#report1.sod_cocde = #report3.hih_cocde and
		convert(varchar(10),#report1.datefrom,101) = convert(varchar(10),#report3.datefrom,101) --and 
		--convert(varchar(10),#report1.dateto,101) = convert(varchar(10),#report3.dateto,101) 
	
	-----------------------------
--where	#report1.hih_cocde=@cocde
group by
	#report1.datefrom,
	#report1.dateto	 
order by
	#report1.datefrom,
	#report1.dateto

--
end
else
begin
--
insert into #Result_INR00011
select 
	#report1.datefrom as 'datefrom',
	#report1.dateto as 'dateto',
	sum(round(#report1.usaosamt,2)) as 'usaosamt',
	sum(round(#report1.usaamt,2)) as 'usaamt',
	sum(case isnull(#report2.usaamt,0) when 0 then 0 else round(#report2.usaamt,2) end) as 'PUSAAMT',
	sum(round(#report1.usaamt,2))- sum(case isnull(#report2.usaamt,0) when 0 then 0 else round(#report2.usaamt,2) end)as 'Difference'
	,0 as 'ACTUSAAMT'
	-----------------------------
	
--into #RESULT
from 
	#report1
	left join #report2 on 
		#report1.sod_cocde = #report2.sod_cocde and
		--Lester Wu 2005/03/04 -- Cater Leaf Year Problem
		convert(varchar(10),dateadd(yy,-1,#report1.datefrom),101) = convert(varchar(10),#report2.datefrom,101) --and 
		--convert(varchar(10),dateadd(yy,-1,#report1.dateto),101) = convert(varchar(10),#report2.dateto,101) 
group by
	#report1.datefrom,
	#report1.dateto	 
order by
	#report1.datefrom,
	#report1.dateto

end
--


--update #RESULT set [Difference] = 0 where [datefrom] > getdate()
--update #Result_INR00011 set [tmp_Difference] = 0 where [tmp_datefrom] > getdate()

if @optPeriod = 'H'
begin
update #Result_INR00011 set [tmp_Difference] = 0 where [tmp_datefrom] > getdate()
end
else
begin
update #Result_INR00011 set [tmp_Difference] = 0 where dateadd(dd,1-day([tmp_datefrom]),[tmp_datefrom]) > getdate()
end


if @optPeriod='H'
begin
select 
	@Cocde as 'cocde',
	case when len(@vendor)>0 then 'Y' else '' end as 'vendor',
--	Marco Chan 2004/05/28
--	replace(replace(@vendor_label, '(', '/'),')', '/') as 	'vendor_label',
	@vendor_label as'vendor_label',
convert(varchar(10), 	@SCFm , 101)  as 'SCFm',
convert(varchar(10), 	@SCTo , 101)    as 'SCTo',
	-------------------------
convert(varchar(10), 	@dateFm , 101)    as 'RptDateFrom',
convert(varchar(10), 	@dateTo , 101)     	as 'RptDateTo',
-----------------------------------------------------------
convert(varchar(10), 	tmp_datefrom  , 101)     	 as 'DateFrom',
convert(varchar(10), 	tmp_dateto  , 101)     	 as 'DateTo',	
tmp_usaosamt as 'USDOSAMT' ,
tmp_usaamt as 'USDAMT',
	tmp_PUSAAMT as 'PUSDAMT',
	tmp_Difference as 'DIFFERENCE',
	tmp_ACTUSAAMT as 'ACTSHIP',


-----------------------------------------------------------
	case when len(@cust) > 0 then 'Y' else '' end  as 'cust',
	@cust_label as 'cust_label',
	@optYear as 'optYear',
	@optActShip as 'optActShip',
	@optPeriod as 'optPeriod',
	@compName as 'compName'

--from #RESULT
from #RESULT_INR00011
end
else
begin

select 
	@Cocde as 'cocde',
	case when len(@vendor) > 0 then 'Y' else '' end  as 'vendor',
--	Marco Chan 2004/05/28
--	replace(replace(@vendor_label, '(', '/'),')', '/') as 	'vendor_label',
	@vendor_label as'vendor_label',

convert(varchar(10), 	@SCFm , 101)  as 'SCFm',
convert(varchar(10), 	@SCTo , 101)    as 'SCTo',
	-------------------------
convert(varchar(10), 	@dateFm , 101)    as 'RptDateFrom',
convert(varchar(10), 	@dateTo , 101)     	as 'RptDateTo',

convert(varchar(10), 		case when convert(nvarchar(10),tmp_datefrom,101)=convert(nvarchar(10),@dateFm,101) 
		then tmp_datefrom
		else dateadd(dd,1-day(tmp_datefrom),tmp_datefrom)
		end  , 101)      as 'DateFrom',

convert(varchar(10), 		case when convert(nvarchar(10),tmp_dateto,101) = convert(nvarchar(10),@dateTo,101)
		then tmp_dateto
		else 
		case when dateadd(dd,-1,dateadd(mm,1,dateadd(dd,1-day(tmp_dateto),tmp_dateto))) >= convert(nvarchar(10),@dateTo,101) then convert(nvarchar(10),@dateTo,101) else dateadd(dd,-1,dateadd(mm,1,dateadd(dd,1-day(tmp_dateto),tmp_dateto)))  end
		end , 101)       as 'DateTo',	

	sum(round(tmp_usaosamt,2)) as 'USDOSAMT' ,
	sum(round(tmp_usaamt,2)) as 'USDAMT',
	sum(round(tmp_PUSAAMT,2)) as 'PUSDAMT',
	sum(round(tmp_Difference,2)) as 'DIFFERENCE',
	sum(round(tmp_ACTUSAAMT,2)) as 'ACTSHIP',

	case when len(@cust) > 0 then 'Y' else '' end  as 'cust',
	@cust_label as 'cust_label',
	@optYear as 'optYear',
	@optActShip as 'optActShip',
	@optPeriod as 'optPeriod',
	@compName as 'compName'
--from #RESULT
from #RESULT_INR00011
group by 
convert(varchar(10), 		case when convert(nvarchar(10),tmp_datefrom,101)=convert(nvarchar(10),@dateFm,101) 
		then tmp_datefrom
		else dateadd(dd,1-day(tmp_datefrom),tmp_datefrom)
		end  , 101)      ,

convert(varchar(10), 		case when convert(nvarchar(10),tmp_dateto,101) = convert(nvarchar(10),@dateTo,101)
		then tmp_dateto
		else 
		case when dateadd(dd,-1,dateadd(mm,1,dateadd(dd,1-day(tmp_dateto),tmp_dateto))) >= convert(nvarchar(10),@dateTo,101) then convert(nvarchar(10),@dateTo,101) else dateadd(dd,-1,dateadd(mm,1,dateadd(dd,1-day(tmp_dateto),tmp_dateto)))  end
		end , 101)       
order by 
convert(varchar(10), 		case when convert(nvarchar(10),tmp_datefrom,101)=convert(nvarchar(10),@dateFm,101) 
		then tmp_datefrom
		else dateadd(dd,1-day(tmp_datefrom),tmp_datefrom)
		end  , 101)      ,

convert(varchar(10), 		case when convert(nvarchar(10),tmp_dateto,101) = convert(nvarchar(10),@dateTo,101)
		then tmp_dateto
		else 
		case when dateadd(dd,-1,dateadd(mm,1,dateadd(dd,1-day(tmp_dateto),tmp_dateto))) >= convert(nvarchar(10),@dateTo,101) then convert(nvarchar(10),@dateTo,101) else dateadd(dd,-1,dateadd(mm,1,dateadd(dd,1-day(tmp_dateto),tmp_dateto)))  end
		end , 101)       

end
drop table #Result_INR00011





GO
GRANT EXECUTE ON [dbo].[sp_select_INR00011] TO [ERPUSER] AS [dbo]
GO
