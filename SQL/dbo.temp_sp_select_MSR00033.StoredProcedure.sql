/****** Object:  StoredProcedure [dbo].[temp_sp_select_MSR00033]    Script Date: 09/29/2017 15:29:08 ******/
DROP PROCEDURE [dbo].[temp_sp_select_MSR00033]
GO
/****** Object:  StoredProcedure [dbo].[temp_sp_select_MSR00033]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








/***********************************************************************************************************************************************
Modification History
************************************************************************************************************************************************
Modified by		Modified on		Description
************************************************************************************************************************************************
Lester Wu			2005-04-04		replace ALL with UC-G, exclude MS from UC-G, retrieve company name from database
************************************************************************************************************************************************/



CREATE    PROCEDURE [dbo].[temp_sp_select_MSR00033]

@Cocde nvarchar(6),
@CUFm nvarchar(6),
@CUTo nvarchar(6),
@SIFm nvarchar(20),
@SITo nvarchar(20),
@VenCdeFm nvarchar(20),
@VenCdeTo nvarchar(20),
@VenSubCdeFm nvarchar(20),
@VenSubCdeTo nvarchar(20),
@VenTypFm nvarchar(20),
@VenTypTo nvarchar(20),
@IssFm DateTime,
@IssTo DateTime,
@Status nvarchar(3),
@Sort nvarchar(20),
@usrid nvarchar(30)

AS

-- temp_sp_select_MSR00033 'UCPP', '', '', 'UA0300979', 'UA0300979', '', '', '', '', 'A', 'Z', '2003-08-01', '2003-08-10', 'ALL', '', ''
-- temp_sp_select_MSR00033 'UCP', '', '', '', '', '0005', '0005', '', 'WT', '', '', '2001-08-01', '2003-08-10', 'ALL', '', ''
-- select top 1 convert(nvarchar(10),sih_issdat,101) from SAINVHDR

Declare 	@OptCu nvarchar(1),
		@OptSI nvarchar(1),
		@OptIss nvarchar(1),
		@OptSts nvarchar(1),
		@OptVenCde nvarchar(1),
		@OptVenSubCde nvarchar(1),
		@OptVenTyp nvarchar(1)

-- Lester Wu 2004/03/05
SET @IssTo = @IssTo + ' 23:59:59.000'
-------------------------------


IF @CUFm = '' 
	SET @OptCu = 'N'
else
	SET @OptCu = 'Y'

IF @SIFm = '' 
	SET @OptSI = 'N'
else
	SET @OptSI= 'Y'

if @VenCdeFm = ''
	set @OptVenCde = 'N'
else
	set @OptVenCde = 'Y'

if @VenSubCdeFm = ''
	set @optVenSubCde = 'N'
else
	set @optVenSubCde = 'Y'


if @VenTypFm = ''
	set @OptVenTyp = 'N'
else
	set @OptVenTyp = 'Y'

IF @IssFm = '' 
	SET @OptIss = 'N'
else
	SET @OptIss = 'Y'
IF @status = 'ALL'
	SET @OptSts = 'N'
else
	SET @OptSts = 'Y'


--Lester Wu 2005-04-02, retrieve company name from database----------------------------------------
declare @compName varchar(100)
set @compName = 'UNITED CHINESE GROUP'
if @cocde<>'UC-G'
begin
	select @compName = yco_conam from sycominf where yco_cocde = @cocde
end
---------------------------------------------------------------------------------------------------------------------




CREATE TABLE #MSR00033_RESULT(
	cocde		nvarchar(6),
	invno		nvarchar(20),
	invsts		nvarchar(3),
	pri_cust	nvarchar(50),
	sec_cust	nvarchar(50),
	issdat		datetime,
	curcde		nvarchar(6),
	netamt		numeric(13,4),
	ttlamt		numeric(13,4),
	usdnet		numeric(13,4),
	hkdnet		numeric(13,4),
	usdttl		numeric(13,4),
	hkdttl		numeric(13,4),
	vencde		nvarchar(20),
	ventyp		nvarchar(20),
	discnt		int
)

insert into #MSR00033_RESULT
Select 	
	sih_cocde,
	sih_invno,
	sih_invsts,
	sih_cus1no +' - ' + isnull(a.cbi_cussna,'') ,
	case when sih_cus2no = '' or  sih_cus2no is null then '' else  sih_cus2no + ' - ' +isnull(b.cbi_cussna,'') end ,
	sih_issdat,
	sih_curcde,
	sih_netamt,
	sih_ttlamt,
	Case sih_curcde when 'USD' then sih_netamt else 0 end,
	Case sih_curcde when 'HKD' then sih_netamt else 0 end,
	Case sih_curcde when 'USD' then sih_ttlamt else 0 end,
	Case sih_curcde when 'HKD' then sih_ttlamt else 0 end,
	'',
	'',
	sih_discnt
From SAINVHDR
--For Pri Customer
Left Join CUBASINF a on --a.cbi_cocde = sih_cocde and 
		a.cbi_cusno = sih_cus1no
--For Sec Customer
Left Join CUBASINF b on --b.cbi_cocde = sih_cocde and 
		b.cbi_cusno = sih_cus2no

Where 
-- 2004/02/11 Lester Wu
--	sih_cocde = @cocde and 
	--Lester Wu 2005-04-04, replace ALL with UC-G and exclude MS company data from UC-G
--(@cocde='ALL' or sih_cocde = @cocde) and
((@cocde='UC-G' and sih_cocde<>'MS')  or sih_cocde = @cocde) and
--------------------------------------------
	((sih_invno between @SIFm and @SITo and @OptSI = 'Y' ) or @OptSI = 'N') and 
	((sih_cus1no between @CuFm and @CuTo and @OptCu = 'Y' ) or @OptCu = 'N') and 
	((sih_issdat between @IssFm and @IssTo and @OptIss = 'Y' ) or @OptIss = 'N') and 
	((sih_invsts = @status and @OptSts = 'Y' ) or @OptSts = 'N')


--select * from #MSR00033_RESULT

if (@OptVenCde = 'N' and @OptVenTyp = 'N')
begin
	select 
		@Cocde 'INPUT_COCDE',
		@CUFm 'INPUT_CUFM',
		@CUTo 'INPUT_CUTO',
		@SIFm 'INPUT_SIFM',
		@SITo 'INPUT_SITO',
		@VenCdeFm 'INPUT_VENCDEFM',
		@VenCdeTo 'INPUT_VENCDETO',
		@VenSubCdeFm 'INPUT_VENSUBCDEFM',
		@VenSubCdeTo 'INPUT_VENSUBCDETO',
		@VenTypFm 'INPUT_VENTYPFM',
		@VenTypTo 'INPUT_VENTYPTO',	
		@IssFm 'INPUT_ISSFM',
		convert(nvarchar(10),@IssTo,101) 'INPUT_ISSTO',
		Case @Status 	when 'ALL' then 'ALL - All Status'
				when 'OPE' then 'OPE - OPEN'
				when 'REL' then 'REL - Released'
				else 'CLO - Close' end 'INPUT_STATUS',
		@Sort 'INPUT_SORT',
		invno as  'sih_invno',
		invsts as 'sih_invsts',
		pri_cust as 'Pri_Cust',
		sec_cust as 'Sec_Cust',
		convert(varchar(10), issdat, 101)  as 'sih_issdat',
		curcde as 'sih_curcde',
		netamt as 'sih_netamt',
		ttlamt as 'sih_ttlamt',
		usdnet as 'USD_Net',
		hkdnet as 'HKD_Net',
		usdttl as 'USD_TTL',
		hkdttl as 'HKD_TTL',
		vencde as 'VenCde',
		ventyp as 'VenTyp',
		@compName as 'compName'
	from #MSR00033_RESULT
end
else
begin
	select 	
		invno as  'sih_invno',
		invsts,
		pri_cust,
		sec_cust,
		issdat,
		curcde,
		case discnt when 0 then sid_ttlamt
		else sid_ttlamt * ((100.0 - discnt) / 100.0) end as 'netamt',
		sid_ttlamt,
		usdnet,
		hkdnet,
		usdttl,
		hkdttl,
--		sid_venno + ' - ' + vbi.vbi_vensna 'vencde',
		case @OptVenSubCde when 'Y' then sid_venno + ' - ' + vbi.vbi_vensna + ' (' + sid_subcde + ')' 
				else sid_venno + ' - ' + vbi.vbi_vensna end 'vencde',	
		case vbi_ventyp when 'J' then 'Joint-Venture'
			when 'I' then 'Internal'
			when 'E' then 'External'
			else '' end 'ventyp'
--		,sid_subcde
	INTO #MSR00033_RESULT2
	from #MSR00033_RESULT
	Left join SAINVDTL sid on sid.sid_cocde = cocde and sid.sid_invno = invno
	Left join VNBASINF vbi on vbi.vbi_venno = sid.sid_venno
	where 
		((sid.sid_venno between @VenCdeFm and @VenCdeTo and @OptVenCde = 'Y' ) or @OptVenCde = 'N') and 
		((sid.sid_subcde between @VenSubCdeFm and @VenSubCdeTo and @OptVenSubCde = 'Y' ) or @OptVenSubCde = 'N') and 
		((vbi.vbi_ventyp between @VenTypFm and @VenTypTo and @OptVenTyp = 'Y' ) or @OptVenTyp = 'N')

	select 	@Cocde 'INPUT_COCDE',
		@CUFm 'INPUT_CUFM',
		@CUTo 'INPUT_CUTO',
		@SIFm 'INPUT_SIFM',
		@SITo 'INPUT_SITO',
		@VenCdeFm 'INPUT_VENCDEFM',
		@VenCdeTo 'INPUT_VENCDETO',
		@VenSubCdeFm 'INPUT_VENSUBCDEFM',
		@VenSubCdeTo 'INPUT_VENSUBCDETO',
		@VenTypFm 'INPUT_VENTYPFM',
		@VenTypTo 'INPUT_VENTYPTO',	
		@IssFm 'INPUT_ISSFM',
		convert(nvarchar(10),@IssTo,101) 'INPUT_ISSTO',
		Case @Status 	when 'ALL' then 'ALL - All Status'
				when 'OPE' then 'OPE - OPEN'
				when 'REL' then 'REL - Released'
				else 'CLO - Close' end 'INPUT_STATUS',
		@Sort 'INPUT_SORT',
		sih_invno,
		invsts as 'sih_invsts',
		pri_cust as 'Pri_Cust',
		sec_cust as 'Sec_Cust',
		convert(varchar(10), issdat, 101)  as 'sih_issdat',
		curcde as 'sih_curcde',
		sum (netamt) 'sih_netamt',
		sum (sid_ttlamt) 'sih_ttlamt',
		case curcde when 'USD' then sum(netamt) else 0 end 'USD_Net',
		case curcde when 'HKD' then sum(netamt) else 0 end 'HKD_Net',
		case curcde when 'USD' then sum(sid_ttlamt) else 0 end 'USD_TTL',
		case curcde when 'HKD' then sum(sid_ttlamt) else 0 end 'HKD_TTL',
		vencde as 'VenCde',
		ventyp as 'VenTyp',     --		,sid_subcde
		@compName as 'compName'
	from #MSR00033_RESULT2
	group by 
		sih_invno,invsts,pri_cust,sec_cust,issdat,curcde,ventyp,vencde
--		,sid_subcde


end












GO
GRANT EXECUTE ON [dbo].[temp_sp_select_MSR00033] TO [ERPUSER] AS [dbo]
GO
