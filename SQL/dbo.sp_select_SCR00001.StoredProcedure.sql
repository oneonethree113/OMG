/****** Object:  StoredProcedure [dbo].[sp_select_SCR00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_SCR00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_SCR00001]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





















-- Checked by Allan Yuen at 27/07/2003
--exec sp_general '㊣SCR00001※S※UCPP※CO※NO※EXACT※Y※US0500101※US0500101※CUST※ORG※Y※N', '', '', '', ''

/*
=========================================================
Program ID	: sp_select _SCR00001	
Description   	: Print SC 
Programmer  	: 
ALTER  Date   	: 
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
21 Jun 2003	Lewis To		Add MOQ charges as Remark and
				changed Unit Price included  MOQ charges               
16 Oct 2003	Marco Chan	Add Revised Option for printing SC Report
18 Feb 2005	Allan Yuen		Add Customer Order No. in grouping
12 Mar 2005	Allan Yuen		Add Company information rather than hard code.
27 May 2005	Lester Wu		Add Secondary Customer Cust. Item No
=========================================================     
*/

CREATE  PROCEDURE [dbo].[sp_select_SCR00001]
@cocde	nvarchar(6),	
@Heading	nvarchar(4),	
@fty		nvarchar(3),
@ShpFmt	nvarchar(6),
@Sup0		nvarchar(1),
@SCfrom	nvarchar(20),	
@SCto		nvarchar(20),
@sortBy	nvarchar(4),	-- 1 : By Customer Item, 2 : By Item, 3 : By Input Seq
@UM		nvarchar(3),
@CRmk	nvarchar(1), 
@Rvs	nvarchar(1),
--Added by Mark Lau 20080620
@printPDF	nvarchar(1),
-- Added by Joe 20100505
@usrid	nvarchar(30),
@doctyp	nvarchar(2)

AS

-- Read Company Information --
declare 
	@yco_conam varchar(50),	@yco_addr nvarchar(200),	@yco_logoimgpth varchar(100),	@yco_phoneno varchar(50),	@yco_faxno varchar(50)

SELECT 
	@yco_conam = yco_conam,	
	@yco_addr = yco_addr,
	@yco_logoimgpth = yco_logoimgpth, 
	@yco_phoneno = yco_phoneno,
	@yco_faxno = yco_faxno 
FROM
	SYCOMINF
WHERE
	YCO_COCDE = @cocde

---------------------------------------------
--if @sortBy = 'CUST'
--Begin
/*
	CREATE TABLE #tmpSC (
	tmp_cocde	nvarchar(6)	not null,
	tmp_ordno	nvarchar(20)	not null,
	tmp_ordseq	int,
	tmp_row		int)  on [PRIMARY]

	Declare
	@sod_ordno	nvarchar(20),
	@sod_ordseq	int,
	@sod_cusitm	nvarchar(20),
	@key		nvarchar(300),

	@sod_row	int,
	@key_pre	nvarchar(300),
	@sod_untprc	numeric(13,4),
	@sod_ordqty	int

	Declare cur_sc_by_cust CURSOR
	for
	Select	sod_ordno, sod_ordseq, 
		Case @sortBy when 'CUST' then sod_cusitm else '' end,
		sod_key = sod_itmno + ltrim(sod_itmdsc) + sod_pckunt + str(sod_inrctn) + str(sod_mtrctn) + str(sod_cft) + str(sod_untprc)
	from	SCORDDTL
	where	sod_ordno between @SCfrom and @SCto
	and	sod_cocde = @cocde
	order by	sod_ordno, Case @sortBy when 'CUST' then sod_cusitm else '' end,
			sod_itmno + ltrim(sod_itmdsc) + sod_pckunt + str(sod_inrctn) + str(sod_mtrctn) + str(sod_cft) + str(sod_untprc)

	Open cur_sc_by_cust
	Fetch NEXT FROM cur_sc_by_cust into @sod_ordno, @sod_ordseq, @sod_cusitm, @key

	Set @key_pre = ''
	Set @sod_row = 1

	While @@fetch_status = 0
	Begin
		If @key_pre = ''
		Begin
			Set @key_pre = @key
		End
		If @key_pre <> @key
		Begin
			Set @key_pre = @key
			Set @sod_row = @sod_row + 1
		End

		Insert into #tmpSC (tmp_cocde, tmp_ordno, tmp_ordseq, tmp_row)
		values
		(@cocde, @sod_ordno, @sod_ordseq, @sod_row)

		Fetch NEXT FROM cur_sc_by_cust into @sod_ordno, @sod_ordseq, @sod_cusitm, @key
	End
	Close cur_sc_by_cust
	Deallocate cur_sc_by_cust
	
	Create table	#tmpSC_SUM (
	sum_cocde	nvarchar(6)	not null,
	sum_ordno	nvarchar(20)	not null,
	sum_untprc	numeric(13,4),
	sum_qty		int) on [PRIMARY]

	Declare cur_calsum CURSOR
	for
	Select	sod_ordno, tmp_row, 
		sod_itmno + ltrim(sod_itmdsc) + sod_pckunt + str(sod_inrctn) + str(sod_mtrctn) + str(sod_cft) + str(sod_untprc),
		sod_untprc, sum(sod_ordqty)
	from 	SCORDDTL, #tmpSC
	where 	sod_cocde = tmp_cocde and sod_ordno = tmp_ordno and sod_ordseq = tmp_ordseq
	group by	sod_cocde, sod_ordno, tmp_row, 
		sod_itmno + ltrim(sod_itmdsc) + sod_pckunt + str(sod_inrctn) + str(sod_mtrctn) + str(sod_cft) + str(sod_untprc), sod_untprc
	order by	sod_cocde, sod_ordno, tmp_row, 
		sod_itmno + ltrim(sod_itmdsc) + sod_pckunt + str(sod_inrctn) + str(sod_mtrctn) + str(sod_cft) + str(sod_untprc)
	
	Open cur_calsum
	Fetch NEXT FROM cur_calsum into @sod_ordno, @sod_row, @key, @sod_untprc, @sod_ordqty

	While @@fetch_status = 0
	Begin
		Insert into #tmpSC_SUM (sum_cocde, sum_ordno, sum_untprc, sum_qty)
		values
		(@cocde, @sod_ordno, @sod_untprc, @sod_ordqty)

		Fetch NEXT FROM cur_calsum into @sod_ordno, @sod_row, @key, @sod_untprc, @sod_ordqty
	End
	Close cur_calsum
	Deallocate cur_calsum	
*/
------------------------------------------------------------------------------------------------------------------------

declare 	@ftyprc		int,	@sortbyWhich	nvarchar(6), 	@feed char(2)
set @feed = char(13) + char(10)
Select
	-- Parameter
	@cocde,
	@yco_conam,
	@yco_addr,
	@yco_logoimgpth,
	@yco_phoneno,
	@yco_faxno, 
	@Heading,	
	@fty,
	@ShpFmt,	
	@Sup0,	
	@sortBy,
	@UM,
	@Rvs,

	Case @sortBy When 'CUST' then  dtl.sod_cusitm else '' end,
	sodKey = 
		--Added by Mark Lau 20080516, Add CDTVX
			--ltrim(left(dtl.sod_itmno+'          ',20))+ 
			ltrim(left( case 
				when len(dtl.sod_itmno) < 11 or charindex('-',dtl.sod_itmno) > 0 or charindex('/',dtl.sod_itmno) >0 or (Upper(substring(dtl.sod_itmno,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(dtl.sod_itmno,7,2) = 'AS' then dtl.sod_itmno
				when upper(substring(dtl.sod_itmno, 3, 1)) = 'A'  or upper(substring(dtl.sod_itmno, 3, 1)) = 'C'  or upper(substring(dtl.sod_itmno, 3, 1)) = 'D' or upper(substring(dtl.sod_itmno, 3, 1)) = 'T' or upper(substring(dtl.sod_itmno, 3, 1)) = 'X' or upper(substring(dtl.sod_itmno, 3, 1)) = 'V'  then substring(dtl.sod_itmno,1,11)
				when upper(substring(dtl.sod_itmno, 3, 1)) = 'B' and (substring(dtl.sod_itmno, 4, 1) >= '0' And substring(dtl.sod_itmno, 4, 1) <= '9' ) And (substring(dtl.sod_itmno, 5, 1) >= '0' And substring(dtl.sod_itmno, 5, 1) <= '9' ) And  (substring(dtl.sod_itmno, 6, 1) >= '0' And substring(dtl.sod_itmno, 6, 1) <= '9') then substring(dtl.sod_itmno,1,11)
				when upper(substring(dtl.sod_itmno, 3, 1)) = 'B' and (upper(substring(dtl.sod_itmno, 4, 1)) >= 'A' And upper(substring(dtl.sod_itmno, 4, 1)) <= 'Z' ) And (substring(dtl.sod_itmno, 5, 1) >= '0' And substring(dtl.sod_itmno, 5, 1) <= '9' ) And  (substring(dtl.sod_itmno, 6, 1) >= '0' And substring(dtl.sod_itmno, 6, 1) <= '9') then substring(dtl.sod_itmno,1,11)
				else dtl.sod_itmno
			end +'          ',20))+ 
	--edited by Mark Lau 20070623
	--edited by Mark Lau 20080616
			case when isnull(dtl.sod_custum,'') <>'' then dtl.sod_custum else
			case when dtl.sod_contopc = 'Y' then 'PC' else 
			 ltrim(dtl.sod_pckunt) end 		
			end +'x' + 
	 		case when dtl.sod_contopc = 'Y' then  convert(varchar(40),dtl.sod_inrctn * dtl.sod_conftr) else convert(varchar(20),dtl.sod_inrctn)  end +'x' + 
			case when dtl.sod_contopc = 'Y' then  convert(varchar(40),dtl.sod_mtrctn * dtl.sod_conftr) else convert(varchar(20),dtl.sod_mtrctn)  end +'x' + 
			convert(varchar(20),dtl.sod_cft)+'x' +
			convert(varchar(20),dtl.sod_netuntprc) +'x' + 
			ltrim(dtl.sod_itmdsc) +'x' + ltrim(dtl.sod_cuspo) ,
	--                ^^^ Change to use netunit price to sort

	-- CUBASINF st
	st.cbi_cusno,
	st.cbi_cusnam,	 
	st.cbi_cussna,
	
	-- CUBASINF snd
	secondCusnam = isNull(snd.cbi_cusnam,''),

	-- SYSETINF snd
	secondCusCy = sndCust.ysi_dsc,

	-- SYSETINF 02
	sys02.ysi_cocde,	
	sys02.ysi_dsc, 	

	-- SCORDHDR
	soh_bilcty,		
	soh_biladr, 	soh_bilstt,		soh_bilzip,		soh_cttper,	
	soh_ordno,	
	soh_candat = ltrim(str(datepart(mm,soh_candat))) + '/' + ltrim(str(datepart(dd,soh_candat))) + '/' + ltrim(str(datepart(yyyy,soh_candat))),
	soh_issdat = ltrim(str(datepart(mm,soh_issdat))) + '/' + ltrim(str(datepart(dd,soh_issdat))) + '/' + ltrim(str(datepart(yyyy,soh_issdat))),
	soh_rvsdat = ltrim(str(datepart(mm,soh_rvsdat))) + '/' + ltrim(str(datepart(dd,soh_rvsdat))) + '/' + ltrim(str(datepart(yyyy,soh_rvsdat))),
	soh_cuspo,	
	soh_resppo,	
	soh_cpodat = ltrim(str(datepart(mm,soh_cpodat))) + '/' + ltrim(str(datepart(dd,soh_cpodat))) + '/' + ltrim(str(datepart(yyyy,soh_cpodat))),
	Case Len(ltrim(replace(replace(isnull(soh_rmk,''), char(13), ''), char(10), ''))) when 0 then '0' else '1' end,
	soh_rmk,		soh_ttlamt,		
--/	soh_cus2no,	
	soh_shpadr,	soh_shpstt,		soh_shpcty,	soh_shpzip,
--/	soh_cft,
	---------------------------------==========================================================
	-- SYAGTINF
	yai_stnam,		

	-- VNBASINF
	vbi_vensna,	vbi_venno,

	-- SCORDDTL
	dtl.sod_purord,		
--	dtl.sod_untprc,	-- Changed to use unit price include MOQ charges
	--edited by Mark Lau 20070623
	case when dtl.sod_contopc = 'Y' then dtl.sod_netuntprc / dtl.sod_conftr else dtl.sod_netuntprc end as 'dtl.sod_netuntprc',
	dtl.sod_ordno,		dtl.sod_colcde,		dtl.sod_ordseq,
	-- dtl.sod_itmno,
	case 
		--Added by Mark Lau 20080516, Add CDTVX
		when len(dtl.sod_itmno) < 11 or charindex('-',dtl.sod_itmno) > 0 or charindex('/',dtl.sod_itmno) >0 or (Upper(substring(dtl.sod_itmno,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(dtl.sod_itmno,7,2) = 'AS' then dtl.sod_itmno
		when len(dtl.sod_itmno) = 13 and upper(substring(dtl.sod_itmno, 3, 1)) = 'A' or upper(substring(dtl.sod_itmno, 3, 1)) = 'C'  or upper(substring(dtl.sod_itmno, 3, 1)) = 'D' or upper(substring(dtl.sod_itmno, 3, 1)) = 'T' or upper(substring(dtl.sod_itmno, 3, 1)) = 'X' or upper(substring(dtl.sod_itmno, 3, 1)) = 'V'  then substring(dtl.sod_itmno,1,11)
		when len (dtl.sod_itmno) = 13 and upper(substring(dtl.sod_itmno, 3, 1)) = 'B' and (substring(dtl.sod_itmno, 4, 1) >= '0' And substring(dtl.sod_itmno, 4, 1) <= '9' ) And (substring(dtl.sod_itmno, 5, 1) >= '0' And substring(dtl.sod_itmno, 5, 1) <= '9' ) And  (substring(dtl.sod_itmno, 6, 1) >= '0' And substring(dtl.sod_itmno, 6, 1) <= '9') then substring(dtl.sod_itmno,1,11)
		when len(dtl.sod_itmno) = 13 and upper(substring(dtl.sod_itmno, 3, 1)) = 'B' and (upper(substring(dtl.sod_itmno, 4, 1)) >= 'A' And upper(substring(dtl.sod_itmno, 4, 1)) <= 'Z' ) And (substring(dtl.sod_itmno, 5, 1) >= '0' And substring(dtl.sod_itmno, 5, 1) <= '9' ) And  (substring(dtl.sod_itmno, 6, 1) >= '0' And substring(dtl.sod_itmno, 6, 1) <= '9') then substring(dtl.sod_itmno,1,11)
		else dtl.sod_itmno
	end as 'dtl.sod_itmno' , 

				dtl.sod_cusitm,		dtl.sod_itmdsc,	sod_itmdsc_Memo = dtl.sod_itmdsc,
	dtl.sod_cususd,
	dtl.sod_cuscad,		dtl.sod_cuspo,		dtl.sod_resppo,		
	--Edited by Mark Lau 20070623
	sod_inrctn = case when sod_contopc = 'Y' then str(dtl.sod_inrctn * dtl.sod_conftr) else  str(dtl.sod_inrctn)  end ,
	sod_mtrctn = case when sod_contopc = 'Y' then str(dtl.sod_mtrctn * dtl.sod_conftr) else  str(dtl.sod_mtrctn) end ,	
--/	sod_cft = str(dtl.sod_cft),
	dtl.sod_cft,
	line_cft = round(dtl.sod_cft * dtl.sod_ttlctn,2),
	ltrim(replace(replace(sod_rmk, char(13), ''), char(10), '')) +  case dtl.sod_moqchg when 0 then '' else 'A'  end,	-- Add the MOQ charges zero chexk for empty check in report by Lewis on 22 Jun 2003
--*****	Add MOQ charges message to item remark by Lewis 
	sod_rmkMemo = dtl.sod_rmk + case rtrim(dtl.sod_rmk) when  ''  then '' else @feed end + case dtl.sod_moqchg when 0 then '' else 'Original Unit Price is ' + rtrim(dtl.sod_curcde) + cast(cast(dtl.sod_untprc as decimal(13,4)) as varchar(13)) + ', additional MOQ Charges ' + CAST(CAST(dtl.sod_moqchg as int) as varchar(10)) + '%' end ,
	dtl.sod_cuscol, 		dtl.sod_coldsc,		dtl.sod_cussku,	dtl.sod_code1, 
	dtl.sod_code2, 		dtl.sod_code3,			dtl.sod_hrmcde,	
	--edited by Mark Lau 20070623	
	--edited by Mark Lau 20080616
	case when isnull(dtl.sod_custum,'') <> '' then dtl.sod_custum else case when dtl.sod_contopc = 'Y' then 'PC' else  dtl.sod_pckunt end end as 'dtl.sod_pckunt',
	case when dtl.sod_contopc = 'Y' then dtl.sod_ordqty * dtl.sod_conftr else dtl.sod_ordqty end as 'dtl.sod_ordqty',
	sod_ordqty_str = str(case when dtl.sod_contopc = 'Y' then dtl.sod_ordqty * dtl.sod_conftr else dtl.sod_ordqty end),
	dtl.sod_curcde,		

	-- Temp Table 
--	vw.sumamt,

	dtl.sod_ordqty * dtl.sod_selprc,
	dtl.sod_venno,		dtl.sod_venitm,		dtl.sod_ordseq,	
	sod_pckitr = isNull(dtl.sod_pckitr,''),	
	dtl.sod_pckitr,
	dtl.sod_typcode,		sod_ttlctn = str(dtl.sod_ttlctn),
--	Logic for the display of factory currency and price
---	U, C, P, I, N T, E, R, H, K --> 1, 2,3, 4,5 ,6 ,7 8, 9, 0
---	1 --> USD & 2 --> HKD
--	e.g. US$38.745 = PRENTI
	sod_fcurcde,	sod_ftyprc,	

/*	Encode for Fty Price formula.........................
	declare @temp numeric(13,4), @word nvarchar(20)	 
	set @temp = 38.745 
	set @word = replace(cast(@temp as nvarchar(17)),'.', '') 
	select replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(@word, '0','K'), '9', 'H'),  '8', 'R') , '7', 'E'), '6', 'T'), '5', 'N'), '4', 'I'), '3', 'P'), '2', 'C'), '1', 'U')
*/ 
	sod_ftyprc = replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(cast(sod_ftyprc as nvarchar(17)),'.', 'D'), '0','K'), '9', 'H'),  '8', 'R') , '7', 'E'), '6', 'T'), '5', 'N'), '4', 'I'), '3', 'P'), '2', 'C'), '1', 'U'),
	sod_fcurcde = replace(replace(dtl.sod_fcurcde,'HKD','2'),'USD','1'),
	sod_ctnstr = str(dtl.sod_ctnstr),	sod_ctnend = str(dtl.sod_ctnend),	

	shipStr = convert(char(10), sod_shpstr, 101),
	shipEnd = convert(char(10), sod_shpend, 101),
--	sod_shpstr = ltrim(str(datepart(mm,sod_shpstr))) + '/' + ltrim(str(datepart(dd,sod_shpstr))) + '/' + ltrim(str(datepart(yyyy,sod_shpstr))),
--	sod_shpend = ltrim(str(datepart(mm,sod_shpend))) + '/' + ltrim(str(datepart(dd,sod_shpend))) + '/' + ltrim(str(datepart(yyyy,sod_shpend))),	
	sod_shpstrMM = replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(ltrim(str(datepart(mm,dtl.sod_shpstr))),'10','Oct'),'11','Nov'),'12','Dec'),'1','Jan'),'2','Feb'),'3','Mar'),'4','Apr'),'5','May'),'6','Jun'),'7','Jul'),'8','Aug'),'9','Sep'),	
	sod_shpendMM = replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(ltrim(str(datepart(mm,dtl.sod_shpend))),'10','Oct'),'11','Nov'),'12','Dec'),'1','Jan'),'2','Feb'),'3','Mar'),'4','Apr'),'5','May'),'6','Jun'),'7','Jul'),'8','Aug'),'9','Sep'),	
	sod_shpstrDD = datepart(dd,dtl.sod_shpstr),
	sod_shpendDD = datepart(dd,dtl.sod_shpend),
 	sod_shpstrYY = ltrim(str(datepart(yyyy,dtl.sod_shpstr))) ,
	sod_shpendYY = ltrim(str(datepart(yyyy,dtl.sod_shpend))),

	-- SYSALREP9
	--Edited by Mark Lau 20080620
	sr1.ysr_dsc + ' (' + sr1.ysr_saltem + ')' as 'ysr_dsc',

	-- SCSHPMRK
	MainMrk = isNull(mrk1.ssm_imgpth,''),	InnerMrk = isNull(mrk2.ssm_imgpth,''),	SideMrk = isNull(mrk3.ssm_imgpth,''),

--/	MainEng = isNull(mrk1.ssm_engdsc,''),	
	MainEng = ltrim(replace(replace(isnull(mrk1.ssm_engdsc,''), char(13), ''), char(10), '')),	
	MainEng_Memo = isNull(mrk1.ssm_engdsc,''),	

--/	InnerEng = isNull(mrk2.ssm_engdsc,''),	
	InnerEng =  ltrim(replace(replace(isnull(mrk2.ssm_engdsc,''), char(13), ''), char(10), '')),	
	InnerEng_Memo = isNull(mrk2.ssm_engdsc,''),	

--/	SideEng = isNull(mrk3.ssm_engdsc,''),	
	SideEng = ltrim(replace(replace(isnull(mrk3.ssm_engdsc,''), char(13), ''), char(10), '')),		
	SideEng_Memo = isNull(mrk3.ssm_engdsc,''),

	MainChnDsc = Case @CRmk when 'Y' then ltrim(replace(replace(isnull(mrk1.ssm_chndsc,''), char(13), ''), char(10), '')) else '' end,
	InnerChnDsc = Case @CRmk when 'Y' then ltrim(replace(replace(isnull(mrk2.ssm_chndsc,''), char(13), ''), char(10), '')) else '' end,
	SideChnDsc =  Case @CRmk when 'Y' then ltrim(replace(replace(isnull(mrk3.ssm_chndsc,''), char(13), ''), char(10), '')) else '' end,
	MainChn_Memo = isNull(mrk1.ssm_chndsc,''),		
	InnerChn_Memo = isNull(mrk2.ssm_chndsc,''),	
	SideChn_Memo = isNull(mrk3.ssm_chndsc,''),

	MainChnRmk = Case @CRmk when 'Y' then ltrim(replace(replace(isnull(mrk1.ssm_chnrmk,''), char(13), ''), char(10), '')) else '' end,	
	InnerChnRmk = Case @CRmk when 'Y' then ltrim(replace(replace(isnull(mrk2.ssm_chnrmk,''), char(13), ''), char(10), '')) else '' end,	
	SideChnRmk = Case @CRmk when 'Y' then ltrim(replace(replace(isnull(mrk3.ssm_chnrmk,''), char(13), ''), char(10), '')) else '' end,		
	MainChnRmk_Memo = isNull(mrk1.ssm_chnrmk,''),	
	InnerChnRmk_Memo = isNull(mrk2.ssm_chnrmk,''),	
	SideChnRmk_Memo = isNull(mrk3.ssm_chnrmk,''),

--/	MainEngRmk = isNull(mrk1.ssm_engrmk,''),	InnerEngRmk = isNull(mrk2.ssm_engrmk,''),	SideEngRmk = isNull(mrk3.ssm_engrmk,''),
	MERk = Case Len(ltrim(replace(replace(isnull(mrk1.ssm_engrmk,''), char(13), ''), char(10), ''))) when 0 then '0' else '1' end,
	IERk = Case Len(ltrim(replace(replace(isnull(mrk2.ssm_engrmk,''), char(13), ''), char(10), ''))) when 0 then '0' else '1' end,
	SERk = Case Len(ltrim(replace(replace(isnull(mrk3.ssm_engrmk,''), char(13), ''), char(10), ''))) when 0 then '0' else '1' end,
	MainEngRmk = ltrim(isnull(mrk1.ssm_engrmk,'')),	
	InnerEngRmk = ltrim(isnull(mrk2.ssm_engrmk,'')),	
	SideEngRmk = ltrim(isnull(mrk3.ssm_engrmk,'')),	

	-- SYSETINF 03
	sys03.ysi_dsc,
	
	-- SYSETINF 04
	sys04.ysi_dsc,

	-- SYSETINF sys05
	--sys05.ysi_dsc,
case when isnull(dtl.sod_custum,'') <> ''  then dtl.sod_custum else case when dtl.sod_contopc = 'Y' then 'PC' else sys05.ysi_dsc end end as 'sys05.ysi_dsc',


	dtl.sod_dept,
	dtl.sod_dtyrat,
	EXTMRK = case dtl.sod_moqchg when 0 then '' else 'Original Unit Price is ' + rtrim(dtl.sod_curcde) + cast(cast(dtl.sod_untprc as decimal(9,2)) as varchar(13)) + ', add additional MOQ Charges ' + CAST(CAST(dtl.sod_moqchg as decimal(6,2)) as varchar(10)) + '%' end 
	--Lester Wu 2005-05-27, add Secondary Customer Cust. Item No
	,isnull(dtl.sod_seccusitm,'') as 'SecCustItem' , 
	-- Lester Wu 2006-09-24
	isnull(dtl.sod_alsitmno,'') as 'dtl.sod_alsitmno' , 
	isnull(dtl.sod_alscolcde,'') as 'dtl.sod_alscolcde' , 
	case 
		--Added by Mark Lau 20080516, Add CDTVX
		when len(dtl.sod_itmno) < 11 or charindex('-',dtl.sod_itmno) > 0 or charindex('/',dtl.sod_itmno) >0 or (Upper(substring(dtl.sod_itmno,3,1)) not in ('A','B','U','C','D','T','V','X')) or substring(dtl.sod_itmno,7,2) = 'AS' then ''
		when len(dtl.sod_itmno) = 13 and upper(substring(dtl.sod_itmno, 3, 1)) = 'A' or upper(substring(dtl.sod_itmno, 3, 1)) = 'C'  or upper(substring(dtl.sod_itmno, 3, 1)) = 'D' or upper(substring(dtl.sod_itmno, 3, 1)) = 'T' or upper(substring(dtl.sod_itmno, 3, 1)) = 'X' or upper(substring(dtl.sod_itmno, 3, 1)) = 'V'  then substring(dtl.sod_itmno,12,2)
		when len(dtl.sod_itmno) = 13 and upper(substring(dtl.sod_itmno, 3, 1)) = 'B' and (substring(dtl.sod_itmno, 4, 1) >= '0' And substring(dtl.sod_itmno, 4, 1) <= '9' ) And (substring(dtl.sod_itmno, 5, 1) >= '0' And substring(dtl.sod_itmno, 5, 1) <= '9' ) And  (substring(dtl.sod_itmno, 6, 1) >= '0' And substring(dtl.sod_itmno, 6, 1) <= '9') then substring(dtl.sod_itmno,12,2)
		when len(dtl.sod_itmno) = 13 and upper(substring(dtl.sod_itmno, 3, 1)) = 'B' and (upper(substring(dtl.sod_itmno, 4, 1)) >= 'A' And upper(substring(dtl.sod_itmno, 4, 1)) <= 'Z' ) And (substring(dtl.sod_itmno, 5, 1) >= '0' And substring(dtl.sod_itmno, 5, 1) <= '9' ) And  (substring(dtl.sod_itmno, 6, 1) >= '0' And substring(dtl.sod_itmno, 6, 1) <= '9') then substring(dtl.sod_itmno,12,2)
		else ''
	end as 'suffix'

-- Added by Mark Lau 2007015
	,''
	,case when @CRmk = 'Y' then isnull(dtl.sod_ztnvbeln,'') else '' end as 'dtl.sod_ztnvbeln'
	,case when @CRmk = 'Y' then isnull(dtl.sod_ztnposnr,'') else '' end as 'dtl.sod_ztnposnr'
-- Added by Mark Lau 20080620
	,isnull(soh_email,'') as 'soh_email', @printPDF as 'printPDF'
	

From 	
SCORDHDR
left join CUBASINF snd on soh_cus2no = snd.cbi_cusno
left join SYSETINF sndCust on sndCust.ysi_typ = '02' and soh_shpcty = sndCust.ysi_cde
left join SYSETINF sys02 on sys02.ysi_typ = '02' and soh_bilcty = sys02.ysi_cde
left join SYSETINF sys03 on sys03.ysi_typ = '03' and soh_prctrm = sys03.ysi_cde
left join SYSETINF sys04 on sys04.ysi_typ = '04' and soh_paytrm = sys04.ysi_cde
left join SYAGTINF on soh_agt = yai_agtcde
left join SCSHPMRK mrk1 on soh_cocde = mrk1.ssm_cocde and soh_ordno = mrk1.ssm_ordno and mrk1.ssm_shptyp = 'M'
left join SCSHPMRK mrk2 on soh_cocde = mrk2.ssm_cocde and soh_ordno = mrk2.ssm_ordno and mrk2.ssm_shptyp = 'I'
left join SCSHPMRK mrk3 on soh_cocde = mrk3.ssm_cocde and soh_ordno = mrk3.ssm_ordno and mrk3.ssm_shptyp = 'S'
, 	
SCORDDTL dtl
left join SYSETINF sys05 on sys05.ysi_typ = '05' and case when isnull(dtl.sod_custum,'') <> '' then dtl.sod_custum else case when dtl.sod_contopc = 'Y' then 'PC' else dtl.sod_pckunt end end = sys05.ysi_cde
left join VNBASINF on sod_venno = vbi_venno
,	
CUBASINF st,	


SYSALREP sr1,	
SYSALREP sr2
where	
	soh_cocde = dtl.sod_cocde and soh_ordno = dtl.sod_ordno
and	soh_cus1no = st.cbi_cusno


and	soh_salrep = sr1.ysr_code1 and sr1.ysr_cocde = ' '
and	st.cbi_salrep = sr2.ysr_code1 and sr2.ysr_cocde = ' '


and	((@Sup0 = 'Y' and dtl.sod_ordqty > 0) or (@Sup0 = 'N' ))
and 	soh_ordno >= @SCfrom and soh_ordno <= @SCto and soh_cocde = @cocde
and 	(	
		exists
		(	
			select 1 from syusrright
			where yur_usrid = @usrid  and yur_doctyp = @doctyp and yur_lvl = 0
		)
		or sr2.ysr_saltem in 
		(	
			select yur_para from syusrright
			where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 1
		)
		or soh_cus1no in 
		(
			select yur_para from syusrright
			where yur_usrid = @usrid and yur_doctyp = @doctyp and yur_lvl = 2
		)
	)



GO
GRANT EXECUTE ON [dbo].[sp_select_SCR00001] TO [ERPUSER] AS [dbo]
GO
