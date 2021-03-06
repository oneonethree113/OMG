/****** Object:  StoredProcedure [dbo].[sp_select_INR00013]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_INR00013]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_INR00013]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




-- Checked by Allan Yuen at 27/07/2003  
-- 2004/01/30 Change display 'Internal Vendor & Joint Venture' instead of 'All Vendor' in UCP Company.  
-- Add All company Select by Lester Wu on 2004/02/27  
--Cater Leaf year problem 2004/03/05  
  
/**********************************************************************************************  
Modification History  
**********************************************************************************************  
Date  Initial  Description  
**********************************************************************************************  
16th Feb, 2005 Lester Wu  Add factory 'S'  
31st Mar, 2005 Lester Wu  replace ALL wtih UC-G, add company MS-Magic Silk  
**********************************************************************************************/  
--sp_select_INR00013 'UC-G','0005,0006,0007,0008,0009,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z','0005 - ELLIWELL     0006 - HUAYO (華佑)   0007 - WYB (華裕盆景)   0008 - WISEMARK 0009 - 香港華裕         A - 華泰              B - 華泰聖誕            C - 華裕 D - 華裕盆景            E - ?               F - 福州              G - 聯輝 H - 北都 / 華佑         I - 華建 / 通藝         J - 智軒              K - 華匯 L - 華泰(龍煒)          M - 嘉德              N - HARRIS          O - 華寶 P - UCPP            Q - 香港華裕            R - 富泰              S - 樂豐 T - 華建 / 通藝         U - 五金廠             V - 華奧              W - 大煒 X - 通泰              Y - 華翔              Z - Inventory       ','','','0','','','05/05/2016 00:00:00','05/05/2016 23:59:59'
--sp_select_INR00013 'HB','O','O - 華寶              ','','','0','','','03/01/2016 00:00:00','07/31/2016 23:59:59'
 
CREATE    PROCEDURE [dbo].[sp_select_INR00013]  
@cocde  nvarchar(6),  
@vendor  varchar(4000),  
@Vendor_label nvarchar(255),  
@SCFm  nvarchar(40),  
@SCTo  nvarchar(40),  
@CatL  nvarchar(1),  
@CatFm  nvarchar(20),  
@CatTo  nvarchar(20),  
@dateFm  datetime,  
@dateTo  datetime  
As   
  
 
create table  #tmp_INR00013 (tmp_venno nvarchar(6))   
  
  
Declare   
@vendor_part  nvarchar(10),  
@vendor_remain varchar(4000),  
@ReviewdateFm datetime,  
@ReviewdateTo datetime  
  
--if @cocde = 'UCP' set @vendor = '0005,0007,0006,0009'  
--if @cocde = 'UCPP' set @vendor = 'A,B,C,D,E,F,G,H,J,K,L,M,N,P,T,U,Z'  
--if @cocde = 'UCPP'  set @Vendor_label = 'ALL Vendors'  
--2005/02/16 Lester Wu add factory 'S'  
--if (@cocde = 'UCPP'  or @cocde = 'PG')  and @vendor = 'A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,T,U,W,Z' set @Vendor_label = 'Internal & Joint-Venture Vendor'  
--Lester Wu 2005-04-01, add EW company  
--if (@cocde = 'UCPP'  or @cocde = 'PG')  and @vendor = 'A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,U,W,Z' set @Vendor_label = 'Internal & Joint-Venture Vendor'  
--if (@cocde = 'UCPP'  or @cocde = 'PG' or @cocde ='EW' or @cocde = 'GU')  and @vendor = 'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z' set @Vendor_label = 'Internal & Joint-Venture Vendor'  
--  
--if @cocde = 'UCP'  and @vendor = '0005,0006,0007,0008,0009,A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,T,U,Z' set @Vendor_label =  'ALL Vendors'  
--2005/02/16 Lester Wu add factory 'S'  
--if (@cocde = 'UCP' OR @cocde = 'ALL')   and @vendor = '0005,0006,0007,0008,0009,A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,T,U,W,Z' set @Vendor_label = 'Internal & Joint-Venture Vendor'  
--Lester Wu 2005-03-31, replace ALL with UC-G  
--if (@cocde = 'UCP' OR @cocde = 'ALL')   and @vendor = '0005,0006,0007,0008,0009,A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,U,W,Z' set @Vendor_label = 'Internal & Joint-Venture Vendor'  
--if (@cocde = 'UCP' OR @cocde = 'UC-G')   and @vendor = '0005,0006,0007,0008,0009,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z' set @Vendor_label = 'Internal & Joint-Venture Vendor'  
 
--20160309update
if @vendor = '0005,0006,0007,0008,0009,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z' set @Vendor_label = 'Internal & Joint-Venture Vendor'  

 
  
--Lester Wu 2005-03-31, retrieve company name from database  
declare @compName varchar(100)  
set @compName = 'UNITED CHINESE GROUP'  
if @cocde <> 'UC-G'  
begin  
	select @compName = yco_conam from SYCOMINF where yco_cocde = @cocde  
end  
  
  
Set  @vendor_remain = @vendor  
-- Lester Wu 2004/03/04  
-- Handle leaf year problem of Feb  
-- previous year of 02/29/2004 23:59:59.000 should be 02/28/2003 23:59:59.000  
--set     @ReviewdateFm = left(convert(varchar(10),@dateFm,101),6) +  cast((right(convert(varchar(10),@dateFm,101),4) -1) as char(4))  
--set     @ReviewdateTo = left(convert(varchar(10),@dateTo,101),6) +  cast((right(convert(varchar(10),@dateTo,101),4) -1) as char(4))  
set @ReviewdateFm = convert(varchar(10),dateadd(yy,-1,@dateFm),101)  
set @ReviewdateTo = convert(varchar(10),dateadd(yy,-1,@dateTo),101) + ' 23:59:59'  
  
  
  
While charindex(',', @vendor_remain) <> 0  
begin  
	Set @vendor_part = ltrim(left(@vendor_remain, charindex(',',@vendor_remain) - 1))  
	Set @vendor_remain = right(@vendor_remain, len(@vendor_remain) - charindex(',', @vendor_remain))  
	insert into #tmp_INR00013 values (@vendor_part)  
end  
insert into #tmp_INR00013 values (ltrim(@vendor_remain))  
  
Declare   
@SCFmC  nvarchar(4),  
@SCToC  nvarchar(4),  
@CURAT  numeric(15,11)  
set  @SCFmC  = ''  
set  @SCToC  = ''  
  
If @SCFm <> ''  
begin  
	Set @SCFmC = left(@SCFm, charindex(' - ', @SCFm))  
end  
  
If @SCTo <> ''  
begin  
	Set @SCToC = left(@SCTo, charindex(' - ', @SCTo) )  
end  
    
declare @tmp_osaamt numeric(13,4)  
set @tmp_osaamt = 0  
  

Select   
'dateFrom' = Case when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') <= @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
		when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') >   @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01')  
		when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') <=  @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
		when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') >    @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16')end,  
'DateTo' = Case when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  > @dateTo then convert(datetime,convert(char(10),@dateTo,111))  
		when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  
		when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  
		when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  > @dateTo then convert(datetime,convert(char(10),@dateTo,111)) end,  
'USAAMT' = sum(case soh_curexrat when 0 then 0 else isnull(hid_shpqty * hid_selprc / soh_curexrat,0) end),
'USAOSAMT' = @tmp_osaamt,  
hih_cocde  
into #report1  
From   
SHIPGHDR (nolock),  
SHINVHDR (nolock),  
SHIPGDTL (nolock),  
SCORDDTL (nolock)  
left join v_imbasinf_rpt on sod_itmno = ibi_itmno,  
#tmp_INR00013, 
SCORDHDR (nolock)
Where   
hih_cocde = hid_cocde   
and hih_shpno = hid_shpno  
and hid_cocde = sod_cocde   
and hid_ordno = sod_ordno   
and hid_ordseq = sod_ordseq   
and hid_cocde = hiv_cocde   
and hid_shpno = hiv_shpno   
and hid_invno = hiv_invno  
and hid_itmno = sod_itmno  
and hiv_invdat >=  convert(datetime,  @dateFm, 121) and hiv_invdat <= convert(datetime, @dateTo, 121)   
and soh_ordno = sod_ordno
and hid_venno = tmp_venno  
and ((@SCTo <> '' and ((sod_venno in ('0005') and sod_subcde Between @SCFmC and @SCToC) or sod_venno not in ('0005'))) or @SCTo = '')  
and ((@CatFm <> '' and ibi_catlvl0 between @CatFm and @CatTo and @CatL = '0') or  
	(@CatFm <> '' and ibi_catlvl1 between @CatFm and @CatTo and @CatL = '1') or  
	(@CatFm <> '' and ibi_catlvl2 between @CatFm and @CatTo and @CatL = '2') or  
	(@CatFm <> '' and ibi_catlvl3 between @CatFm and @CatTo and @CatL = '3') or  
	(@CatFm <> '' and ibi_catlvl4 between @CatFm and @CatTo and @CatL = '4') or @CatFm = '')  
group by   
Case 	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') <= @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') > @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01')  
	when datepart(dd, hiv_invdat) > 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') <= @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
	when datepart(dd, hiv_invdat) > 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') > @dateFm then convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') end,  
Case	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15') > @dateTo then convert(datetime,convert(char(10),@dateTo,111))  
	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15') <= @dateTo then convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  
	when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1 <= @dateTo then convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  
	when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1 > @dateTo then convert(datetime,convert(char(10),@dateTo,111)) end,
hih_cocde  
order by   
Case 	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') <= @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') >   @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01')  
	when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') <=  @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
	when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') >    @dateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') end,  
Case	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  > @dateTo then convert(datetime,convert(char(10),@dateTo,111))  
	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  
	when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  
	when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  > @dateTo then convert(datetime,convert(char(10),@dateTo,111)) end   






create table #TEMP_SCORDDTL
(
sod_ordno	nvarchar(20),
sod_ordseq	int,
sod_shpseq	int,
sod_shpstr	datetime,
sod_osqty	int,
sod_netuntprc	numeric(13,4),
soh_curexrat	numeric(13,4),
sod_cocde	nvarchar(10)
)



insert into #TEMP_SCORDDTL
select 
sod_ordno,
sod_ordseq,
0,
sod_shpstr,
sod_ordqty - sod_shpqty,
sod_netuntprc,
soh_curexrat,
sod_cocde
from SCORDDTL (nolock)
left join v_imbasinf_rpt on sod_itmno = ibi_itmno
left join SCDTLSHP on sds_ordno = sod_ordno and sds_seq = sod_ordseq,  
SCORDHDR (nolock),  
#tmp_INR00013  
Where   
sds_cocde is null and sod_cocde = soh_cocde   
and sod_ordno = soh_ordno  
and  sod_shpstr >=  convert(datetime,  @dateFm, 121) and sod_shpstr <= convert(datetime, @dateTo, 121)   
and  sod_venno = tmp_venno  
and  ((@SCTo <> '' and ((sod_venno in ('0005') and sod_subcde Between @SCFmC and @SCToC) or sod_venno not in ('0005'))) or @SCTo = '')  
and ((@CatFm <> '' and ibi_catlvl0 between @CatFm and @CatTo and @CatL = '0') or  
	(@CatFm <> '' and ibi_catlvl1 between @CatFm and @CatTo and @CatL = '1') or  
	(@CatFm <> '' and ibi_catlvl2 between @CatFm and @CatTo and @CatL = '2') or  
	(@CatFm <> '' and ibi_catlvl3 between @CatFm and @CatTo and @CatL = '3') or  
	(@CatFm <> '' and ibi_catlvl4 between @CatFm and @CatTo and @CatL = '4') or @CatFm = '')  


declare 
@tmp_sod_ordno nvarchar(20),
@tmp_sod_ordseq int,
@tmp_sds_shpseq int,
@tmp_sds_scfrom datetime,
@tmp_sod_ordqty int,
@tmp_sod_shpqty int,
@tmp_sds_ordqty int,
@tmp_sod_netuntprc numeric(13,4),
@tmp_soh_cuexrat numeric(13,4),
@tmp_sod_cocde nvarchar(10),

@last_sod_ordno nvarchar(20),
@last_sod_ordseq int,
@used_shpqty int,
@remain_shpqty int

set @tmp_sod_ordno = ''
set @tmp_sod_ordseq = 0
set @tmp_sds_shpseq = 0
set @tmp_sds_scfrom = '1900-01-01'
set @tmp_sod_ordqty = 0
set @tmp_sod_shpqty = 0
set @tmp_sds_ordqty = 0
set @tmp_sod_netuntprc = 0
set @tmp_soh_cuexrat = 0
set @tmp_sod_cocde = ''

set @last_sod_ordno = ''
set @last_sod_ordseq = 0
set @used_shpqty = 0
set @remain_shpqty = 0

declare cur_delivery_scdtlshp cursor
for
select
sod_ordno,
sod_ordseq,
sds_shpseq,
sds_scfrom,
sod_ordqty,
sod_shpqty,
sds_ordqty,
sod_netuntprc,
soh_curexrat,
sod_cocde
from SCORDDTL (nolock)
left join v_imbasinf_rpt on sod_itmno = ibi_itmno
left join SCDTLSHP on sds_ordno = sod_ordno and sds_seq = sod_ordseq,  
SCORDHDR (nolock),  
#tmp_INR00013  
Where   
sds_cocde is not null and sod_ordqty <> sod_shpqty and sod_cocde = soh_cocde   
and sod_ordno = soh_ordno  
and  sds_scfrom >=  convert(datetime,  @dateFm, 121) and sds_scfrom <= convert(datetime, @dateTo, 121)   
and  sod_venno = tmp_venno  
and  ((@SCTo <> '' and ((sod_venno in ('0005') and sod_subcde Between @SCFmC and @SCToC) or sod_venno not in ('0005'))) or @SCTo = '')  
and ((@CatFm <> '' and ibi_catlvl0 between @CatFm and @CatTo and @CatL = '0') or  
	(@CatFm <> '' and ibi_catlvl1 between @CatFm and @CatTo and @CatL = '1') or  
	(@CatFm <> '' and ibi_catlvl2 between @CatFm and @CatTo and @CatL = '2') or  
	(@CatFm <> '' and ibi_catlvl3 between @CatFm and @CatTo and @CatL = '3') or  
	(@CatFm <> '' and ibi_catlvl4 between @CatFm and @CatTo and @CatL = '4') or @CatFm = '')  
order by sod_ordno,sod_ordseq,sds_shpseq


open cur_delivery_scdtlshp
fetch next from cur_delivery_scdtlshp into @tmp_sod_ordno,@tmp_sod_ordseq,@tmp_sds_shpseq,@tmp_sds_scfrom,@tmp_sod_ordqty,@tmp_sod_shpqty,@tmp_sds_ordqty,@tmp_sod_netuntprc,@tmp_soh_cuexrat,@tmp_sod_cocde

while @@fetch_status = 0
begin
	if not(@tmp_sod_ordno = @last_sod_ordno and @tmp_sod_ordseq = @last_sod_ordseq)
	begin
		set @remain_shpqty = @tmp_sod_shpqty
		set @used_shpqty = 0
	end

	if @remain_shpqty - @tmp_sds_ordqty >= 0 
	begin
		set @remain_shpqty = @remain_shpqty - @tmp_sds_ordqty
	end
	else if @remain_shpqty > 0
	begin
		insert into #TEMP_SCORDDTL
		select @tmp_sod_ordno,@tmp_sod_ordseq,@tmp_sds_shpseq,@tmp_sds_scfrom,@tmp_sds_ordqty - @remain_shpqty,@tmp_sod_netuntprc,@tmp_soh_cuexrat,@tmp_sod_cocde

		set @remain_shpqty = @remain_shpqty - @tmp_sds_ordqty
	end
	else
	begin
		insert into #TEMP_SCORDDTL
		select @tmp_sod_ordno,@tmp_sod_ordseq,@tmp_sds_shpseq,@tmp_sds_scfrom,@tmp_sds_ordqty,@tmp_sod_netuntprc,@tmp_soh_cuexrat,@tmp_sod_cocde

		set @remain_shpqty = @remain_shpqty - @tmp_sds_ordqty
	end

	if not(@tmp_sod_ordno = @last_sod_ordno and @tmp_sod_ordseq = @last_sod_ordseq)
	begin
		set @last_sod_ordno = @tmp_sod_ordno
		set @last_sod_ordseq = @tmp_sod_ordseq
	end
	fetch next from cur_delivery_scdtlshp into @tmp_sod_ordno,@tmp_sod_ordseq,@tmp_sds_shpseq,@tmp_sds_scfrom,@tmp_sod_ordqty,@tmp_sod_shpqty,@tmp_sds_ordqty,@tmp_sod_netuntprc,@tmp_soh_cuexrat,@tmp_sod_cocde
end
close cur_delivery_scdtlshp
deallocate cur_delivery_scdtlshp



Select   
'dateFrom' = Case when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01') <= @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
		when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01') >   @dateFm then  convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01')  
		when datepart(dd, sod_shpstr) > 15   and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16') <=  @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
		when datepart(dd, sod_shpstr) > 15   and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16') >    @dateFm then  convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16')end,  
'DateTo' = Case when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  > @dateTo then convert(datetime,convert(char(10),@dateTo,111))  
		when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  
		when datepart(dd, sod_shpstr) > 15 and convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  
		when datepart(dd, sod_shpstr) > 15 and convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  > @dateTo then convert(datetime,convert(char(10),@dateTo,111)) end,  
'USAAMT' = 0,  
'USAOSAMT' = sum( isnull(((sod_osqty * sod_netuntprc) / soh_curexrat),0)),
sod_cocde  
into #report1_2 
From   #TEMP_SCORDDTL
group by   
Case	when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01') <= @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
	when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01') >   @dateFm then  convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01')  
	when datepart(dd, sod_shpstr) > 15   and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16')<=  @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
	when datepart(dd, sod_shpstr) > 15   and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16') >    @dateFm then convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16') end,  
Case	when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  > @dateTo then convert(datetime,convert(char(10),@dateTo,111))  
	when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  
	when datepart(dd, sod_shpstr) > 15 and convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  
	when datepart(dd, sod_shpstr) > 15 and convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  > @dateTo then convert(datetime,convert(char(10),@dateTo,111)) end,
sod_cocde  
order by   
Case	when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01') <= @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
	when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01') >   @dateFm then  convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01')  
	when datepart(dd, sod_shpstr) > 15   and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16') <=  @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
	when datepart(dd, sod_shpstr) > 15   and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16') >    @dateFm then  convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16') end,  
Case 	when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  > @dateTo then convert(datetime,convert(char(10),@dateTo,111))  
	when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  
	when datepart(dd, sod_shpstr) > 15 and convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  
	when datepart(dd, sod_shpstr) > 15 and convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  > @dateTo then convert(datetime,convert(char(10),@dateTo,111)) end  
--select * from #report1_2

/*  
Select   
'dateFrom' = Case when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01') <= @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
		when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01') >   @dateFm then  convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01')  
		when datepart(dd, sod_shpstr) > 15   and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16') <=  @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
		when datepart(dd, sod_shpstr) > 15   and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16') >    @dateFm then  convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16')end,  
'DateTo' = Case when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  > @dateTo then convert(datetime,convert(char(10),@dateTo,111))  
		when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  
		when datepart(dd, sod_shpstr) > 15 and convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  
		when datepart(dd, sod_shpstr) > 15 and convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  > @dateTo then convert(datetime,convert(char(10),@dateTo,111)) end,  
'USAAMT' = 0,  
'USAOSAMT' = sum(case soh_ordsts when 'CLO' then 0 when 'CAN' then 0 else case soh_curexrat when 0 then 0 else isnull(((sod_ordqty - sod_shpqty) * sod_netuntprc) / soh_curexrat,0) end end),
sod_cocde  
into #report1_2 
From   
SCORDDTL (nolock)  
left join v_imbasinf_rpt on sod_itmno = ibi_itmno,  
SCORDHDR (nolock),  
#tmp_INR00013  
Where   
sod_cocde = soh_cocde   
and sod_ordno = soh_ordno  
and  sod_shpstr >=  convert(datetime,  @dateFm, 121) and sod_shpstr <= convert(datetime, @dateTo, 121)   
and  sod_venno = tmp_venno  
and  ((@SCTo <> '' and ((sod_venno in ('0005') and sod_subcde Between @SCFmC and @SCToC) or sod_venno not in ('0005'))) or @SCTo = '')  
and ((@CatFm <> '' and ibi_catlvl0 between @CatFm and @CatTo and @CatL = '0') or  
	(@CatFm <> '' and ibi_catlvl1 between @CatFm and @CatTo and @CatL = '1') or  
	(@CatFm <> '' and ibi_catlvl2 between @CatFm and @CatTo and @CatL = '2') or  
	(@CatFm <> '' and ibi_catlvl3 between @CatFm and @CatTo and @CatL = '3') or  
	(@CatFm <> '' and ibi_catlvl4 between @CatFm and @CatTo and @CatL = '4') or @CatFm = '')  
group by   
Case	when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01') <= @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
	when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01') >   @dateFm then  convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01')  
	when datepart(dd, sod_shpstr) > 15   and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16')<=  @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
	when datepart(dd, sod_shpstr) > 15   and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16') >    @dateFm then convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16') end,  
Case	when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  > @dateTo then convert(datetime,convert(char(10),@dateTo,111))  
	when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  
	when datepart(dd, sod_shpstr) > 15 and convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  
	when datepart(dd, sod_shpstr) > 15 and convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  > @dateTo then convert(datetime,convert(char(10),@dateTo,111)) end,
sod_cocde  
order by   
Case	when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01') <= @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
	when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01') >   @dateFm then  convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '01')  
	when datepart(dd, sod_shpstr) > 15   and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16') <=  @dateFm then convert(datetime,convert(char(10),@dateFm,111))  
	when datepart(dd, sod_shpstr) > 15   and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16') >    @dateFm then  convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '16') end,  
Case 	when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  > @dateTo then convert(datetime,convert(char(10),@dateTo,111))  
	when datepart(dd, sod_shpstr) <= 15 and convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  <= @dateTo then convert(datetime,left(convert(char(10), sod_shpstr,111),8) + '15')  
	when datepart(dd, sod_shpstr) > 15 and convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  <= @dateTo then convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  
	when datepart(dd, sod_shpstr) > 15 and convert(datetime, left(convert(char(10), sod_shpstr +16,111),8) + '01') - 1  > @dateTo then convert(datetime,convert(char(10),@dateTo,111)) end  
*/







  
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
  
	if not exists (select 1 from #report1 where [dateFrom] = convert(datetime,@tmp_date_fm) and [DateTo] = convert(datetime,@tmp_date_to)-1 and hih_cocde = 'UCPP')  
	begin  
		insert into #report1 values (convert(datetime,@tmp_date_fm), convert(datetime,@tmp_date_to)-1, 0, 0, 'UCPP')  
	end  
  
	if not exists (select 1 from #report1 where [dateFrom] = convert(datetime,@tmp_date_fm) and [DateTo] = convert(datetime,@tmp_date_to)-1 and hih_cocde = 'UCP')  
	begin  
		insert into #report1 values (convert(datetime,@tmp_date_fm), convert(datetime,@tmp_date_to)-1, 0, 0, 'UCP')  
	end  
  
	if not exists (select 1 from #report1 where [dateFrom] = convert(datetime,@tmp_date_fm) and [DateTo] = convert(datetime,@tmp_date_to)-1 and hih_cocde = 'PG')  
	begin  
		insert into #report1 values (convert(datetime,@tmp_date_fm), convert(datetime,@tmp_date_to)-1, 0, 0, 'PG')  
	end  

	if not exists (select 1 from #report1 where [dateFrom] = convert(datetime,@tmp_date_fm) and [DateTo] = convert(datetime,@tmp_date_to)-1 and hih_cocde = 'EW')  
	begin  
		insert into #report1 values (convert(datetime,@tmp_date_fm), convert(datetime,@tmp_date_to)-1, 0, 0, 'EW')  
	end  

	if not exists (select 1 from #report1 where [dateFrom] = convert(datetime,@tmp_date_fm) and [DateTo] = convert(datetime,@tmp_date_to)-1 and hih_cocde = 'MS')  
	begin  
		insert into #report1 values (convert(datetime,@tmp_date_fm), convert(datetime,@tmp_date_to)-1, 0, 0, 'MS')  
	end  

	if not exists (select 1 from #report1 where [dateFrom] = convert(datetime,@tmp_date_fm) and [DateTo] = convert(datetime,@tmp_date_to)-1 and hih_cocde = 'HX')  
	begin  
		insert into #report1 values (convert(datetime,@tmp_date_fm), convert(datetime,@tmp_date_to)-1, 0, 0, 'HX')  
	end  

	if not exists (select 1 from #report1 where [dateFrom] = convert(datetime,@tmp_date_fm) and [DateTo] = convert(datetime,@tmp_date_to)-1 and hih_cocde = 'HB')  
	begin  
		insert into #report1 values (convert(datetime,@tmp_date_fm), convert(datetime,@tmp_date_to)-1, 0, 0, 'HB')  
	end  

	if not exists (select 1 from #report1 where [dateFrom] = convert(datetime,@tmp_date_fm) and [DateTo] = convert(datetime,@tmp_date_to)-1 and hih_cocde = 'TT')  
	begin  
		insert into #report1 values (convert(datetime,@tmp_date_fm), convert(datetime,@tmp_date_to)-1, 0, 0, 'TT')  
	end  

	if not exists (select 1 from #report1 where [dateFrom] = convert(datetime,@tmp_date_fm) and [DateTo] = convert(datetime,@tmp_date_to)-1 and hih_cocde = 'GU')  
	begin  
		insert into #report1 values (convert(datetime,@tmp_date_fm), convert(datetime,@tmp_date_to)-1, 0, 0, 'GU')  
	end  

	if not exists (select 1 from #report1 where [dateFrom] = convert(datetime,@tmp_date_fm) and [DateTo] = convert(datetime,@tmp_date_to)-1 and hih_cocde = 'HH')  
	begin  
		insert into #report1 values (convert(datetime,@tmp_date_fm), convert(datetime,@tmp_date_to)-1, 0, 0, 'HH')  
	end  

end  
  
update #report1 set [USAOSAMT] = b.[USAOSAMT]  
from #report1 a, #report1_2 b  
where a.hih_cocde = b.sod_cocde  
and a.[dateFrom] = b.[dateFrom]  
and a.[dateTo] = b.[dateTo]  
  

Select   
'dateFrom' = Case when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') <= @ReviewdateFm then @reviewdatefm  
		when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') >   @ReviewdateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01')  
		when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') <=  @ReviewdateFm then @reviewdatefm  
		when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') >    @ReviewdateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16')end,  
'DateTo' = Case when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  > @ReviewdateTo then @ReviewdateTo  
		when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  <= @ReviewdateTo then convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  
		when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  <= @ReviewdateTo then convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  
		when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  > @ReviewdateTo then @ReviewdateTo end,  
'USAAMT' = isnull(sum(case soh_curexrat when 0 then 0 else isnull(hid_shpqty * hid_selprc / soh_curexrat,0) end),0),
'USAOSAMT' = @tmp_osaamt,  
hih_cocde  
into #report2  
From
SHIPGHDR (nolock),  
SHINVHDR (nolock),  
SHIPGDTL (nolock),  
SCORDDTL (nolock)  
left join v_imbasinf_rpt on sod_itmno = ibi_itmno,  
#tmp_INR00013, 
SCORDHDR (nolock)
Where   
hih_cocde = hid_cocde   
and hih_shpno = hid_shpno  
and hid_cocde = sod_cocde   
and hid_ordno = sod_ordno   
and hid_ordseq = sod_ordseq   
and hid_cocde = hiv_cocde   
and hid_shpno = hiv_shpno   
and hid_invno = hiv_invno  
and hid_itmno = sod_itmno  
and hiv_invdat >=  convert(datetime,  @reviewdatefm, 121) and hiv_invdat <=  convert(datetime, @ReviewdateTo, 121)   
and hid_venno = tmp_venno  
and soh_ordno = sod_ordno
and ((@SCTo <> '' and ((sod_venno in ('0005') and sod_subcde Between @SCFmC and @SCToC) or sod_venno not in ('0005'))) or @SCTo = '')  
and ((@CatFm <> '' and ibi_catlvl0 between @CatFm and @CatTo and @CatL = '0') or  
	(@CatFm <> '' and ibi_catlvl1 between @CatFm and @CatTo and @CatL = '1') or  
	(@CatFm <> '' and ibi_catlvl2 between @CatFm and @CatTo and @CatL = '2') or  
	(@CatFm <> '' and ibi_catlvl3 between @CatFm and @CatTo and @CatL = '3') or  
	(@CatFm <> '' and ibi_catlvl4 between @CatFm and @CatTo and @CatL = '4') or @CatFm = '')  
group by   
Case	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') <= @ReviewdateFm then @reviewdatefm  
	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') >   @ReviewdateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01')  
	when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16')<=  @ReviewdateFm then @reviewdatefm  
	when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') >    @ReviewdateFm then convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') end,  
Case	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  > @ReviewdateTo then @ReviewdateTo  
	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  <= @ReviewdateTo then convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  
	when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  <= @ReviewdateTo then convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  
	when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  > @ReviewdateTo then @ReviewdateTo end,
hih_cocde  
order by   
Case 	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') <= @ReviewdateFm then @reviewdatefm  
	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01') >   @ReviewdateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '01')  
	when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') <=  @ReviewdateFm then @reviewdatefm  
	when datepart(dd, hiv_invdat) > 15   and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') >    @ReviewdateFm then  convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '16') end,  
Case	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  > @ReviewdateTo then @ReviewdateTo  
	when datepart(dd, hiv_invdat) <= 15 and convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  <= @ReviewdateTo then convert(datetime,left(convert(char(10), hiv_invdat,111),8) + '15')  
	when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  <= @ReviewdateTo then convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  
	when datepart(dd, hiv_invdat) > 15 and convert(datetime, left(convert(char(10), hiv_invdat +16,111),8) + '01') - 1  > @ReviewdateTo then @ReviewdateTo end  

if @cocde<>'UC-G'   
begin  
	delete from #report1 where hih_cocde<>@cocde  
	delete from #report2 where hih_cocde<>@cocde  
end  
else  
begin  
	delete from #report1 where hih_cocde='MS'  
	delete from #report2 where hih_cocde='MS'  
end  
  
select   
@Cocde as 'cocde',  
@vendor as 'vendor',  
@vendor_label as 'vendor_label',  
@SCFm as 'SCFm',  
@SCTo as 'SCTo',  
@dateFm as 'RptDateFrom',  
@dateTo as 'RptDateTo',  
#report1.datefrom as 'datefrom',  
#report1.dateto as 'dateto',  
sum(round(#report1.usaosamt,2)) as 'usaosamt',  
sum(round(#report1.usaamt,2)) as 'usaamt',  
sum(case isnull(#report2.usaamt,0) when 0 then 0 else round(#report2.usaamt,2) end) as 'PUSAAMT',  
sum(round(#report1.usaamt,2))- sum(case isnull(#report2.usaamt,0) when 0 then 0 else round(#report2.usaamt,2) end) as 'Difference'  
into #RESULT  
from #report1  
left join #report2 on #report1.hih_cocde = #report2.hih_cocde and  
		  convert(varchar(10),dateadd(yy,-1,#report1.datefrom),101) = convert(varchar(10),#report2.datefrom,101) and   
		  convert(varchar(10),dateadd(yy,-1,#report1.datefrom),101) = convert(varchar(10),#report2.datefrom,101)   
group by #report1.datefrom, #report1.dateto    
order by #report1.datefrom, #report1.dateto  
  
update #RESULT set [Difference] = 0 where [datefrom] > getdate()  

select   
Cocde	  as 'Cocde',   
Vendor	  as 'Vendor',   
Vendor_Label	  as 'Vendor_Label',   
SCFm  as 'SCFm',   
SCTo  as 'SCTo',   
RptDateFrom  as 'RptDateFrom',   
RptDateTo  as 'RptDateTo',   
DateFrom  as 'DateFrom',   
DateTo	  as 'DateTo',   
USAOSAMT  as 'USDOSAMT',   
USAAMT	  as 'USDAMT',   
PUSAAMT	  as 'PUSDAMT',   
DIFFERENCE  as 'DIFFERENCE',   
@compName as 'compName'  
from #RESULT





GO
GRANT EXECUTE ON [dbo].[sp_select_INR00013] TO [ERPUSER] AS [dbo]
GO
