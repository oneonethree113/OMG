/****** Object:  StoredProcedure [dbo].[sp_select_QCM00006]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCM00006]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCM00006]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_select_QCM00006]
	@cocde nvarchar(10),
	@pricustlist nvarchar(1000),
	@seccustlist nvarchar(1000), 
	@pvlist nvarchar(1000),
	@cvlist nvarchar(1000),
	@falist nvarchar(1000),	
	@scnolist nvarchar(1000),
	@ponolist nvarchar(1000),
	@custpolist nvarchar(1000),
	--@itemlist nvarchar(1000),
	@scshipdatefrom datetime,
	@scshipdateto datetime,
	@poshipdatefrom datetime,
	@poshipdateto datetime, 
	
	@usrid nvarchar(30) --Check What PO this user can view

AS
BEGIN
	SET NOCOUNT ON
	
	CREATE table #TEMP_INIT(tmp_init nvarchar(1000)) on [PRIMARY]
	CREATE table #TEMP_INIT2(tmp_init nvarchar(50)) on [PRIMARY]

	CREATE table #TEMP_CUS1NO(tmp_cus1no nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_CUS2NO(tmp_cus2no nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_PV(tmp_venno nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_CV(tmp_venno nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_FA(tmp_examven nvarchar(50)) on [PRIMARY]	
	CREATE table #TEMP_SCNO(tmp_scno nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_PONO(tmp_pono nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_CUSTPO(tmp_custpo nvarchar(50)) on [PRIMARY]
	--CREATE table #TEMP_ITM(tmp_itmno nvarchar(50)) on [PRIMARY]
	
	DECLARE @token nvarchar(100)
	DECLARE @tmp_fm nvarchar(50)
	DECLARE @tmp_to nvarchar(50)
	
	DECLARE @flg_pricust char(1),
	@flg_seccust char(1),
	@flg_pv char(1),
	@flg_cv char(1),
	@flg_fa char(1),
	@flg_scno char(1),
	@flg_pono char(1),
	@flg_custpo char(1),
	--@flg_item char(1),
	
	@flg_scshipdate_fm char(1),
	@flg_scshipdate_to char(1),
	@flg_poshipdate_fm char(1),
	@flg_poshipdate_to char(1)
	

	

	SET @flg_pricust = 'N'
	SET @flg_seccust = 'N'
	SET @flg_pv = 'N'
	SET @flg_cv = 'N'
	SET @flg_fa = 'N'
	SET @flg_scno = 'N'
	SET @flg_pono = 'N'
	--SET @flg_item = 'N'
	SET @flg_custpo = 'N'

	
	
	if @scshipdatefrom = '01/01/1900'
		set @flg_scshipdate_fm = 'N'
	else 
		set @flg_scshipdate_fm = 'Y'
		
	if @scshipdateto = '01/01/2100'
		set @flg_scshipdate_to = 'N'
	else 
		set @flg_scshipdate_to = 'Y'
	
	if @poshipdatefrom = '01/01/1900'
		set @flg_poshipdate_fm = 'N'
	else 
		set @flg_poshipdate_fm = 'Y'
		
	if @poshipdateto = '01/01/2100'
		set @flg_poshipdate_to = 'N'
	else 
		set @flg_poshipdate_to = 'Y'
		

	
	--*** Insert Temp Table Start ***--
	--Pri Cust Start	
	IF ltrim(rtrim(@pricustlist)) <> ''
	BEGIN
		SET @flg_pricust = 'Y'
		--INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring("10000~10001, 50100, 2% ")
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@pricustlist)
		--SELECT * FROM #TEMP_INIT
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT cbi_cusno from CUBASINF WHERE cbi_cusno between @tmp_fm and @tmp_to and cbi_custyp = 'P'
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT cbi_cusno from CUBASINF WHERE cbi_cusno like @token and cbi_custyp = 'P'
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_CUS1NO SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * FROM #TEMP_CUS1NO
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END
	--Pri Cust End
	
	--Sec Cust Start
	IF ltrim(rtrim(@seccustlist)) <> ''
	BEGIN
		SET @flg_seccust = 'Y'
		--INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring("10000~10001, 50100, 2% ")
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@seccustlist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT cbi_cusno from CUBASINF WHERE cbi_cusno between @tmp_fm and @tmp_to and cbi_custyp = 'S'
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT cbi_cusno from CUBASINF WHERE cbi_cusno like @token and cbi_custyp = 'S'
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_CUS2NO SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * from #TEMP_CUS2NO
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
		--Sec Cust End
	END

	--PV Start
	IF ltrim(rtrim(@pvlist)) <> ''
	BEGIN
		SET @flg_pv = 'Y'
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@pvlist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT vbi_venno from VNBASINF WHERE vbi_venno between @tmp_fm and @tmp_to
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT vbi_venno from VNBASINF WHERE vbi_venno like @token
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_PV SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * from #TEMP_PV
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END	
	--PV End

	--CV Start
	IF ltrim(rtrim(@cvlist)) <> ''
	BEGIN
		SET @flg_cv = 'Y'
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@cvlist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT vbi_venno from VNBASINF WHERE vbi_venno between @tmp_fm and @tmp_to
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT vbi_venno from VNBASINF WHERE vbi_venno like @token
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_CV SELECT distinct tmp_init from #TEMP_INIT2
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END	
	--CV End	
	
	
	--FA Start
	IF ltrim(rtrim(@falist)) <> ''
	BEGIN
		SET @flg_fa = 'Y'
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@falist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT vbi_venno from VNBASINF WHERE vbi_venno between @tmp_fm and @tmp_to
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT vbi_venno from VNBASINF WHERE vbi_venno like @token
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_FA SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * from #TEMP_FA
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END	
	--FA End

	--SC No Start
	IF ltrim(rtrim(@scnolist)) <> ''
	BEGIN
		SET @flg_scno = 'Y'
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@scnolist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT poh_ordno from POORDHDR WHERE poh_ordno between @tmp_fm and @tmp_to
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT poh_ordno from POORDHDR WHERE poh_ordno like @token
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_SCNO SELECT distinct tmp_init from #TEMP_INIT2
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END	
	--SC No End
	
	--PO No Start
	IF ltrim(rtrim(@ponolist)) <> ''
	BEGIN
		SET @flg_pono = 'Y'
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@ponolist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT poh_purord from POORDHDR WHERE poh_purord between @tmp_fm and @tmp_to
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT poh_purord from POORDHDR WHERE poh_purord like @token
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_PONO SELECT distinct tmp_init from #TEMP_INIT2

		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END		
	--PO No End
	
	--Customer PO Start
	if ltrim(rtrim(@custpolist)) <> ''
	BEGIN
		SET @flg_custpo = 'Y'
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@custpolist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT distinct pod_cuspno from POORDDTL WHERE pod_cuspno between @tmp_fm and @tmp_to
				INSERT INTO #TEMP_INIT2 SELECT distinct poh_cuspno from POORDHDR WHERE poh_cuspno between @tmp_fm and @tmp_to
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT pod_cuspno from POORDDTL WHERE pod_cuspno like @token
				INSERT INTO #TEMP_INIT2 SELECT poh_cuspno from POORDHDR WHERE poh_cuspno like @token
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_CUSTPO SELECT distinct tmp_init from #TEMP_INIT2
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END
	--Customer PO End
	
	--Item Start
	-- IF ltrim(rtrim(@itemlist)) <> ''
	-- BEGIN
		-- SET @flg_item = 'Y'
		-- INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@itemlist)
		
		-- DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		-- OPEN C
		-- FETCH NEXT FROM C into @token
		
		-- WHILE @@FETCH_STATUS = 0 
		-- BEGIN
			-- if charindex('~', @token) <> 0
			-- BEGIN
				-- SET @tmp_fm = left(@token, charindex('~', @token)-1)
				-- SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				-- INSERT INTO #TEMP_INIT2 SELECT pod_itmno from POORDDTL WHERE pod_itmno between @tmp_fm and @tmp_to
			-- END
			-- else
			-- BEGIN
				-- INSERT INTO #TEMP_INIT2 SELECT pod_itmno from POORDDTL WHERE pod_itmno like @token
			-- END
			-- FETCH NEXT FROM C into @token
		-- END
		-- INSERT INTO #TEMP_ITM SELECT distinct tmp_init from #TEMP_INIT2
		
		-- CLOSE C
		-- DEALLOCATE C
		-- DELETE FROM #TEMP_INIT
		-- DELETE FROM #TEMP_INIT2
	-- END	
	--Item End

	--*** Insert Temp Table End ***--

	--*** Declare Result_ALL Start ***--
	DECLARE @TBL_ALL table(
		--key
		tmp_cocde nvarchar(6),
		tmp_qcno nvarchar(20),
		tmp_purord nvarchar(20),
		tmp_insptyp nvarchar(20),
		tmp_upddat datetime
		
		
		--tmp_venno nvarchar(6),
		
		--tmp_ordno nvarchar(20), --SC No
		--tmp_cuspno nvarchar(20), 
		--tmp_poshpstr datetime, --POHeader Ship Date
		--tmp_poshpend datetime,
		--tmp_scshpstr datetime,  --SCHeader Ship DAte
		--tmp_scshpend datetime		
	
	
	)
	
	INSERT INTO @TBL_ALL
	SELECT
		qch_cocde, 
		qch_qcno, 
		qpd_purord, 
		qch_insptyp, 
		qch_upddat
		
		--qch_venno, 
		
		--poh_ordno, 
		--poh_cuspno,
		--poh_shpstr,
		--poh_shpend, 
		--soh_shpstr, 
		--soh_shpend
	FROM QCREQHDR (nolock)
	INNER JOIN QCPORDTL (nolock)
		ON 	qch_cocde = qpd_cocde
		AND qch_qcno = qpd_qcno
	LEFT JOIN POORDHDR (nolock)
		ON qpd_cocde = poh_cocde
		AND qpd_purord = poh_purord
	LEFT JOIN SCORDHDR (nolock) 
		on soh_cocde = poh_cocde 
		and soh_ordno = poh_ordno	
	WHERE 
		qch_cocde = @cocde
	AND qch_qcsts = 'REL'
	AND qpd_del <> 'Y'
	AND ((@flg_pricust = 'N') OR (@flg_pricust = 'Y' and qch_prmcus in (select tmp_cus1no from #TEMP_CUS1NO)))
	AND ((@flg_seccust = 'N') OR (@flg_seccust = 'Y' and qch_seccus in (select tmp_cus2no from #TEMP_CUS2NO)))
	AND ((@flg_pv = 'N') OR ( @flg_pv = 'Y' and qch_venno in (select tmp_venno from #TEMP_PV)))
	AND ((@flg_cv = 'N') OR ( @flg_cv = 'Y' and qch_venno in (select tmp_venno from #TEMP_CV)))	
	AND ((@flg_fa = 'N') OR ( @flg_fa = 'Y' and qch_venno in (select tmp_examven from #TEMP_FA)))
	AND ((@flg_scno = 'N') OR (@flg_scno = 'Y' and poh_ordno in (select tmp_scno from #TEMP_SCNO)))
	AND ((@flg_pono = 'N') OR (@flg_pono = 'Y' and poh_purord in (select tmp_pono from #TEMP_PONO)))
	AND (
			(@flg_custpo = 'N') OR 
			(@flg_custpo = 'Y' and 
				(	
					--pod_cuspno in (select tmp_custpo from #TEMP_CUSTPO) 
					poh_cuspno in (select tmp_custpo from #TEMP_CUSTPO)
				)
			)
		)
	--AND ((@flg_item = 'N') OR ( @flg_item = 'Y' and pod_itmno in (select tmp_itmno from #TEMP_ITM)))
	AND ((@flg_scshipdate_fm = 'N' OR (@flg_scshipdate_fm = 'Y' and (soh_shpstr >= @scshipdatefrom))))
	AND ((@flg_scshipdate_to = 'N' OR (@flg_scshipdate_to = 'Y' and (soh_shpstr <= @scshipdateto))))
	AND ((@flg_poshipdate_fm = 'N' OR (@flg_poshipdate_fm = 'Y' and (poh_shpstr >= @poshipdatefrom))))
	AND ((@flg_poshipdate_to = 'N' OR (@flg_poshipdate_to = 'Y' and (poh_shpend <= @poshipdateto))))
	ORDER BY
		qpd_purord, 
		qch_qcno
	
	--*** Declare Result_ALL End ***--

	
	--*** Declare Result Pool Start ***--
	-- DECLARE @QCPO_POOL table(
		-- tmp_qcno nvarchar(20), 
		-- tmp_purord nvarchar(20),
		-- tmp_insptyp nvarchar(20),
		-- tmp_upddat datetime
	-- )
	
	-- INSERT INTO @QCPO_POOL
	-- SELECT
		-- qch_qcno, 
		-- qpd_purord, 
		-- qch_insptyp,
		-- max(qch_upddat)
	
	
	
	
	--*** Declare Result Pool End ***--
	
	--*** PO TBL Start ***--
	DECLARE @PO_POOL table(
		tmp_cocde nvarchar(6),
		tmp_purord nvarchar(20),
		UNIQUE CLUSTERED (tmp_cocde, tmp_purord)
		
	)
	
	INSERT INTO @PO_POOL
	SELECT distinct tmp_cocde, tmp_purord from @TBL_ALL 
	
	--CREATE INDEX IDX_PO_POOL ON @PO_POOL(tmp_cocde, tmp_purord)
	--*** PO TBL End ***--
		
	--***  PO_DATE TBL Start ***---
	DECLARE @PO_DATE table(
		tmp_cocde nvarchar(6),
		tmp_purord nvarchar(20),
		P_date datetime,
		PP_date datetime, 
		M_date datetime,
		DCM_date datetime,
		F_date datetime,
		DCF_date datetime
		UNIQUE CLUSTERED (tmp_cocde, tmp_purord)
	)
	
	--CREATE INDEX IDX_PO_DATE ON @PO_DATE(tmp_cocde, tmp_purord)
	
	INSERT INTO @PO_DATE
	SELECT A.tmp_cocde, A.tmp_purord, max(P.tmp_upddat), max(PP.tmp_upddat), MAX(M.tmp_upddat),  MAX(DCM.tmp_upddat), max(F.tmp_upddat), MAX(DCF.tmp_upddat)
	from @PO_POOL A
	left JOIN @TBL_ALL M 
		on A.tmp_purord = M.tmp_purord
		AND M.tmp_insptyp = 'M'
	left JOIN @TBL_ALL F
		ON A.tmp_purord = F.tmp_purord
		AND F.TMP_insptyp = 'F'
	left JOIN @TBL_ALL P
		ON A.tmp_purord = P.tmp_puroRd
		and P.tmp_insptyp = 'P'
	left JOIN @TBL_ALL PP
		ON A.tmp_purord = PP.tmp_puroRd
		and PP.tmp_insptyp = 'PP'
	left JOIN @TBL_ALL DCM
		ON A.tmp_purord = DCM.tmp_puroRd
		and DCM.tmp_insptyp = 'DCM'
	left JOIN @TBL_ALL DCF
		ON A.tmp_purord = DCF.tmp_puroRd
		and DCF.tmp_insptyp = 'DCF'
	group by 
		A.tmp_cocde,
		A.tmp_purord
	
	--***  PO_DATE TBL End ***---
	
	
	--Main Query Start
	
	SELECT 
		t1.tmp_purord as 'PO No',
		poh_cuspno as 'Cust. PO',
		vbi_vensna as 'Vendor',
		pri.cbi_cussna as 'Pri. Cust', 
		isnull(sec.cbi_cussna, '')  as 'Sec. Cust', 
		poh_ordno as 'SC No', 
		
		'SC Header Ship Date' = convert(varchar(20),soh_shpstr,103) + ' - ' + convert(varchar(20),soh_shpend,103),
		'PO Header Ship Date' = convert(varchar(20),poh_shpstr,103) + ' - ' + convert(varchar(20),poh_shpend,103),
		
		'Pre-Pro (P)' = case isnull(t2.P_date, '') when '' then '' else convert(varchar(20), t2.P_date, 103) END,
		'PP Meeting (PP)' = case isnull(t2.PP_date, '') when '' then '' else convert(varchar(20), t2.PP_date, 103) END,
		'In-Line (M)' = case isnull(t2.M_date, '') when '' then '' else convert(varchar(20), t2.M_date, 103) END,
		'Customer In-Line with QC (DCM)' = case isnull(t2.DCM_date, '') when '' then '' else convert(varchar(20), t2.DCM_date, 103) END,
		'Final (F)' = case isnull(t2.F_date, '') when '' then '' else convert(varchar(20), t2.F_date, 103) END,
		'Customer Final with QC (DCF)' = case isnull(t2.DCF_date, '') when '' then '' else convert(varchar(20), t2.DCF_date, 103) END
		
	
	
	FROM @PO_POOL t1 
	LEFT JOIN @PO_DATE t2 
		ON t1.tmp_cocde = t2.tmp_cocde
		AND t1.tmp_purord = t2.tmp_purord
	LEFT JOIN POORDHDR (nolock)
		ON t1.tmp_cocde = poh_cocde
		AND t1.tmp_purord = poh_purord
	LEFT JOIN SCORDHDR (nolock) 
		on soh_cocde = poh_cocde 
		and soh_ordno = poh_ordno
	LEFT JOIN CUBASINF pri (nolock)
		ON poh_prmcus = pri.cbi_cusno
	LEFT JOIN CUBASINF sec (nolock)
		ON poh_seccus = sec.cbi_cusno
	LEFT JOIN VNBASINF (nolock)
		ON poh_venno = vbi_venno

	
	
		
	
	--Main Query End
	
	
END


GO
GRANT EXECUTE ON [dbo].[sp_select_QCM00006] TO [ERPUSER] AS [dbo]
GO
