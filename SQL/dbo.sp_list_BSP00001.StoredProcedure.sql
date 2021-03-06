/****** Object:  StoredProcedure [dbo].[sp_list_BSP00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_list_BSP00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_list_BSP00001]    Script Date: 09/29/2017 15:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO









--sp_list_BSP00001 'L','','','','','','','','','','','','','','','', '5', 'Q', 'Y', '08/01/2002' , '08/01/2003'
--sp_list_BSP00001 'L','A','B','','','','','','','','','','','','','','','','','20', '5', 'Q', 'Y', '09/01/2002 00:00:00.000' , '12/31/2049 23:59:59.999'
--sp_list_BSP00001 'L','','','sfsdfsdf','','','','','','','','','','','','','','20', '5', 'Q', 'Y', '09/01/2002 00:00:00.000' , '12/31/2049 23:59:59.999'
/*
=========================================================
Program ID	: sp_list_BSP00001
Description   	: 
Programmer  	: Marco Chan
ALTER  Date   	: 04/09/2003
Last Modified  	: 
Table Read(s) 	:
Table Write(s) 	:
=========================================================
 Modification History                                    
=========================================================
Date		Author		Description
2003/10/09		Marco Chan	Fix for searching Vendor Item number instead of Item number               
2005-04-06	Lester Wu		Retrieve Company Name from database
=========================================================     
*/
CREATE procedure [dbo].[sp_list_BSP00001]
	@cocde		nvarchar(6),	
----------2003/11/21----------------
	@VN_FM		NVARCHAR(20),
	@VN_TO		NVARCHAR(20),
----------------------------------------
	@ITM_FM		nvarchar(20),
	@ITM_TO		nvarchar(20),
-----2003/11/19-
	@ITM_STRING	nvarchar(1000),
-------------------
	@PRDLNE_FR	nvarchar(10),
	@PRDLNE_TO	nvarchar(10),
-----2003/11/19--
	@PRDLNE_STRING	nvarchar(1000),
--------------------
	@CL0_FM		nvarchar(20),
	@CL0_TO		nvarchar(20),
	@CL1_FM		nvarchar(20),
	@CL1_TO		nvarchar(20),
	@CL2_FM		nvarchar(20),
	@CL2_TO		nvarchar(20),
	@CL3_FM		nvarchar(20),
	@CL3_TO		nvarchar(20),
	@CL4_FM		nvarchar(20),
	@CL4_TO		nvarchar(20),
	@DSG_FM		nvarchar(20),
	@DSG_TO		nvarchar(20),
	@NUMOFREC	int,
	@NUMOFTOPPRDLNE	int,
	@ORDERBY	nvarchar(20),
	@PRINTAMOUNT	nvarchar(20),
	@STARTDATE 	DATETIME,
	@ENDDATE	DATETIME
as

--SET @STARTDATE 	= '09-01-2002' 
--SET @ENDDATE 	= GETDATE()

-- Extract IM Basic Inifo =====> #LN
--DROP TABLE #LN		-- 226479

SET NOCOUNT ON
SET ANSI_WARNINGS off
SET ANSI_NULLS OFF

-----------------2003/11/21-------------------------
IF LTRIM(RTRIM(@VN_FM))=''
     SET @VN_FM = '000000000000000000'
IF LTRIM(RTRIM(@VN_TO)) = ''
     SET @VN_TO = 'ZZZZZZZZZZZZZZZZZZ'
-------------------------------------------------------

IF LTRIM(RTRIM(@ITM_FM)) = ''
     SET @ITM_FM = '000000000000000000'

IF LTRIM(RTRIM(@ITM_TO)) = ''
     SET @ITM_TO = 'ZZZZZZZZZZZZZZZZZZ'

IF LTRIM(RTRIM(@PRDLNE_FR)) = ''
     SET @PRDLNE_FR = '0000000000'

IF LTRIM(RTRIM(@PRDLNE_TO)) = ''
     SET @PRDLNE_TO = 'ZZZZZZZZZZ'

IF LTRIM(RTRIM(@CL0_FM)) = '' 
     SET @CL0_FM = '000000000000000000'

IF LTRIM(RTRIM(@CL0_TO)) = '' 
     SET @CL0_TO = 'ZZZZZZZZZZZZZZZZZZ'

IF LTRIM(RTRIM(@CL1_FM)) = '' 
     SET @CL1_FM = '000000000000000000'

IF LTRIM(RTRIM(@CL1_TO)) = '' 
     SET @CL1_TO = 'ZZZZZZZZZZZZZZZZZZ'

IF LTRIM(RTRIM(@CL2_FM)) = '' 
     SET @CL2_FM = '000000000000000000'

IF LTRIM(RTRIM(@CL2_TO)) = '' 
     SET @CL2_TO = 'ZZZZZZZZZZZZZZZZZZ'

IF LTRIM(RTRIM(@CL3_FM)) = '' 
     SET @CL3_FM = '000000000000000000'

IF LTRIM(RTRIM(@CL3_TO)) = '' 
     SET @CL3_TO = 'ZZZZZZZZZZZZZZZZZZ'

IF LTRIM(RTRIM(@CL4_FM)) = '' 
     SET @CL4_FM = '000000000000000000'

IF LTRIM(RTRIM(@CL4_TO)) = '' 
     SET @CL4_TO = 'ZZZZZZZZZZZZZZZZZZ'

declare @OPT_DSG char(1)
	set @OPT_DSG = 'Y'

IF LTRIM(RTRIM(@DSG_FM)) = '' 
	set @OPT_DSG = 'N'

IF LTRIM(RTRIM(@NUMOFREC)) = ''
     SET @NUMOFREC = '20'

IF LTRIM(RTRIM(@PRINTAMOUNT)) = ''
     SET @PRINTAMOUNT = 'Y'

--Lester Wu 2005-04-06, retrieve company name from database
declare @compName varchar(100)
select @compName = yco_conam from SYCOMINF(NOLOCK) where yco_cocde = @cocde
if @cocde<>'MS'
begin
	set @compName = 'UNITED CHINESE GROUP'
end



----2003/11/19--------------------------
--declare variable
declare 	@optITMSTR	char(1),
	@optLNESTR	char(1),
	@ITM_REMAIN	nvarchar(1000),
	@LNE_REMAIN	nvarchar(1000),
	@ITM_PART	nvarchar(20),
	@LNE_PART	nvarchar(10)
create table #TMP_ITM (tmp_ITMNO nvarchar(20)) on [PRIMARY]
create table #TMP_LNE (tmp_PRDLNE nvarchar(10)) on [PRIMARY]
--set default value
set @optITMSTR='N'

--insert data into table if data exist
IF LTRIM(RTRIM(@ITM_STRING))<>'' 
BEGIN 
	SET @optITMSTR='Y'
	SET @ITM_REMAIN = @ITM_STRING
	WHILE CHARINDEX(',',@ITM_REMAIN)<>0
	BEGIN
		SET @ITM_PART = LTRIM(LEFT(@ITM_REMAIN,CHARINDEX(',',@ITM_REMAIN)-1))
		SET @ITM_REMAIN = RIGHT(@ITM_REMAIN,LEN(@ITM_REMAIN) - CHARINDEX(',',@ITM_REMAIN))
		INSERT INTO #TMP_ITM VALUES (@ITM_PART)
	END
		INSERT INTO #TMP_ITM VALUES (@ITM_REMAIN)
END

set @optLNESTR='N'

--insert data into table if data exist
IF LTRIM(RTRIM(@PRDLNE_STRING))<>''
BEGIN
	SET @optLNESTR='Y'
	SET @LNE_REMAIN = @PRDLNE_STRING	
	WHILE CHARINDEX(',',@LNE_REMAIN)<> 0
	BEGIN
		SET @LNE_PART = LTRIM(LEFT(@LNE_REMAIN,CHARINDEX(',',@LNE_REMAIN)-1))
		SET @LNE_REMAIN = RIGHT(@LNE_REMAIN,LEN(@LNE_REMAIN)-CHARINDEX(',',@LNE_REMAIN))
		INSERT INTO #TMP_LNE VALUES (@LNE_PART)
	END
	INSERT INTO #TMP_LNE VALUES (@LNE_REMAIN)
END

--SELECT * FROM #TMP_LNE
--SELECT * FROM #TMP_ITM
-------------------------------------------

SELECT 
	'LN' = LTRIM(RTRIM(IBI_LNECDE)), 
	'CATLVL0' = IBI_CATLVL0, 
	'CATLVL1' = IBI_CATLVL1, 
	'CATLVL2' = IBI_CATLVL2, 
	'CATLVL3' = IBI_CATLVL3, 
	'CATLVL4' = IBI_CATLVL4, 
	'ITM' = LTRIM(RTRIM(IBI_ITMNO)), 
	'VITM' = LTRIM(RTRIM(IVI_VENITM)),
	'DSC' = LTRIM(RTRIM(IBI_ENGDSC)), 
	'IMGPATH' = IBI_IMGPTH
--,
--	'VTYP' = BB.VBI_VENTYP, 
--	'DVENNO' = IBI_VENNO,
--	'DVENSNA' = BB.VBI_VENSNA,
--	'PVENNO' = AA.VBI_VENNO,
--	'PVENSNA' = AA.VBI_VENSNA
INTO 
	#LN
FROM 
	IMBASINF (NOLOCK) 
	LEFT JOIN IMVENINF (NOLOCK) ON 
		IVI_ITMNO = IBI_ITMNO AND 
		IVI_DEF = 'Y'
--	LEFT JOIN VNBASINF AA (NOLOCK) ON 
--		AA.VBI_VENNO = IVI_VENNO
--	LEFT JOIN VNBASINF BB (NOLOCK) ON 
--		BB.VBI_VENNO = IBI_VENNO

--SELECT * FROM IMBASINF
--select * from imveninf
-- SELECT * FROM #LN WHERE VTYP IS NULL -- OR ITM = '021424-00016'
------------------------------------------------------------------------------------------------------------------------------------------------
-- Consolidate IM previous UCP & UCPP item no for scanning SC tx. ========> #LN_IM
--DROP TABLE #LN_VITM, #LN_IM
SELECT 
	* 
INTO 
	#LN_VITM 
FROM 
	#LN	
-- 226479
UPDATE 
	#LN_VITM 
SET 
	ITM = VITM 
	-- SELECT SUBSTRING (ITM, 3, 4), * FROM #LN_VITM 
WHERE 
	(LEFT (ITM, 2) BETWEEN '02' AND '03') AND 
	(SUBSTRING (ITM, 3, 4) BETWEEN '0005' AND '0009')	
-- 45165
SELECT 
	L = MAX(LN), 
	CL0 = MAX(CATLVL0), 
	CL1 = MAX(CATLVL1), 
	CL2 = MAX(CATLVL2), 
	CL3 = MAX(CATLVL3), 
	CL4 = MAX(CATLVL4), 
	ITM, 
	VITM,
	D = MAX(DSC), 
--	'VT' = VTYP, 
	IMG = MAX(IMGPATH)
--,
--	VTYP,
--	DVENNO,
--	DVENSNA,
--	PVENNO,
--	PVENSNA
INTO 
	#LN_IM 
FROM 
	#LN_VITM	-- 181786
GROUP BY 
	VITM, ITM
--,
--	VTYP,
--	DVENNO,
--	DVENSNA,
--	PVENNO,
--	PVENSNA


	--ITM
-- Validate the consolidated result
-- SELECT * FROM #LN_VITM ORDER BY ITM	-- 226479
-- SELECT * FROM #LN_IM ORDER BY ITM	-- 181786

------------------------------------------------------------------------------------------------------------------------------------------------
-- Extract SC Details info =======> #SOD
--DROP TABLE #SOD
SELECT 
	'ITMSC' = SOD_ITMNO, 
--	'COLCDE' = SOD_COLCDE,
--	'COLDSC' = SOD_COLDSC,
	'CO' = SOD_COCDE, 
	'XDTE' = CONVERT (CHAR(10), SOH_ISSDAT, 111),
	'VN' = SOD_VENNO, 
	'VNSUB' = SOD_SUBCDE, 
	'PCKUNT' = SOD_PCKUNT, 
	'ORDQTY' = SOD_ORDQTY, 
	'PCQTY' = SOD_ORDQTY,
	'PCFLG' = 'N',
	'CUR' = SOD_CURCDE, 
	'ORDAMT' = SOD_SELPRC, 
	'USAMT' = 0,
	--Frankie Cheung 20091006
	'CUREXRAT' = soh_curexrat
INTO 
	#SOD
FROM 
	SCORDDTL (NOLOCK) 
	LEFT JOIN SCORDHDR (NOLOCK) ON 
		SOD_COCDE = SOH_COCDE AND 
		SOD_ORDNO = SOH_ORDNO
WHERE  
--	(SOD_COCDE = 'UCPP' OR (SOD_COCDE = 'UCP' AND SOD_VENNO BETWEEN '0005' AND '0009')) 
--AND 
	SOH_ISSDAT  BETWEEN @STARTDATE AND @ENDDATE

-- SELECT * FROM #SOD		-- 44319
-- SELECT COUNT(1)  FROM #SOD

-- Convert to 'PC' Unit if necessary. 
UPDATE 
	#SOD 
SET 
	PCQTY = ORDQTY * YCF_VALUE,
	PCFLG = 'Y'
FROM 
	#SOD		-- 44036
	LEFT JOIN SYCONFTR (NOLOCK) ON 
		YCF_CODE1 = PCKUNT AND 
		YCF_CODE2 = 'PC'
WHERE 
	YCF_CODE1 IS NOT NULL	

/*
SELECT * FROM SYCONFTR 
SELECT * FROM #SOD
WHERE PCKUNT NOT IN ('PC', 'BG1', 'BX1', 'CD1') AND ORDQTY = PCQTY AND ORDQTY <> 0
*/

-- Convert to 'USD' currency if necessary.
UPDATE 
	#SOD 
SET 
--	USAMT = ORDAMT * YSI_SELRAT 
	--Frankie Cheung 20091006
	USAMT =case CUREXRAT when 0 then 0 else (ORDAMT / CUREXRAT) end 
FROM 
	#SOD		-- 9687
	LEFT JOIN SYSETINF (NOLOCK) ON 
		YSI_TYP = '06' AND 
		YSI_CDE = CUR
WHERE 
--Frankie Cheung 20091006
--	CUR = 'HKD' AND 
	YSI_TYP IS NOT NULL



--Frankie Cheung 20091006
/*
UPDATE 
	#SOD 
SET 
	USAMT = ORDAMT 
FROM 
	#SOD 
WHERE 
	CUR = 'USD' 	-- 34632
*/

/*
SELECT COUNT(1) FROM #SOD 
SELECT * FROM #SOD 
WHERE USAMT = 0 AND ORDAMT <> 0
SELECT * FROM SYSETINF WHERE YSI_TYP = '06'
*/

------------------------------------------------------------------------------------------------------------------------------------------------
-- Unique SC Item info =======> #SOD_1
--DROP TABLE #SOD_VITM
SELECT 
	* 
INTO 
	#SOD_VITM 
FROM 
	#SOD	-- 44319

-- SELECT * FROM #SOD_VITM
UPDATE 
	#SOD_VITM 
SET 
	ITMSC = VITM 
FROM 
	#SOD_VITM	-- 6062
	LEFT JOIN #LN ON 
		ITM = ITMSC
WHERE 
	(LEFT (ITMSC, 2) BETWEEN '02' AND '03') AND 
	(SUBSTRING (ITMSC, 3, 4) BETWEEN '0005' AND '0009')AND 
	ITM IS NOT NULL
/*
DROP TABLE #SOD_1
SELECT DISTINCT ITMSC, CO, VN, VNSUB, 'ORD_PC_QTY' = SUM(PCQTY), 'ORD_US_AMT' = SUM(USAMT) INTO #SOD_1 FROM #SOD_VITM		-- 13622
WHERE USAMT <> 0 AND PCQTY <> 0
GROUP BY ITMSC, CO, VN, VNSUB
*/

--DROP TABLE #SOD_1A
SELECT 
	DISTINCT VN, -- include VN (vendor code in select ' 2003/11/21
	ITMSC, 
	PCFLG,
	PCKUNT,
--	COLCDE,
--	COLDSC,
	'TOTAL ORDER PC QTY' = SUM(PCQTY), 
	'TOTAL ORDER US AMT' = SUM(USAMT) 
INTO 
	#SOD_1A 
FROM 
	#SOD_VITM	-- 12634
WHERE 
	USAMT <> 0 AND 
	PCQTY <> 0
GROUP BY 
	VN,
	ITMSC,
	PCFLG,
	PCKUNT
--,
--	COLCDE,
--	COLDSC

/*
SELECT * FROM #SOD_1A 
WHERE ITMSC = 'FDC/7112/3BC'
-- WHERE PCKUNT NOT IN ('PC', 'BG1', 'BX1', 'CD1') 
*/

--DROP TABLE #SOD_LN
SELECT 
	*
INTO 
	#SOD_LN
FROM 
	#SOD_1A
	LEFT JOIN #LN_IM ON 
	ITMSC = ITM -- AND LEN (LTRIM(RTRIM(LN))) > 0	-- 12634

/*
-- Audit duplication of ITMSC
SELECT DISTINCT ITMSC FROM #SOD_LN

-- Audit w/o Product Line / Category info
SELECT * FROM #SOD_LN WHERE ITM IS NULL
ORDER BY [TOTAL ORDER US AMT] DESC, ITM

-- Output final results
SELECT * FROM #SOD_LN		-- 12632
ORDER BY [TOTAL ORDER US AMT] DESC, ITM

SELECT COUNT(1) FROM #SOD_LN	-- 12632

SELECT [TOTAL QTY] = SUM([TOTAL ORDER PC QTY]),  [TOTAL AMT] = SUM([TOTAL ORDER US AMT]) FROM #SOD_LN		-- 12632

*/
--IF (@IMAGEONLY = 1)
--DELETE FROM #SOD_LN WHERE IMG = ''

CREATE TABLE #BSI_RESULT(
	------2003/11/21----------------
	VN			NVARCHAR(20),
	-----------------------------------
	VITM			nvarchar(20),
	[TOTAL ORDER PC QTY]	int, 
	[TOTAL ORDER US AMT]	int, 
	L			nvarchar(10), 
	CL0			nvarchar(20), 
	CL1			nvarchar(20), 	
	CL2			nvarchar(20), 
	CL3			nvarchar(20), 
	CL4			nvarchar(20), 
	DSG			nvarchar(200),	--Designer
	D			nvarchar(800), 
	ven_typ			nvarchar(20), 
	IMG			nvarchar(200),
	DVENNO 			nvarchar(20),
	DVNSENSNA		nvarchar(20),
	PVENNO			nvarchar(20),
	PVNSENSNA		nvarchar(20),
	CL4DESC			nvarchar(200),
	PCFLG			CHAR(1),
	PCKUNT			NVARCHAR(6)
--,
--	COLCDE			NVARCHAR(30),
--	COLDSC			NVARCHAR(300)
)



SELECT 
--	ITM, 
	' ' as 'VN',
	VITM,
	sum([TOTAL ORDER PC QTY]) as 'TOTAL ORDER PC QTY', 
	sum([TOTAL ORDER US AMT]) as 'TOTAL ORDER US AMT', 
	L, 
	CL0, 
	CL1, 
	CL2, 
	CL3, 
	CL4,
	case isnull(YLI_DSGCDE,'') when '' then ''
				   when null then ''
				   else isnull(YLI_DSGCDE,'') + ' - ' + isnull(YSI_DSC, '') end 'DSG', 
--	isnull(YLI_DSGCDE, '') 'DSG',
	D, 
	case AA.VBI_VENTYP when 'J' then 'Joint-Venture'
		when 'I' then 'Internal'
		when 'E' then 'External'
		else ''
	end as 'ven_typ', 
	IMG,
	'DVENNO' = IBI_VENNO,
	'DVNSENSNA' = AA.VBI_VENSNA,
	'PVENNO' =  IVI_VENNO,
	'PVNSENSNA' = BB.VBI_VENSNA,
	'CL4DESC' = SY.YCC_CATDSC,
	PCFLG,
	'PC' as 'PCKUNT' 	--	PCKUNT

--,
--	COLCDE,
--	COLDSC
INTO	
	#RESULT
FROM 
	#SOD_LN		-- 12632
	LEFT JOIN IMBASINF (NOLOCK) ON IBI_ITMNO = VITM
	LEFT JOIN VNBASINF AA (NOLOCK) ON AA.VBI_VENNO = IBI_VENNO 
	LEFT JOIN IMVENINF (NOLOCK) ON IVI_ITMNO = VITM AND IVI_DEF = 'Y'
	LEFT JOIN VNBASINF BB (NOLOCK) ON BB.VBI_VENNO = IVI_VENNO
	LEFT JOIN SYCATCDE SY (NOLOCK) ON SY.YCC_CATCDE = CL4 AND SY.YCC_LEVEL = '4'
---------2003/11/19------------
	LEFT JOIN #TMP_ITM (NOLOCK) ON tmp_ITMNO = VITM
	LEFT JOIN #TMP_LNE (NOLOCK) ON tmp_PRDLNE = L
-----------------------------------
	LEFT JOIN SYLNEINF (NOLOCK) ON L = YLI_LNECDE
	LEFT JOIN SYSETINF (NOLOCK) ON YSI_TYP = '15' and YLI_DSGCDE = YSI_CDE

WHERE
	(CL0 >= @CL0_FM AND CL0 <= @CL0_TO)
	AND (CL1 >= @CL1_FM AND CL1 <= @CL1_TO)
	AND (CL2 >= @CL2_FM AND CL2 <= @CL2_TO)
	AND (CL3 >= @CL3_FM AND CL3 <= @CL3_TO)
	AND (CL4 >= @CL4_FM AND CL4 <= @CL4_TO)
	AND ((@OPT_DSG = 'N') OR (YLI_DSGCDE >= @DSG_FM AND YLI_DSGCDE <= @DSG_TO))
--	AND ITM BETWEEN @ITM_FM AND @ITM_TO 
--------2003/11/19--------------
--	AND VITM BETWEEN @ITM_FM AND @ITM_TO
--	AND L BETWEEN @PRDLNE_FR AND @PRDLNE_TO
	AND ((@optITMSTR='N' AND VITM BETWEEN @ITM_FM AND @ITM_TO ) OR (@optITMSTR='Y' AND tmp_ITMNO IS NOT NULL))
	AND ((@optLNESTR='N' AND L BETWEEN @PRDLNE_FR AND @PRDLNE_TO) OR (@optLNESTR='Y' AND tmp_PRDLNE IS NOT NULL ))
	AND IBI_VENNO BETWEEN @VN_FM AND @VN_TO
-----------------------------------		
--ORDER BY
--	 [TOTAL ORDER US AMT] DESC, VITM
group by VITM,	L, 	CL0, 	CL1, 	CL2, 	CL3, 	CL4,	YLI_DSGCDE, YSI_DSC,	D, AA.VBI_VENTYP,IMG,	IBI_VENNO,	AA.VBI_VENSNA,	IVI_VENNO,	BB.VBI_VENSNA,	SY.YCC_CATDSC,	PCFLG

declare	@INPUT_VN_FM		nvarchar(20),
	@INPUT_VN_TO		nvarchar(20),
	@INPUT_ITM_FM		nvarchar(20),
	@INPUT_ITM_TO		nvarchar(20),
	@INPUT_PRDLNE_FR	nvarchar(10),
	@INPUT_PRDLNE_TO	nvarchar(10),
	@INPUT_CL0_FM		nvarchar(20),
	@INPUT_CL0_TO		nvarchar(20),
	@INPUT_CL1_FM		nvarchar(20),
	@INPUT_CL1_TO		nvarchar(20),
	@INPUT_CL2_FM		nvarchar(20),
	@INPUT_CL2_TO		nvarchar(20),
	@INPUT_CL3_FM		nvarchar(20),
	@INPUT_CL3_TO		nvarchar(20),
	@INPUT_CL4_FM		nvarchar(20),
	@INPUT_CL4_TO		nvarchar(20),
	@INPUT_DSG_FM		nvarchar(200),
	@INPUT_DSG_TO		nvarchar(200),
	@INPUT_NUMOFREC		nvarchar(20),
	@INPUT_NUMOFTOPPRDLNE	nvarchar(20),
	@INPUT_ORDERBY		nvarchar(20),
	@INPUT_PRINTAMOUNT	nvarchar(20),
	@INPUT_STARTDATE 	nvarchar(50),
	@INPUT_ENDDATE		nvarchar(50)


select @INPUT_VN_FM = @VN_FM
select @INPUT_VN_TO = @VN_TO
select @INPUT_ITM_FM = @ITM_FM
select @INPUT_ITM_TO = @ITM_TO
select @INPUT_PRDLNE_FR	= @PRDLNE_FR
select @INPUT_PRDLNE_TO = @PRDLNE_TO
select @INPUT_CL0_FM = @CL0_FM
select @INPUT_CL0_TO = @CL0_TO
select @INPUT_CL1_FM = @CL1_FM
select @INPUT_CL1_TO = @CL1_TO
select @INPUT_CL2_FM = @CL2_FM
select @INPUT_CL2_TO = @CL2_TO
select @INPUT_CL3_FM = @CL3_FM
select @INPUT_CL3_TO = @CL3_TO
select @INPUT_CL4_FM = @CL4_FM
select @INPUT_CL4_TO = @CL4_TO

select @INPUT_DSG_FM = isnull(ysi_dsc, '') from SYSETINF (nolock) where ysi_typ = '15' and ysi_cde = @DSG_FM
if @INPUT_DSG_FM = '' or @INPUT_DSG_FM is null
	select @INPUT_DSG_FM = @DSG_FM
else
	select @INPUT_DSG_FM = @DSG_FM + ' - ' + @INPUT_DSG_FM

select @INPUT_DSG_TO = isnull(ysi_dsc, '') from SYSETINF (nolock) where ysi_typ = '15' and ysi_cde = @DSG_TO
if @INPUT_DSG_TO = '' or @INPUT_DSG_TO is null
	select @INPUT_DSG_TO = @DSG_TO
else
	select @INPUT_DSG_TO = @DSG_TO + ' - ' + @INPUT_DSG_TO

select @INPUT_NUMOFREC = @NUMOFREC
select @INPUT_NUMOFTOPPRDLNE = @NUMOFTOPPRDLNE
select @INPUT_ORDERBY = @ORDERBY
select @INPUT_PRINTAMOUNT = @PRINTAMOUNT
select @INPUT_STARTDATE = convert(nvarchar(50), @STARTDATE, 101)
select @INPUT_ENDDATE = convert(nvarchar(50), @ENDDATE, 101)


if @INPUT_VN_FM = '00000000000000000000'
	select @INPUT_VN_FM = 'All'
if @INPUT_VN_TO = 'ZZZZZZZZZZZZZZZZZZZZ'
	select @INPUT_VN_TO = 'All'

if @INPUT_ITM_FM = '00000000000000000000'
	select @INPUT_ITM_FM = 'All'
if @INPUT_ITM_TO = 'ZZZZZZZZZZZZZZZZZZZZ'
	select @INPUT_ITM_TO = 'All'
if @INPUT_PRDLNE_FR = '0000000000'
	select @INPUT_PRDLNE_FR = 'All'
if @INPUT_PRDLNE_TO = 'ZZZZZZZZZZ'
	select @INPUT_PRDLNE_TO = 'All'
if @INPUT_CL0_FM = '00000000000000000000'
	select @INPUT_CL0_FM = 'All'
if @INPUT_CL0_TO = 'ZZZZZZZZZZZZZZZZZZZZ'
	select @INPUT_CL0_TO = 'All'
if @INPUT_CL1_FM = '00000000000000000000'
	select @INPUT_CL1_FM = 'All'
if @INPUT_CL1_TO = 'ZZZZZZZZZZZZZZZZZZZZ'
	select @INPUT_CL1_TO = 'All'
if @INPUT_CL2_FM = '00000000000000000000'
	select @INPUT_CL2_FM = 'All'
if @INPUT_CL2_TO = 'ZZZZZZZZZZZZZZZZZZZZ'
	select @INPUT_CL2_TO = 'All'
if @INPUT_CL3_FM = '00000000000000000000'
	select @INPUT_CL3_FM = 'All'
if @INPUT_CL3_TO = 'ZZZZZZZZZZZZZZZZZZZZ'
	select @INPUT_CL3_TO = 'All'
if @INPUT_CL4_FM = '00000000000000000000'
	select @INPUT_CL4_FM = 'All'
if @INPUT_CL4_TO = 'ZZZZZZZZZZZZZZZZZZZZ'
	select @INPUT_CL4_TO = 'All'
if @INPUT_DSG_FM = '00000000000000000000'
	select @INPUT_DSG_FM = 'All'
if @INPUT_DSG_TO = 'ZZZZZZZZZZZZZZZZZZZZ'
	select @INPUT_DSG_TO = 'All'
if @INPUT_ORDERBY = 'Q'
	select @INPUT_ORDERBY = 'Quantity'
else
	select @INPUT_ORDERBY = 'Amount'
if @INPUT_NUMOFREC = '0'
	select @INPUT_NUMOFREC = 'All'
if @INPUT_NUMOFTOPPRDLNE = '0'
	select @INPUT_NUMOFTOPPRDLNE = 'All'
if @INPUT_STARTDATE = '01/01/1980 00:00:00.000'
	select @INPUT_STARTDATE = 'All'
if @INPUT_ENDDATE = '12/31/2049 23:59:59.999'
	select @INPUT_ENDDATE = 'All'




IF (@NUMOFTOPPRDLNE > 0) 
BEGIN
	IF (@ORDERBY = 'Q')
	BEGIN
		declare @prdlineqty nvarchar(20)

		SET ROWCOUNT @NUMOFTOPPRDLNE
		select L, sum([TOTAL ORDER PC QTY]) 'TOTAL QTY'
		INTO #TOPPRDLINEQTY
		from #RESULT 
		group by L
		order by sum([TOTAL ORDER PC QTY]) desc
		SET ROWCOUNT 0

		DECLARE prdlineqty_cursor CURSOR FOR select L FROM #TOPPRDLINEQTY

		OPEN prdlineqty_cursor

		FETCH NEXT FROM prdlineqty_cursor INTO @prdlineqty

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET ROWCOUNT @NUMOFREC
			
			insert into #BSI_RESULT 
			select * from #RESULT
			where L = @prdlineqty
			order by [TOTAL ORDER PC QTY] desc
   
			SET ROWCOUNT 0
			FETCH NEXT FROM prdlineqty_cursor INTO @prdlineqty
		END

		CLOSE prdlineqty_cursor
		DEALLOCATE prdlineqty_cursor

		if ((@INPUT_CL0_FM <> 'All' or @INPUT_CL0_TO <> 'All' 
			or @INPUT_CL1_FM <> 'All' or @INPUT_CL1_TO <> 'All'
			or @INPUT_CL2_FM <> 'All' or @INPUT_CL2_TO <> 'All'
			or @INPUT_CL3_FM <> 'All' or @INPUT_CL3_TO <> 'All'
			or @INPUT_CL4_FM <> 'All' or @INPUT_CL4_TO <> 'All')
		     and
		     (@INPUT_PRDLNE_FR = 'All' and @INPUT_PRDLNE_TO = 'All'))
		begin
			select 	@INPUT_VN_FM 'VN_FM',
				@INPUT_VN_TO 'VN_TO',
				@INPUT_ITM_FM 'ITM_FM',
				@INPUT_ITM_TO 'ITM_TO',
				@ITM_STRING 'ITM_STR',
				@INPUT_PRDLNE_FR 'PRDLNE_FR',
				@INPUT_PRDLNE_TO 'PRDLNE_TO',
				@PRDLNE_STRING 'PRDLNE_STR',
				@INPUT_CL0_FM 'CL0_FM',
				@INPUT_CL0_TO 'CL0_TO',
				@INPUT_CL1_FM 'CL1_FM',
				@INPUT_CL1_TO 'CL1_TO',
				@INPUT_CL2_FM 'CL2_FM',
				@INPUT_CL2_TO 'CL2_TO',
				@INPUT_CL3_FM 'CL3_FM',
				@INPUT_CL3_TO 'CL3_TO',
				@INPUT_CL4_FM 'CL4_FM',
				@INPUT_CL4_TO 'CL4_TO',
				@INPUT_DSG_FM 'DSG_FM',
				@INPUT_DSG_TO 'DSG_TO',
				@INPUT_NUMOFREC 'NUMOFREC',
				@INPUT_NUMOFTOPPRDLNE 'NUMOFTOPPRDLNE',
				@INPUT_ORDERBY 'ORDERBY',
				@INPUT_PRINTAMOUNT 'PRINTAMOUNT',
				@INPUT_STARTDATE 'STARTDATE',
				@INPUT_ENDDATE 'ENDDATE',
				*
				,@compName as 'compName'
			from #BSI_RESULT 
			order by CL4, [TOTAL ORDER PC QTY] desc 
		end
		else 
		begin
			select 	@INPUT_VN_FM 'VN_FM',
				@INPUT_VN_TO 'VN_TO',
				@INPUT_ITM_FM 'ITM_FM',
				@INPUT_ITM_TO 'ITM_TO',
				@ITM_STRING 'ITM_STR',
				@INPUT_PRDLNE_FR 'PRDLNE_FR',
				@INPUT_PRDLNE_TO 'PRDLNE_TO',
				@PRDLNE_STRING 'PRDLNE_STR',
				@INPUT_CL0_FM 'CL0_FM',
				@INPUT_CL0_TO 'CL0_TO',
				@INPUT_CL1_FM 'CL1_FM',
				@INPUT_CL1_TO 'CL1_TO',
				@INPUT_CL2_FM 'CL2_FM',
				@INPUT_CL2_TO 'CL2_TO',
				@INPUT_CL3_FM 'CL3_FM',
				@INPUT_CL3_TO 'CL3_TO',
				@INPUT_CL4_FM 'CL4_FM',
				@INPUT_CL4_TO 'CL4_TO',
				@INPUT_DSG_FM 'DSG_FM',
				@INPUT_DSG_TO 'DSG_TO',
				@INPUT_NUMOFREC 'NUMOFREC',
				@INPUT_NUMOFTOPPRDLNE 'NUMOFTOPPRDLNE',
				@INPUT_ORDERBY 'ORDERBY',
				@INPUT_PRINTAMOUNT 'PRINTAMOUNT',
				@INPUT_STARTDATE 'STARTDATE',
				@INPUT_ENDDATE 'ENDDATE',
				*
				,@compName as 'compName'
			from #BSI_RESULT 
			order by L, [TOTAL ORDER PC QTY] desc 
		end
	END
	ELSE
	BEGIN
		declare @prdlineamt nvarchar(20)

		SET ROWCOUNT @NUMOFTOPPRDLNE
		select L, sum([TOTAL ORDER US AMT]) 'TOTAL AMT'
		INTO #TOPPRDLINEAMT
		from #RESULT
		group by L
		order by sum([TOTAL ORDER US AMT]) desc
		SET ROWCOUNT 0

		DECLARE prdlineamt_cursor CURSOR FOR select L FROM #TOPPRDLINEAMT

		OPEN prdlineamt_cursor

		FETCH NEXT FROM prdlineamt_cursor INTO @prdlineamt

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET ROWCOUNT @NUMOFREC

			insert into #BSI_RESULT 
			select * from #RESULT
			where L = @prdlineamt
			order by [TOTAL ORDER US AMT] desc
  
			SET ROWCOUNT 0
			FETCH NEXT FROM prdlineamt_cursor INTO @prdlineamt
		END

		CLOSE prdlineamt_cursor
		DEALLOCATE prdlineamt_cursor

		if ((@INPUT_CL0_FM <> 'All' or @INPUT_CL0_TO <> 'All' 
			or @INPUT_CL1_FM <> 'All' or @INPUT_CL1_TO <> 'All'
			or @INPUT_CL2_FM <> 'All' or @INPUT_CL2_TO <> 'All'
			or @INPUT_CL3_FM <> 'All' or @INPUT_CL3_TO <> 'All'
			or @INPUT_CL4_FM <> 'All' or @INPUT_CL4_TO <> 'All')
		     and
		     (@INPUT_PRDLNE_FR = 'All' and @INPUT_PRDLNE_TO = 'All'))
		begin
			select 	@INPUT_VN_FM 'VN_FM',
				@INPUT_VN_TO 'VN_TO',
				@INPUT_ITM_FM 'ITM_FM',
				@INPUT_ITM_TO 'ITM_TO',
				@ITM_STRING 'ITM_STR',
				@INPUT_PRDLNE_FR 'PRDLNE_FR',
				@INPUT_PRDLNE_TO 'PRDLNE_TO',
				@PRDLNE_STRING 'PRDLNE_STR',
				@INPUT_CL0_FM 'CL0_FM',
				@INPUT_CL0_TO 'CL0_TO',
				@INPUT_CL1_FM 'CL1_FM',
				@INPUT_CL1_TO 'CL1_TO',
				@INPUT_CL2_FM 'CL2_FM',
				@INPUT_CL2_TO 'CL2_TO',
				@INPUT_CL3_FM 'CL3_FM',
				@INPUT_CL3_TO 'CL3_TO',
				@INPUT_CL4_FM 'CL4_FM',
				@INPUT_CL4_TO 'CL4_TO',
				@INPUT_DSG_FM 'DSG_FM',
				@INPUT_DSG_TO 'DSG_TO',
				@INPUT_NUMOFREC 'NUMOFREC',
				@INPUT_NUMOFTOPPRDLNE 'NUMOFTOPPRDLNE',
				@INPUT_ORDERBY 'ORDERBY',
				@INPUT_PRINTAMOUNT 'PRINTAMOUNT',
				@INPUT_STARTDATE 'STARTDATE',
				@INPUT_ENDDATE 'ENDDATE',
				*
				,@compName as 'compName'
			from #BSI_RESULT 
			order by CL4, [TOTAL ORDER US AMT] desc 
		end
		else
		begin
			select 	@INPUT_VN_FM 'VN_FM',
				@INPUT_VN_TO 'VN_TO',
				@INPUT_ITM_FM 'ITM_FM',
				@INPUT_ITM_TO 'ITM_TO',
				@ITM_STRING 'ITM_STR',
				@INPUT_PRDLNE_FR 'PRDLNE_FR',
				@INPUT_PRDLNE_TO 'PRDLNE_TO',
				@PRDLNE_STRING 'PRDLNE_STR',
				@INPUT_CL0_FM 'CL0_FM',
				@INPUT_CL0_TO 'CL0_TO',
				@INPUT_CL1_FM 'CL1_FM',
				@INPUT_CL1_TO 'CL1_TO',
				@INPUT_CL2_FM 'CL2_FM',
				@INPUT_CL2_TO 'CL2_TO',
				@INPUT_CL3_FM 'CL3_FM',
				@INPUT_CL3_TO 'CL3_TO',
				@INPUT_CL4_FM 'CL4_FM',
				@INPUT_CL4_TO 'CL4_TO',
				@INPUT_DSG_FM 'DSG_FM',
				@INPUT_DSG_TO 'DSG_TO',
				@INPUT_NUMOFREC 'NUMOFREC',
				@INPUT_NUMOFTOPPRDLNE 'NUMOFTOPPRDLNE',
				@INPUT_ORDERBY 'ORDERBY',
				@INPUT_PRINTAMOUNT 'PRINTAMOUNT',
				@INPUT_STARTDATE 'STARTDATE',
				@INPUT_ENDDATE 'ENDDATE',
				*
				,@compName as 'compName'	
			from #BSI_RESULT 
			order by L, [TOTAL ORDER US AMT] desc 
		end
	END
END
ELSE
BEGIN

	SET ROWCOUNT @NUMOFREC
	IF (@ORDERBY = 'Q')
	BEGIN
		if ((@INPUT_CL0_FM <> 'All' or @INPUT_CL0_TO <> 'All' 
			or @INPUT_CL1_FM <> 'All' or @INPUT_CL1_TO <> 'All'
			or @INPUT_CL2_FM <> 'All' or @INPUT_CL2_TO <> 'All'
			or @INPUT_CL3_FM <> 'All' or @INPUT_CL3_TO <> 'All'
			or @INPUT_CL4_FM <> 'All' or @INPUT_CL4_TO <> 'All')
		     and
		     (@INPUT_PRDLNE_FR = 'All' and @INPUT_PRDLNE_TO = 'All'))
		begin
			select 	@INPUT_VN_FM 'VN_FM',
				@INPUT_VN_TO 'VN_TO',
				@INPUT_ITM_FM 'ITM_FM',
				@INPUT_ITM_TO 'ITM_TO',
				@ITM_STRING 'ITM_STR',
				@INPUT_PRDLNE_FR 'PRDLNE_FR',
				@INPUT_PRDLNE_TO 'PRDLNE_TO',
				@PRDLNE_STRING 'PRDLNE_STR',
				@INPUT_CL0_FM 'CL0_FM',
				@INPUT_CL0_TO 'CL0_TO',
				@INPUT_CL1_FM 'CL1_FM',
				@INPUT_CL1_TO 'CL1_TO',
				@INPUT_CL2_FM 'CL2_FM',
				@INPUT_CL2_TO 'CL2_TO',
				@INPUT_CL3_FM 'CL3_FM',
				@INPUT_CL3_TO 'CL3_TO',
				@INPUT_CL4_FM 'CL4_FM',
				@INPUT_CL4_TO 'CL4_TO',
				@INPUT_DSG_FM 'DSG_FM',
				@INPUT_DSG_TO 'DSG_TO',
				@INPUT_NUMOFREC 'NUMOFREC',
				@INPUT_NUMOFTOPPRDLNE 'NUMOFTOPPRDLNE',
				@INPUT_ORDERBY 'ORDERBY',
				@INPUT_PRINTAMOUNT 'PRINTAMOUNT',
				@INPUT_STARTDATE 'STARTDATE',
				@INPUT_ENDDATE 'ENDDATE',
				*
				,@compName as 'compName'
			from #RESULT
			order by CL4, [TOTAL ORDER PC QTY] DESC, VITM
		end
		else
		begin
			select 	@INPUT_VN_FM 'VN_FM',
				@INPUT_VN_TO 'VN_TO',
				@INPUT_ITM_FM 'ITM_FM',
				@INPUT_ITM_TO 'ITM_TO',
				@ITM_STRING 'ITM_STR',
				@INPUT_PRDLNE_FR 'PRDLNE_FR',
				@INPUT_PRDLNE_TO 'PRDLNE_TO',
				@PRDLNE_STRING 'PRDLNE_STR',
				@INPUT_CL0_FM 'CL0_FM',
				@INPUT_CL0_TO 'CL0_TO',
				@INPUT_CL1_FM 'CL1_FM',
				@INPUT_CL1_TO 'CL1_TO',
				@INPUT_CL2_FM 'CL2_FM',
				@INPUT_CL2_TO 'CL2_TO',
				@INPUT_CL3_FM 'CL3_FM',
				@INPUT_CL3_TO 'CL3_TO',
				@INPUT_CL4_FM 'CL4_FM',
				@INPUT_CL4_TO 'CL4_TO',
				@INPUT_DSG_FM 'DSG_FM',
				@INPUT_DSG_TO 'DSG_TO',
				@INPUT_NUMOFREC 'NUMOFREC',
				@INPUT_NUMOFTOPPRDLNE 'NUMOFTOPPRDLNE',
				@INPUT_ORDERBY 'ORDERBY',
				@INPUT_PRINTAMOUNT 'PRINTAMOUNT',
				@INPUT_STARTDATE 'STARTDATE',
				@INPUT_ENDDATE 'ENDDATE',
				*
				,@compName as 'compName'
			from #RESULT
			order by [TOTAL ORDER PC QTY] DESC, VITM
		end
	END
	ELSE
	BEGIN
		if ((@INPUT_CL0_FM <> 'All' or @INPUT_CL0_TO <> 'All' 
			or @INPUT_CL1_FM <> 'All' or @INPUT_CL1_TO <> 'All'
			or @INPUT_CL2_FM <> 'All' or @INPUT_CL2_TO <> 'All'
			or @INPUT_CL3_FM <> 'All' or @INPUT_CL3_TO <> 'All'
			or @INPUT_CL4_FM <> 'All' or @INPUT_CL4_TO <> 'All')
		     and
		     (@INPUT_PRDLNE_FR = 'All' and @INPUT_PRDLNE_TO = 'All'))
		begin
			select 	@INPUT_VN_FM 'VN_FM',
				@INPUT_VN_TO 'VN_TO',
				@INPUT_ITM_FM 'ITM_FM',
				@INPUT_ITM_TO 'ITM_TO',
				@ITM_STRING 'ITM_STR',
				@INPUT_PRDLNE_FR 'PRDLNE_FR',
				@INPUT_PRDLNE_TO 'PRDLNE_TO',
				@PRDLNE_STRING 'PRDLNE_STR',
				@INPUT_CL0_FM 'CL0_FM',
				@INPUT_CL0_TO 'CL0_TO',
				@INPUT_CL1_FM 'CL1_FM',
				@INPUT_CL1_TO 'CL1_TO',
				@INPUT_CL2_FM 'CL2_FM',
				@INPUT_CL2_TO 'CL2_TO',
				@INPUT_CL3_FM 'CL3_FM',
				@INPUT_CL3_TO 'CL3_TO',
				@INPUT_CL4_FM 'CL4_FM',
				@INPUT_CL4_TO 'CL4_TO',
				@INPUT_DSG_FM 'DSG_FM',
				@INPUT_DSG_TO 'DSG_TO',
				@INPUT_NUMOFREC 'NUMOFREC',
				@INPUT_NUMOFTOPPRDLNE 'NUMOFTOPPRDLNE',
				@INPUT_ORDERBY 'ORDERBY',
				@INPUT_PRINTAMOUNT 'PRINTAMOUNT',
				@INPUT_STARTDATE 'STARTDATE',
				@INPUT_ENDDATE 'ENDDATE',
				*
				,@compName as 'compName'
			from #RESULT
			order by CL4, [TOTAL ORDER US AMT] DESC, VITM
		end
		else
		begin
			select 	@INPUT_VN_FM 'VN_FM',
				@INPUT_VN_TO 'VN_TO',
				@INPUT_ITM_FM 'ITM_FM',
				@INPUT_ITM_TO 'ITM_TO',
				@ITM_STRING 'ITM_STR',
				@INPUT_PRDLNE_FR 'PRDLNE_FR',
				@INPUT_PRDLNE_TO 'PRDLNE_TO',
				@PRDLNE_STRING 'PRDLNE_STR',

				@INPUT_CL0_FM 'CL0_FM',
				@INPUT_CL0_TO 'CL0_TO',
				@INPUT_CL1_FM 'CL1_FM',
				@INPUT_CL1_TO 'CL1_TO',
				@INPUT_CL2_FM 'CL2_FM',
				@INPUT_CL2_TO 'CL2_TO',
				@INPUT_CL3_FM 'CL3_FM',
				@INPUT_CL3_TO 'CL3_TO',
				@INPUT_CL4_FM 'CL4_FM',
				@INPUT_CL4_TO 'CL4_TO',
				@INPUT_DSG_FM 'DSG_FM',
				@INPUT_DSG_TO 'DSG_TO',
				@INPUT_NUMOFREC 'NUMOFREC',
				@INPUT_NUMOFTOPPRDLNE 'NUMOFTOPPRDLNE',
				@INPUT_ORDERBY 'ORDERBY',
				@INPUT_PRINTAMOUNT 'PRINTAMOUNT',
				@INPUT_STARTDATE 'STARTDATE',
				@INPUT_ENDDATE 'ENDDATE',
				*
				,@compName as 'compName'
			from #RESULT
			order by [TOTAL ORDER US AMT] DESC, VITM
		end
	END
	SET ROWCOUNT 0

END

--drop table #BSI_RESULT
--SELECT * FROM #SOD_LN		
--ORDER BY
--	 [TOTAL ORDER US AMT] DESC, VITM

-- 12632

/******************** TABLE #SOD_LN
ITMSC 				nvarchar(20) 	not null
TOTAL ORDER PC QTY 		int 		null
TOTAL ORDER US AMT		int 		null
L				nvarchar(10)	null
CL2				nvarchar(20)	null
CL4				nvarchar(20)	null
ITM				nvarchar(20)	null
D				nvarchar(800)	null
VT				char(1)		null
IMG				nvarchar(200)	null

Excel File

Product Line		=	L
Item No.		=	ITMSC
Description		=	D
Total Order Qty		=	TOTAL ORDER PC QTY
Total Order Amount	= 	TOTAL ORDER US AMT
*********************/






GO
GRANT EXECUTE ON [dbo].[sp_list_BSP00001] TO [ERPUSER] AS [dbo]
GO
