/****** Object:  StoredProcedure [dbo].[sp_select_QCM00001]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCM00001]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCM00001]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create  PROCEDURE [dbo].[sp_select_QCM00001]
	@cocde nvarchar(10),
	@pricustlist nvarchar(1000),
	@seccustlist nvarchar(1000), 
	@pvlist nvarchar(1000),
	@cvlist nvarchar(1000),
	@falist nvarchar(1000),	
	@scnolist nvarchar(1000),
	@ponolist nvarchar(1000),
	@custpolist nvarchar(1000),
	@itemlist nvarchar(1000),
	@poshipdatefrom datetime,
	@poshipdateto datetime, 
	@scshipdatefrom datetime,
	@scshipdateto datetime,

	
	--2015-08-21
	@QCM00002_venno varchar(12), --When this is not empty , neglect pvlist, cvlist, falist
	--2015-10-15
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
	CREATE table #TEMP_ITM(tmp_itmno nvarchar(50)) on [PRIMARY]
	
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
	@flg_item char(1),
	
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
	SET @flg_item = 'N'
	SET @flg_custpo = 'N'
	SET @flg_item = 'N'	
	
	
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
	IF ltrim(rtrim(@itemlist)) <> ''
	BEGIN
		SET @flg_item = 'Y'
		INSERT INTO #TEMP_INIT SELECT * FROM dbo.splitstring(@itemlist)
		
		DECLARE c CURSOR FORWARD_ONLY FOR SELECT tmp_init from #TEMP_INIT
		OPEN C
		FETCH NEXT FROM C into @token
		
		WHILE @@FETCH_STATUS = 0 
		BEGIN
			if charindex('~', @token) <> 0
			BEGIN
				SET @tmp_fm = left(@token, charindex('~', @token)-1)
				SET @tmp_to = right(@token, len(@token) - charindex('~', @token))
				INSERT INTO #TEMP_INIT2 SELECT pod_itmno from POORDDTL WHERE pod_itmno between @tmp_fm and @tmp_to
			END
			else
			BEGIN
				INSERT INTO #TEMP_INIT2 SELECT pod_itmno from POORDDTL WHERE pod_itmno like @token
			END
			FETCH NEXT FROM C into @token
		END
		INSERT INTO #TEMP_ITM SELECT distinct tmp_init from #TEMP_INIT2
		--SELECT * from #TEMP_ITM
		
		CLOSE C
		DEALLOCATE C
		DELETE FROM #TEMP_INIT
		DELETE FROM #TEMP_INIT2
	END	
	--Item End

	--*** Insert Temp Table End ***--

	
	--Handle QCM00002 Case Start
	IF @QCM00002_venno <> ''
	BEGIN
		SET @flg_pv = 'N'
		SET @flg_cv = 'N'
		SET @flg_fa = 'N'
	END
	--Handle QCM00002 Case End
	

	
	
	
	
	--Main Query Start

	Select 
		distinct 
		'N' as 'ACT',
		--'' as 'Week Fm',
		--'' as 'Week To',
		--'' as 'Date',
		'' as 'Year',
		'' as 'Week',
		'' as 'Mon', 
		'' as 'Tue', 
		'' as 'Wed', 
		'' as 'Thur', 
		'' as 'Fri', 
		'' as 'Sat', 
		'' as 'Sun',
		'OPE' as 'Req. Status',
		
		'' as 'Insp. Typ',
		'' as 'Sample',
		'' as 'GenBy',
		'' as 'GenBy Vendor',
		--'' as 'InspectMode',
		'' as 'SI Date', 
		'' as 'CY Date', 
		'' as 'Customer Inspection Date', --20151202

		
		poh_venno as 'CV_r', 
		pod_prdven as 'PV_r', 
		pod_examven as 'FA_r', 
		
		cv.vbi_vensna as 'CV',		
		pv.vbi_vensna as 'PV',		
		fa.vbi_vensna as 'FA',	
		
		pri.cbi_cussna as 'pricust_r',
		sec.cbi_cussna as 'seccust_r',
		poh_prmcus as 'Pri. Cust',
		poh_seccus as 'Sec. Cust',
		
		
		poh_ordno as 'SC No',
		pod_purord as 'PO No',
		Case IsNull(poh_cuspno,'') when '' then pod_cuspno else poh_cuspno end as 'Cust. PO',
		convert(varchar, poh_shpstr, 101) + '-' + convert(varchar, poh_shpend, 101) as 'PO Header Ship Date',	--Ship Start date
		
		--POORDDTL Only
		pod_purseq as 'PO_Seq',
		pod_itmno as 'Item Number',
		pod_cusitm as 'Cust. Item No.',
		pod_venitm as 'Vendor Item No.',
		pod_vencol as 'Color', 
		pod_untcde + '/' + convert(varchar, pod_inrctn) + '/' + convert(varchar, pod_mtrctn) + '/' + convert(varchar, pod_hkprctrm) + '/' + convert(varchar, pod_trantrm) as 'Packing & Terms',
		pod_ordqty as 'Order Qty',
		convert(varchar, pod_shpstr, 101) + '-' + convert(varchar, pod_shpend, 101) as 'PO Detail Ship Date', --Ship Start date
		
		--SCORDDTL AND SCORDHDR
		convert(varchar, soh_shpstr, 101) + '-' + convert(varchar, soh_shpend, 101) as 'SC Header Ship Date',	-- SC Ship Start date
		convert(varchar, sod_shpstr, 101) + '-' + convert(varchar, sod_shpend, 101) as 'SC Detail Ship Date', --SC Ship Start date
		
		'' as 'Remark',
		
		'' as 'qcd_xitmno',
		
		
		--20151022
		'' as 'Week_r'
		
		
	FROM POORDHDR (nolock)
	LEFT JOIN POORDDTL (nolock) ON poh_cocde = pod_cocde AND poh_purord = pod_purord
	LEFT JOIN SCORDDTL (nolock) on sod_cocde = pod_cocde and sod_purord = pod_purord and sod_purseq = pod_purseq
	LEFT JOIN SCORDHDR (nolock) on soh_cocde = sod_cocde and soh_ordno = sod_ordno
	left join SHIPGDTL (nolock) on hid_cocde = pod_cocde and hid_purord = pod_purord and hid_purseq = pod_purseq
	left join SHIPGHDR (nolock) on hid_cocde = hih_cocde and hid_shpno = hih_shpno
	LEFT JOIN CUBASINF (nolock)	ON cbi_cusno = poh_prmcus
	LEFT JOIN VNBASINF cv (nolock) ON cv.vbi_venno = poh_venno
	LEFT JOIN VNBASINF pv (nolock) ON pv.vbi_venno = pod_prdven
	LEFT JOIN VNBASINF fa (nolock) ON fa.vbi_venno = pod_examven
	LEFT JOIN CUBASINF pri (nolock) ON poh_prmcus = pri.cbi_cusno
	LEFT JOIN CUBASINF sec (nolock)	ON poh_seccus = sec.cbi_cusno
	WHERE 
		poh_cocde = @cocde

	AND ((@QCM00002_venno = '') OR (@QCM00002_venno <> '' and (pod_prdven = @QCM00002_venno OR poh_venno = @QCM00002_venno OR pod_examven = @QCM00002_venno)))
	AND ((@flg_pricust = 'N') OR (@flg_pricust = 'Y' and poh_prmcus in (select tmp_cus1no from #TEMP_CUS1NO)))
	AND ((@flg_seccust = 'N') OR (@flg_seccust = 'Y' and poh_seccus in (select tmp_cus2no from #TEMP_CUS2NO)))
	AND ((@flg_pv = 'N') OR ( @flg_pv = 'Y' and pod_prdven in (select tmp_venno from #TEMP_PV)))
	AND ((@flg_cv = 'N') OR ( @flg_cv = 'Y' and poh_venno in (select tmp_venno from #TEMP_CV)))	
	AND ((@flg_fa = 'N') OR ( @flg_fa = 'Y' and pod_examven in (select tmp_examven from #TEMP_FA)))
	AND ((@flg_scno = 'N') OR (@flg_scno = 'Y' and poh_ordno in (select tmp_scno from #TEMP_SCNO)))
	AND ((@flg_pono = 'N') OR (@flg_pono = 'Y' and pod_purord in (select tmp_pono from #TEMP_PONO)))
	AND (
			(@flg_custpo = 'N') OR 
			(@flg_custpo = 'Y' and 
				(	
					pod_cuspno in (select tmp_custpo from #TEMP_CUSTPO) 
					OR poh_cuspno in (select tmp_custpo from #TEMP_CUSTPO)
				)
			)
		)
	AND ((@flg_item = 'N') OR ( @flg_item = 'Y' and pod_itmno in (select tmp_itmno from #TEMP_ITM)))
	AND ((@flg_scshipdate_fm = 'N' OR (@flg_scshipdate_fm = 'Y' and (sod_shpstr >= @scshipdatefrom or  soh_shpstr >= @scshipdatefrom))))
	AND ((@flg_scshipdate_to = 'N' OR (@flg_scshipdate_to = 'Y' and (sod_shpstr <= @scshipdateto or  soh_shpstr <= @scshipdateto))))
	AND ((@flg_poshipdate_fm = 'N' OR (@flg_poshipdate_fm = 'Y' and (pod_shpstr >= @poshipdatefrom or poh_shpstr >= @poshipdatefrom))))
	AND ((@flg_poshipdate_to = 'N' OR (@flg_poshipdate_to = 'Y' and (pod_shpend <= @poshipdateto or poh_shpend <= @poshipdateto))))
	AND poh_pursts = 'REL'
	AND soh_ordsts <> 'CLO'
	AND	(((sod_ordqty - sod_shpqty) > 0) or ((sod_ordqty - sod_shpqty) = 0 and hih_slnonb > getdate() - 1))
	AND (
		EXISTS (
			select 1 from syusrright
			where yur_usrid = @usrid  and yur_doctyp = 'SC' and yur_lvl = 0
		) 
		OR pri.cbi_saltem in (	
			select yur_para from syusrright
			where yur_usrid = @usrid and yur_doctyp = 'SC' and yur_lvl = 1
		) or pri.cbi_cusno in 
		(
			select yur_para from syusrright
			where yur_usrid = @usrid and yur_doctyp = 'SC' and yur_lvl = 2
		)
	
	)
	ORDER BY 
		pod_purord,
		pod_purseq
	
	
	--Main Query End
	
	
END



GO
GRANT EXECUTE ON [dbo].[sp_select_QCM00001] TO [ERPUSER] AS [dbo]
GO
