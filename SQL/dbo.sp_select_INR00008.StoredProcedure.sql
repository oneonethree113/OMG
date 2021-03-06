/****** Object:  StoredProcedure [dbo].[sp_select_INR00008]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_INR00008]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_INR00008]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



















-- Checked by Allan Yuen at 27/07/2003


/*
=========================================================
Program ID	: sp_select_INR00008
Description   	: Customer Order Enquiry Report
Programmer  	: Allan Yuen
ALTER  Date   	: 2002-02-13
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
 Date      Initial  	Description                          
=========================================================    
19/02/2003 Allan Yuen   User request to sume of all factory  
27/02/2004 Lester Wu	ADD ALL COMPANY SELECTION AND CUSTOMER ALIAS
		Use Ship Invoice date instead of Ship Start Date for data selection
16/03/2004 Lester Wu Amend missing logic in shipping part
		Add logic to fileter SC detail with zero order quantity
19/04/2004 Lester Wu	Eliminate Combine Customer Alias

16/02/2005	Lester Wu	Use factory 'S' instead of factory 'U' and re-arrange the position

30/03/2005	Lester Wu	replace ALL with UC-G, exclude MS from UC-G, retrieve company name from database

19/04/2005 Lester Wu	Add factory R - 富泰
*/
-- sp_select_INR00008 'UCP','','ZZZZZZ','','ZZZZZZ','','ZZZZZZZZZZZZZZZZZZZZ','01/01/2003 00:00:00.000','12/31/2003 23:59:59.000','','ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ','01/01/2004 00:00:00.000','01/31/2004 23:59:59.000','Y','Y'
--3216-000OD
-- sp_select_INR00008 'ALL','50001','50001','','ZZZZZZ','3216-000OD','3216-000OD','01/01/1980 00:00:00.000','12/31/2049 23:59:59.000','','ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ','01/01/1980 00:00:00.000','01/31/2049 23:59:59.000','N','Y'

CREATE    PROCEDURE [dbo].[sp_select_INR00008]
	@cocde		nvarchar(6),
	@cusno1_fm	nvarchar(6) = '',
	@cusno1_to	nvarchar(6) = 'ZZZZZZ',
	@cusno2_fm	nvarchar(6) = '',
	@cusno2_to	nvarchar(6) = 'ZZZZZZ',
	@cuspo_fm	nvarchar(20) = '',
	@cuspo_to		nvarchar(20) = 'ZZZZZZZZZZZZZZZZZZZZ',
	@cuspo_date_fm	datetime = '1980/01/01',
	@cuspo_date_to	datetime = '2049/12/31',
	@scfm		nvarchar(40) = '0000000000000000000000000000000000000000',
	@scto		nvarchar(40) = 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ',
	@ship_start_date_fm	datetime = '1980/01/01',
	@ship_start_date_to	datetime = '2049/12/31',
	@osonly		char(1) = 'N',
	@printsec		char(1) = 'Y'
As 


set nocount on

/*
drop table  #TmpReport
drop table  #TmpReport2

declare
	@cocde		nvarchar(6),
	@cusno1_fm	nvarchar(6),
	@cusno1_to	nvarchar(6),
	@cusno2_fm	nvarchar(6),
	@cusno2_to	nvarchar(6),
	@cuspo_fm	nvarchar(20),
	@cuspo_to		nvarchar(20),
	@cuspo_date_fm	datetime,
	@cuspo_date_to	datetime,
	@scfm		nvarchar(40),
	@scto		nvarchar(40),
	@ship_start_date_fm	datetime,
	@ship_start_date_to	datetime,
	@osonly		char(1),
	@printsec		char(1)
	

	set @cocde			= 'UCPP'
	set @cusno1_fm		= ''
	set @cusno1_to		= 'ZZZZZZ'
--	set @cusno1_fm		= '10004'
--	set @cusno1_to		= '10004'
	set @cusno2_fm		= ''
	set @cusno2_to		= 'ZZZZZZ'
	set @cuspo_fm		= ''
	set @cuspo_to		= 'ZZZZZZZZZZZZZZZZZZZZ'
	set @cuspo_date_fm		= '1980/01/01'
	set @cuspo_date_to		= '2049/12/31'
--	set @scfm			= '00000000000000000000'
--	set @scto			= 'ZZZZZZZZZZZZZZZZZZZZ'
	set @scfm			= 'US0201497'
	set @scto			= 'US0201497'
	set @ship_start_date_fm	= '1980/01/01'
	set @ship_start_date_to	= '2049/12/31'
	set @osonly		= 'N'
	set @printsec		= 'Y'
*/

create table #TmpReport (
	cocde		nvarchar(6),
	cusno1		nvarchar(6),
	cus1sna		nvarchar(20),
	cusno2		nvarchar(6),
	cus2sna		nvarchar(20),
	scno		nvarchar(20),
	cuspo		nvarchar(20),
	cuspo_date		datetime,
	ship_start_date_fm	datetime,
	ship_start_date_to	datetime,
	ttlctn		int  DEFAULT 0,
	ttlamt		numeric(13,4)DEFAULT 0,	
	Factory01 		int  DEFAULT 0,	--A	華泰			0005 or 0005 + subcode = 'WT'
	Factory02 		int DEFAULT 0,	--B	華泰聖誕			0005 + subcode = 'WTX'
	Factory03 		int DEFAULT 0,	--C	華裕			0005 + subcode = 'WY'
	Factory04 		int DEFAULT 0,	--D	華裕盆景			0005 + subcode = '0007'
	Factory05 		int DEFAULT 0,	--E	利興			0005 + subcode = 'HE' or subcode = 'HEC'
	Factory06 		int DEFAULT 0,	--F	福州			0005 + subcode = 'FC'
	Factory07 		int DEFAULT 0,	--G	聯輝			0005 + subcode = 'UGIL'
	Factory08 		int DEFAULT 0,	--H	北都 / 華佑		0006 or 0005 + 'HY'
	Factory09 		int DEFAULT 0,	--J	智軒			0005 + subcode = 'WM'
	Factory10 		int DEFAULT 0,	--K	華碧			0005 + subcode = 'WB'
	Factory11 		int DEFAULT 0,	--L	華泰(龍煒)		0005 + subcode = LW'
	Factory12 		int DEFAULT 0,	--M	嘉德			
	Factory13 		int DEFAULT 0,	--N	HARRIS
	Factory14 		int DEFAULT 0,	--P	UCPP
	Factory15 		int DEFAULT 0,	--T	華建 / 通藝		0005 + subcode = 'TY'
	--2005/02/17 Lester Wu use factory 'S' instead of 'U'
	--Factory16 		int DEFAULT 0,	--U	五金廠
	Factory16 		int DEFAULT 0,	--S	樂豐
	--
	Factory17 		int DEFAULT 0,	--Z	Inventory
	Factory18 		int DEFAULT 0,	--Q	香港華裕
	Factory19 		int DEFAULT 0,	--R	富泰		--Lester Wu 2005-04-19, add factory R - 富泰
	Factory20		int DEFAULT 0, --X	通泰		--Mark Lau 20091217, add factory X - 通泰
	)


-- Create Temp Txn Table --
create table #TmpReport2 (
	cocde		nvarchar(6),
	cusno1		nvarchar(6),
	cusno2		nvarchar(6),
	cuspo		nvarchar(20),
	scno		nvarchar(20),
	Act_ship_date	datetime,
	Total_shipped_amt	numeric(13,4)DEFAULT 0,	
	Total_shipped_ctn	int DEFAULT 0,
	Factory01b		int DEFAULT 0,	--A	華泰			0005 or 0005 + subcode = 'WT'
	Factory02b		int DEFAULT 0,	--B	華泰聖誕			0005 + subcode = 'WTX'
	Factory03b		int DEFAULT 0,	--C	華裕			0005 + subcode = 'WY'
	Factory04b		int DEFAULT 0,	--D	華裕盆景			0005 + subcode = '0007'
	Factory05b		int DEFAULT 0,	--E	利興			0005 + subcode = 'HE' or subcode = 'HEC'
	Factory06b		int DEFAULT 0,	--F	福州			0005 + subcode = 'FC'
	Factory07b		int DEFAULT 0,	--G	聯輝			0005 + subcode = 'UGIL'
	Factory08b		int DEFAULT 0,	--H	北都 / 華佑		0006 or 0005 + 'HY'
	Factory09b		int DEFAULT 0,	--J	智軒			0005 + subcode = 'WM'
	Factory10b		int DEFAULT 0,	--K	華碧			0005 + subcode = 'WB'
	Factory11b		int DEFAULT 0,	--L	華泰(龍煒)		0005 + subcode = LW'
	Factory12b		int DEFAULT 0,	--M	嘉德			
	Factory13b		int DEFAULT 0,	--N	HARRIS
	Factory14b		int DEFAULT 0,	--P	UCPP
	Factory15b		int DEFAULT 0,	--T	華建 / 通藝		0005 + subcode = 'TY'
	--2005/02/17 Lester Wu use factory 'S' instead of 'U'
	--Factory16b		int DEFAULT 0,	--U	五金廠
	Factory16b		int DEFAULT 0,	--樂豐
	--
	Factory17b		int DEFAULT 0,	--Z	Inventory
	Factory18b		int DEFAULT 0,	--Q	香港華裕
	Factory19b		int DEFAULT 0,	--R	--Lester Wu 2005-04-19, add factory R - 富泰
	Factory20b		int DEFAULT 0	--R	--Mark Lau 20091217, add factory X - 通泰
	)

Declare	
	@soh_cocde	nvarchar(6),	@soh_ordno	nvarchar(20),
	@soh_cus1no	nvarchar(6),	@soh_cus2no	nvarchar(6),	
	@soh_cuspo	nvarchar(20),	@soh_cpodat	datetime,
	@sod_venno	nvarchar(6),	@sod_subcde	nvarchar(10),
	@sod_cbm		numeric(11,4),	@sod_curcde	nvarchar(6),
	@sod_untprc	numeric(13,4),	@sod_selprc	numeric(13,4),	
	@sod_ordqty	int,		@sod_shpqty	int,
	@soh_shpstr	datetime,		@soh_shpend	datetime,
	@sod_itmno	nvarchar(20),	@sod_colcde	nvarchar(30),
	@sod_pckunt	nvarchar(6),	@sod_inrctn	int,
	@sod_mtrctn	int,		@sod_ttlctn	int,
	@hid_ttlctn		int,		@hid_untamt	nvarchar(6),
	@hid_ttlamt	numeric(13,4),	@hih_issdat	datetime,
	@cus1sna		nvarchar(20),	@cus2sna		nvarchar(20),
	@soh_curexrat	numeric(16,11), -- Frankie Cheung 20091007

	@FName01	nvarchar(20),	@FName02	nvarchar(20), 
	@FName03	nvarchar(20),	@FName04	nvarchar(20), 
	@FName05	nvarchar(20), 	@FName06	nvarchar(20), 
	@FName07	nvarchar(20), 	@FName08	nvarchar(20), 
	@FName09	nvarchar(20), 	@FName10	nvarchar(20), 
	@FName11	nvarchar(20), 	@FName12	nvarchar(20), 
	@FName13	nvarchar(20), 	@FName14	nvarchar(20), 
	@FName15	nvarchar(20), 	@FName16	nvarchar(20), 
	@FName17	nvarchar(20), 	@FName18	nvarchar(20),
	@HKD_buyrat	numeric(16,11),	@HKD_selrat	numeric(16,11),
	@TTLAMT2	numeric(13,4),	@TTLAMT3	numeric(13,4),	
	@Factory01a	int,		@Factory02a	int,
	@Factory03a	int,		@Factory04a	int,
	@Factory05a	int,		@Factory06a	int,
	@Factory07a	int,		@Factory08a	int,
	@Factory09a	int,		@Factory10a	int,
	@Factory11a	int,		@Factory12a	int,
	@Factory13a	int,		@Factory14a	int,
	@Factory15a	int,		@Factory16a	int,
	@Factory17a	int,		@Factory18a	int,

	@Factory01b	int,		@Factory02b	int,
	@Factory03b	int,		@Factory04b	int,
	@Factory05b	int,		@Factory06b	int,
	@Factory07b	int,		@Factory08b	int,
	@Factory09b	int,		@Factory10b	int,
	@Factory11b	int,		@Factory12b	int,
	@Factory13b	int,		@Factory14b	int,
	@Factory15b	int,		@Factory16b	int,
	@Factory17b	int,		@Factory18b	int,
	@updateflag1	char(1),		@updateflag2	char(1)
	,@optSecCust	char(1)
	,@optInvDat	char(1)
	--Lester Wu 2005-04-19 add factory R - 富泰
	,@Factory19a	int
	,@Factory19b	int
	,@FName19		nvarchar(20)
	--Mark Lau 20091217, add factory X - 通泰
	,@Factory20a	int
	,@Factory20b	int
	,@FName20		nvarchar(20)
	-- Lester WU 2004/02/27
	set @optInvDat = 'Y'
	if @ship_start_date_fm='01/01/1980 00:00:00.000' and @ship_start_date_to='12/31/2049 23:59:59.000' 
	begin
		set @optInvDat = 'N'
	end	
	-----------------------------
	--Lester Wu, 2005-03-30, set factory name for MS company 
	if @cocde = 'MS' 
	begin
		SET @FName01 = 'MAGICSILK (華碧)'
		SET @FName02 = '華碧'
	end
	else
	begin
		SET @FName01 = '華泰'	--	0005 or 0005 + subcode = 'WT'
		SET @FName02 = '華泰聖誕'	--	0005 + subcode = 'WTX'
	end
	SET @FName03 = '華裕'	--	0005 + subcode = 'WY'
	SET @FName04 = '華裕盆景'	--	0005 + subcode = '0007'
	SET @FName05 = '利興'	--	0005 + subcode = 'HE' or subcode = 'HEC'
	SET @FName06 = '福州'	--	0005 + subcode = 'FC'
	SET @FName07 = '聯輝'	--	0005 + subcode = 'UGIL'
	SET @FName08 = '北都 / 華佑'	--	0006 or 0005 + 'HY'
	SET @FName09 = '智軒'	--	0005 + subcode = 'WM'
	SET @FName10 = '華碧'	--	0005 + subcode = 'WB'
	SET @FName11 = '華泰(龍煒)'	--	0005 + subcode = LW'
	SET @FName12 = '嘉德'	--		
	SET @FName13 =  'HARRIS'	--
	SET @FName14 = 'UCPP'	--
	SET @FName15 = '華建 / 通藝'	--	0005 + subcode = 'TY'
	--2005/02/16 Lester Wu use factory 'S' instead of factory 'U'
	--SET @FName16 = '五金廠'	--
	SET @FName16 = '樂豐'	--
	-----------------------------------------------
	SET @FName17 = 'Inventory'	--
	SET @FName18 = '香港華裕'	--	0009
	SET @HKD_buyrat = 0
	SET @HKD_selrat = 0

	--Add factory R - 富泰, Lester Wu 2005-04-19
	SET @FName19 = '富泰'	

	--Mark Lau 20091217, add factory X - 通泰
	SET @FName20 = '通泰'	

--- Get Currency Excnange Rate ---
SELECT         
	@HKD_buyrat = YSI_BUYRAT,
	@HKD_selrat = YSI_SELRAT
FROM             
	SYSETINF (nolock)
WHERE      
--	ysi_cocde = @COCDE AND 
	ysi_typ = '06' AND
	ysi_cde = 'HKD'


--Lester WU 2004/02/27----------------------add combine customer alias----------------------------------
-- Lester Wu 2004/04/19 ---------------------eliminate combine customer alias--------------------------------
/*
select vw_cbi_cusno,vw_cbi_cusali
into #tmp_inr00008_cusali
from vw_cusali (nolock)
where vw_cbi_cusali in (
			select distinct vw_cbi_cusali from vw_cusali
			where vw_cbi_cusno between @cusno1_fm and @cusno1_to
			and vw_cbi_custyp='P'
			)

SET @optSecCust='Y'
if @cusno2_fm = ''
begin
	SET @optSecCust = 'N'
end

select vw_cbi_cusno,vw_cbi_cusali
into #tmp_inr00008_cusali_sec
from vw_cusali (nolock)
where vw_cbi_cusali in (
			select distinct vw_cbi_cusali from vw_cusali
			where vw_cbi_cusno between @cusno2_fm and @cusno2_to
			and vw_cbi_custyp='S'
			)
*/
-----------------------------------------------------------------------------------
-----------------------------------------
--IF @osonly = 'N'
--    BEGIN
-- Lester Wu 2004/02/27 Insert the data into a temp table b4 process
		select
			soh_cocde,		soh_ordno,		
			--Lester Wu 2004/04/19
			soh_cus1no, --pri.vw_cbi_cusali as 'soh_cus1no',	-- use customer alias instead of soh_cus1no
			isnull(soh_cus2no,'') as 'soh_cus2no', --isnull(sec.vw_cbi_cusali,'') as 'soh_cus2no',	-- use customer alias instead of soh_cus2no
			-----------------------------
			soh_cuspo,		soh_cpodat,	soh_shpstr,		soh_shpend,
			sod_venno,		sod_subcde,	sod_cbm,		sod_curcde,
			sod_untprc,	sod_selprc,		sod_ordqty,	sod_shpqty,
			sod_itmno,		sod_colcde,	sod_pckunt	,	sod_inrctn,
			sod_mtrctn, 	sod_ttlctn,		soh_curexrat
		into	#tmp_inr00008_SOH
		from
			scordhdr (nolock)
			--left join #tmp_inr00008_cusali_sec sec on soh_cus2no = sec.vw_cbi_cusno
			,scorddtl  (nolock)
			--Lester Wu 2004/02/27 , Rem on 2004/03/05
			--left join shipgdtl (nolock) on sod_cocde=hid_cocde and sod_ordno = hid_ordno and sod_ordseq = hid_ordseq
			--left join shinvhdr (nolock) on hiv_shpno = hid_shpno and hiv_invno = hid_invno			
			------------------------------------
			--,#tmp_inr00008_cusali pri
		where
			soh_cocde = sod_cocde and
			soh_ordno = sod_ordno and
			--soh_cocde = @cocde and
			--Lester Wu Eliminate Combine Customer Alias
			--soh_cus1no = pri.vw_cbi_cusno and
			--(@optSecCust='N' or (@optSecCust='Y' and isnull(sec.vw_cbi_cusno,'')<>'')) and
			------------------------------------------------------------------------------------------------------
			soh_cus1no between @cusno1_fm	 and @cusno1_to and
			soh_cus2no between @cusno2_fm	 and @cusno2_to and
			-------------------------------------------------------------------------------------------------------
			soh_ordno between @scfm and @scto and
			soh_cuspo between @cuspo_fm and @cuspo_to and
			convert(varchar(20),soh_cpodat,101) between @cuspo_date_fm and @cuspo_date_to and
			--Lester Wu 2004/02/27 , Roll back to orginal status
			convert(varchar(20),soh_shpstr,101) between @ship_start_date_fm and  @ship_start_date_to and
			--(@optInvDat = 'N' or (@optInvDat = 'Y' and convert(varchar(20),hiv_invdat,101) between @ship_start_date_fm and  @ship_start_date_to)) and
			-------------------------------------------------------------------------------------------------------------------------------------
			soh_ordsts <> 'CAN'  
			and sod_ttlctn > 0
			-- Lester Wu 2004/03/16

			--------------------------------
		order by
			soh_cocde,
			soh_cus1no,
			soh_cus2no,
			soh_ordno,
			soh_cuspo

	
	
	/*select * from #tmp_inr00008_cusali
	select * from #tmp_inr00008_cusali_sec
	select * from #tmp_inr00008_SOH
	*/
	--Filter data of required company	
	--Lester Wu 2005-03-30, replace ALL with UC-G, exclude MS company data from UC-G
	--if @cocde<>'ALL'
	if @cocde<>'UC-G'
	begin
		delete from #tmp_inr00008_SOH where soh_cocde <> @cocde
	end
	else
	begin
		delete from #tmp_inr00008_SOH where soh_cocde = 'MS'
	end
	
	-- Lester Wu 2005-03-30, retrieve company name from database --------
	declare @compName varchar(100)
	set @compName = 'UNITED CHINESE GROUP'
	if @cocde <> 'UC-G'
	begin
		select @compName = yco_conam from SYCOMINF where yco_cocde = @cocde
	end
	--------------------------------------------------------------------------------------

	--select * from #tmp_inr00008_SOH
------------------------------------------------------------------------------------------------------------
	DECLARE SC_Order_Cursor CURSOR FOR 	
		select * from #tmp_inr00008_SOH
--    END
--ELSE
--    BEGIN
--	DECLARE SC_Order_Cursor CURSOR FOR 	
--		select
--			soh_cocde,		soh_ordno,		soh_cus1no,	soh_cus2no,
--			soh_cuspo,		soh_cpodat,	soh_shpstr,		soh_shpend,
--			sod_venno,		sod_subcde,	sod_cbm,		sod_curcde,
--			sod_untprc,	sod_selprc,		sod_ordqty,	sod_shpqty,
--			sod_itmno,		sod_colcde,	sod_pckunt	,	sod_inrctn,
--			sod_mtrctn, 	sod_ttlctn
--		from
--			scordhdr (nolock),
--			scorddtl  (nolock)
--		where
--			soh_cocde = sod_cocde and
--			soh_ordno = sod_ordno and
--			soh_cocde = @cocde and
--			soh_cus1no between @cusno1_fm	 and @cusno1_to and
--			soh_cus2no between @cusno2_fm	 and @cusno2_to and
--			soh_ordno between @scfm and @scto and
--			soh_cuspo between @cuspo_fm and @cuspo_to and
--			convert(varchar(20),soh_cpodat,101) between @cuspo_date_fm and @cuspo_date_to and
--			convert(varchar(20),soh_shpstr,101) between 	@ship_start_date_fm and  @ship_start_date_to and
--			soh_ordsts <> 'CAN'  and
--			sod_ordqty <> sod_shpqty
--		order by
--			soh_cocde,
--			soh_cus1no,
--			soh_cus2no,
--			soh_ordno,
--			soh_cuspo
--    END

OPEN SC_Order_Cursor 

FETCH NEXT FROM SC_Order_Cursor  INTO 
	@soh_cocde,	@soh_ordno,	@soh_cus1no,	@soh_cus2no,
	@soh_cuspo,	@soh_cpodat,	@soh_shpstr,	@soh_shpend,
	@sod_venno,	@sod_subcde,	@sod_cbm,	@sod_curcde,
	@sod_untprc,	@sod_selprc,	@sod_ordqty,	@sod_shpqty,
	@sod_itmno,	@sod_colcde,	@sod_pckunt,	@sod_inrctn,
	@sod_mtrctn,	@sod_ttlctn,	@soh_curexrat -- Frankie Cheung 20091007

WHILE @@FETCH_STATUS = 0
	BEGIN
		-- Reset Variable --
		set @Factory01a = 0
		set @Factory02a = 0
		set @Factory03a = 0
		set @Factory04a = 0
		set @Factory05a = 0
		set @Factory06a = 0
		set @Factory07a = 0
		set @Factory08a = 0
		set @Factory09a = 0
		set @Factory10a = 0
		set @Factory11a = 0
		set @Factory12a = 0
		set @Factory13a = 0
		set @Factory14a = 0
		set @Factory15a = 0
		set @Factory16a = 0
		set @Factory17a = 0
		set @Factory18a = 0
		set @updateflag1 = 'Y'
		set @TTLAMT2  = 0 
		--add factory R - 富泰, Lester Wu 2005-04-19
		set @Factory19a = 0
		--Mark Lau 20091217, add factory X - 通泰
		set @Factory20a = 0
		--Frankie Cheung 20091007
/*
		-- Convert currency --
		if @sod_curcde = 'HKD'
	                       SET @TTLAMT2 = @sod_selprc * @HKD_selrat
		else
	                       SET @TTLAMT2 = @sod_selprc 
*/
                       SET @TTLAMT2 = case @soh_curexrat when 0 then 0 else isnull(@sod_selprc / @soh_curexrat,0) end
		---------------------------

		--------------------------
		-- Lester WU 2004/02/27
		-- use @soh_cocde instead of @cocde for company code comparison
		
		--Lester Wu 2005-03-30, Cater 0002 and K factory of MS company ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if (@sod_venno = '0002'  and @soh_cocde = 'MS')
			set @Factory01a = @Factory01a  + @sod_ttlctn  

	 	else if (@sod_venno = 'K'  and @soh_cocde = 'MS')
			set @Factory02a = @Factory02a  + @sod_ttlctn  
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		--Lester Wu 2005-04-01, cater PG and EW company
--		else if (@sod_venno = '0005' and @sod_subcde = 'WT' and @soh_cocde = 'UCP')  or (@sod_venno = '0005'  and rtrim(ltrim(@sod_subcde)) = '' and @soh_cocde = 'UCP')   or (@sod_venno = 'A' and @soh_cocde = 'UCPP') OR (@sod_venno = 'A' and @soh_cocde = 'UCP')
		else if (@sod_venno = '0005' and @sod_subcde = 'WT' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))  or (@sod_venno = '0005'  and rtrim(ltrim(@sod_subcde)) = '' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))   or (@sod_venno = 'A' and @soh_cocde = 'UCPP') OR (@sod_venno = 'A' and  (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
			set @Factory01a = @Factory01a  + @sod_ttlctn  

--	 	else if (@sod_venno = '0005' and @sod_subcde = 'WTX' and @soh_cocde = 'UCP') or (@sod_venno = 'B' and @soh_cocde = 'UCPP') OR (@sod_venno = 'B' and @soh_cocde = 'UCP')
	 	else if (@sod_venno = '0005' and @sod_subcde = 'WTX' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'B' and @soh_cocde = 'UCPP') OR (@sod_venno = 'B' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
			set @Factory02a = @Factory02a  + @sod_ttlctn  

--		else if (@sod_venno = '0005' and @sod_subcde = 'WY' and @soh_cocde = 'UCP') or (@sod_venno = 'C' and @soh_cocde = 'UCPP') or (@sod_venno = 'C' and @soh_cocde = 'UCP')
		else if (@sod_venno = '0005' and @sod_subcde = 'WY' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'C' and @soh_cocde = 'UCPP') or (@sod_venno = 'C' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
			set @Factory03a = @Factory03a  + @sod_ttlctn  

--		else if (@sod_venno = '0007'  and ltrim(rtrim(@sod_subcde)) = '' and @soh_cocde = 'UCP') or (@sod_venno = 'D' and @soh_cocde = 'UCPP') or (@sod_venno = 'D' and @soh_cocde = 'UCP')
		else if (@sod_venno = '0007'  and ltrim(rtrim(@sod_subcde)) = '' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'D' and @soh_cocde = 'UCPP') or (@sod_venno = 'D' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
			set @Factory04a = @Factory04a  + @sod_ttlctn  

--		else if (@sod_venno = '0005' and @sod_subcde = 'HE' and @soh_cocde = 'UCP') or (@sod_venno = '0005' and @sod_subcde = 'HEC' and @soh_cocde = 'UCP') or (@sod_venno = 'E' and @soh_cocde = 'UCPP') or (@sod_venno = 'E' and @soh_cocde = 'UCP')
		else if (@sod_venno = '0005' and @sod_subcde = 'HE' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = '0005' and @sod_subcde = 'HEC' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'E' and @soh_cocde = 'UCPP') or (@sod_venno = 'E' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
--			set @Factory05a = @Factory05a  + @sod_ttlctn  
			set @updateflag1 = 'N'

--		else if (@sod_venno = '0005' and @sod_subcde = 'FC' and @soh_cocde = 'UCP') or (@sod_venno = 'F' and @soh_cocde = 'UCPP') or (@sod_venno = 'F' and @soh_cocde = 'UCP')
		else if (@sod_venno = '0005' and @sod_subcde = 'FC' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'F' and @soh_cocde = 'UCPP') or (@sod_venno = 'F' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
			set @Factory06a = @Factory06a  + @sod_ttlctn  

--		else if (@sod_venno = '0005' and @sod_subcde  = 'UGIL' and @soh_cocde = 'UCP') or (@sod_venno = 'G' and @soh_cocde = 'UCPP') or (@sod_venno = 'G' and @soh_cocde = 'UCP')
		else if (@sod_venno = '0005' and @sod_subcde  = 'UGIL' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'G' and @soh_cocde = 'UCPP') or (@sod_venno = 'G' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
			set @Factory07a = @Factory07a  + @sod_ttlctn  

--		else if (@sod_venno = '0006'  and ltrim(rtrim(@sod_subcde)) = '' and @soh_cocde = 'UCP') or (@sod_venno = '0005' and @sod_subcde ='HY' and @soh_cocde = 'UCP') or (@sod_venno = 'H' and @soh_cocde = 'UCPP') or (@sod_venno = 'H' and @soh_cocde = 'UCP') 
		else if (@sod_venno = '0006'  and ltrim(rtrim(@sod_subcde)) = '' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = '0005' and @sod_subcde ='HY' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'H' and @soh_cocde = 'UCPP') or (@sod_venno = 'H' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) 
			set @Factory08a = @Factory08a  + @sod_ttlctn  

--		else if (@sod_venno = '0005' and @sod_subcde = 'WM' and @soh_cocde = 'UCP') or (@sod_venno = 'J' and @soh_cocde = 'UCPP') or (@sod_venno = 'J' and @soh_cocde = 'UCP')
		else if (@sod_venno = '0005' and @sod_subcde = 'WM' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'J' and @soh_cocde = 'UCPP') or (@sod_venno = 'J' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
			set @Factory09a = @Factory09a  + @sod_ttlctn  

--		else if (@sod_venno = '0005' and @sod_subcde = 'WB' and @soh_cocde = 'UCP') or (@sod_venno = 'K' and @soh_cocde = 'UCPP') or (@sod_venno = 'K' and @soh_cocde = 'UCP')
		else if (@sod_venno = '0005' and @sod_subcde = 'WB' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'K' and @soh_cocde = 'UCPP') or (@sod_venno = 'K' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
			set @Factory10a = @Factory10a  + @sod_ttlctn  

--		else if (@sod_venno = '0005' and @sod_subcde = 'LW' and @soh_cocde = 'UCP') or (@sod_venno = 'L' and @soh_cocde = 'UCPP') or (@sod_venno = 'L' and @soh_cocde = 'UCP')
		else if (@sod_venno = '0005' and @sod_subcde = 'LW' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'L' and @soh_cocde = 'UCPP') or (@sod_venno = 'L' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
			set @Factory11a = @Factory11a  + @sod_ttlctn  

--		else if (@sod_venno = 'M' and @soh_cocde = 'UCPP') OR (@sod_venno = 'M' and @soh_cocde = 'UCP') 
		else if (@sod_venno = 'M' and @soh_cocde = 'UCPP') OR (@sod_venno = 'M' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) 
--			set @Factory12a = @Factory12a  + @sod_ttlctn  
			set @updateflag1 = 'N'

--		else if (@sod_venno = 'N' and @soh_cocde = 'UCPP') OR (@sod_venno = 'N' and @soh_cocde = 'UCP')
		else if (@sod_venno = 'N' and @soh_cocde = 'UCPP') OR (@sod_venno = 'N' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
--			set @Factory13a = @Factory13a  + @sod_ttlctn  
			set @updateflag1 = 'N'

--		else if (@sod_venno = 'P' and @soh_cocde = 'UCPP') OR (@sod_venno = 'P' and @soh_cocde = 'UCP')
		else if (@sod_venno = 'P' and @soh_cocde = 'UCPP') OR (@sod_venno = 'P' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
--			set @Factory14a = @Factory14a  + @sod_ttlctn  
			set @updateflag1 = 'N'

--		else if (@sod_venno = '0005' and @sod_subcde = 'TY' and @soh_cocde = 'UCP')  OR (@sod_venno = 'T' and @soh_cocde = 'UCPP') OR (@sod_venno = 'T' and @soh_cocde = 'UCP')
		else if (@sod_venno = '0005' and @sod_subcde = 'TY' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))  OR (@sod_venno = 'T' and @soh_cocde = 'UCPP') OR (@sod_venno = 'T' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
			set @Factory15a = @Factory15a  + @sod_ttlctn  

		--2005/02/16 Lester Wu use factory 'S' instead of 'U'
		--else if (@sod_venno = 'U' and @soh_cocde = 'UCPP') OR (@sod_venno = 'U' and @soh_cocde = 'UCP')
		else if (@sod_venno = 'S' and @soh_cocde = 'UCPP') OR (@sod_venno = 'S' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
		--
			set @Factory16a = @Factory16a  + @sod_ttlctn  

--		else if (@sod_venno = 'Z' and @soh_cocde = 'UCPP') OR (@sod_venno = 'Z' and @soh_cocde = 'UCP')
		else if (@sod_venno = 'Z' and @soh_cocde = 'UCPP') OR (@sod_venno = 'Z' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
--			set @Factory17a = @Factory17a  + @sod_ttlctn  
			set @updateflag1 = 'N'

--		else if (@sod_venno = '0009'  and @soh_cocde = 'UCP') 
		else if (@sod_venno = '0009'  and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) 
			set @Factory18a = @Factory18a  + @sod_ttlctn  
		
		-- Lester Wu 2005-04-19, add factory R - 富泰 ---------------------------------------------------------------------------------------------------
		else if (@sod_venno = 'R'  and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW' or @soh_cocde ='UCPP')) 
			set @Factory19a = @Factory19a  + @sod_ttlctn  
		-------------------------------------------------------------------------------------------------------------------------------------------------------------

		--Mark Lau 20091217, add factory X - 通泰 ---------------------------------------------------------------------------------------------------
		else if (@sod_venno = 'X'  and (@soh_cocde = 'TT' or @soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW' or @soh_cocde ='UCPP')) 
			set @Factory20a = @Factory20a  + @sod_ttlctn  
		-------------------------------------------------------------------------------------------------------------------------------------------------------------
		else
			set @updateflag1 = 'N'			

--			set @Factory18a = @Factory18a  + @sod_ttlctn  

		--select @updateflag1,@soh_cuspo,@sod_venno

		if @updateflag1 = 'Y'
		    begin
			if exists (select * from #TmpReport where cocde  = @soh_cocde and cusno1 = @soh_cus1no and cusno2 = @soh_cus2no and cuspo = @soh_cuspo and scno = @soh_ordno) 
				begin
					update 
						#TmpReport  
					set 
						ttlctn = ttlctn +  @sod_ttlctn, 
						ttlamt = ttlamt + @TTLAMT2,
						Factory01 = Factory01+ @Factory01a,
						Factory02 = Factory02+ @Factory02a,
						Factory03 = Factory03+ @Factory03a,
						Factory04 = Factory04+ @Factory04a,
						Factory05 = Factory05+ @Factory05a,
						Factory06 = Factory06+ @Factory06a,
						Factory07 = Factory07+ @Factory07a,
						Factory08 = Factory08+ @Factory08a,
						Factory09 = Factory09+ @Factory09a,
						Factory10 = Factory10+ @Factory10a,
						Factory11 = Factory11+ @Factory11a,
						Factory12 = Factory12+ @Factory12a,
						Factory13 = Factory13+ @Factory13a,
						Factory14 = Factory14+ @Factory14a,
						Factory15 = Factory15+ @Factory15a,
						Factory16 = Factory16+ @Factory16a,
						Factory17 = Factory17+ @Factory17a,
						Factory18 = Factory18 + @Factory18a, 
						Factory19 = Factory19 + @Factory19a,
						--Mark Lau 20091217, add factory X - 通泰
						Factory20 = Factory20 + @Factory20a
					where 
						cocde  = @soh_cocde and cusno1 = @soh_cus1no and cusno2 = @soh_cus2no and cuspo = @soh_cuspo and scno = @soh_ordno
					end
			else
				begin
					set @cus1sna = ''
					set @cus2sna = ''
					if ltrim(rtrim(@soh_cus1no)) <>  '' 
					   select 
						@cus1sna = cbi_cussna 
					from 
						CUBASINF 
					where 
						--cbi_cocde = @cocde and 
						cbi_cusno = @soh_cus1no
			
					if ltrim(rtrim(@soh_cus2no)) <>  '' 
					   select 
						@cus2sna = cbi_cussna 
					from 

						CUBASINF 
					where 
						--cbi_cocde = @cocde and 
						cbi_cusno = @soh_cus2no

					insert into 
						#TmpReport  
						(cocde, cusno1, cusno2, scno, cuspo, cuspo_date, ship_start_date_fm, ship_start_date_to, ttlctn, ttlamt, cus1sna, cus2sna,
						Factory01, Factory02, Factory03, Factory04, Factory05, Factory06, Factory07, Factory08, Factory09, Factory10, Factory11, Factory12, Factory13, Factory14, Factory15, Factory16, Factory17, Factory18,Factory19,Factory20) 
					values
						(@soh_cocde, @soh_cus1no, @soh_cus2no, @soh_ordno, @soh_cuspo, @soh_cpodat, @soh_shpstr, @soh_shpend, @sod_ttlctn,  @TTLAMT2, @cus1sna, @cus2sna, 
						@Factory01a, @Factory02a, @Factory03a, @Factory04a, @Factory05a, @Factory06a, @Factory07a, @Factory08a,  @Factory09a, @Factory10a,  @Factory11a, @Factory12a,  @Factory13a,  @Factory14a,  @Factory15a,  @Factory16a,  @Factory17a, @Factory18a, @Factory19a,@Factory20a)
				end
		    end
			
			

		DECLARE SH_Order_Cursor CURSOR FOR 			
			select 
				-- 2004/03/05 Lester Wu
				-- Use Invoice Date Instead of Issue Date
				--hih_issdat,
				isnull(hiv_invdat,'01/01/1980') as 'hih_issdat',
				-- Lester Wu 2005-12-14, Cater Credit Debit Note 
				hid_ttlctn + case isnull(hnh_nottyp,'') when '' then 0 when 'C' then 0 - (isnull(hnd_adjqty,0)/isnull(hnd_mtrctn,1)) else isnull(hnd_adjqty,0)/isnull(hnd_mtrctn,1) end,	--hid_ttlctn,
				hid_untamt,
				(hid_shpqty + case isnull(hnh_nottyp,'') when '' then 0 when 'C' then 0 - (isnull(hnd_adjqty,0)) else (isnull(hnd_adjqty,0)) end)*hid_selprc as 'hid_ttlamt' 		--hid_ttlamt
			from
				SHIPGHDR (nolock),
				SHIPGDTL (nolock)
				left join SHINVHDR (nolock) on hiv_cocde=hid_cocde and hiv_shpno=hid_shpno and hiv_invno=hid_invno
				-- Lester Wu 2005-12-14 Cater Credit Debit Note
				left join SHCBNHDR (nolock) on hiv_cocde = hnh_cocde and hiv_invno = hnh_refno
				left join SHCBNDTL (nolock) on hnh_cocde = hnd_cocde and hnh_noteno = hnd_noteno and hnd_itmno = hid_itmno 
							and left(hid_colcde,10) = left(hnd_colcde,10) and hid_untcde = hnd_pckunt 
							and hid_inrctn = hnd_inrctn and hid_mtrctn = hnd_mtrctn and hid_vol = hnd_cft
			where
				hid_cocde = hih_cocde and
				hid_shpno = hih_shpno and
				hid_cocde = @soh_cocde and 
				hid_ordno = @soh_ordno and
				hid_itmno = @sod_itmno  and
				-- Lester Wu 2004/03/12
				--hid_colcde = left(@sod_colcde,10) and
				left(hid_colcde,10) = left(@sod_colcde,10) and 
				------------------------------------------------
				hid_untcde = @sod_pckunt and
				hid_inrctn = @sod_inrctn and
				hid_mtrctn = @sod_mtrctn and
				hid_vol = @sod_cbm

			OPEN SH_Order_Cursor 

			FETCH NEXT FROM SH_Order_Cursor  INTO 
				@hih_issdat, @hid_ttlctn, @hid_untamt, @hid_ttlamt

			WHILE @@FETCH_STATUS = 0
				BEGIN
					-- Reset Variable --
					set @Factory01b= 0
					set @Factory02b= 0
					set @Factory03b = 0
					set @Factory04b = 0
					set @Factory05b = 0
					set @Factory06b = 0
					set @Factory07b = 0
					set @Factory08b = 0
					set @Factory09b = 0
					set @Factory10b = 0
					set @Factory11b = 0
					set @Factory12b = 0
					set @Factory13b = 0
					set @Factory14b = 0
					set @Factory15b = 0
					set @Factory16b = 0
					set @Factory17b = 0
					set @Factory18b = 0
					set @Factory19b = 0		-- Lester Wu 2005-04-19, add factory R - 富泰
					set @Factory20b = 0		--Mark Lau 20091217, add factory X - 通泰
					set @updateflag2 = 'Y'
		
					-- Frankie Cheung 20091007
/*
					-- Convert currency --
					if @HID_UNTAMT = 'HKD'
				                       SET @TTLAMT3 = @HID_TTLAMT * @HKD_selrat
					else
				                       SET @TTLAMT3 = @HID_TTLAMT 
*/
					-- Assume currency of hid_untamt always equal to currency of soh_curcde	
			                       SET @TTLAMT3 = case @soh_curexrat when 0 then 0 else isnull(@HID_TTLAMT / @soh_curexrat,0) end
					----------------------------

					--------------------------
					-- Lester Wu 2004/03/16
					--if (@sod_venno = '0005' and @sod_subcde = 'WT' and @soh_cocde = 'UCP')  or (@sod_venno = '0005'  and rtrim(ltrim(@sod_subcde)) = '' and @soh_cocde = 'UCP')   or (@sod_venno = 'A' and @soh_cocde = 'UCPP')
					
					-- Lester Wu 2005-03-30, cater 0002 and K factory of MS Company -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					if (@sod_venno = '0002' and @soh_cocde = 'MS')
						set @Factory01b = @Factory01b  + @hid_ttlctn
			
				 	else if (@sod_venno = 'K' and @soh_cocde = 'MS')
						set @Factory02b = @Factory02b  + @hid_ttlctn
			
					-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--					else if (@sod_venno = '0005' and @sod_subcde = 'WT' and @soh_cocde = 'UCP')  or (@sod_venno = '0005'  and rtrim(ltrim(@sod_subcde)) = '' and @soh_cocde = 'UCP')   or (@sod_venno = 'A' and @soh_cocde = 'UCPP') OR (@sod_venno = 'A' and @soh_cocde = 'UCP')
					else if (@sod_venno = '0005' and @sod_subcde = 'WT' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))  or (@sod_venno = '0005'  and rtrim(ltrim(@sod_subcde)) = '' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))   or (@sod_venno = 'A' and @soh_cocde = 'UCPP') OR (@sod_venno = 'A' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
						set @Factory01b = @Factory01b  + @hid_ttlctn
			
--				 	else if (@sod_venno = '0005' and @sod_subcde = 'WTX' and @soh_cocde = 'UCP') or (@sod_venno = 'B' and @soh_cocde = 'UCPP') or (@sod_venno = 'B' and @soh_cocde = 'UCP')
				 	else if (@sod_venno = '0005' and @sod_subcde = 'WTX' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'B' and @soh_cocde = 'UCPP') or (@sod_venno = 'B' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))	
						set @Factory02b = @Factory02b  + @hid_ttlctn
			
--					else if (@sod_venno = '0005' and @sod_subcde = 'WY' and @soh_cocde = 'UCP') or (@sod_venno = 'C' and @soh_cocde = 'UCPP') or (@sod_venno = 'C' and @soh_cocde = 'UCP')
					else if (@sod_venno = '0005' and @sod_subcde = 'WY' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'C' and @soh_cocde = 'UCPP') or (@sod_venno = 'C' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
						set @Factory03b = @Factory03b  + @hid_ttlctn
			
--					else if (@sod_venno = '0007'  and ltrim(rtrim(@sod_subcde)) = '' and @soh_cocde = 'UCP') or (@sod_venno = 'D' and @soh_cocde = 'UCPP') or (@sod_venno = 'D' and @soh_cocde = 'UCP')
					else if (@sod_venno = '0007'  and ltrim(rtrim(@sod_subcde)) = '' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'D' and @soh_cocde = 'UCPP') or (@sod_venno = 'D' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
						set @Factory04b = @Factory04b  + @hid_ttlctn
			
--					else if (@sod_venno = '0005' and @sod_subcde = 'HE' and @soh_cocde = 'UCP') or (@sod_venno = '0005' and @sod_subcde = 'HEC' and @soh_cocde = 'UCP') or (@sod_venno = 'E' and @soh_cocde = 'UCPP') or (@sod_venno = 'E' and @soh_cocde = 'UCP')
					else if (@sod_venno = '0005' and @sod_subcde = 'HE' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = '0005' and @sod_subcde = 'HEC' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'E' and @soh_cocde = 'UCPP') or (@sod_venno = 'E' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
--						set @Factory05b = @Factory05b  + @hid_ttlctn
						set @updateflag2 = 'N'
			
--					else if (@sod_venno = '0005' and @sod_subcde = 'FC' and @soh_cocde = 'UCP') or (@sod_venno = 'F' and @soh_cocde = 'UCPP') or (@sod_venno = 'F' and @soh_cocde = 'UCP')
					else if (@sod_venno = '0005' and @sod_subcde = 'FC' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'F' and @soh_cocde = 'UCPP') or (@sod_venno = 'F' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
						set @Factory06b = @Factory06b  + @hid_ttlctn
			
--					else if (@sod_venno = '0005' and @sod_subcde  = 'UGIL' and @soh_cocde = 'UCP') or (@sod_venno = 'G' and @soh_cocde = 'UCPP') or (@sod_venno = 'G' and @soh_cocde = 'UCP')
					else if (@sod_venno = '0005' and @sod_subcde  = 'UGIL' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'G' and @soh_cocde = 'UCPP') or (@sod_venno = 'G' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
						set @Factory07b = @Factory07b  + @hid_ttlctn
			
--					else if (@sod_venno = '0006'  and ltrim(rtrim(@sod_subcde)) = '' and @soh_cocde = 'UCP') or (@sod_venno = '0005' and @sod_subcde ='HY' and @soh_cocde = 'UCP') or (@sod_venno = 'H' and @soh_cocde = 'UCPP') or (@sod_venno = 'H' and @soh_cocde = 'UCP')
					else if (@sod_venno = '0006'  and ltrim(rtrim(@sod_subcde)) = '' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = '0005' and @sod_subcde ='HY' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'H' and @soh_cocde = 'UCPP') or (@sod_venno = 'H' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
						set @Factory08b = @Factory08b  + @hid_ttlctn
			
--					else if (@sod_venno = '0005' and @sod_subcde = 'WM' and @soh_cocde = 'UCP') or (@sod_venno = 'J' and @soh_cocde = 'UCPP') or (@sod_venno = 'J' and @soh_cocde = 'UCP')
					else if (@sod_venno = '0005' and @sod_subcde = 'WM' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'J' and @soh_cocde = 'UCPP') or (@sod_venno = 'J' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
						set @Factory09b = @Factory09b  + @hid_ttlctn
			
--					else if (@sod_venno = '0005' and @sod_subcde = 'WB' and @soh_cocde = 'UCP') or (@sod_venno = 'K' and @soh_cocde = 'UCPP') or (@sod_venno = 'K' and @soh_cocde = 'UCP')
					else if (@sod_venno = '0005' and @sod_subcde = 'WB' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'K' and @soh_cocde = 'UCPP') or (@sod_venno = 'K' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
						set @Factory10b = @Factory10b  + @hid_ttlctn
			
--					else if (@sod_venno = '0005' and @sod_subcde = 'LW' and @soh_cocde = 'UCP') or (@sod_venno = 'L' and @soh_cocde = 'UCPP') or (@sod_venno = 'L' and @soh_cocde = 'UCP')
					else if (@sod_venno = '0005' and @sod_subcde = 'LW' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW')) or (@sod_venno = 'L' and @soh_cocde = 'UCPP') or (@sod_venno = 'L' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))

						set @Factory11b = @Factory11b  + @hid_ttlctn
			
--					else if (@sod_venno = 'M' and @soh_cocde = 'UCPP') OR (@sod_venno = 'M' and @soh_cocde = 'UCP')
					else if (@sod_venno = 'M' and @soh_cocde = 'UCPP') OR (@sod_venno = 'M' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))
--						set @Factory12b = @Factory12b  + @hid_ttlctn
						set @updateflag2 = 'N'
			
--					else if (@sod_venno = 'N' and @soh_cocde = 'UCPP') OR (@sod_venno = 'N' and @soh_cocde = 'UCP')
					else if (@sod_venno = 'N' and @soh_cocde = 'UCPP') OR (@sod_venno = 'N' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))--						set @Factory13b = @Factory13b  + @hid_ttlctn
						set @updateflag2 = 'N'
			
--					else if (@sod_venno = 'P' and @soh_cocde = 'UCPP') OR (@sod_venno = 'P' and @soh_cocde = 'UCP')
					else if (@sod_venno = 'P' and @soh_cocde = 'UCPP') OR (@sod_venno = 'P' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))--						set @Factory14b = @Factory14b  + @hid_ttlctn
						set @updateflag2 = 'N'			

--					else if (@sod_venno = '0005' and @sod_subcde = 'TY' and @soh_cocde = 'UCP')  OR (@sod_venno = 'T' and @soh_cocde = 'UCPP') OR (@sod_venno = 'T' and @soh_cocde = 'UCP')
					else if (@sod_venno = '0005' and @sod_subcde = 'TY' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))  OR (@sod_venno = 'T' and @soh_cocde = 'UCPP') OR (@sod_venno = 'T' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))						
						set @Factory15b = @Factory15b  + @hid_ttlctn
					--2005/02/16 Lester Wu use factory 'S' instead of 'U'
					--else if (@sod_venno = 'U' and @soh_cocde = 'UCPP') OR (@sod_venno = 'U' and @soh_cocde = 'UCP')
--					else if (@sod_venno = 'S' and @soh_cocde = 'UCPP') OR (@sod_venno = 'S' and @soh_cocde = 'UCP')
					else if (@sod_venno = 'S' and @soh_cocde = 'UCPP') OR (@sod_venno = 'S' and @soh_cocde = 'UCP')					--
						set @Factory16b = @Factory16b  + @hid_ttlctn
			
--					else if (@sod_venno = 'Z' and @soh_cocde = 'UCPP') OR (@sod_venno = 'Z' and @soh_cocde = 'UCP')
					else if (@sod_venno = 'Z' and @soh_cocde = 'UCPP') OR (@sod_venno = 'Z' and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))--						set @Factory17b = @Factory17b  + @hid_ttlctn
						set @updateflag2 = 'N'
			
--					else if (@sod_venno = '0009'  and @soh_cocde = 'UCP')
					else if (@sod_venno = '0009'  and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW'))						
						set @Factory18b = @Factory18b  + @hid_ttlctn
					else if (@sod_venno = 'R'  and (@soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW' or @soh_cocde ='UCPP'))
						set @Factory19b = @Factory19b  + @hid_ttlctn
					--Mark Lau 20091217, add factory X - 通泰
					else if (@sod_venno = 'X'  and (@soh_cocde = 'TT' or @soh_cocde = 'UCP' or @soh_cocde ='PG' or @soh_cocde ='EW' or @soh_cocde ='UCPP'))
						set @Factory20b = @Factory20b  + @hid_ttlctn					

					else
						set @updateflag2 = 'N'			

					if  @updateflag2 = 'Y'
					     begin
						if exists (select * from #TmpReport2 where cocde  = @soh_cocde and cusno1 = @soh_cus1no and cusno2 = @soh_cus2no and cuspo = @soh_cuspo and Act_ship_date = @hih_issdat  and scno = @soh_ordno)
							begin
								update 
									#TmpReport2 
								set 
									Total_shipped_amt =  Total_shipped_amt  + @TTLAMT3, 
									Total_shipped_ctn = Total_shipped_ctn + @hid_ttlctn,
									Factory01b = Factory01b + @Factory01b,
									Factory02b = Factory02b + @Factory02b,
									Factory03b = Factory03b + @Factory03b,
									Factory04b = Factory04b + @Factory04b,
									Factory05b = Factory05b + @Factory05b,
									Factory06b = Factory06b + @Factory06b,
									Factory07b = Factory07b + @Factory07b,
									Factory08b = Factory08b + @Factory08b,
									Factory09b = Factory09b + @Factory09b,
									Factory10b = Factory10b + @Factory10b,
									Factory11b = Factory11b + @Factory11b,
									Factory12b = Factory12b + @Factory12b,
									Factory13b = Factory13b + @Factory13b,
									Factory14b = Factory14b + @Factory14b,
									Factory15b = Factory15b + @Factory15b,
									Factory16b = Factory16b + @Factory16b,
									Factory17b = Factory17b + @Factory17b,
									Factory18b = Factory18b + @Factory18b,
									Factory19b = Factory19b + @Factory19b,	--Lester Wu 2005-04-19, add factory R - 富泰
									Factory20b = Factory20b + @Factory20b	--Mark Lau 20091217, add factory X - 通泰
								where 
									cocde  = @soh_cocde and cusno1 = @soh_cus1no and cusno2 = @soh_cus2no and cuspo = @soh_cuspo and Act_ship_date = @hih_issdat and scno = @soh_ordno
							end
						else
							begin
								insert into 
									#TmpReport2  
									(cocde, cusno1, cusno2, scno, cuspo, Act_ship_date, Total_shipped_amt, Total_shipped_ctn, 
									Factory01b, Factory02b, Factory03b, Factory04b, Factory05b, Factory06b, Factory07b, Factory08b, Factory09b, Factory10b, Factory11b, Factory12b, Factory13b, Factory14b, Factory15b, Factory16b, Factory17b, Factory18b, Factory19b,Factory20b)
								values
									(@soh_cocde, @soh_cus1no, @soh_cus2no, @soh_ordno, @soh_cuspo, @hih_issdat, @TTLAMT3, @hid_ttlctn,
									@Factory01b, @Factory02b, @Factory03b, @Factory04b, @Factory05b, @Factory06b, @Factory07b, @Factory08b,  @Factory09b, @Factory10b,  @Factory11b, @Factory12b,  @Factory13b,  @Factory14b,  @Factory15b,  @Factory16b,  @Factory17b, @Factory18b, @Factory19b,@Factory20b)
							end
					    end
					FETCH NEXT FROM SH_Order_Cursor  INTO 
						@hih_issdat, @hid_ttlctn, @hid_untamt, @hid_ttlamt
				END
				CLOSE SH_Order_Cursor 
				DEALLOCATE SH_Order_Cursor 


		FETCH NEXT FROM SC_Order_Cursor  INTO 
			@soh_cocde,	@soh_ordno,	@soh_cus1no,	@soh_cus2no,
			@soh_cuspo,	@soh_cpodat,	@soh_shpstr,	@soh_shpend,
			@sod_venno,	@sod_subcde,	@sod_cbm,	@sod_curcde,
			@sod_untprc,	@sod_selprc,	@sod_ordqty,	@sod_shpqty,
			@sod_itmno,	@sod_colcde,	@sod_pckunt,	@sod_inrctn,
			@sod_mtrctn, 	@sod_ttlctn,	@soh_curexrat -- Frankie Cheung 20091007

	END
CLOSE SC_Order_Cursor 
DEALLOCATE SC_Order_Cursor 
/*
select * from #TmpReport
select * from #TmpReport2
*/



IF @osonly = 'N'
    begin
	if @cocde = 'MS' 
	begin
		SELECT 
			@cocde as 'Co_Code',
			@cusno1_fm as 'Primary_Cus_Fm',
			@cusno1_to as 'Primary_Cus_To',
			@cusno2_fm as 'Second_Cus_Fm', 
			@cusno2_to as 'Second_Cus_To',
			@cuspo_fm as 'PO_Fm',
			@cuspo_to	as 'PO_To',
			@cuspo_date_fm as 'PO_Date_Fm',
			@cuspo_date_to as 'PO_Date_To',
			@scfm as 'SC_Fm',
			@scto as 'SC_To',
			@ship_start_date_fm as 'Ship_Stdate_Fm',
			@ship_start_date_to as 'Ship_Stdate_To',
			@osonly as 'OS_Only',
			@printsec as 'Print_Sec',
			#TmpReport.cusno1 as 'Cus1_No',		
			#TmpReport.cus1sna as 'Cus1_Name',		
			#TmpReport.cusno2 as 'Cus2_No',		
			#TmpReport.cus2sna as 'Cus2_Name',		
			#TmpReport.scno as 'SCNO',		
			#TmpReport.cuspo as 'Cus_PO',		
			#TmpReport.cuspo_date 'Cus_Date',	
			#TmpReport.ship_start_date_fm as 'Cfm_Ship_Date_Fm',	
			#TmpReport.ship_start_date_to 'Cfm_Ship_Date_Tm',		
			#TmpReport.ttlctn as 'Total_CTN',		
			#TmpReport.ttlamt as 'Total_Amt',	
			@FName01 as 'Factory_Name01',
			@FName02 as 'Factory_Name02',
			#TmpReport.Factory01, 	
			#TmpReport.Factory02, 	
			isnull(#TmpReport2.Act_ship_date,'01/01/1980') as 'Act_Ship_Date',
			isnull(#TmpReport2.Total_shipped_amt,0) as 'Total_Shipped_Amt',
			isnull(#TmpReport2.Total_shipped_ctn,0) as 'Total_Shipped_CTN',
			isnull(#TmpReport2.Factory01b,0) as 'Factory01_Shipped_CTN',
			isnull(#TmpReport2.Factory02b,0) as 'Factory02_Shipped_CTN',
			@compName as 'compName'
		from
			#TmpReport
			left join	#TmpReport2 on
				#TmpReport.cocde =  #TmpReport2.cocde and
				#TmpReport.cusno1= #TmpReport2.cusno1 and	
				#TmpReport.cusno2 = #TmpReport2.cusno2 and
				#TmpReport.cuspo = #TmpReport2.cuspo and
				#TmpReport.scno = #TmpReport2.scno
		order by
			#TmpReport.cusno1,
			#TmpReport.cusno2,
			#TmpReport.cuspo,
			#TmpReport2.Act_ship_date

	end 
	else
	begin	

		SELECT 
			@cocde as 'Co_Code',
			@cusno1_fm as 'Primary_Cus_Fm',
			@cusno1_to as 'Primary_Cus_To',
			@cusno2_fm as 'Second_Cus_Fm', 
			@cusno2_to as 'Second_Cus_To',
			@cuspo_fm as 'PO_Fm',
			@cuspo_to	as 'PO_To',
			@cuspo_date_fm as 'PO_Date_Fm',
			@cuspo_date_to as 'PO_Date_To',
			@scfm as 'SC_Fm',
			@scto as 'SC_To',
			@ship_start_date_fm as 'Ship_Stdate_Fm',
			@ship_start_date_to as 'Ship_Stdate_To',
			@osonly as 'OS_Only',
			@printsec as 'Print_Sec',
			#TmpReport.cusno1 as 'Cus1_No',		
			#TmpReport.cus1sna as 'Cus1_Name',		
			#TmpReport.cusno2 as 'Cus2_No',		
			#TmpReport.cus2sna as 'Cus2_Name',		
			#TmpReport.scno as 'SCNO',		
			#TmpReport.cuspo as 'Cus_PO',		
			#TmpReport.cuspo_date 'Cus_Date',	
			#TmpReport.ship_start_date_fm as 'Cfm_Ship_Date_Fm',	
			#TmpReport.ship_start_date_to 'Cfm_Ship_Date_Tm',		
			#TmpReport.ttlctn as 'Total_CTN',		
			#TmpReport.ttlamt as 'Total_Amt',	
			@FName01 as 'Factory_Name01',
			@FName02 as 'Factory_Name02',
			@FName03 as 'Factory_Name03',
			@FName04 as 'Factory_Name04',
			@FName05 as 'Factory_Name05', 
			@FName06 as 'Factory_Name06',
			@FName07 as 'Factory_Name07',
			@FName08 as 'Factory_Name08',
			@FName09 as 'Factory_Name09',
			--2005/02/16 Lester Wu re-arrange the position
	/*		@FName10 as 'Factory_Name10',
			@FName11 as 'Factory_Name11',
			@FName12 as 'Factory_Name12', 
			@FName13 as 'Factory_Name13', 
			@FName14 as 'Factory_Name14',
			@FName15 as 'Factory_Name15',
	*/
			@FName11 as 'Factory_Name10',
			@FName15 as 'Factory_Name11',
			@FName12 as 'Factory_Name12', 
			@FName13 as 'Factory_Name13', 
			@FName14 as 'Factory_Name14',
			@FName10 as 'Factory_Name15',
			
			-------------------------------------------
			@FName16 as 'Factory_Name16',
			@FName17 as 'Factory_Name17',
			@FName18 as 'Factory_Name18',
			@FName19 as 'Factory_Name19',		--Lester Wu 2005-04-19, add factory R - 富泰
			@FName20 as 'Factory_Name20',		--Mark Lau 20091217, add factory X - 通泰			
			#TmpReport.Factory01, 	
			#TmpReport.Factory02, 	
			#TmpReport.Factory03, 	
			#TmpReport.Factory04, 	
			#TmpReport.Factory05, 	
			#TmpReport.Factory06, 	
			#TmpReport.Factory07, 	
			#TmpReport.Factory08, 	
			#TmpReport.Factory09,
			--2005/02/16 Lester Wu re-arrange the position 	
	/*		#TmpReport.Factory10, 	
			#TmpReport.Factory11, 	
			#TmpReport.Factory12, 	
			#TmpReport.Factory13, 	
			#TmpReport.Factory14, 	
			#TmpReport.Factory15, 	
	*/
			#TmpReport.Factory11, 	
			#TmpReport.Factory15, 	
			#TmpReport.Factory12, 	
			#TmpReport.Factory13, 	
			#TmpReport.Factory14, 	
			#TmpReport.Factory10, 	
			-----------------------------
			#TmpReport.Factory16, 	
			#TmpReport.Factory17, 	
			#TmpReport.Factory18,
			#TmpReport.Factory19,		--Lester Wu 2005-04-19, add factory R - 富泰
			#TmpReport.Factory20,		--Mark Lau 20091217, add factory X - 通泰
			isnull(#TmpReport2.Act_ship_date,'01/01/1980') as 'Act_Ship_Date',
			isnull(#TmpReport2.Total_shipped_amt,0) as 'Total_Shipped_Amt',
			isnull(#TmpReport2.Total_shipped_ctn,0) as 'Total_Shipped_CTN',
			isnull(#TmpReport2.Factory01b,0) as 'Factory01_Shipped_CTN',
			isnull(#TmpReport2.Factory02b,0) as 'Factory02_Shipped_CTN',
			isnull(#TmpReport2.Factory03b,0) as 'Factory03_Shipped_CTN',
			isnull(#TmpReport2.Factory04b,0) as 'Factory04_Shipped_CTN',
			isnull(#TmpReport2.Factory05b,0) as 'Factory05_Shipped_CTN',
			isnull(#TmpReport2.Factory06b,0) as 'Factory06_Shipped_CTN',
			isnull(#TmpReport2.Factory07b,0) as 'Factory07_Shipped_CTN',
			isnull(#TmpReport2.Factory08b,0) as 'Factory08_Shipped_CTN',
			isnull(#TmpReport2.Factory09b,0) as 'Factory09_Shipped_CTN',
			--2005/02/16 Lester Wu re-arrange the position
	/*		isnull(#TmpReport2.Factory10b,0) as 'Factory10_Shipped_CTN',
			isnull(#TmpReport2.Factory11b,0) as 'Factory11_Shipped_CTN',
			isnull(#TmpReport2.Factory12b,0) as 'Factory12_Shipped_CTN',
			isnull(#TmpReport2.Factory13b,0) as 'Factory13_Shipped_CTN',
			isnull(#TmpReport2.Factory14b,0) as 'Factory14_Shipped_CTN',
			isnull(#TmpReport2.Factory15b,0) as 'Factory15_Shipped_CTN',
	*/
			isnull(#TmpReport2.Factory11b,0) as 'Factory10_Shipped_CTN',
			isnull(#TmpReport2.Factory15b,0) as 'Factory11_Shipped_CTN',
			isnull(#TmpReport2.Factory12b,0) as 'Factory12_Shipped_CTN',
			isnull(#TmpReport2.Factory13b,0) as 'Factory13_Shipped_CTN',
			isnull(#TmpReport2.Factory14b,0) as 'Factory14_Shipped_CTN',
			isnull(#TmpReport2.Factory10b,0) as 'Factory15_Shipped_CTN',
			---------------------------------------------------------
			isnull(#TmpReport2.Factory16b,0) as 'Factory16_Shipped_CTN',
			isnull(#TmpReport2.Factory17b,0) as 'Factory17_Shipped_CTN',
			isnull(#TmpReport2.Factory18b,0) as 'Factory18_Shipped_CTN',
			isnull(#TmpReport2.Factory19b,0) as 'Factory19_Shipped_CTN',		--Lester Wu 2005-04-19, add factory R - 富泰
			isnull(#TmpReport2.Factory20b,0) as 'Factory20_Shipped_CTN',		--Mark Lau 20091217, add factory X - 通泰
			@compName as 'compName'
		from
			#TmpReport
			left join	#TmpReport2 on
				#TmpReport.cocde =  #TmpReport2.cocde and
				#TmpReport.cusno1= #TmpReport2.cusno1 and	
				#TmpReport.cusno2 = #TmpReport2.cusno2 and
				#TmpReport.cuspo = #TmpReport2.cuspo and
				#TmpReport.scno = #TmpReport2.scno
		order by
			#TmpReport.cusno1,
			#TmpReport.cusno2,
			#TmpReport.cuspo,
			#TmpReport2.Act_ship_date
	end 
    end
else
    begin
	-- Collect Group Total --
	SELECT 
		#TmpReport.cocde,
		#TmpReport.cusno1,
		#TmpReport.cusno2,
		#TmpReport.scno,
		#TmpReport.cuspo, 
		#TmpReport.ttlctn as 'Total_CTN',
		sum(isnull(#TmpReport2.Total_shipped_ctn,0)) as 'Total_Shipped_CTN'
	into
		#TmpReport3
	from
		#TmpReport
		left join	#TmpReport2 on
			#TmpReport.cocde =  #TmpReport2.cocde and
			#TmpReport.cusno1= #TmpReport2.cusno1 and	
			#TmpReport.cusno2 = #TmpReport2.cusno2 and
			#TmpReport.cuspo = #TmpReport2.cuspo and
			#TmpReport.scno = #TmpReport2.scno
	group by
		#TmpReport.cocde,
		#TmpReport.cusno1,
		#TmpReport.cusno2,
		#TmpReport.scno,
		#TmpReport.cuspo,
		#TmpReport.ttlctn
	order by
		#TmpReport.scno

	-- Delete Complete Report --
	delete from #TmpReport3 where Total_CTN =  Total_Shipped_CTN

	-- Output Data --
	if @cocde = 'MS' 
	begin
	SELECT 
		@cocde as 'Co_Code',
		@cusno1_fm as 'Primary_Cus_Fm',
		@cusno1_to as 'Primary_Cus_To',
		@cusno2_fm as 'Second_Cus_Fm', 
		@cusno2_to as 'Second_Cus_To',

		@cuspo_fm as 'PO_Fm',
		@cuspo_to	as 'PO_To',
		@cuspo_date_fm as 'PO_Date_Fm',
		@cuspo_date_to as 'PO_Date_To',
		@scfm as 'SC_Fm',
		@scto as 'SC_To',
		@ship_start_date_fm as 'Ship_Stdate_Fm',
		@ship_start_date_to as 'Ship_Stdate_To',
		@osonly as 'OS_Only',
		@printsec as 'Print_Sec',
		#TmpReport.cusno1 as 'Cus1_No',		
		#TmpReport.cus1sna as 'Cus1_Name',		
		#TmpReport.cusno2 as 'Cus2_No',		
		#TmpReport.cus2sna as 'Cus2_Name',		
		#TmpReport.scno as 'SCNO',		
		#TmpReport.cuspo as 'Cus_PO',		
		#TmpReport.cuspo_date 'Cus_Date',	
		#TmpReport.ship_start_date_fm as 'Cfm_Ship_Date_Fm',	
		#TmpReport.ship_start_date_to 'Cfm_Ship_Date_Tm',		
		#TmpReport.ttlctn as 'Total_CTN',		
		#TmpReport.ttlamt as 'Total_Amt',	
		@FName01 as 'Factory_Name01',
		@FName02 as 'Factory_Name02',
		#TmpReport.Factory01, 	
		#TmpReport.Factory02, 	
		isnull(#TmpReport2.Act_ship_date,'01/01/1980') as 'Act_Ship_Date',
		isnull(#TmpReport2.Total_shipped_amt,0) as 'Total_Shipped_Amt',
		isnull(#TmpReport2.Total_shipped_ctn,0) as 'Total_Shipped_CTN',
		isnull(#TmpReport2.Factory01b,0) as 'Factory01_Shipped_CTN',
		isnull(#TmpReport2.Factory02b,0) as 'Factory02_Shipped_CTN',
		@compName as 'compName'
	from
		#TmpReport
		left join	#TmpReport2 on
			#TmpReport.cocde =  #TmpReport2.cocde and
			#TmpReport.cusno1= #TmpReport2.cusno1 and	
			#TmpReport.cusno2 = #TmpReport2.cusno2 and
			#TmpReport.cuspo = #TmpReport2.cuspo AND
			#TmpReport.scno = #TmpReport2.scno

		left join	#TmpReport3 on
			#TmpReport.cocde =  #TmpReport3.cocde and
			#TmpReport.cusno1= #TmpReport3.cusno1 and	
			#TmpReport.cusno2 = #TmpReport3.cusno2 and
			#TmpReport.cuspo = #TmpReport3.cuspo and
			#TmpReport.scno = #TmpReport3.scno
	where
		#TmpReport3.cuspo is not null
	order by
		#TmpReport.cusno1,
		#TmpReport.cusno2,
		#TmpReport.cuspo,
		#TmpReport2.Act_ship_date

	end
	else
	begin

	
		SELECT 
			@cocde as 'Co_Code',
			@cusno1_fm as 'Primary_Cus_Fm',
			@cusno1_to as 'Primary_Cus_To',
			@cusno2_fm as 'Second_Cus_Fm', 
			@cusno2_to as 'Second_Cus_To',
	
			@cuspo_fm as 'PO_Fm',
			@cuspo_to	as 'PO_To',
			@cuspo_date_fm as 'PO_Date_Fm',
			@cuspo_date_to as 'PO_Date_To',
			@scfm as 'SC_Fm',
			@scto as 'SC_To',
			@ship_start_date_fm as 'Ship_Stdate_Fm',
			@ship_start_date_to as 'Ship_Stdate_To',
			@osonly as 'OS_Only',
			@printsec as 'Print_Sec',
			#TmpReport.cusno1 as 'Cus1_No',		
			#TmpReport.cus1sna as 'Cus1_Name',		
			#TmpReport.cusno2 as 'Cus2_No',		
			#TmpReport.cus2sna as 'Cus2_Name',		
			#TmpReport.scno as 'SCNO',		
			#TmpReport.cuspo as 'Cus_PO',		
			#TmpReport.cuspo_date 'Cus_Date',	
			#TmpReport.ship_start_date_fm as 'Cfm_Ship_Date_Fm',	
			#TmpReport.ship_start_date_to 'Cfm_Ship_Date_Tm',		
			#TmpReport.ttlctn as 'Total_CTN',		
			#TmpReport.ttlamt as 'Total_Amt',	
			@FName01 as 'Factory_Name01',
			@FName02 as 'Factory_Name02',
			@FName03 as 'Factory_Name03',
			@FName04 as 'Factory_Name04',
			@FName05 as 'Factory_Name05', 
			@FName06 as 'Factory_Name06',
			@FName07 as 'Factory_Name07',
			@FName08 as 'Factory_Name08',
			@FName09 as 'Factory_Name09',
			--2005/02/16 Lester Wu re-arrange the position
	/*		@FName10 as 'Factory_Name10',
			@FName11 as 'Factory_Name11',
			@FName12 as 'Factory_Name12', 
			@FName13 as 'Factory_Name13', 
			@FName14 as 'Factory_Name14',
			@FName15 as 'Factory_Name15',
	*/		
			@FName11 as 'Factory_Name10',
			@FName15 as 'Factory_Name11',
			@FName12 as 'Factory_Name12', 
			@FName13 as 'Factory_Name13', 
			@FName14 as 'Factory_Name14',
			@FName10 as 'Factory_Name15',
			-----------------------------------------
			@FName16 as 'Factory_Name16',
			@FName17 as 'Factory_Name17',
			@FName18 as 'Factory_Name18',
			@FName19 as 'Factory_Name19',		--Lester Wu 2005-04-19 , add factory R - 富泰
			@FName20 as 'Factory_Name20',		--Mark Lau 20091217, add factory X - 通泰
			#TmpReport.Factory01, 	
			#TmpReport.Factory02, 	
			#TmpReport.Factory03, 	
			#TmpReport.Factory04, 	
			#TmpReport.Factory05, 	
			#TmpReport.Factory06, 	
			#TmpReport.Factory07, 	
			#TmpReport.Factory08, 	
			#TmpReport.Factory09, 
			--2005/02/16 Lester Wu re-arrange the position	
	/*		#TmpReport.Factory10, 	
			#TmpReport.Factory11, 	
			#TmpReport.Factory12, 	
			#TmpReport.Factory13, 	
			#TmpReport.Factory14, 	
			#TmpReport.Factory15, 	
	*/
			#TmpReport.Factory11, 	
			#TmpReport.Factory15, 	
			#TmpReport.Factory12, 	
			#TmpReport.Factory13, 	
			#TmpReport.Factory14, 	
			#TmpReport.Factory10, 	
			-----------------------------
			#TmpReport.Factory16, 	
			#TmpReport.Factory17, 	
			#TmpReport.Factory18,
			#TmpReport.Factory19,		--Lester Wu 2005-04-19, add factory R - 富泰	
			#TmpReport.Factory20,		--Mark Lau 20091217, add factory X - 通泰
			isnull(#TmpReport2.Act_ship_date,'01/01/1980') as 'Act_Ship_Date',
			isnull(#TmpReport2.Total_shipped_amt,0) as 'Total_Shipped_Amt',
			isnull(#TmpReport2.Total_shipped_ctn,0) as 'Total_Shipped_CTN',
			isnull(#TmpReport2.Factory01b,0) as 'Factory01_Shipped_CTN',
			isnull(#TmpReport2.Factory02b,0) as 'Factory02_Shipped_CTN',
			isnull(#TmpReport2.Factory03b,0) as 'Factory03_Shipped_CTN',
			isnull(#TmpReport2.Factory04b,0) as 'Factory04_Shipped_CTN',
			isnull(#TmpReport2.Factory05b,0) as 'Factory05_Shipped_CTN',
			isnull(#TmpReport2.Factory06b,0) as 'Factory06_Shipped_CTN',
			isnull(#TmpReport2.Factory07b,0) as 'Factory07_Shipped_CTN',
			isnull(#TmpReport2.Factory08b,0) as 'Factory08_Shipped_CTN',
			isnull(#TmpReport2.Factory09b,0) as 'Factory09_Shipped_CTN',
			--2005/02/16 Lester Wu re-arrange the position
	/*		isnull(#TmpReport2.Factory10b,0) as 'Factory10_Shipped_CTN',
			isnull(#TmpReport2.Factory11b,0) as 'Factory11_Shipped_CTN',
			isnull(#TmpReport2.Factory12b,0) as 'Factory12_Shipped_CTN',
			isnull(#TmpReport2.Factory13b,0) as 'Factory13_Shipped_CTN',
			isnull(#TmpReport2.Factory14b,0) as 'Factory14_Shipped_CTN',
			isnull(#TmpReport2.Factory15b,0) as 'Factory15_Shipped_CTN',
	*/
			isnull(#TmpReport2.Factory11b,0) as 'Factory10_Shipped_CTN',
			isnull(#TmpReport2.Factory15b,0) as 'Factory11_Shipped_CTN',
			isnull(#TmpReport2.Factory12b,0) as 'Factory12_Shipped_CTN',
			isnull(#TmpReport2.Factory13b,0) as 'Factory13_Shipped_CTN',
			isnull(#TmpReport2.Factory14b,0) as 'Factory14_Shipped_CTN',
			isnull(#TmpReport2.Factory10b,0) as 'Factory15_Shipped_CTN',
			----------------------------------------------------------
			isnull(#TmpReport2.Factory16b,0) as 'Factory16_Shipped_CTN',
			isnull(#TmpReport2.Factory17b,0) as 'Factory17_Shipped_CTN',
			isnull(#TmpReport2.Factory18b,0) as 'Factory18_Shipped_CTN',
			isnull(#TmpReport2.Factory19b,0) as 'Factory19_Shipped_CTN',		--Lester Wu 2005-04-19, add factory R - 富泰
			isnull(#TmpReport2.Factory20b,0) as 'Factory20_Shipped_CTN',		--Mark Lau 20091217, add factory X - 通泰
			@compName as 'compName'
		from
			#TmpReport
			left join	#TmpReport2 on
				#TmpReport.cocde =  #TmpReport2.cocde and
				#TmpReport.cusno1= #TmpReport2.cusno1 and	
				#TmpReport.cusno2 = #TmpReport2.cusno2 and
				#TmpReport.cuspo = #TmpReport2.cuspo AND
				#TmpReport.scno = #TmpReport2.scno
	
			left join	#TmpReport3 on
				#TmpReport.cocde =  #TmpReport3.cocde and
				#TmpReport.cusno1= #TmpReport3.cusno1 and	
				#TmpReport.cusno2 = #TmpReport3.cusno2 and
				#TmpReport.cuspo = #TmpReport3.cuspo and
				#TmpReport.scno = #TmpReport3.scno
		where
			#TmpReport3.cuspo is not null
		order by
			#TmpReport.cusno1,
			#TmpReport.cusno2,
			#TmpReport.cuspo,
			#TmpReport2.Act_ship_date
	end 
    end

















GO
GRANT EXECUTE ON [dbo].[sp_select_INR00008] TO [ERPUSER] AS [dbo]
GO
