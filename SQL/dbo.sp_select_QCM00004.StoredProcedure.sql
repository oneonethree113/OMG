/****** Object:  StoredProcedure [dbo].[sp_select_QCM00004]    Script Date: 09/29/2017 15:29:09 ******/
DROP PROCEDURE [dbo].[sp_select_QCM00004]
GO
/****** Object:  StoredProcedure [dbo].[sp_select_QCM00004]    Script Date: 09/29/2017 15:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE  PROCEDURE [dbo].[sp_select_QCM00004]
	@cocde nvarchar(10), 
	@pricustlist nvarchar(1000),
	@seccustlist nvarchar(1000), 
	@pvlist nvarchar(1000),	
	@inspyear int, 
	@inspweekfm int, 
	@inspweekto int, 
	@insptyp nvarchar(20), 
	@status nvarchar(10),
	@usrid nvarchar(30)

AS
BEGIN
	SET NOCOUNT ON
	
	CREATE table #TEMP_INIT(tmp_init nvarchar(1000)) on [PRIMARY]
	CREATE table #TEMP_INIT2(tmp_init nvarchar(50)) on [PRIMARY]

	CREATE table #TEMP_CUS1NO(tmp_cus1no nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_CUS2NO(tmp_cus2no nvarchar(50)) on [PRIMARY]
	CREATE table #TEMP_PV(tmp_venno nvarchar(50)) on [PRIMARY]

	
	DECLARE @token nvarchar(100)
	DECLARE @tmp_fm nvarchar(50)
	DECLARE @tmp_to nvarchar(50)
	
	DECLARE @flg_pricust char(1),
	@flg_seccust char(1),
	@flg_pv char(1)


	SET @flg_pricust = 'N'
	SET @flg_seccust = 'N'
	SET @flg_pv = 'N'

	


	
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

	
	--*** Insert Temp Table End ***--

	CREATE table #TEMP_QC(tmp_qcno nvarchar(20)) on [PRIMARY]
	
	INSERT INTO #TEMP_QC(tmp_qcno)
	SELECT
		qch_qcno 
	FROM QCREQHDR
	LEFT JOIN CUBASINF
		ON qch_prmcus = cbi_cusno
	WHERE
		qch_cocde = @cocde
	AND	((@flg_pv = 'N') OR ( @flg_pv = 'Y' and qch_venno in (select tmp_venno from #TEMP_PV)))		--Vendor
	AND	((@flg_pricust = 'N') OR (@flg_pricust = 'Y' and qch_prmcus in (select tmp_cus1no from #TEMP_CUS1NO)))
	AND ((@flg_seccust = 'N') OR (@flg_seccust = 'Y' and qch_seccus in (select tmp_cus2no from #TEMP_CUS2NO)))
	AND qch_inspyear = @inspyear 
	AND ((@inspweekfm = '') OR (@inspweekfm <> '' and qch_inspweek >= @inspweekfm ))
	AND ((@inspweekto = '') OR ( @inspweekto <> '' and qch_inspweek <= @inspweekto))
	AND ((@insptyp = 'ALL') OR (@insptyp <> 'ALL' and qch_insptyp = @insptyp))
	AND ((@status = 'ALL') OR (@status <> 'ALL' and qch_qcsts = @status))
	AND (
		EXISTS (
			select 1 from syusrright
			where yur_usrid = @usrid  and yur_doctyp = 'SC' and yur_lvl = 0
		) 
		OR cbi_saltem in (	
			select yur_para from syusrright
			where yur_usrid = @usrid and yur_doctyp = 'SC' and yur_lvl = 1
		) or cbi_cusno in 
		(
			select yur_para from syusrright
			where yur_usrid = @usrid and yur_doctyp = 'SC' and yur_lvl = 2
		)
	)
	

	
	SELECT
		qch_qcno,
		qch_qcsts, 
		qch_venno, 
		qch_prmcus, 
		qch_seccus, 
		qch_inspyear, 
		qch_inspweek, 
		qch_insptyp, 
		
		qch_mon, 
		qch_tue, 
		qch_wed, 
		qch_thur, 
		qch_fri, 
		qch_sat, 
		qch_sun, 
		
		qcd_purord, 
		qcd_purseq, 
		--qpd_flgattach, 
		--qcd_flgattach, 
		
		
		--View
		view_vensna = isnull(ven.vbi_vensna, ''), 
		view_pricust = isnull(pri.cbi_cussna, ''), 
		view_seccust = isnull(sec.cbi_cussna, ''),
		view_insptyp = CASE qch_insptyp 
						when 'P' then 'Pre-Pro'
						when 'PP' then 'PP Meeting'
						when 'M' then 'In-Line'
						when 'CM' then 'Customer In-Line'
						when 'DCM' then 'Customer In-Line with QC'
						when 'F' then 'Final'
						when 'CF' then 'Customer Final'
						when 'DCF' then 'Customer Final with QC'
						else 'Error'
						END,
		view_inspweek = '',
		qcd_credat,
		qcd_upddat,
		qcd_updusr
	
					
						
							
	FROM
		QCREQHDR
	INNER JOIN #TEMP_QC
	ON qch_qcno = tmp_qcno
	INNER JOIN QCREQDTL
	ON qch_qcno = qcd_qcno
	LEFT JOIN VNBASINF ven
	ON ven.vbi_venno = qch_venno
	LEFT JOIN CUBASINF pri
	ON pri.cbi_cusno = qch_prmcus
	LEFT JOIN CUBASINF sec
	ON sec.cbi_cusno = qch_seccus
	-- LEFT JOIN POULFILE att_qc
	-- ON qch_cocde = puf_cocde
	-- AND qch_qcno = puf_ordno 
	-- AND puf_type = 'Q'
	-- LEFT JOIN POULFILE att_pohdr
	--ON 
	
	
	
	--Main Query Start		
/*
	SELECT
		qch_qcno,
		qch_qcsts, 
		qch_venno, 
		qch_prmcus, 
		qch_seccus, 
		qch_inspyear, 
		qch_inspweek, 
		qch_insptyp, 
		
		qch_mon, 
		qch_tue, 
		qch_wed, 
		qch_thur, 
		qch_fri, 
		qch_sat, 
		qch_sun, 
		
		--View
		view_vensna = isnull(ven.vbi_vensna, ''), 
		view_pricust = isnull(pri.cbi_cussna, ''), 
		view_seccust = isnull(sec.cbi_cussna, '')
		
	FROM QCREQHDR
	LEFT JOIN QCREQDTL
		ON qch_qcno = qcd_qcno
	LEFT JOIN VNBASINF ven
	ON ven.vbi_venno = qch_venno
	LEFT JOIN CUBASINF pri
	ON pri.cbi_cusno = qch_prmcus
	LEFT JOIN CUBASINF sec
	ON sec.cbi_cusno = qch_seccus

	*/
	
	--Main Query End
	
	DROP TABLE #TEMP_QC
END

GO
GRANT EXECUTE ON [dbo].[sp_select_QCM00004] TO [ERPUSER] AS [dbo]
GO
