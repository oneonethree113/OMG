/****** Object:  StoredProcedure [dbo].[sp_list_BSP00005a]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_BSP00005a]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_BSP00005a]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






--sp_list_BSP00005a 'UCPP','08/01/2005 00:00:00.000','12/31/2005 23:59:59','10/01/2005 00:00:00.000','05/31/2006 23:59:59','','','A','Z','','','1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,1234567890,12345678','','Y','S','I,J,E','Q'

--sp_list_BSP00005a 'UCPP','10/01/2005 00:00:00.000','12/31/2005 23:59:59','','','','','','','','','','','N','S','J,E','Q'

--sp_list_BSP00005a 'UCPP','','','01/01/2006 00:00:00.000','12/31/2006 23:59:59','50130','50130','','','','','','','N','S','I,J,E','Q'


CREATE  procedure [dbo].[sp_list_BSP00005a]
@COCDE		varchar(6) , 
@ITMDATEFM	datetime , 
@ITMDATETO	datetime , 
@SCIDATEFM	datetime , 
@SCIDATETO	datetime , 
@CUSTFM	varchar(10) , 
@CUSTTO	varchar(10) , 
@VENCDEFM	varchar(10) , 
@VENCDETO	varchar(10) , 
@ITMNOFM	varchar(30) , 
@ITMNOTO	varchar(30) , 
@ITMNOLIST	varchar(2500) , 
@TITLE		varchar(100) , 
@PRINTAMOUNT	char(1) , 
@optSal_Pur	char(1) , 
@VendorType	char(6) , 
@ORDERBY	char(1) 
as
Begin


--select @SCIDATEFM, @SCIDATETO

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
create table #TMP_Result(
	res_ordno		varchar(20) , 
	res_cusno		varchar(12) , 
	res_cussna		varchar(40) , 
	res_itmno 		varchar(30) , 
	res_pven		varchar(250) , 
	res_imgpth		varchar(200),
	res_ordqtypc	int , 
	res_total		numeric(13,4) 
)	

create table #Result(
	res_cusno		varchar(12) , 
	res_cussna		varchar(40) , 
	res_itmno 		varchar(30) , 
	res_pven		varchar(250) , 
	res_ordqtypc	int , 
	res_imgpth		varchar(200),
	res_total		numeric(13,4) , 
	res_count		int ,

)	


create table #Total_Counter (
	res_cusno		varchar(12) , 
	res_cussna		varchar(40) , 
	res_itmno 		varchar(30) , 
	res_ttl_ordqtypc	int,
	res_ttl_total		numeric(13,4)
)


create table #TMP_ITM (tmp_ITMNO varchar(20)) on [PRIMARY]
create table #TMP_VENTYP (tmp_VenTyp varchar(10)) on [PRIMARY]
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Declare 
@optItmStr	char(1) ,
@ItmStrRemain	varchar(2500) , 
@ItmStrPart	varchar(20) , 
@optVenTypStr	char(1) , 
@VenTypStrRemain	varchar(2500) , 
@VenTypStrPart	varchar(20)

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- Vendor Type
set @optVenTypStr = 'N'
set @VendorType = ltrim(rtrim(@VendorType))

if len(@VendorType) > 0 
Begin
	
	set @optVenTypStr = 'Y'
	set @VenTypStrRemain = ltrim(rtrim(@VendorType))
	set @VenTypStrPart  = ''
	while charindex(',', @VenTypStrRemain) > 0
	begin
		set @VenTypStrPart = ltrim(left(@VenTypStrRemain, charindex(',', @VenTypStrRemain)-1))
		set @VenTypStrRemain = right(@VenTypStrRemain, len(@VenTypStrRemain) - charindex(',', @VenTypStrRemain))

		insert into #TMP_VENTYP values (@VenTypStrPart)
	end

	--if charindex(',',@VenTypStrRemain) = 0 
	insert into #TMP_VENTYP values (ltrim(@VenTypStrRemain))
	
End
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- Item List
set @optItmStr = 'N'
set @ITMNOLIST = ltrim(rtrim(@ITMNOLIST))
if len(@ITMNOLIST) > 0 
Begin
	set @optItmStr = 'Y'
	set @ItmStrRemain = ltrim(rtrim(@ITMNOLIST))
	set @ItmStrPart = ''

	while charindex(',',@ItmStrRemain)<>0
	begin
		set @ItmStrPart = ltrim(left(@ItmStrRemain, charindex(',', @ItmStrRemain)-1))
		set @ItmStrRemain = right(@ItmStrRemain, len(@ItmStrRemain) - charindex(',', @ItmStrRemain))
		insert into #TMP_ITM values (@ItmStrPart)
	end

	if charindex(',',@ItmStrRemain) = 0 
		insert into #TMP_ITM values (@ItmStrRemain)	
End



--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx



insert into #TMP_Result
select 
	--soh_ordno as 'soh_ordno' , 
	'' as 'soh_ordno' , 
	soh_cus1no , 
	isnull(cbi_cussna,'') as 'cbi_cussna', 
	sod_itmno, 
	sod_venno +  ' - ' +  isnull(vbi_vensna,'') as 'sod_venno',  
	isnull(ibi_imgpth ,'') as 'ibi_imgpth' , 
	sum(sod_ordqty * isnull(ycf_value,0)) as 'sod_ordqtypc', 
	--sum(round(round(sod_netuntprc*isnull(ysi_selrat,0),4)*sod_ordqty,0)) as 'sod_subtotal_usd' 
	--sum(round(sod_netuntprc*isnull(ysi_selrat,0)*sod_ordqty,4)) as 'sod_subtotal_usd' 
	--Frankie Cheung 20091006
	sum(case soh_curexrat when 0 then 0 else round((sod_netuntprc/soh_curexrat)*sod_ordqty,4) end) as 'sod_subtotal_usd'

	
from 
	SCORDHDR(NOLOCK) 
	LEFT JOIN SCORDDTL(NOLOCK)  on soh_cocde = sod_cocde and soh_ordno = sod_ordno
	LEFT JOIN IMBASINF(NOLOCK)  on sod_itmno = ibi_itmno
	--LEFT JOIN IMVENINF on ibi_itmno = ivi_itmno and ivi_def = 'Y'
	LEFT JOIN VNBASINF(NOLOCK)  on sod_venno  = vbi_venno
	--Frankie Cheung 20091006
	--LEFT JOIN SYSETINF(NOLOCK)  on ysi_typ = '06' and ysi_cde = sod_curcde	
	LEFT JOIN SYCONFTR(NOLOCK)  on sod_pckunt = ycf_code1
	LEFT JOIN CUBASINF(NOLOCK)  on soh_cus1no = cbi_cusno
where 
	(@SCIDATEFM = '1900-01-01' or  Soh_issdat between @SCIDATEFM and @SCIDATETO) and
	(@ITMDATEFM = '1900-01-01' or ibi_credat between @ITMDATEFM and @ITMDATETO)  and 
	(len(@CUSTFM) <= 0 or (len(@CUSTFM) > 0 and  Soh_cus1no between @CUSTFM and @CUSTTO)) and 
	(len(@VENCDEFM )<=0 or (len(@VENCDEFM ) > 0 and vbi_venno between @VENCDEFM and @VENCDETO)) and 
	(len(@ITMNOFM )<= 0 or (len(@ITMNOFM ) > 0 and sod_itmno between @ITMNOFM and @ITMNOTO)) and 
	(@optItmStr = 'N' or (@optItmStr = 'Y' and sod_itmno  in (select tmp_ITMNO from #TMP_ITM ))) and 
	(@optVenTypStr = 'N' or (@optVenTypStr = 'Y' and vbi_ventyp in (select tmp_VenTyp from #TMP_VENTYP ) ))

group by 
	soh_ordno , 
	soh_cus1no , 
	isnull(cbi_cussna,'') , 
	sod_itmno, 
	sod_venno +  ' - ' +  isnull(vbi_vensna,''),
	isnull(ibi_imgpth ,'')
	

--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

insert into 
	#Result (res_cusno, res_cussna, res_itmno, res_pven,res_imgpth, res_ordqtypc, res_total,res_count)
select 
	res_cusno, 
	res_cussna, 
	res_itmno, 
	res_pven, 
	res_imgpth , 
	sum(res_ordqtypc), 
	sum(res_total), 
	0
from
	#TMP_Result
group by 
	res_cusno, 
	res_cussna, 
	res_itmno, 
	res_pven, 
	res_imgpth


insert into 
	#Total_Counter (res_cusno, res_cussna, res_itmno,res_ttl_ordqtypc, res_ttl_total)
select 
	res_cusno, 
	res_cussna, 
	res_itmno, 
	sum(res_ordqtypc), 
	sum(res_total)
from
	#Result
group by 
	res_cusno, 
	res_cussna, 
	res_itmno






/*

update c
set c.res_count = b. _cnt
from #Result c , (
	select res_cusno as '_cusno' , count(1) as '_cnt'
	from (
		select 	
			distinct 
			res_ordno , 
			res_cusno 
		from 
			#TMP_Result
	) a
	group by res_cusno 
	) b

*/


--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx	
-- Result 
--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

--select * from #TMP_Result


select 
	@ITMDATEFM as 'ITMDATEFM' , 
	@ITMDATETO as 'ITMDATETO' , 
	@SCIDATEFM as 'SCIDATEFM' , 
	@SCIDATETO as 'SCIDATETO'	, 
	@TITLE as 'TITLE' , 
	@PRINTAMOUNT as 'PRINTTAMOUNT' , 
	@ORDERBY as 'OrderBy', 
	a.*
from 
	#Result a, #Total_Counter b
where
	a.res_ordqtypc > 0 
	and a.res_cusno = b.res_cusno
	and a.res_cussna = b.res_cussna
	and a.res_itmno = b.res_itmno
order by 
	a.res_cussna, 
	case @ORDERBY when 'Q' then b.res_ttl_ordqtypc else b.res_ttl_total end desc 


--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

drop table #TMP_Result
drop table #Result
drop table #Total_Counter
	
End






GO
GRANT EXECUTE ON [dbo].[sp_list_BSP00005a] TO [ERPUSER] AS [dbo]
GO
